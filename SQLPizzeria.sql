use master;
GO
create database Pizzeria;
GO
use Pizzeria;


create table Pizza( 
IdPizza int constraint PK_Pizza primary key identity(1,1),
Nome varchar(30) not null unique,
Prezzo decimal(6,2) not null constraint chk_prezzoMaggioreZero check (Prezzo>0)
)

create table Ingrediente(
IdIngrediente int constraint PK_Ingrediente primary key identity(1,1),
Nome varchar(40) not null unique,
Costo decimal(6,2) not null constraint chk_costoMaggioreZero check (Costo > 0),
ScorteMagazzino int not null constraint chk_ScorteMagazzinoMaggioreZero check (ScorteMagazzino >=0)
)

create table PizzaIngrediente(
PizzaId int constraint FK_Pizza foreign key references Pizza(IdPizza),
IngredienteId int constraint FK_Ingrediente foreign key references Ingrediente(IdIngrediente),
constraint PK_Compost_PizzaIngrediente primary key (PizzaId, IngredienteId)
)


insert into Ingrediente values ('pomodoro',0.50,50),('mozzarella',2,30),('mozzarella di bufala', 3, 25),
('spianata piccante', 2.50, 10), ('funghi',2,14),('carciofi',1.50,12),('cotto',2,21),('olive',1,8),
('funghi porcini',2.40,11),('stracchino',1.50,3),('speck',3,4),('rucola',0.50,6),('grana',4,2),
('verdure di stagione',3,12),('patate',0.50,30),('salsiccia',2,16),('pomodorini',0.80,12),('ricotta',2,4),
('provola',2.50,2),('gorgonzola', 4, 6),('pomodoro fresco',0.40,9),('basilico',1,24),('bresaola',3,8)




--Procedure
--Inserimento di una nuova pizza (parametri: nome, prezzo)
create procedure AggiungiPizza 
@nome varchar(30), 
@prezzo decimal(6,2)
as
	insert into Pizza values (@nome,@prezzo)
go

execute AggiungiPizza 'Margherita',5;
execute AggiungiPizza 'Bufala',7;
execute AggiungiPizza 'Diavola',6;
execute AggiungiPizza 'Quattro Stagioni',6.50;
execute AggiungiPizza 'Porcini',7;
execute AggiungiPizza 'Dioniso',8;
execute AggiungiPizza 'Ortolana',8;
execute AggiungiPizza 'Patate e Salsiccia',6;
execute AggiungiPizza 'Pomodorini',6;
execute AggiungiPizza 'Quattro Formaggi',7.50;
execute AggiungiPizza 'Caprese',7.50;
execute AggiungiPizza 'Zeus',7.50;

--Assegnazione di un ingrediente a una pizza (parametri: nome pizza, nome ingrediente)



create procedure AggiungiIngredientePizza 
@nomePizza varchar(30), 
@nomeIngrediente varchar(40)
as
declare @idPizza int 

select @idPizza=IdPizza
from Pizza p 
where p.Nome = @nomePizza

declare @idIngrediente int 

select @idIngrediente = IdIngrediente
from Ingrediente i 
where i.Nome = @nomeIngrediente

insert into PizzaIngrediente values (@idPizza,@idIngrediente)

go

select * from Pizza
select * from Ingrediente

execute AggiungiIngredientePizza 'Margherita', 'pomodoro';
execute AggiungiIngredientePizza 'Margherita', 'mozzarella';
execute AggiungiIngredientePizza 'Bufala', 'pomodoro';
execute AggiungiIngredientePizza 'Bufala', 'mozzarella di bufala';
execute AggiungiIngredientePizza 'Diavola', 'pomodoro';
execute AggiungiIngredientePizza 'Diavola', 'mozzarella';
execute AggiungiIngredientePizza 'Diavola', 'spianata piccante';
execute AggiungiIngredientePizza 'Quattro stagioni', 'pomodoro';
execute AggiungiIngredientePizza 'Quattro stagioni', 'mozzarella';
execute AggiungiIngredientePizza 'Quattro stagioni', 'funghi';
execute AggiungiIngredientePizza 'Quattro stagioni', 'carciofi';
execute AggiungiIngredientePizza 'Quattro stagioni', 'cotto';
execute AggiungiIngredientePizza 'Quattro stagioni', 'olive';
execute AggiungiIngredientePizza 'Porcini', 'pomodoro';
execute AggiungiIngredientePizza 'Porcini', 'mozzarella';
execute AggiungiIngredientePizza 'Porcini', 'funghi porcini';
execute AggiungiIngredientePizza 'Dioniso', 'pomodoro';
execute AggiungiIngredientePizza 'Dioniso', 'mozzarella';
execute AggiungiIngredientePizza 'Dioniso', 'stracchino';
execute AggiungiIngredientePizza 'Dioniso', 'speck';
execute AggiungiIngredientePizza 'Dioniso', 'rucola';
execute AggiungiIngredientePizza 'Dioniso', 'grana';
execute AggiungiIngredientePizza 'Ortolana', 'pomodoro';
execute AggiungiIngredientePizza 'Ortolana', 'mozzarella';
execute AggiungiIngredientePizza 'Ortolana', 'verdure di stagione';
execute AggiungiIngredientePizza 'Patate e Salsiccia', 'mozzarella';
execute AggiungiIngredientePizza 'Patate e Salsiccia', 'patate';
execute AggiungiIngredientePizza 'Patate e Salsiccia', 'salsiccia';
execute AggiungiIngredientePizza 'Pomodorini', 'mozzarella';
execute AggiungiIngredientePizza 'Pomodorini', 'pomodorini';
execute AggiungiIngredientePizza 'Pomodorini', 'ricotta';
execute AggiungiIngredientePizza 'Quattro Formaggi', 'mozzarella';
execute AggiungiIngredientePizza 'Quattro Formaggi', 'provola';
execute AggiungiIngredientePizza 'Quattro Formaggi', 'gorgonzola';
execute AggiungiIngredientePizza 'Quattro Formaggi', 'grana';
execute AggiungiIngredientePizza 'Caprese', 'mozzarella';
execute AggiungiIngredientePizza 'Caprese', 'pomodoro fresco';
execute AggiungiIngredientePizza 'Caprese', 'basilico';
execute AggiungiIngredientePizza 'Zeus', 'mozzarella';
execute AggiungiIngredientePizza 'Zeus', 'bresaola';
execute AggiungiIngredientePizza 'Zeus', 'rucola';

--Aggiornamento del prezzo di una pizza (parametri: nome pizza e nuovo prezzo)

create procedure AggiornaPrezzoPizza 
@nomePizza varchar(30), 
@prezzo decimal(6,2)
as
	update Pizza set Prezzo = @prezzo WHERE Nome=@nomePizza
go

select * from Pizza

execute AggiornaPrezzoPizza 'Margherita', 5.50

--Eliminazione di un ingrediente da una pizza (parametri: nome pizza, nome ingrediente)

create procedure RimuoviIngredienteDaPizza 
@nomePizza varchar(30), 
@nomeIngrediente varchar(40)
as
declare @idPizza int 
select @IdPizza = IdPizza 
from Pizza 
where Nome = @nomePizza

declare @idIngrediente int
select @IdIngrediente = IdIngrediente 
from Ingrediente 
where Nome = @nomeIngrediente

delete from PizzaIngrediente where PizzaId = @idPizza and IngredienteId = @idIngrediente

execute RimuoviIngredienteDaPizza 'Margherita', 'pomodoro'
select * from PizzaIngrediente

--Incremento del 10% del prezzo delle pizze contenenti un ingrediente (parametro: nome ingrediente)

create procedure AggiornaPrezzoPizzePerIngrediente 
@nomeIngrediente varchar(40)
as
declare @idIngrediente int 
select @idIngrediente = IdIngrediente 
from Ingrediente 
where Ingrediente.Nome = @nomeIngrediente
		update Pizza set Prezzo += (Prezzo/100*10) where IdPizza IN 
																(select IdPizza 
																from PizzaIngrediente 
																where IngredienteId = @idIngrediente)
go

execute AggiornaPrezzoPizzePerIngrediente 'mozzarella'
select * from pizza

--funzioni
--1. Tabella listino pizze (nome, prezzo) (parametri: nessuno)

create function ListinoPizze()
returns table
as
return
	select Nome, Prezzo
	from Pizza
go
select * from dbo.ListinoPizze()

--2. Tabella listino pizze (nome, prezzo) contenenti un ingrediente (parametri: nome ingrediente)

create function ListinoPizzeConIngrediente(@nomeIngrediente varchar(40))
returns table
as
return
	select p.Nome, p.Prezzo
	from   Pizza p join PizzaIngrediente p_i on p_i.PizzaId = p.IdPizza 
				   join Ingrediente i on p_i.IngredienteId = i.IdIngrediente
	where (i.Nome = @nomeIngrediente)
go

select * from ListinoPizzeConIngrediente('bresaola')

--3. Tabella listino pizze (nome, prezzo) che non contengono un certo ingrediente (parametri: nome ingrediente)
create function ListinoPizzeSenzaIngrediente(@nomeIngrediente varchar(40))
returns table
as
return

	select p.Nome, p.Prezzo
	from Pizza p
	where p.IdPizza not in (select p.IdPizza
							from   Pizza p join PizzaIngrediente p_i on p_i.PizzaId = p.IdPizza 
											join Ingrediente i on p_i.IngredienteId = i.IdIngrediente
							where (i.Nome = @nomeIngrediente))

SELECT * FROM ListinoPizzeSenzaIngrediente ('pomodoro');
							
--4. Calcolo numero pizze contenenti un ingrediente (parametri: nome ingrediente)

create function NumeroPizze(@nomeIngrediente varchar(40))
returns int
as 
begin

declare @numeroPizze int

select @numeroPizze=COUNT(*)
from   Pizza p join PizzaIngrediente p_i on p_i.PizzaId = p.IdPizza 
				   join Ingrediente i on p_i.IngredienteId = i.IdIngrediente
where (i.Nome = @nomeIngrediente)

return @numeroPizze
end

select dbo.NumeroPizze('olive') as [numero pizze]

--5. Calcolo numero pizze che non contengono un ingrediente (parametri: codice ingrediente)

create function NumPizzeSenzaIngrediente(@id int)
returns int
as
begin
	declare @nomeIngrediente varchar(40) 
	select @nomeIngrediente = Nome 
	from Ingrediente 
	where IdIngrediente = @id

	return (select count(*)
	from Pizza p
	where p.IdPizza not in (select p.IdPizza
							from   Pizza p join PizzaIngrediente p_i on p_i.PizzaId = p.IdPizza 
											join Ingrediente i on p_i.IngredienteId = i.IdIngrediente
							where (i.Nome = @nomeIngrediente)))
end

select * from Ingrediente
select dbo.NumPizzeSenzaIngrediente(3) as numPizze

--6. Calcolo numero ingredienti contenuti in una pizza (parametri: nome pizza)

create function NumIngredientiPizza (@nomePizza varchar(30))
returns int
as 
begin

declare @numeroIngredienti int

select @numeroIngredienti=COUNT(*)
from   Pizza p join PizzaIngrediente p_i on p_i.PizzaId = p.IdPizza 
				   join Ingrediente i on p_i.IngredienteId = i.IdIngrediente
where (p.Nome = @nomePizza)

return @numeroIngredienti
end

select dbo.NumIngredientiPizza('Margherita') as [numero ingredienti]

--query
--1. Estrarre tutte le pizze con prezzo superiore a 6 euro.

select Nome, Prezzo
from Pizza
where Prezzo >= 6

--2. Estrarre la pizza/le pizze più costosa/e.

select Nome, Prezzo
from   ListinoPizze()
where (Prezzo =
               (select MAX(Prezzo) AS [Costo massimo]
                 from   ListinoPizze()))


--3. Estrarre le pizze «bianche»

select p.Nome
	from Pizza p
	where p.IdPizza not in (select p.IdPizza
							from   Pizza p join PizzaIngrediente p_i on p_i.PizzaId = p.IdPizza 
											join Ingrediente i on p_i.IngredienteId = i.IdIngrediente
							where (i.Nome = 'pomodoro'))

--4. Estrarre le pizze che contengono funghi (di qualsiasi tipo).

select p.Nome
from Pizza p join PizzaIngrediente p_i on p_i.PizzaId = p.IdPizza 
			 join Ingrediente i on p_i.IngredienteId = i.IdIngrediente
where i.Nome like 'fungh%'


--view
--Realizzare una view che rappresenta il menù con tutte le pizze. (Pizza, Prezzo, Ingredienti)

create function IngredientiByPizza (@idPizza int)
returns table
as
return (select i.Nome
		from   Ingrediente i join PizzaIngrediente p_i on i.IdIngrediente = p_i.IngredienteId
		where (p_i.PizzaId = @idPizza))


create function GetIngredientiListbyPizza (@idPizza int)
	returns varchar(50)
	as
	begin
		 return (select 
				STUFF((select ', ' + Nome 
						from IngredientiByPizza(@idPizza)
						for XML PATH('')), 1, 1, ''))				
	end

create view Menu 
	as
	select Nome, Prezzo, dbo.GetIngredientiListbyPizza(IdPizza) as Ingredienti
	from   Pizza p

select * from Menu