DROP DATABASE IF EXISTS BANCO;
CREATE DATABASE BANCO;

use BANCO;
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Banco de Dados: `banco`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `conta`
--

DROP TABLE IF EXISTS `conta`;
CREATE TABLE IF NOT EXISTS `conta` (
  `TipoConta` int(11) NOT NULL,
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `clienteCPF` varchar(255) DEFAULT NULL,
  `clienteDataNasc` date DEFAULT NULL,
  `clienteNome` varchar(255) DEFAULT NULL,
  `clienteRG` varchar(255) DEFAULT NULL,
  `clienteSobrenome` varchar(255) DEFAULT NULL,
  `saldo` float NOT NULL,
  `senha` varchar(255) DEFAULT NULL,
  `limite` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `clienteCPF` (`clienteCPF`),
  UNIQUE KEY `clienteRG` (`clienteRG`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Extraindo dados da tabela `conta`
--

INSERT INTO `conta` (`TipoConta`, `id`, `clienteCPF`, `clienteDataNasc`, `clienteNome`, `clienteRG`, `clienteSobrenome`, `saldo`, `senha`, `limite`) VALUES
(-805549676, 1, '123.456.789-09', '1980-01-01', 'Joao', NULL, 'da Silva', 4, '123', NULL),
(-2071168267, 2, '112.391.735-39', '1970-01-01', 'Pessoa', NULL, 'Qualquer', 3, '123', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `movimentacao`
--

DROP TABLE IF EXISTS `movimentacao`;
CREATE TABLE IF NOT EXISTS `movimentacao` (
  `TipoMovimento` varchar(31) NOT NULL,
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `dataExecucao` date DEFAULT NULL,
  `valor` float NOT NULL,
  `conta_id` bigint(20) DEFAULT NULL,
  `contaDestino_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK257EB9232DD48772` (`conta_id`),
  KEY `FK257EB923A9B806E8` (`contaDestino_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Extraindo dados da tabela `movimentacao`
--

INSERT INTO `movimentacao` (`TipoMovimento`, `ID`, `dataExecucao`, `valor`, `conta_id`, `contaDestino_id`) VALUES
('Deposito', 1, '2013-02-02', 9, 1, NULL),
('Deposito', 2, '2013-02-02', 1, 1, NULL),
('Deposito', 3, '2013-02-02', 1, 1, NULL),
('Deposito', 4, '2013-02-02', 1, 1, NULL),
('Saque', 5, '2013-02-02', 11, 1, NULL),
('Saque', 6, '2013-02-02', 1, 1, NULL),
('Deposito', 7, '2013-02-02', 7, 2, NULL),
('Transferencia', 8, '2013-02-02', 4, 2, 1);

--
-- Restrições para as tabelas dumpadas
--

--
-- Restrições para a tabela `movimentacao`
--
ALTER TABLE `movimentacao`
  ADD CONSTRAINT `FK257EB923A9B806E8` FOREIGN KEY (`contaDestino_id`) REFERENCES `conta` (`id`),
  ADD CONSTRAINT `FK257EB9232DD48772` FOREIGN KEY (`conta_id`) REFERENCES `conta` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
