-- Criação das tabelas e inserção dos registros para fazer a atividade

drop database ExerciciosFIB;
create database ExerciciosFIB;
use ExerciciosFIB;
create table Coordenadas(
	ID_coordenadas int primary key auto_increment,
    latitude double not null,
    longitude double not null
);
create table Ambulancia(
	ID_ambulancia int primary key auto_increment,
    tipo varchar(20) not null
);
create table Equipe(
	ID_equipe int primary key auto_increment,
    nomeequipe varchar(20) not null,
    ID_ambulancia int, 
    foreign key(ID_ambulancia) references Ambulancia(ID_ambulancia)
);
create table Funcionario(
	ID_funcionario int primary key auto_increment,
    nome varchar(20) not null,
    salario double not null,
    ID_equipe int, 
    foreign key(ID_equipe) references Equipe(ID_equipe)
);
create table Chamado(
	ID_chamado int primary key auto_increment,
    solicitante varchar(20) not null,
    ID_funcionario int,
    ID_Equipe int,
    ID_coordenadas int,
    foreign key(ID_funcionario) references Funcionario(ID_funcionario),
    foreign key(ID_Equipe) references Equipe(ID_Equipe),
    foreign key(ID_coordenadas) references Coordenadas(ID_coordenadas)
);

insert into Coordenadas (latitude, longitude) values (-22.2989127, -49.0389815);
insert into Coordenadas (latitude, longitude) values (-22.3449531, -49.1078079);
insert into Coordenadas (latitude, longitude) values (-22.348534, -49.0329557);

insert into Ambulancia (tipo) values ("A");
insert into Ambulancia (tipo) values ("B");
insert into Ambulancia (tipo) values ("C");
insert into Ambulancia (tipo) values ("D");

insert into Equipe (nomeequipe, ID_ambulancia) values ("Equipe 1", 2);
insert into Equipe (nomeequipe, ID_ambulancia) values ("Equipe 2", 4);
insert into Equipe (nomeequipe, ID_ambulancia) values ("Equipe 3", 1);
insert into Equipe (nomeequipe, ID_ambulancia) values ("Equipe 4", 3);

insert into Funcionario (nome, ID_equipe, salario) values ("Felipe", 1, 900.00);
insert into Funcionario (nome, ID_equipe, salario) values ("Alex", 2, 1250.00);
insert into Funcionario (nome, ID_equipe, salario) values ("Karina", 1, 850.00);
insert into Funcionario (nome, ID_equipe, salario) values ("Pamela", 3, 1130.00);
insert into Funcionario (nome, ID_equipe, salario) values ("João", 4, 1200.00);
insert into Funcionario (nome, ID_equipe, salario) values ("Beatriz", 2, 1550.55);
insert into Funcionario (nome, ID_equipe, salario) values ("Jessica", 3, 2170.00);
insert into Funcionario (nome, ID_equipe, salario) values ("Janaina", 1, 1170.00);
insert into Funcionario (nome, ID_equipe, salario) values ("Matheus", 4, 2500.00);
insert into Funcionario (nome, ID_equipe, salario) values ("Bruna", 1, 499.00);
insert into Funcionario (nome, ID_equipe, salario) values ("Alex", 3, 4502.00);
insert into Funcionario (nome, ID_equipe, salario) values ("Jonathan", 4, 4170.00);
insert into Funcionario (nome, ID_equipe, salario) values ("Karina", 2, 1500.00);
insert into Funcionario (nome, ID_equipe, salario) values ("Pamela", 2, 2546.00);
insert into Funcionario (nome, ID_equipe, salario) values ("João", 1, 5210.00);

insert into Chamado (solicitante, ID_funcionario, ID_Equipe, ID_coordenadas) values ("Unimed", 2, 2, 1);
insert into Chamado (solicitante, ID_funcionario, ID_Equipe, ID_coordenadas) values ("Upa", 1, 1, 2);
insert into Chamado (solicitante, ID_funcionario, ID_Equipe, ID_coordenadas) values ("Hospital Estadual", 3, 2, 2);
insert into Chamado (solicitante, ID_funcionario, ID_Equipe, ID_coordenadas) values ("Hospital de Base", 4, 3, 3);

-- Exercícios (Tarefa 02)
-- 01

create view view1Ex1 as
select 
Equipe.nomeequipe as "Nome da Equipe", Ambulancia.tipo as "Tipo da Ambulancia", Coordenadas.latitude as "Latitude", Coordenadas.longitude as "Longitude"
from Chamado 
inner join Equipe on Equipe.ID_equipe = Chamado.ID_Equipe
inner join Coordenadas on Coordenadas.ID_coordenadas = Chamado.ID_coordenadas
inner join Ambulancia on Ambulancia.ID_ambulancia = Equipe.ID_ambulancia
where Chamado.solicitante = "Unimed";

create view view2Ex1 as
select 
Equipe.nomeequipe as "Nome da Equipe", Ambulancia.tipo as "Tipo da Ambulancia", Coordenadas.latitude as "Latitude", Coordenadas.longitude as "Longitude"
from Chamado 
inner join Equipe on Equipe.ID_equipe = Chamado.ID_Equipe
inner join Coordenadas on Coordenadas.ID_coordenadas = Chamado.ID_coordenadas
inner join Ambulancia on Ambulancia.ID_ambulancia = Equipe.ID_ambulancia
where Chamado.solicitante = "Upa";

create view view3Ex1 as
select 
Equipe.nomeequipe as "Nome da Equipe", Ambulancia.tipo as "Tipo da Ambulancia", Coordenadas.latitude as "Latitude", Coordenadas.longitude as "Longitude"
from Chamado 
inner join Equipe on Equipe.ID_equipe = Chamado.ID_Equipe
inner join Coordenadas on Coordenadas.ID_coordenadas = Chamado.ID_coordenadas
inner join Ambulancia on Ambulancia.ID_ambulancia = Equipe.ID_ambulancia
where Chamado.solicitante = "Hospital Estadual";

create view view4Ex1 as
select 
Equipe.nomeequipe as "Nome da Equipe", Ambulancia.tipo as "Tipo da Ambulancia", Coordenadas.latitude as "Latitude", Coordenadas.longitude as "Longitude"
from Chamado 
inner join Equipe on Equipe.ID_equipe = Chamado.ID_Equipe
inner join Coordenadas on Coordenadas.ID_coordenadas = Chamado.ID_coordenadas
inner join Ambulancia on Ambulancia.ID_ambulancia = Equipe.ID_ambulancia
where Chamado.solicitante = "Hospital de Base";

select * from view1Ex1;
select * from view2Ex1;
select * from view3Ex1;
select * from view4Ex1;

-- 02

create view view1Ex2 as
select 
ID_Equipe as "Código da Equipe"
from Chamado
group by ID_Equipe;

create view view2Ex2 as
select
nome as "Nome do Funcionário", count(nome) as "Funcionários com o mesmo nome"
from Funcionario
group by nome;

create view view3Ex2 as
select
Equipe.nomeequipe as "Equipes", count(Funcionario.ID_Equipe) as "Quantidade de pessoas na equipe"
from Funcionario
inner join Equipe on Equipe.ID_equipe = Funcionario.ID_Equipe
group by Funcionario.ID_Equipe;

select * from view1Ex2;
select * from view2Ex2;
select * from view3Ex2;

-- 03

create view view1Ex3 as
select
count(Funcionario.ID_Equipe) as "Pessoas em cada Equipe"
from Funcionario
inner join Equipe on Equipe.ID_equipe = Funcionario.ID_Equipe
group by Funcionario.ID_Equipe;

create view view2Ex3 as
select
Equipe.nomeequipe as "Equipe", avg(Funcionario.salario) as "Média salarial por Equipe"
from Funcionario
inner join Equipe on Equipe.ID_equipe = Funcionario.ID_Equipe
group by Funcionario.ID_Equipe;

create view view3Ex3 as
select
Equipe.nomeequipe as "Equipe", sum(Funcionario.salario) as "Salário total das Equipes"
from Funcionario
inner join Equipe on Equipe.ID_equipe = Funcionario.ID_Equipe
group by Funcionario.ID_Equipe;

select * from view1Ex3;
select * from view2Ex3;
select * from view3Ex3;

-- 04

create view view1Ex4 as
select
distinct nome as "Pessoa com salário entre 500 e 2500 que não tem o nome repetido"
from Funcionario
where salario between 500.00 and 2500.00;

create view view2Ex4 as
select nome as "Nome dos funcionários que começam com J", salario as "Salário"
from Funcionario
where nome like "J%";

create view view3Ex4 as
select * 
from Funcionario 
where ID_funcionario in (1, 3, 5);

select * from view1Ex4;
select * from view2Ex4;
select * from view3Ex4;