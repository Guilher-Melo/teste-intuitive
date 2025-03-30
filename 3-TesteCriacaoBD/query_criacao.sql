CREATE TABLE relatorio_cadop (
	registro_ans VARCHAR(10) NOT NULL,
	cnpj VARCHAR(18) NOT NULL,
	razao_social VARCHAR(255) NOT NULL,
	nome_fantasia VARCHAR(255),
	modalidade VARCHAR(255) NOT NULL,
	logradouro VARCHAR(255) NOT NULL,
	numero VARCHAR(30),
	complemento VARCHAR(150),
	bairro VARCHAR(100),
	cidade VARCHAR(100) NOT NULL,
	uf VARCHAR(5) NOT NULL,
	cep VARCHAR(15) NOT NULL,
	ddd VARCHAR(8),
	telefone VARCHAR(20),
	fax VARCHAR(20),
	endereco_eletronico VARCHAR(150),
	representante VARCHAR (255) NOT NULL,
	cargo_representante VARCHAR (150) NOT NULL,
	regiao_de_comercializacao VARCHAR(10),
	data_registro_ans DATE
);


CREATE TABLE contas_contabeis (
    data DATE NOT NULL,
    registro_ans VARCHAR(10) NOT NULL,
    cd_conta_contabil VARCHAR(20) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    vl_saldo_inicial DECIMAL(15,2),
    vl_saldo_final DECIMAL(15,2) NOT NULL
);


-- Conceder privilégio para carregar arquivos
GRANT FILE ON *.* TO 'mysql-teste'@'%';

FLUSH PRIVILEGES;

-- Caminho do CONTAINER
LOAD DATA INFILE '/var/lib/mysql-files/Relatorio_cadop.csv'
INTO TABLE relatorio_cadop 
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
IGNORE 1 ROWS;


LOAD DATA INFILE '/var/lib/mysql-files/1T2023.csv'
INTO TABLE detalhes_contas
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
IGNORE 1 ROWS
(@data, @registro_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET
    data = @data,
    registro_ans = @registro_ans,
    cd_conta_contabil = @cd_conta_contabil,
    descricao = @descricao,
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');


LOAD DATA INFILE '/var/lib/mysql-files/2t2023.csv'
INTO TABLE detalhes_contas
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
IGNORE 1 ROWS
(@data, @registro_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET
    data = @data,
    registro_ans = @registro_ans,
    cd_conta_contabil = @cd_conta_contabil,
    descricao = @descricao,
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');



LOAD DATA INFILE '/var/lib/mysql-files/3T2023.csv'
INTO TABLE detalhes_contas
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
IGNORE 1 ROWS
(@data, @registro_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET
    data = @data,
    registro_ans = @registro_ans,
    cd_conta_contabil = @cd_conta_contabil,
    descricao = @descricao,
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');


LOAD DATA INFILE '/var/lib/mysql-files/4T2023.csv'
INTO TABLE detalhes_contas
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
IGNORE 1 ROWS
(@data, @registro_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET
    data = STR_TO_DATE(@data, '%d/%m/%Y'),
    registro_ans = @registro_ans,
    cd_conta_contabil = @cd_conta_contabil,
    descricao = @descricao,
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');


LOAD DATA INFILE '/var/lib/mysql-files/1T2024.csv'
INTO TABLE detalhes_contas
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
IGNORE 1 ROWS
(@data, @registro_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET
    data = @data,
    registro_ans = @registro_ans,
    cd_conta_contabil = @cd_conta_contabil,
    descricao = @descricao,
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');


LOAD DATA INFILE '/var/lib/mysql-files/2T2024.csv'
INTO TABLE detalhes_contas
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
IGNORE 1 ROWS
(@data, @registro_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET
    data = @data,
    registro_ans = @registro_ans,
    cd_conta_contabil = @cd_conta_contabil,
    descricao = @descricao,
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');


LOAD DATA INFILE '/var/lib/mysql-files/3T2024.csv'
INTO TABLE detalhes_contas
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
IGNORE 1 ROWS
(@data, @registro_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET
    data = @data,
    registro_ans = @registro_ans,
    cd_conta_contabil = @cd_conta_contabil,
    descricao = @descricao,
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');


LOAD DATA INFILE '/var/lib/mysql-files/4T2024.csv'
INTO TABLE detalhes_contas
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
IGNORE 1 ROWS
(@data, @registro_ans, @cd_conta_contabil, @descricao, @vl_saldo_inicial, @vl_saldo_final)
SET
    data = @data,
    registro_ans = @registro_ans,
    cd_conta_contabil = @cd_conta_contabil,
    descricao = @descricao,
    vl_saldo_inicial = REPLACE(@vl_saldo_inicial, ',', '.'),
    vl_saldo_final = REPLACE(@vl_saldo_final, ',', '.');