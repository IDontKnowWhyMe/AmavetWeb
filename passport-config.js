const LocalStrategy = require("passport-local").Strategy;
const bcrypt = require("bcrypt");
const db = require("./db");

function initialize(passport) {
  const authenticateUser = async (email, password, done) => {
    try {
      const [results] = await db.query(
        "SELECT * FROM users WHERE email = ?",
        [email]
      );

      if (results.length === 0) {
        return done(null, false, { message: "No user found with that email" });
      }

      const user = results[0];
      if (await bcrypt.compare(password, user.password)) {
        return done(null, user);
      } else {
        return done(null, false, { message: "Password incorrect" });
      }
    } catch (error) {
      return done(error);
    }
  };

  passport.use(new LocalStrategy({ usernameField: "email" }, authenticateUser));
  passport.serializeUser((user, done) => done(null, user.id));
  passport.deserializeUser(async (id, done) => {
    try {
      const [results] = await db.query("SELECT * FROM users WHERE id = ?", [
        id,
      ]);
      return done(null, results[0]);
    } catch (error) {
      return done(error);
    }
  });
}

module.exports = initialize;