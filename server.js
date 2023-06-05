if (process.env.NODE_ENV !== "production"){
    require("dotenv").config()
}

//Imports
const path = require('path')
const { v4: uuidv4 } = require('uuid');
const express = require('express')
const app = express()
const bcrypt = require('bcrypt')
const passport = require('passport')
const initializePassport = require('./passport-config')
const flash =  require("express-flash")
const session = require("express-session")
const MethodOverride = require("method-override")

//setup view engine
app.set('views', path.join(__dirname, 'views'))
app.set('view engine', 'ejs')

app.use(express.static(path.join(__dirname, 'public')))

const db = require('./db')
const multer = require("multer")

initializePassport(passport)

app.use(express.urlencoded({extended: false}))
app.use(flash())
app.use(session({
  secret: process.env.SECRET_KEY,
  resave: false,
  saveUninitialized: false
}))
app.use(passport.initialize())
app.use(passport.session())
app.use(MethodOverride("_method"))


app.post("/login", checkAuthenticated, passport.authenticate("local", {
  successRedirect: "/",
  failureRedirect: "/login",
  failureFlash: true,
  session: true
}));


app.post("/register", checkAuthenticated, async (req, res) => {
    const { name, email, password} = req.body;
    if (!name || !email || !password) {
      req.flash("error", "Všetky polia sú povinné");
      return res.redirect("/register");
    }
  
    const [rows] = await db.query('SELECT * FROM users WHERE email = ?', [email]);
    if (rows.length) {
      req.flash("error", "Používateľ s týmto emailom už existuje");
      return res.redirect("/register");
    }
  
    try {
      const hashedPassword = await bcrypt.hash(password, 10);
      await db.query('INSERT INTO users (name, email, password) VALUES (?, ?, ?)', [name, email, hashedPassword]);
      res.redirect("/login");
    } catch (error) {
      console.log(error);
      req.flash("error", "Nastala chyba pri registrácii");
      res.redirect("/register");
    }
  });

app.get('/', checkNotAuthenticated, async(req, res) => {
  const [rows] = await db.query('SELECT * FROM users WHERE email = ?', [req.user.email]);
  app.locals.userID = rows[0].id
  res.render("index.ejs", {user: req.user.name})
})

app.post("/addComment", checkNotAuthenticated, async(req, res) => {
  const newId = uuidv4()
  await db.query('INSERT INTO comments (id, image_id, user_id, comment) VALUES (?, ?, ?, ?)', [newId, app.locals.image_id, app.locals.userID, req.body.comment]);
  res.redirect("/galery");
})

app.get('/galery', checkNotAuthenticated, async(req, res) => {
  const [images] = await db.query('SELECT * FROM images');
  app.locals.images = images;
  app.locals
  console.log( app.locals.displayFullImg)
  res.render("galery.ejs", {user: req.user,commentsData: [], images: images})
})

app.get('/galery/:param', checkNotAuthenticated, async(req, res) => {
  app.locals.img_id = req.params.param;
  const images = app.locals.images;
  app.locals.image_id = req.params.param;
  const [comments] = await db.query('SELECT images.url, COUNT(likes.image_id) AS likes_count, comments.comment, users.name \n' +
  'FROM images \n'+
  'LEFT JOIN likes ON images.id = likes.image_id \n'+
  'LEFT JOIN comments ON images.id = comments.image_id \n'+
  'LEFT JOIN users ON comments.user_id = users.id \n'+
  'WHERE images.id =? \n'+
  'GROUP BY comments.id; \n', [req.params.param]);
  res.render('galery.ejs', {user: req.user, commentsData: comments, images: images});
})

app.get('/login', checkAuthenticated, (req, res) => {
  res.render("login.ejs")
})

app.get('/register', checkAuthenticated, (req, res) => {
  res.render("register.ejs")
})

app.delete("/logout", (req, res) =>{
  req.logOut(req.user, err => {
      if (err) return next(err)
      res.redirect("/")
  })
})

function checkNotAuthenticated(req,res, next){
  if(req.isAuthenticated()){
      return next()
  }
  res.redirect("/login")
}

function checkAuthenticated(req,res, next){
  if(req.isAuthenticated()){
      return res.redirect("/")
  }
  next()
}

app.listen(3000)
