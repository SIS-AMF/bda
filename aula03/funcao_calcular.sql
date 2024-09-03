create function soma(integer, integer) returns integer as
'
select $1 + $2;
'
language 'sql';



select soma(1,1);

drop function soma;

# Teste

create table departamentos (
id serial,
descricao varchar(30),
primary key(id)
);

create table cidades (
id serial,
nome varchar(40),
primary key(id)
);

insert into departamentos (id, descricao) values 
(1, 'Financeiro'),
(2, 'Contabil'),
(3, 'TI');

insert into cidades (id, nome) values
(1, 'Pelotas'),
(2, 'Porto Alegre'),
(3, 'Sao Paulo'),
(4, 'Rio de Janeiro');

insert into funcionarios (id, nome, depto_id, cidade_id) values 
(1, 'Jose',1,1),
(2,'Maria',2,3),
(3,'Pedro',1,4),
(4,'Ana',2,1);

select * from funcionarios as f, departamentos as d
where f.depto_id = d.id;

create function buscaFuncionarioIDDepto(integer) returns funcionarios as
'
select * from funcionarios as f
where f.depto_id = $1;
'
language 'sql';

create function buscaFuncionarioIDDepto(integer) returns setof funcionarios as
'
select * from funcionarios as f
where f.depto_id = $1;
'
language 'sql';

create function countFuncionarioByCity(varchar(40)) returns integer as
'
select count(f.id) from funcionarios as f, cidades as c where
f.cidade_id = c.id and c.nome like $1;
'
language 'sql';

select countFuncionarioByCity(varchar 'Pelotas');
select countFuncionarioByCity('Pelotas');


CREATE FUNCTION qtdFuncionarioByCity()
RETURNS TABLE(city_name varchar, employee_count integer) AS
' 
    SELECT c.nome, COUNT(f.id) 
    FROM funcionarios AS f
    JOIN cidades AS c ON f.cidade_id = c.id 
    GROUP BY c.nome;
' 
LANGUAGE 'sql';



create or replace function 
retorna_nome_funcionario(func_id int)
returns text as
$$
declare
nome text;
situacao text;
begin

select funcionario_nome, funcionario_situacao
into nome, situacao
from funcionarios_testIF
where id = func_id;
if situacao = 'A' then
return nome || ' Usuario Ativo'; 
else
return nome || ' Usuario Inativo';
end if;
end
$$
language 'plpgsql';

create table funcionarios_testIF(                                                                                                      
id int primary key,                                       
funcionario_codigo varchar(20),
funcionario_nome varchar(100),
funcionario_situacao varchar(1) default 'A',
funcionario_comissao real,
funcionario_cargo varchar(30),
data_criacao timestamp,
data_autorizacao timestamp
);

insert into funcionarios_testif (id,funcionario_nome,funcionario_situacao,funcionario_comissao,funcionario_cargo, data_criacao) values 
('0001','VINICIUS CARVALHO','B',5,'GERENTE','01/01/2016'),
('0002','SOUZA','A',2,'GARCOM','01/01/2016');

CREATE TABLE empregados (
    codigo SERIAL PRIMARY KEY,
    nome_emp TEXT,
    salario INT,
    departamento_cod INT,
    FOREIGN KEY (departamento_cod) REFERENCES departamentos(id)    
);
