DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes_comentaris` (
  `id` int(11) NOT NULL,
  `data_like` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_usuari_like_comentari` int(11) NOT NULL,
  `id_comentari` int(11) NOT NULL,
  `esborrat` tinyint(1) NOT NULL,
  `like_no_like` INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `comentaris`
--

DROP TABLE IF EXISTS `comentaris`;
CREATE TABLE `comentaris` (
  `id` int(11) NOT NULL,
  `data_comentari` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `text_comentari` text COLLATE utf8_unicode_ci NOT NULL,
  `id_usuari_comentari` int(11) NOT NULL,
  `id_publicacio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- --------------------------------------------------------

--
-- Estructura de la taula `likes`
--

DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes` (
  `id` int(11) NOT NULL,
  `data_like` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_usuari_like` int(11) NOT NULL,
  `id_publicacio` int(11) NOT NULL,
  `esborrat` tinyint(1) NOT NULL,
  `like_no_like` INT NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `publicacions`
--

DROP TABLE IF EXISTS `publicacions`;
CREATE TABLE `publicacions` (
  `id` int(11) NOT NULL,
  `data_publicacio` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `imatge` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `text_imatge` text COLLATE utf8_unicode_ci NOT NULL,
  `id_usuari` int(11) NOT NULL,
  `esborrat` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `seguidors`
--

DROP TABLE IF EXISTS `seguidors`;
CREATE TABLE `seguidors` (
  `id` int(11) NOT NULL,
  `data_seguidor` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `estat` int(11) NOT NULL,
  `id_usuari_seguit` int(11) NOT NULL,
  `id_usuari_segueix` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de la taula `usuaris`
--

DROP TABLE IF EXISTS `usuaris`;
CREATE TABLE `usuaris` (
  `id_usuari` int(11) NOT NULL,
  `password` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `username` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nom` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cognoms` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data_ultim_acces` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `data_alta` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

