Create database HomeWork
use HomeWork
create table Notebooks(
[Id] int primary key identity,
[Name] nvarchar(30) not null,
[Price] int default 0
)

insert into Notebooks(Name,Price)
values ('VivoBook',500),
('Ryzen 7',1000),
('Mac Book',1500),
('Hp pavilion',200)

create table Brands(
Id int primary key identity,
Name nvarchar (30)
)
alter table Brands
add constraint C_Name check(Len(Name)>3)
insert into Brands([Name])
values ('HPPP'),
('APPLE'),('ASUS')
alter table Notebooks
add Brand_id int foreign key references Brands(Id)

use HomeWork
-- Inner join
Select Notebooks.Name,Brands.Name as 'Brand Name',Price from Notebooks
inner join Brands
on Notebooks.Brand_id=Brands.Id


--Qiymeti 100-500 arasi olan ve ya qiymeti 1000-den boyuk olan productlari qaytaran sorgu
Select Notebooks.Name,Brands.Name as 'Brand Name',Price from Notebooks
inner join Brands
on Notebooks.Brand_id=Brands.Id where Price between 100 and 500 or Price>1000

-- BrandName-nda 'a' olan notebooklari geri qaytaran
Select Notebooks.Name,Brands.Name as 'Brand Name',Price from Notebooks
inner join Brands
on Notebooks.Brand_id=Brands.Id where CHARINDEX('a',Brands.Name)>0







