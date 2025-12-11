-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql server
*/

CREATE DATABASE photoTECH;

USE photoTECH;

CREATE TABLE empresa (
	id INT PRIMARY KEY AUTO_INCREMENT,
	razao_social VARCHAR(50),
	cnpj CHAR(14),
	codigo_ativacao VARCHAR(50)
);

CREATE TABLE usuario (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50),
	email VARCHAR(50),
	senha VARCHAR(50),
	fk_empresa INT,
	FOREIGN KEY (fk_empresa) REFERENCES empresa(id)
);

CREATE TABLE aviso (
	id INT PRIMARY KEY AUTO_INCREMENT,
	titulo VARCHAR(100),
	descricao VARCHAR(150),
	fk_usuario INT,
	FOREIGN KEY (fk_usuario) REFERENCES usuario(id)
);                    
				

create table dark_room (
/* em nossa regra de negócio, um aquario tem apenas um sensor */
	id INT PRIMARY KEY AUTO_INCREMENT,
	descricao VARCHAR(300),
	fk_empresa INT,
	FOREIGN KEY (fk_empresa) REFERENCES empresa(id)
);

/* esta tabela deve estar de acordo com o que está em INSERT de sua API do arduino - dat-acqu-ino */

create table medida (
	id INT PRIMARY KEY AUTO_INCREMENT,
	luminosidade INT,
	momento DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT luminosidadePercentual
		CHECK (luminosidade >= 0 AND luminosidade <= 100),
	fk_dark_room INT,
	FOREIGN KEY (fk_dark_room) REFERENCES dark_room(id)
);

insert into empresa (razao_social, codigo_ativacao) values ('Empresa 1', 'ED145B');
insert into empresa (razao_social, codigo_ativacao) values ('Empresa 2', 'A1B2C3');
insert into dark_room (descricao, fk_empresa) values ('Sala escura dedicada para filmes', 1);
insert into dark_room (descricao, fk_empresa) values ('Sala escura dedicada para fotos de esporte', 2);
INSERT INTO medida (luminosidade, fk_dark_room) VALUES
	(50, 2);

select * from empresa; 
select * from dark_room; 


SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));   

SELECT d.descricao, (
            SELECT luminosidade FROM medida WHERE fk_dark_room = d.id ORDER BY medida.id DESC LIMIT 1
        ) AS 'ultimo_registro', m.momento FROM medida m
            JOIN dark_room d ON fk_dark_room = d.id
            WHERE d.fk_empresa = 2
            GROUP BY d.id;