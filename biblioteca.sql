create database biblioteca;

use biblioteca;

create table autor(
	codigo int not null identity,
	nome varchar(100) not null,
	cpf bigint not null,
	primary key(codigo)
);

create table editora(
	codigo int not null identity,
	nome varchar(100) not null,
	cidade varchar(100) not null, 
	registro date not null,
	primary key(codigo)
);

create table genero(
	codigo int not null identity,
	nome varchar(100) not null,
	primary key(codigo)
);

create table livro(
	isbn int not null identity,
	cod_genero int not null,
	cod_editora int not null,
	titulo varchar(100) not null,
	edicao int not null,
	volume int not null,
	valor smallmoney not null,
	primary key(isbn),
	constraint fk_livro_genero foreign key (cod_genero) references genero(codigo),
	constraint fk_livro_editora foreign key (cod_editora) references editora(codigo)
);

create table autoria(
	codigo int not null identity,
	isbn_livro int not null,
	cod_autor int not null,
	primary key(codigo),
	constraint fk_autoria_livro foreign key (isbn_livro) references livro(isbn),
	constraint fk_autoria_autor foreign key (cod_autor) references autor(codigo)
);

create table exemplar(
	codigo int not null identity,
	isbn_livro int not null,
	status varchar(100) not null,
	primary key(codigo),
	constraint fk_exemplar_livro foreign key (isbn_livro) references livro(isbn)
);

create table perfil(
	codigo int not null identity,
	nome varchar(100) not null,
	limite int not null,
	prazo date not null,
	primary key(codigo),
);

create table usuario(
	cpf bigint not null identity,
	cod_perfil int not null,
	nome varchar(100) not null,
	endereco varchar(200) not null,
	telefone bigint not null,
	email varchar(100) not null,
	primary key(cpf),
);

create table emprestimo(
	codigo int not null identity,
	cod_exemplar int not null,
	cpf_usuario bigint not null,
	data_saida date not null,
	data_entrega date not null,
	prazo date not null,
	primary key(codigo),
	constraint fk_emprestimo_exemplar foreign key (cod_exemplar) references exemplar(codigo),
	constraint fk_emprestimo_usuario foreign key (cpf_usuario) references usuario(cpf)
);

insert into autor values ('Michelle Quach', 83727330474);
insert into autor values ('Adam Silvera', 93762304719);
insert into autor values ('Mo Xiang Tong Xiu', 76243873687);
insert into autor values ('Kii Kanna', 34764387433);

select * from autor

insert into autoria values (6555604883, 1);
insert into autoria values (6555603026, 2);
insert into autoria values (1648279171, 3);
insert into autoria values (6586799643, 4);

select * from autoria

insert into editora values ('Intrínseca', 'Rio de Janeiro, Brasil', 14-04-2022);
insert into editora values ('Intrínseca', 'Rio de Janeiro, Brasil', 04/10/2021);
insert into editora values ('Seven Seas', 'Los Angeles, Califórnia', 04/10/2021);
insert into editora values ('NewPOP', 'Brasil', 07/04/2022);

select * from editora

insert into emprestimo values (1, 1, 02554535245, 22-10-2022, 29-10-2022, 04-11-2022);
insert into emprestimo values (2, 2, 12545556235, 26-10-2022, 03-11-2022, 16-11-2022);
insert into emprestimo values (3, 3, 33652456256, 12-10-2022, 20-10-2022, 13-11-2022);
insert into emprestimo values (4, 4, 63352500284, 28-10-2022, 05-11-2022, 20-11-2022);

select * from emprestimo

insert into exemplar values (0, 6555604883, 'Disponível');
insert into exemplar values (0, 6555603026, 'Disponível');
insert into exemplar values (0, 1648279171, 'Indisponível');
insert into exemplar values (0, 6586799643, 'Disponível');

select * from exemplar

insert into genero values ('Problemas Sociais e na Família para Adolescentes');
insert into genero values ('Death-Cast');
insert into genero values ('Fantasia Histórica');
insert into genero values ('Mangá HQs, Mangás e Graphic Novels');

select * from genero

insert into livro values (6555604883, 1, 1, 'Não Nasci Para Agradar', 1, 1, 36.99);
insert into livro values (6555603026, 2, 2, 'Os Dois Morrem No Final', 1, 1, 48.50);
insert into livro values (1648279171, 3, 3, 'Heaven Officials Blessing: Tian Guan CI Fu', 1, 1, 118.55);
insert into livro values (6586799643, 4, 4, 'Umibe no Étranger', 1, 1, 23.90);

select * from livro

insert into perfil values ('Leonardo', 12, 04-11-2022);
insert into perfil values ('Lohanna', 21, 16-11-2022);
insert into perfil values ('Victorio', 32, 13-11-2022);
insert into perfil values ('Maya', 23, 20-11-2022);

select * from perfil

insert into usuario values (02554535245, 1, 'Leonardo Cerqueira', 'Avenida Governador José Malcher, Nº12', 015934189242, 'leo.cerqueira@gmail.com');
insert into usuario values (12545556235, 2, 'Lohanna Ferraz', 'Rua Pereira Estéfano, Nº 47', 046931586314, 'ferraz.lohanna@gmail.com');
insert into usuario values (33652456256, 3, 'Victorio Kess', 'Rua Maria Luísa do Val Penteado, Nº 81', 058964821389, 'vic.kess@gmail.com');
insert into usuario values (63352500284, 4, 'Maya Luisa', 'Avenida Afonso Pena, Nº 94', 081957156834, 'luisa.clara@gmail.com');

select * from usuario
