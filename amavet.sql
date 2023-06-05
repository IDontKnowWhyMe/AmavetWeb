-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hostiteľ: 127.0.0.1
-- Čas generovania: Po 05.Jún 2023, 14:42
-- Verzia serveru: 10.4.27-MariaDB
-- Verzia PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáza: `amavet`
--

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `image_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `comment` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Sťahujem dáta pre tabuľku `comments`
--

INSERT INTO `comments` (`id`, `image_id`, `user_id`, `comment`) VALUES
(1, 3, 1, 'yuiyi\r\n'),
(2, 1, 1, '2'),
(4, 3, 1, 'IUERHGUIOFHERIOGJOPEAHJF'),
(26, 3, 1, '4rygherygertge'),
(40, 3, 1, 'ertgertertwer'),
(86, 1, 1, '44'),
(90, 1, 1, '1'),
(251, 1, 1, 'Hi'),
(967, 3, 1, 'y6uyi'),
(5006, 1, 1, '44'),
(6484, 3, 1, 'Hello'),
(6485, 3, 1, 'tryhertyhrtyer'),
(340000, 3, 1, 'dferg'),
(340001, 3, 2, 'Hi'),
(521522, 1, 1, '3'),
(7650642, 1, 1, '44'),
(38232011, 1, 1, '4'),
(83387515, 2, 1, 'Test1\r\n'),
(2147483647, 1, 1, '44');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `images`
--

CREATE TABLE `images` (
  `id` int(11) NOT NULL,
  `url` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Sťahujem dáta pre tabuľku `images`
--

INSERT INTO `images` (`id`, `url`) VALUES
(1, './images/1.jpg'),
(2, './images/2.jpg'),
(3, './images/3.jpg'),
(4, './images/4.jpg'),
(5, './images/5.jpg'),
(6, './images/6.jpg'),
(7, './images/7.jpg'),
(8, './images/8.jpg'),
(9, './images/9.jpg'),
(10, './images/10.jpg'),
(11, './images/11.jpg'),
(12, './images/12.jpg'),
(13, './images/13.jpg'),
(14, './images/14.jpg'),
(15, './images/15.jpg'),
(16, './images/16.jpg'),
(17, './images/17.jpg'),
(18, './images/18.jpg');

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `likes`
--

CREATE TABLE `likes` (
  `user_id` int(11) DEFAULT NULL,
  `image_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Štruktúra tabuľky pre tabuľku `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Sťahujem dáta pre tabuľku `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`) VALUES
(1, 'MilanBot', 'lukasstupaka@gmail.com', '$2b$10$WeZav9tS5Q/HrqBxLmubEOdIV.Nxn16h7CTVWO0mBMrYv.YLQZr7S'),
(2, 'lukasstupak', 'lukasstupakb@gmail.com', '$2b$10$.skNDFNQS89WC/CFIaPDE.4M6Hys/4OQ8OACGpLViG7mNLUBZi1Ai');

--
-- Kľúče pre exportované tabuľky
--

--
-- Indexy pre tabuľku `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `image_id` (`image_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexy pre tabuľku `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`);

--
-- Indexy pre tabuľku `likes`
--
ALTER TABLE `likes`
  ADD KEY `user_id` (`user_id`),
  ADD KEY `image_id` (`image_id`);

--
-- Indexy pre tabuľku `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pre exportované tabuľky
--

--
-- AUTO_INCREMENT pre tabuľku `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2147483648;

--
-- AUTO_INCREMENT pre tabuľku `images`
--
ALTER TABLE `images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT pre tabuľku `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Obmedzenie pre exportované tabuľky
--

--
-- Obmedzenie pre tabuľku `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`),
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Obmedzenie pre tabuľku `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`image_id`) REFERENCES `images` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
