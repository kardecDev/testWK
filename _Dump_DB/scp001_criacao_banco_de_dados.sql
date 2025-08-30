/*
Description: Este escript possui as seguites funcionalidades
			a) Cria o banco de dados e o seleciona [db_pedidos].
			b) Cria a estrutura de tabelas.
			c) Insere dados ficticios para testes
			
Created By: Allan.Alves
Created At: 30/08/2025
*/

-- Desativa o "safe update mode" apenas nesta sessão para permitir 
-- DELETE sem WHERE isto torna este script re-executavel sem duplicar
-- os registros. 
SET SQL_SAFE_UPDATES = 0;

--
-- Cria banco de dados `DB_PEDIDOS`
--
CREATE DATABASE IF NOT EXISTS db_pedidos;
USE db_pedidos;

--
-- Estrutura da Tabela `CLIENTES`
--
CREATE TABLE IF NOT EXISTS `clientes` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `cidade` VARCHAR(150) NOT NULL,
  `uf` CHAR(2) NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `idx_clientes_nome` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Estrutura da Tabela `PRODUTOS`
--
CREATE TABLE IF NOT EXISTS `produtos` (
  `codigo` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(255) NOT NULL,
  `preco_venda` DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (`codigo`),
  INDEX `idx_produtos_descricao` (`descricao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Estrutura da Tabela `PEDIDO_DADOS_GERAIS`
--
CREATE TABLE IF NOT EXISTS `pedido_dados_gerais` (
  `numero_pedido` INT NOT NULL AUTO_INCREMENT,
  `data_emissao` DATE NOT NULL,
  `codigo_cliente` INT NOT NULL,
  `valor_total` DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (`numero_pedido`),
  INDEX `idx_pedido_dados_gerais_cliente` (`codigo_cliente`),
  CONSTRAINT `fk_pedido_cliente`
    FOREIGN KEY (`codigo_cliente`)
    REFERENCES `clientes` (`codigo`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Estrutura da Tabela `PEDIDO_PRODUTOS`
--
CREATE TABLE IF NOT EXISTS `pedido_produtos` (
  `id_produto` INT NOT NULL AUTO_INCREMENT,
  `numero_pedido` INT NOT NULL,
  `codigo_produto` INT NOT NULL,
  `quantidade` DECIMAL(10, 2) NOT NULL,
  `vlr_unitario` DECIMAL(10, 2) NOT NULL,
  `vlr_total` DECIMAL(10, 2) NOT NULL,
  PRIMARY KEY (`id_produto`),
  INDEX `idx_pedido_produtos_pedido` (`numero_pedido`),
  INDEX `idx_pedido_produtos_produto` (`codigo_produto`),
  CONSTRAINT `fk_produto_pedido_dados_gerais`
    FOREIGN KEY (`numero_pedido`)
    REFERENCES `pedido_dados_gerais` (`numero_pedido`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_produto_produtos`
    FOREIGN KEY (`codigo_produto`)
    REFERENCES `produtos` (`codigo`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



-- **Scripts de Inserção de Dados (50 Clientes e 50 Produtos)**

--
-- Inserção de 50 Clientes (dados fictícios)
--
DELETE FROM `clientes`;
INSERT INTO `clientes` (`nome`, `cidade`, `uf`) VALUES
('João da Silva', 'São Paulo', 'SP'),
('Maria Oliveira', 'Rio de Janeiro', 'RJ'),
('Pedro Santos', 'Belo Horizonte', 'MG'),
('Ana Costa', 'Salvador', 'BA'),
('Carlos Pereira', 'Curitiba', 'PR'),
('Mariana Almeida', 'Porto Alegre', 'RS'),
('Fernando Lima', 'Recife', 'PE'),
('Julia Rodrigues', 'Fortaleza', 'CE'),
('Lucas Fernandes', 'Brasília', 'DF'),
('Laura Martins', 'Manaus', 'AM'),
('Felipe Gomes', 'Goiânia', 'GO'),
('Isabela Santos', 'Belém', 'PA'),
('Guilherme Pereira', 'Campo Grande', 'MS'),
('Luiza Rocha', 'Cuiabá', 'MT'),
('Rafael Carvalho', 'Florianópolis', 'SC'),
('Camila Dias', 'Vitória', 'ES'),
('Thiago Silva', 'Natal', 'RN'),
('Gabriela Oliveira', 'João Pessoa', 'PB'),
('Daniel Costa', 'Teresina', 'PI'),
('Beatriz Lima', 'Maceió', 'AL'),
('Bruno Almeida', 'Aracaju', 'SE'),
('Amanda Gomes', 'Porto Velho', 'RO'),
('Leonardo Martins', 'Boa Vista', 'RR'),
('Patrícia Rodrigues', 'Palmas', 'TO'),
('Eduardo Ferreira', 'São Luís', 'MA'),
('Vanessa Cardoso', 'Macapá', 'AP'),
('Gustavo Ribeiro', 'Uberlândia', 'MG'),
('Lívia Souza', 'Ribeirão Preto', 'SP'),
('André Barros', 'Campinas', 'SP'),
('Carolina Nogueira', 'São José dos Campos', 'SP'),
('Thiago Mendes', 'Osasco', 'SP'),
('Letícia Barbosa', 'Santo André', 'SP'),
('Ricardo Ramos', 'São Bernardo do Campo', 'SP'),
('Fernanda Castro', 'Sorocaba', 'SP'),
('João Pedro Alves', 'Jundiaí', 'SP'),
('Maria Clara Melo', 'Taubaté', 'SP'),
('Paulo Henrique Diniz', 'Santos', 'SP'),
('Beatriz Costa', 'Guarulhos', 'SP'),
('Lucas Gabriel', 'Diadema', 'SP'),
('Sofia Oliveira', 'Suzano', 'SP'),
('Caio Felipe', 'Mogi das Cruzes', 'SP'),
('Julia Almeida', 'Carapicuíba', 'SP'),
('Arthur Santos', 'Itaquaquecetuba', 'SP'),
('Ana Laura Silva', 'Taboão da Serra', 'SP'),
('Bruno Ferreira', 'Barueri', 'SP'),
('Mariana Teixeira', 'Cotia', 'SP'),
('Henrique Rocha', 'Embu das Artes', 'SP'),
('Juliana Alves', 'Franco da Rocha', 'SP'),
('Pedro Henrique', 'Cabo Frio', 'RJ'),
('Gabriela Nunes', 'Niterói', 'RJ');

--
-- Inserção de 50 Produtos (dados fictícios)
--
DELETE FROM `produtos`;
INSERT INTO `produtos` (`descricao`, `preco_venda`) VALUES
('Monitor LED 24 polegadas', 850.00),
('Teclado Mecânico Gamer', 350.50),
('Mouse Óptico Sem Fio', 89.90),
('Webcam Full HD', 215.00),
('Headset Gamer com Microfone', 299.99),
('Placa de Vídeo NVIDIA GeForce RTX 3060', 2500.00),
('Processador Intel Core i7', 1800.00),
('SSD 512GB', 450.00),
('Memória RAM 16GB DDR4', 620.00),
('Gabinete ATX com Vidro Temperado', 410.00),
('Cadeira de Escritório Ergonômica', 550.00),
('Impressora Multifuncional Epson', 780.00),
('Roteador Wi-Fi 6', 380.00),
('HD Externo 1TB', 320.00),
('Notebook Dell Core i5', 3899.99),
('Smartphone Samsung Galaxy S21', 4500.00),
('Smart TV 55 polegadas 4K', 2900.00),
('Console PlayStation 5', 4999.00),
('Controle de Xbox Wireless', 350.00),
('Kit de Ferramentas com 128 peças', 150.00),
('Bateria Portátil 20000mAh', 120.00),
('Caixa de Som Bluetooth', 99.90),
('Microfone Condensador USB', 250.00),
('Drone DJI Mini SE', 2100.00),
('Relógio Inteligente Smartwatch', 280.00),
('Fone de Ouvido Sem Fio Bluetooth', 180.00),
('Carregador USB de Parede', 45.00),
('Adaptador HDMI para VGA', 35.00),
('Projetor Portátil LED', 650.00),
('Leitor de Código de Barras', 190.00),
('Estabilizador de Energia 1000VA', 130.00),
('Mesa de Escritório com Gavetas', 490.00),
('Webcam 720p', 120.00),
('Placa Mãe B450M', 550.00),
('Fonte de Alimentação 650W', 420.00),
('Placa de Som USB', 80.00),
('Cabo de Rede Ethernet 10m', 25.00),
('Hub USB 3.0', 50.00),
('Adaptador de Tomada Universal', 20.00),
('Scanner de Documentos Portátil', 480.00),
('Kit Limpeza de Eletrônicos', 30.00),
('Extensor HDMI sem Fio', 300.00),
('Suporte para Monitor Articulado', 95.00),
('Case para HD Externo 2.5"', 40.00),
('Teclado Sem Fio com Touchpad', 140.00),
('Mini Ventilador USB', 25.00),
('Luminária LED para Mesa', 60.00),
('Protetor de Surto com 6 Tomadas', 75.00),
('Cabo USB-C de Carregamento Rápido', 35.00),
('Mouse Pad Grande Gamer', 45.00);
