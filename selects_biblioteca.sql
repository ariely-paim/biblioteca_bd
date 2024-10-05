create database atvdd_biblioteca;

use atvdd_biblioteca;

create table autor(
	codigo int not null identity,
	nome varchar(100) not null,
	cpf bigint not null,
	primary key(codigo)
);

create table editora(
	codigo int not null identity,
	nome varchar(100) not null,
	cidade varchar(100) null, 
	registro varchar(100) null,
	primary key(codigo)
);

create table genero(
	codigo int not null identity,
	nome varchar(100) not null,
	primary key(codigo)
);

create table livro(
	isbn varchar(50) not null,
	cod_genero int not null,
	cod_editora int not null,
	titulo varchar(100) not null,
	edicao int null,
	volume int null,
	valor smallmoney null,
	primary key(isbn),
	constraint fk_livro_genero foreign key (cod_genero) references genero(codigo),
	constraint fk_livro_editora foreign key (cod_editora) references editora(codigo)
);

create table autoria(
	codigo int not null identity,
	isbn_livro varchar(50) not null,
	cod_autor int not null,
	primary key(codigo),
	constraint fk_autoria_livro foreign key (isbn_livro) references livro(isbn),
	constraint fk_autoria_autor foreign key (cod_autor) references autor(codigo)
);

create table exemplar(
	codigo int not null identity,
	isbn_livro varchar(50) not null,
	status varchar(100) null,
	primary key(codigo),
	constraint fk_exemplar_livro foreign key (isbn_livro) references livro(isbn)
);

create table perfil(
	codigo int not null identity,
	nome varchar(100) not null,
	limite int null,
	prazo date null,
	primary key(codigo),
);

create table usuario(
	cpf bigint not null identity,
	cod_perfil int not null,
	nome varchar(100) not null,
	endereco varchar(200) null,
	telefone bigint null,
	email varchar(100) null,
	primary key(cpf),
	constraint fk_usuario_perfil foreign key (cod_perfil) references perfil(codigo)
);

create table emprestimo(
	codigo int not null identity,
	cod_exemplar int not null,
	cpf_usuario bigint not null,
	data_saida date null,
	data_entrega date null,
	prazo int null,
	primary key(codigo),
	constraint fk_emprestimo_exemplar foreign key (cod_exemplar) references exemplar(codigo),
	constraint fk_emprestimo_usuario foreign key (cpf_usuario) references usuario(cpf)
);

insert into autor values ('Michelle Quach', 83727330474);
insert into autor values ('Adam Silvera', 93762304719);
insert into autor values ('Mo Xiang Tong Xiu', 76243873687);
insert into autor values ('Kii Kanna', 34764387433);
insert into autor values ('Cassandra Clare', 34764387468);
select * from autor;

insert into editora values ('Intrínseca', 'Rio de Janeiro, Brasil', null);
insert into editora values ('Intrínseca', 'Rio de Janeiro, Brasil', null);
insert into editora values ('Seven Seas', 'Los Angeles, Califórnia', null);
insert into editora values ('NewPOP', 'Brasil', null);
select * from editora

insert into genero values ('Problemas Sociais e na Família para Adolescentes');
insert into genero values ('Death-Cast');
insert into genero values ('Fantasia Histórica');
insert into genero values ('Mangá HQs, Mangás e Graphic Novels');
select * from genero

insert into perfil values ('Leonardo', 0, '04-11-2022');
insert into perfil values ('Lohanna', 0, '16-11-2022');
insert into perfil values ('Victorio', 0, '13-11-2022');
insert into perfil values ('Maya', 0, '20-11-2022');
select * from perfil

insert into usuario values (1, 'Leonardo Cerqueira', 'Avenida Governador José Malcher, Nº12', 015934189242, 'leo.cerqueira@gmail.com');
insert into usuario values (2, 'Lohanna Ferraz', 'Rua Pereira Estéfano, Nº 47', 046931586314, 'ferraz.lohanna@gmail.com');
insert into usuario values (3, 'Victorio Kess', 'Rua Maria Luísa do Val Penteado, Nº 81', 058964821389, 'vic.kess@gmail.com');
insert into usuario values (4, 'Maya Luisa', 'Avenida Afonso Pena, Nº 94', 081957156834, 'luisa.clara@gmail.com');
select * from usuario

insert into livro values (6555604883, 1, 1, 'Não Nasci Para Agradar', 1, 1, 36.99);
insert into livro values (6555603026, 2, 2, 'Os Dois Morrem No Final', 1, 1, 48.50);
insert into livro values (1648279171, 3, 3, 'Heaven Officials Blessing: Tian Guan CI Fu', 1, 1, 118.55);
insert into livro values (6586799643, 4, 4, 'Umibe no Étranger', 1, 1, 23.90);
select * from livro

insert into autoria values (6555604883, 1);
insert into autoria values (6555603026, 2);
insert into autoria values (1648279171, 3);
insert into autoria values (6586799643, 4);
select * from autoria

insert into exemplar values (6555604883, 'Disponível');
insert into exemplar values (6555603026, 'Disponível');
insert into exemplar values (1648279171, 'Indisponível');
insert into exemplar values (6586799643, 'Disponível');
select * from exemplar

insert into emprestimo values (1, 1, '22-10-2022', '29-10-2022', null);
insert into emprestimo values (2, 2, '26-10-2022', '03-11-2022', null);
insert into emprestimo values (3, 3, '12-10-2022', '20-10-2022', null);
insert into emprestimo values (4, 4, '28-10-2022', '05-11-2022', null);
select * from emprestimo

---select codigo, nome from autor
---where codigo >= 1 and codigo <= 4;

select codigo, nome from autor
where codigo between 1 and 4;

select codigo, nome from autor
where codigo not between 1 and 4;

select isbn, titulo from livro
where titulo like 'Ja%';

select isbn, titulo, edicao from livro
where cod_editora in(1,2,3,4);

select isbn, titulo, edicao from livro
where cod_editora not in(1,2,3,4);

select codigo, nome from autor
where codigo = 1 and nome = 'Hebert';

select codigo, nome from autor
where codigo = 1 or nome = 'Hebert';

select count(cod_exemplar) as 'Quantidade de livros emprestado' from emprestimo;

select count(cod_exemplar) as 'Quantidade de livros emprestado cujo CPF do usuário seja 123' from emprestimo
where cpf_usuario = 123;

select data_saida as 'Data de saída dos empréstimos cujo a data de entrega seja nula' from emprestimo
where data_entrega = null;

select sum(valor) as 'Soma dos livros' from livro;

select avg(valor) as 'Média dos livros' from livro;

select min(valor) as 'Menor valor dos livros' from livro;

select max(valor) as 'Maior valor dos livros' from livro;

select count(isbn) as 'Quantidade de livros cadastrados' from livro;

select us.nome as 'Nome do usuário', count(em.codigo) as 'Quantidade de emprestimos realizados' from usuario us inner join perfil pf on us.cod_perfil = pf.codigo inner join emprestimo em on us.cpf = em.cpf_usuario group by us.nome;

select li.titulo as 'Titulo do livro', sum(li.valor) as 'Valor total dos exemplares' from autor au inner join autoria aut on au.codigo = aut.cod_autor inner join livro li on li.isbn = aut.isbn_livro group by li.titulo;

select au.nome as 'Nome do autor', count(li.isbn) as 'Quantidade de livros de sua autoria' from autor au inner join autoria aut on au.codigo = aut.cod_autor inner join livro li on li.isbn = aut.isbn_livro group by au.nome;

select em.data_saida as 'Data de emprestimo', count(li.isbn) as 'Quantidade de livros por data' from emprestimo em inner join exemplar ex on em.cod_exemplar = ex.codigo inner join livro li on li.isbn = ex.isbn_livro group by em.data_saida;

select em.data_saida as 'Data de emprestimo', us.nome as 'Nome do usuário', pf.nome as 'Perfil do Usuário' from emprestimo em left join usuario us on em.cpf_usuario = us.cpf left join perfil pf on us.cod_perfil = pf.codigo;

select au.nome as 'Nome do autor', li.titulo as 'Titulo do livro' 
from autor au left join autoria aut on au.codigo = aut.cod_autor 
left join livro li on li.isbn = aut.isbn_livro group by au.nome, li.titulo;

select em.data_saida as 'Data de emprestimo', us.nome as 'Nome do usuário', pf.nome as 'Perfil do usuário', ex.status as 'Status do exemplar', li.isbn as 'ISBN do livro', li.valor as 'Valor do livro', ge.nome as 'Nome do genero', ed.nome as 'Nome da editora' from emprestimo em inner join usuario us on em.cpf_usuario = us.cpf inner join perfil pf on us.cod_perfil = pf.codigo inner join exemplar ex on em.cod_exemplar = ex.codigo inner join livro li on ex.isbn_livro = li.isbn inner join genero ge on li.cod_genero = ge.codigo inner join editora ed on li.cod_editora = ed.codigo group by em.data_saida, us.nome, pf.nome, ex.status, li.isbn, li.valor, ge.nome, ed.nome;
