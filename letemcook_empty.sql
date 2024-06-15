-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 10 mai 2024 à 22:19
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12
DROP DATABASE IF EXISTS LETEMCOOK_LEROY_FARAVEL;

CREATE DATABASE IF NOT EXISTS LETEMCOOK_LEROY_FARAVEL;
USE LETEMCOOK_LEROY_FARAVEL;


SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";



/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `letemcook`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `addComment` (IN `body` TEXT, IN `idParent` INT(2), IN `userID` INT(2), OUT `postID` INT(2))   BEGIN
    INSERT INTO post (USERID,BODY) VALUES (userID,body);
    SET postID = LAST_INSERT_ID();
    INSERT INTO comment (IDPOST, IDPOST_PARENT) VALUES (postID, idParent);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addIngredient` (IN `name` VARCHAR(100), OUT `ingredientID` INT(2))   BEGIN
    INSERT INTO ingredient (NAME)
    VALUES (name);
	SET ingredientID = LAST_INSERT_ID();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addInstruction` (IN `postID` INT(2), IN `body` TEXT, IN `instructionOrder` INT, OUT `instructionID` INT)  MODIFIES SQL DATA BEGIN
	INSERT INTO instructions (IDPOST,BODY,INSTRUCTIONORDER)
    VALUES (postID,body,instructionOrder);
	SET instructionID = LAST_INSERT_ID();
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `addRecipe` (IN `userID` INT(2), IN `title` TEXT, IN `description` TEXT, IN `imageExtension` VARCHAR(50), IN `difficulty` SMALLINT(2), IN `duration` TIME(1), IN `nbPeople` SMALLINT(2), IN `category` VARCHAR(50), IN `type` VARCHAR(50), OUT `postID` INT(2))  MODIFIES SQL DATA BEGIN
DECLARE lastPostID INT;
DECLARE image VARCHAR(255);
	INSERT INTO post (USERID,BODY) VALUES (userID,description);
    SET lastPostID = LAST_INSERT_ID();
    SET image = CONCAT(lastPostID,'.',imageExtension);
	INSERT INTO recipe (IDPOST, TITLE, IMAGE, DIFFICULTY, DURATION, NBPEOPLE, CATEGORY, TYPE)
	VALUES (lastPostID, title, image, difficulty, duration, nbPeople, category, type);
	SET postID = lastPostID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateRecipe` (IN `postID` INT(2), IN `title` TEXT, IN `description` TEXT, IN `difficulty` SMALLINT(2), IN `duration` TIME(1), IN `nbPeople` SMALLINT(2), IN `category` VARCHAR(50), IN `type` VARCHAR(50))  MODIFIES SQL DATA BEGIN
	UPDATE post SET BODY=description WHERE IDPOST=postID;
    UPDATE recipe 
    SET TITLE=title,
    DIFFICULTY=difficulty,
    DURATION=duration,
    NBPEOPLE=nbPeople,
    CATEGORY=category,
    TYPE=type
    WHERE IDPOST=postID;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `ban`
--

CREATE TABLE `ban` (
  `BANID` smallint(1) NOT NULL,
  `USERID` int(2) NOT NULL,
  `USERBANNED` int(2) NOT NULL,
  `DATESTART` date DEFAULT current_timestamp(),
  `DATEEND` date DEFAULT NULL,
  `BODY` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `ban`
--



-- --------------------------------------------------------

--
-- Structure de la table `comment`
--

CREATE TABLE `comment` (
  `IDPOST` smallint(1) NOT NULL,
  `IDPOST_PARENT` smallint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `comment`
--



-- --------------------------------------------------------

--
-- Structure de la table `follownotif`
--

CREATE TABLE `follownotif` (
  `IDNOTIF` smallint(1) NOT NULL,
  `USERID` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `follownotif`
--



-- --------------------------------------------------------

--
-- Structure de la table `follows`
--

CREATE TABLE `follows` (
  `USERID_FOLLOWER` int(2) NOT NULL,
  `USERID_FOLLOWED` int(2) NOT NULL,
  `FOLLOWDATE` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `follows`
--



--
-- Déclencheurs `follows`
--
DELIMITER $$
CREATE TRIGGER `addNotifFollow` AFTER INSERT ON `follows` FOR EACH ROW BEGIN
-- Insertion dans la table notification et récupération de l'IDNOTIF
    INSERT INTO notification (USERID, BODY, DATENOTIF, TYPE)
    VALUES (NEW.USERID_FOLLOWED, 
            CONCAT((SELECT username FROM user WHERE userid = NEW.USERID_FOLLOWER), ' a commencé à vous suivre !'), 
            CURRENT_TIMESTAMP(), 
            'follow');

    -- Insertion dans la table follownotif avec l'IDNOTIF récupéré
    INSERT INTO follownotif (USERID, IDNOTIF)
    SELECT NEW.USERID_FOLLOWER, MAX(IDNOTIF)
    FROM notification;  
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `ingredient`
--

CREATE TABLE `ingredient` (
  `IDINGREDIENT` smallint(1) NOT NULL,
  `NAME` char(50) DEFAULT NULL,
  `IMAGE` char(32) DEFAULT 'default.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `ingredient`
--

INSERT INTO `ingredient` (`IDINGREDIENT`, `NAME`, `IMAGE`) VALUES
(1, 'farine', 'farine.jpg'),
(2, 'farine de pomme de terre', 'default.png'),
(3, 'farine de mais', 'default.png'),
(4, 'sucre', 'default.png'),
(6, 'huile', 'default.png'),
(7, 'tomate', 'default.png'),
(8, 'concombre', 'default.png'),
(9, 'carotte', 'default.png'),
(20, NULL, 'default.png'),
(21, NULL, 'default.png'),
(22, NULL, 'default.png'),
(23, NULL, 'default.png'),
(24, NULL, 'default.png'),
(25, NULL, 'default.png'),
(26, NULL, 'default.png'),
(27, NULL, 'default.png'),
(28, NULL, 'default.png'),
(29, NULL, 'default.png'),
(30, NULL, 'default.png'),
(31, NULL, 'default.png'),
(32, NULL, 'default.png'),
(33, NULL, 'default.png'),
(34, NULL, 'default.png'),
(35, NULL, 'default.png'),
(36, NULL, 'default.png'),
(37, NULL, 'default.png'),
(38, NULL, 'default.png'),
(39, NULL, 'default.png'),
(40, NULL, 'default.png'),
(41, NULL, 'default.png'),
(42, NULL, 'default.png'),
(43, NULL, 'default.png'),
(44, NULL, 'default.png'),
(45, NULL, 'default.png'),
(46, 'w', 'default.png'),
(47, '532', 'default.png'),
(48, '543', 'default.png'),
(49, '234', 'default.png'),
(50, 'margarine', 'default.png'),
(51, 'beurre', 'default.png'),
(52, 'four', 'default.png'),
(53, NULL, 'default.png'),
(54, 'pois chiche', 'default.png'),
(55, 'eau', 'default.png'),
(56, 'pates', 'default.png'),
(57, 'lardons', 'default.png'),
(58, 'crème fraiche', 'default.png'),
(59, 'levure chimique', 'default.png'),
(60, 'sucre vanillé', 'default.png'),
(61, 'oeufs', 'default.png'),
(62, 'chocolat', 'default.png');

-- --------------------------------------------------------

--
-- Structure de la table `instructions`
--

CREATE TABLE `instructions` (
  `IDINSTRUCTION` smallint(1) NOT NULL,
  `IDPOST` smallint(1) NOT NULL,
  `BODY` text DEFAULT NULL,
  `INSTRUCTIONORDER` smallint(1) DEFAULT NULL,
  `DURATION` smallint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `instructions`
--

INSERT INTO `instructions` (`IDINSTRUCTION`, `IDPOST`, `BODY`, `INSTRUCTIONORDER`, `DURATION`) VALUES
(1, 11, '0', 1, NULL),
(2, 11, '0', 2, NULL),
(3, 12, '0', 1, NULL),
(4, 13, '0', 1, NULL),
(5, 13, '0', 2, NULL),
(6, 14, 'Faire bouillir l\'eau', 1, NULL),
(7, 14, 'Une fois l\'eau bouillante, ajouter les pates', 2, NULL),
(8, 14, 'Faire cuire les lardons', 3, NULL),
(9, 14, 'Ajouter la crème fraiche et le poivre aux lardons puis ajouter les pates cuites et mélanger le tout.<br>', 4, NULL),
(22, 26, 'sad', 1, NULL),
(23, 27, 'asd', 1, NULL),
(24, 28, 'saddsa', 1, NULL),
(25, 28, '', 2, NULL),
(26, 29, 'dsasad', 1, NULL),
(27, 30, 'dsadsa', 1, NULL),
(49, 31, 'dasdassda', 1, NULL),
(50, 31, 'okk', 2, NULL),
(51, 31, 'dac', 3, NULL),
(52, 32, 'ajouter les patees', 1, NULL),
(53, 32, 'les faire cuire', 2, NULL),
(54, 33, 'sda', 1, NULL),
(55, 34, 'sdasda', 1, NULL),
(56, 35, 'dfs', 1, NULL),
(57, 36, 'sda', 1, NULL),
(58, 37, 'dsa', 1, NULL),
(59, 38, 'asd', 1, NULL),
(61, 40, 'farine', 1, NULL),
(65, 41, 'asdsda', 1, NULL),
(66, 41, 'asd', 2, NULL),
(67, 88, 'Faire chauffer l\\\'eau.', 1, NULL),
(68, 88, 'Quand l\\\'eau bout, ajouter les pates.', 2, NULL),
(69, 88, 'Pendant ce temps, faire cuire les lardons sans matière grasse.', 3, NULL),
(70, 88, 'Une fois les pates cuites, enlever l\\\'eau avec une passoire, ajouter la crème fraiche aux lardons une fois cuits et ajouter les pates.', 4, NULL),
(71, 115, 'Faire fondre le beurre et ajouter le sucre, le sucre vanillé et la levure chimique.', 1, NULL),
(72, 115, 'Ajouter les oeufs puis la farine', 2, NULL),
(73, 115, 'Ajouter le chocolat coupé en petit morceaux', 3, NULL),
(74, 115, 'Faire cuire a 180 degrès pendant environ 10 minutes.', 4, NULL),
(75, 116, 'Mettre une bonne notre, c\\&#039;est tout', 1, NULL);

--
-- Déclencheurs `instructions`
--
DELIMITER $$
CREATE TRIGGER `deleteInstruction` BEFORE DELETE ON `instructions` FOR EACH ROW BEGIN
	DELETE FROM usedingredient 
    WHERE IDINSTRUCTION = OLD.IDINSTRUCTION;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `likes`
--

CREATE TABLE `likes` (
  `USERID` int(2) NOT NULL,
  `IDPOST` smallint(1) NOT NULL,
  `LIKEDATE` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `likes`
--



-- --------------------------------------------------------

--
-- Structure de la table `notification`
--

CREATE TABLE `notification` (
  `USERID` int(2) NOT NULL,
  `BODY` text DEFAULT NULL,
  `DATENOTIF` datetime DEFAULT current_timestamp(),
  `TYPE` char(32) DEFAULT NULL,
  `IDNOTIF` smallint(1) NOT NULL,
  `READNOTIF` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `notification`
--



-- --------------------------------------------------------

--
-- Structure de la table `post`
--

CREATE TABLE `post` (
  `IDPOST` smallint(1) NOT NULL,
  `USERID` int(2) NOT NULL,
  `BODY` text DEFAULT NULL,
  `POSTDATE` datetime DEFAULT current_timestamp(),
  `SENSIBLE` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `post`
--


--
-- Déclencheurs `post`
--
DELIMITER $$
CREATE TRIGGER `deletePost` BEFORE DELETE ON `post` FOR EACH ROW BEGIN
	DELETE FROM instructions 
    WHERE IDPOST = OLD.IDPOST;
	DELETE FROM recipe WHERE IDPOST = OLD.IDPOST;
    DELETE FROM likes WHERE IDPOST = OLD.IDPOST;
    DELETE FROM saved WHERE IDPOST = OLD.IDPOST;
    
    DELETE FROM comment WHERE IDPOST_PARENT IN (SELECT IDPOST FROM comment WHERE IDPOST = OLD.IDPOST);
    DELETE FROM comment WHERE IDPOST = OLD.IDPOST;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `deletePostNotif` BEFORE DELETE ON `post` FOR EACH ROW BEGIN
	DELETE FROM postnotif WHERE IDPOST = OLD.IDPOST;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `postnotif`
--

CREATE TABLE `postnotif` (
  `IDNOTIF` smallint(1) NOT NULL,
  `IDPOST` smallint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `postnotif`
--



-- --------------------------------------------------------

--
-- Structure de la table `postsimple`
--

CREATE TABLE `postsimple` (
  `IDPOST` smallint(1) NOT NULL,
  `IMAGE` char(50) DEFAULT 'default.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `recipe`
--

CREATE TABLE `recipe` (
  `IDPOST` smallint(1) NOT NULL,
  `TITLE` char(100) DEFAULT NULL,
  `IMAGE` char(50) DEFAULT 'default.png',
  `DIFFICULTY` smallint(1) DEFAULT NULL,
  `DURATION` time(1) DEFAULT NULL,
  `NBPEOPLE` smallint(1) DEFAULT NULL,
  `CATEGORY` char(50) DEFAULT NULL,
  `TYPE` char(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `recipe`
--

--
-- Déclencheurs `recipe`
--
DELIMITER $$
CREATE TRIGGER `addNotifPost` AFTER INSERT ON `recipe` FOR EACH ROW BEGIN
    INSERT INTO notification (USERID, BODY, DATENOTIF, TYPE)    
    	VALUES ((SELECT USERID FROM post WHERE IDPOST = NEW.IDPOST), 
        CONCAT((SELECT username FROM user WHERE userid = (SELECT USERID FROM post WHERE IDPOST = NEW.IDPOST)), 
        ' viens de publier une recette'),CURRENT_TIMESTAMP(), 'post');
INSERT INTO postnotif (IDPOST, IDNOTIF)
SELECT NEW.IDPOST, MAX(IDNOTIF)
FROM notification;  

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `saved`
--

CREATE TABLE `saved` (
  `USERID` int(2) NOT NULL,
  `IDPOST` smallint(1) NOT NULL,
  `SAVEDATE` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `saved`
--



-- --------------------------------------------------------

--
-- Structure de la table `usedingredient`
--

CREATE TABLE `usedingredient` (
  `IDINGREDIENT` smallint(1) NOT NULL,
  `IDINSTRUCTION` smallint(1) NOT NULL,
  `QUANTITY` smallint(1) DEFAULT NULL,
  `UNITY` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `usedingredient`
--

INSERT INTO `usedingredient` (`IDINGREDIENT`, `IDINSTRUCTION`, `QUANTITY`, `UNITY`) VALUES
(1, 49, 23, 'g'),
(1, 56, 234, 'g'),
(1, 58, 23, 'g'),
(1, 59, 23, 'g'),
(1, 61, 23, 'g'),
(1, 65, 23, 'g'),
(1, 72, 260, 'g'),
(3, 58, 42, 'g'),
(4, 71, 200, 'g'),
(50, 65, 40, 'g'),
(51, 65, 23, 'g'),
(51, 71, 100, 'g'),
(52, 65, 1, 'piece'),
(54, 66, 1, 'piece'),
(55, 67, 500, 'g'),
(56, 68, 500, 'g'),
(57, 69, 200, 'g'),
(58, 70, 500, 'g'),
(59, 71, 1, 'piece'),
(60, 71, 1, 'piece'),
(61, 72, 1, 'piece'),
(62, 73, 200, 'g');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `USERNAME` char(50) DEFAULT NULL,
  `USERID` int(2) NOT NULL,
  `EMAIL` char(50) DEFAULT NULL,
  `PASSWORD` char(50) DEFAULT NULL,
  `ACCOUNTCREATION` date DEFAULT current_timestamp(),
  `PROFILEPICTURE` char(50) DEFAULT 'default.png',
  `BIOGRAPHY` text DEFAULT NULL,
  `DATEBIRTH` date DEFAULT NULL,
  `ADRESS` char(50) DEFAULT NULL,
  `ISADMIN` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `user`
--

-- --------------------------------------------------------

--
-- Structure de la table `warningnotif`
--

CREATE TABLE `warningnotif` (
  `IDNOTIF` smallint(1) NOT NULL,
  `USERID` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `ban`
--
ALTER TABLE `ban`
  ADD PRIMARY KEY (`BANID`),
  ADD KEY `I_FK_BAN_USER` (`USERID`),
  ADD KEY `I_FK_BAN_USER1` (`USERBANNED`);

--
-- Index pour la table `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`IDPOST`),
  ADD KEY `I_FK_COMMENT_POST` (`IDPOST_PARENT`) USING BTREE;

--
-- Index pour la table `follownotif`
--
ALTER TABLE `follownotif`
  ADD PRIMARY KEY (`IDNOTIF`),
  ADD KEY `I_FK_FOLLOWNOTIF_USER` (`USERID`);

--
-- Index pour la table `follows`
--
ALTER TABLE `follows`
  ADD PRIMARY KEY (`USERID_FOLLOWER`,`USERID_FOLLOWED`) USING BTREE,
  ADD KEY `I_FK_FOLLOWS_USER` (`USERID_FOLLOWER`),
  ADD KEY `I_FK_FOLLOWS_USER1` (`USERID_FOLLOWED`);

--
-- Index pour la table `ingredient`
--
ALTER TABLE `ingredient`
  ADD PRIMARY KEY (`IDINGREDIENT`),
  ADD UNIQUE KEY `NAME` (`NAME`);

--
-- Index pour la table `instructions`
--
ALTER TABLE `instructions`
  ADD PRIMARY KEY (`IDINSTRUCTION`),
  ADD KEY `I_FK_INSTRUCTIONS_RECIPE` (`IDPOST`);

--
-- Index pour la table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`USERID`,`IDPOST`),
  ADD KEY `I_FK_LIKES_USER` (`USERID`),
  ADD KEY `I_FK_LIKES_POST` (`IDPOST`);

--
-- Index pour la table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`IDNOTIF`),
  ADD KEY `I_FK_NOTIFICATION_USER` (`USERID`);

--
-- Index pour la table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`IDPOST`) USING BTREE,
  ADD KEY `I_FK_POST_USER` (`USERID`) USING BTREE;

--
-- Index pour la table `postnotif`
--
ALTER TABLE `postnotif`
  ADD PRIMARY KEY (`IDNOTIF`),
  ADD KEY `I_FK_POSTNOTIF_POST` (`IDPOST`);

--
-- Index pour la table `postsimple`
--
ALTER TABLE `postsimple`
  ADD PRIMARY KEY (`IDPOST`);

--
-- Index pour la table `recipe`
--
ALTER TABLE `recipe`
  ADD PRIMARY KEY (`IDPOST`);

--
-- Index pour la table `saved`
--
ALTER TABLE `saved`
  ADD PRIMARY KEY (`USERID`,`IDPOST`),
  ADD KEY `I_FK_SAVED_USER` (`USERID`),
  ADD KEY `I_FK_SAVED_POST` (`IDPOST`);

--
-- Index pour la table `usedingredient`
--
ALTER TABLE `usedingredient`
  ADD PRIMARY KEY (`IDINGREDIENT`,`IDINSTRUCTION`),
  ADD KEY `I_FK_USEDINREDIENT_INGREDIENT` (`IDINGREDIENT`),
  ADD KEY `I_FK_USEDINREDIENT_INSTRUCTIONS` (`IDINSTRUCTION`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`USERID`);

--
-- Index pour la table `warningnotif`
--
ALTER TABLE `warningnotif`
  ADD PRIMARY KEY (`IDNOTIF`),
  ADD KEY `I_FK_WARNINGNOTIF_USER` (`USERID`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `ban`
--
ALTER TABLE `ban`
  MODIFY `BANID` smallint(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `ingredient`
--
ALTER TABLE `ingredient`
  MODIFY `IDINGREDIENT` smallint(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT pour la table `instructions`
--
ALTER TABLE `instructions`
  MODIFY `IDINSTRUCTION` smallint(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT pour la table `notification`
--
ALTER TABLE `notification`
  MODIFY `IDNOTIF` smallint(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT pour la table `post`
--
ALTER TABLE `post`
  MODIFY `IDPOST` smallint(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `USERID` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `ban`
--
ALTER TABLE `ban`
  ADD CONSTRAINT `FK_BAN_USER` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`),
  ADD CONSTRAINT `FK_BAN_USER1` FOREIGN KEY (`USERBANNED`) REFERENCES `user` (`USERID`);

--
-- Contraintes pour la table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `FK_COMMENT_POST` FOREIGN KEY (`IDPOST_PARENT`) REFERENCES `post` (`IDPOST`),
  ADD CONSTRAINT `FK_COMMENT_POST1` FOREIGN KEY (`IDPOST`) REFERENCES `post` (`IDPOST`);

--
-- Contraintes pour la table `follownotif`
--
ALTER TABLE `follownotif`
  ADD CONSTRAINT `FK_FOLLOWNOTIF_NOTIFICATION` FOREIGN KEY (`IDNOTIF`) REFERENCES `notification` (`IDNOTIF`),
  ADD CONSTRAINT `FK_FOLLOWNOTIF_USER` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`);

--
-- Contraintes pour la table `follows`
--
ALTER TABLE `follows`
  ADD CONSTRAINT `FK_FOLLOWS_USER` FOREIGN KEY (`USERID_FOLLOWER`) REFERENCES `user` (`USERID`),
  ADD CONSTRAINT `FK_FOLLOWS_USER1` FOREIGN KEY (`USERID_FOLLOWED`) REFERENCES `user` (`USERID`);

--
-- Contraintes pour la table `instructions`
--
ALTER TABLE `instructions`
  ADD CONSTRAINT `FK_INSTRUCTIONS_RECIPE` FOREIGN KEY (`IDPOST`) REFERENCES `recipe` (`IDPOST`);

--
-- Contraintes pour la table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `FK_LIKES_POST` FOREIGN KEY (`IDPOST`) REFERENCES `post` (`IDPOST`),
  ADD CONSTRAINT `FK_LIKES_USER` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`);

--
-- Contraintes pour la table `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `FK_NOTIFICATION_USER` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`);

--
-- Contraintes pour la table `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `FK_POST_USER` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`);

--
-- Contraintes pour la table `postnotif`
--
ALTER TABLE `postnotif`
  ADD CONSTRAINT `FK_POSTNOTIF_NOTIFICATION` FOREIGN KEY (`IDNOTIF`) REFERENCES `notification` (`IDNOTIF`),
  ADD CONSTRAINT `FK_POSTNOTIF_POST` FOREIGN KEY (`IDPOST`) REFERENCES `post` (`IDPOST`);

--
-- Contraintes pour la table `postsimple`
--
ALTER TABLE `postsimple`
  ADD CONSTRAINT `FK_POSTSIMPLE_POST` FOREIGN KEY (`IDPOST`) REFERENCES `post` (`IDPOST`);

--
-- Contraintes pour la table `recipe`
--
ALTER TABLE `recipe`
  ADD CONSTRAINT `FK_RECIPE_POST` FOREIGN KEY (`IDPOST`) REFERENCES `post` (`IDPOST`);

--
-- Contraintes pour la table `saved`
--
ALTER TABLE `saved`
  ADD CONSTRAINT `FK_SAVED_POST` FOREIGN KEY (`IDPOST`) REFERENCES `post` (`IDPOST`),
  ADD CONSTRAINT `FK_SAVED_USER` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`);

--
-- Contraintes pour la table `usedingredient`
--
ALTER TABLE `usedingredient`
  ADD CONSTRAINT `FK_USEDINREDIENT_INGREDIENT` FOREIGN KEY (`IDINGREDIENT`) REFERENCES `ingredient` (`IDINGREDIENT`),
  ADD CONSTRAINT `FK_USEDINREDIENT_INSTRUCTIONS` FOREIGN KEY (`IDINSTRUCTION`) REFERENCES `instructions` (`IDINSTRUCTION`);

--
-- Contraintes pour la table `warningnotif`
--
ALTER TABLE `warningnotif`
  ADD CONSTRAINT `FK_WARNINGNOTIF_NOTIFICATION` FOREIGN KEY (`IDNOTIF`) REFERENCES `notification` (`IDNOTIF`),
  ADD CONSTRAINT `FK_WARNINGNOTIF_USER` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
