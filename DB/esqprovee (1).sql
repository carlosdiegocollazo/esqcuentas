-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 08-10-2020 a las 14:17:08
-- Versión del servidor: 8.0.21
-- Versión de PHP: 7.3.21

START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `esqprovee`
--
CREATE DATABASE IF NOT EXISTS `esqprovee` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE esqprovee;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cheques`
--

DROP TABLE IF EXISTS `cheques`;
CREATE TABLE IF NOT EXISTS `cheques` (
  `idcheq` int NOT NULL AUTO_INCREMENT,
  `nrocheq` int NOT NULL,
  `banco` text NOT NULL,
  `moneda` int NOT NULL,
  `fechemi` date NOT NULL,
  `fechpag` date NOT NULL,
  `fechcob` date NOT NULL,
  `activo` tinyint NOT NULL,
  PRIMARY KEY (`idcheq`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizacion`
--

DROP TABLE IF EXISTS `cotizacion`;
CREATE TABLE IF NOT EXISTS `cotizacion` (
  `idcot` int NOT NULL AUTO_INCREMENT,
  `fechcot` date NOT NULL,
  `moneda` int NOT NULL,
  `impcot` int NOT NULL,
  `deldia` tinyint NOT NULL,
  `activo` int NOT NULL,
  PRIMARY KEY (`idcot`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos`
--

DROP TABLE IF EXISTS `documentos`;
CREATE TABLE IF NOT EXISTS `documentos` (
  `Idtipdoc` int NOT NULL AUTO_INCREMENT,
  `tipodoc` text NOT NULL,
  `moneda` int NOT NULL,
  `activo` tinyint(1) NOT NULL,
  PRIMARY KEY (`Idtipdoc`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `monedas`
--

DROP TABLE IF EXISTS `monedas`;
CREATE TABLE IF NOT EXISTS `monedas` (
  `idmon` int NOT NULL AUTO_INCREMENT,
  `moneda` text NOT NULL,
  `divide` int NOT NULL,
  `activo` int NOT NULL,
  PRIMARY KEY (`idmon`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `monedas`
--

INSERT INTO `monedas` (`idmon`, `moneda`, `divide`, `activo`) VALUES
(1, 'Pesos', 1, 1),
(2, 'Dolares', 1, 1),
(15, 'Australes', 1, 0),
(14, 'Reales', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimientos`
--

DROP TABLE IF EXISTS `movimientos`;
CREATE TABLE IF NOT EXISTS `movimientos` (
  `idmov` int NOT NULL AUTO_INCREMENT,
  `proveedor` int NOT NULL,
  `tipdoc` int NOT NULL,
  `nrofac` int NOT NULL,
  `fechemi` date NOT NULL,
  `fechpag` date NOT NULL,
  `moneda` int NOT NULL,
  `fechcheq` date NOT NULL,
  `nrocheq` int NOT NULL,
  `debe` int NOT NULL,
  `haber` int NOT NULL,
  `saldo` int NOT NULL,
  `saldtot` int NOT NULL,
  `nrorec` int NOT NULL,
  `activo` tinyint NOT NULL,
  PRIMARY KEY (`idmov`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
CREATE TABLE IF NOT EXISTS `proveedores` (
  `idpro` int NOT NULL AUTO_INCREMENT,
  `rutced` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `razon` text CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `nomfantasia` text NOT NULL,
  `nombre` text NOT NULL,
  `apellido` text NOT NULL,
  `fechingr` date NOT NULL,
  `telefono` text NOT NULL,
  `direccion` text NOT NULL,
  `moneda` int NOT NULL,
  `seguridad` int NOT NULL,
  `saldoinicial` int NOT NULL,
  `saldototal` int NOT NULL,
  `retorno` int NOT NULL,
  `fechret` date NOT NULL,
  `retactivo` int NOT NULL,
  `observaciones` text NOT NULL,
  `activo` tinyint(1) NOT NULL,
  PRIMARY KEY (`idpro`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`idpro`, `rutced`, `razon`, `nomfantasia`, `nombre`, `apellido`, `fechingr`, `telefono`, `direccion`, `moneda`, `seguridad`, `saldoinicial`, `saldototal`, `retorno`, `fechret`, `retactivo`, `observaciones`, `activo`) VALUES
(1, '${usuario.razon}', '${usuario.apellido}', '', 'Administrador de EsQProvee', 'Esquema Servicios', '2020-09-01', '${usuario.telefono}', '${usuario.direccion}', 1, 0, 0, 0, 1, '2021-12-31', 1, '${usuario.observaciones}', 1),
(3, '${proveedor.rutced}', '${proveedor.razon}', '${proveedor.nomfantasia}', '${proveedor.nombre}', '${proveedor.apellido}', '2020-09-01', '${proveedor.telefono}', '${proveedor.direccion}', 0, 0, 0, 0, 0, '2020-09-01', 0, '${proveedor.observaciones}', 0),
(4, '${usuario.razon}', '${usuario.apellido}', '', 'Administrador de EsQProvee', 'Esquema Servicios', '0000-00-00', '${usuario.telefono}', '${usuario.direccion}', 1, 0, 0, 1000, 1, '2021-12-31', 1, '${usuario.observaciones}', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguridad`
--

DROP TABLE IF EXISTS `seguridad`;
CREATE TABLE IF NOT EXISTS `seguridad` (
  `idseg` int NOT NULL AUTO_INCREMENT,
  `categoria` text NOT NULL,
  `descripcion` text NOT NULL,
  `activo` text NOT NULL,
  PRIMARY KEY (`idseg`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `seguridad`
--

INSERT INTO `seguridad` (`idseg`, `categoria`, `descripcion`, `activo`) VALUES
(0, '0', 'Administrador', '1'),
(1, '1', 'Administrativo', '1'),
(2, '2', 'Consultante', '1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `idusu` int NOT NULL AUTO_INCREMENT,
  `email` text NOT NULL,
  `pass` text NOT NULL,
  `apellidos` text NOT NULL,
  `nombres` text NOT NULL,
  `telefono` text NOT NULL,
  `direccion` text NOT NULL,
  `ciudad` text NOT NULL,
  `seguridad` int NOT NULL,
  `fechnac` date NOT NULL,
  `feching` date NOT NULL,
  `observaciones` text NOT NULL,
  `activo` int NOT NULL,
  PRIMARY KEY (`idusu`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`idusu`, `email`, `pass`, `apellidos`, `nombres`, `telefono`, `direccion`, `ciudad`, `seguridad`, `fechnac`, `feching`, `observaciones`, `activo`) VALUES
(1, 'admin@mail.com', '827ccb0eea8a706c4c34a16891f84e7b', 'Collazo', 'Diego', '099550624', 'Salto1262', 'Montevideo', 0, '0000-00-00', '0000-00-00', '', 1),
(2, 'admini@mail.com', '827ccb0eea8a706c4c34a16891f84e7b', 'Collazo', 'Diego', '099550624', 'Salto1262', 'Montevideo', 0, '0000-00-00', '0000-00-00', '', 1);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
