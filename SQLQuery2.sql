create database BookInfo
use BookInfo

create table Authors(
 Id tinyint primary key identity,
 [Name] nvarchar(30) not null,
 Surname nvarchar(30)
 )


create table Books(
 Id tinyint primary key identity,
 [Name] nvarchar(100) constraint CK_Name CHECK(len([name])<100 and len([name])>3),
 Author_Id tinyint foreign key references Authors(Id),
 [PageCount] int constraint CK_Count CHECK ([PageCount]>10) 
 )
--Umumi Melumat Cixardan View 
create view vw_GetBooksInfo
as
select* from
(
 select a.Name+' '+ a.Surname as Fullname ,b.Id , b.Name,b.PageCount from Authors as a
 join Books as b
 on a.Id=b.Author_Id
 ) as AllBokks

 select * from vw_GetBooksInfo
 ----Search Pracedures by Book name or Fullname
 create procedure usp_Search
 @Name nvarchar(30),
 @Fullname nvarchar(60)
 as
 select *from vw_GetBooksInfo as gb
 where gb.Name=@Name or gb.Fullname=@Fullname

 exec usp_Search 'Edebiyyat' , 'Fazil'
 --------Inset Pracudure
 create procedure usp_AddtAuthers
 @Name nvarchar (30),
 @Surname nvarchar (30)
 as
 insert into Authors
 values(@Name,@Surname)

 exec usp_AddtAuthers 'riyaziyyat','elovset'
 --Delete
 create procedure usp_DeleteAuthers
 @Id tinyint
 as
 delete Authors 
 where Authors.Id=@Id

 exec usp_DeleteAuthers 12
 ---Update 
 create procedure usp_UpdateAlthers
 @Id tinyint,
 @Name nvarchar (30),
 @Surname nvarchar (30)
 as
 update Authors
 set [Name]=@Name, Surname=@Surname where Id=@Id
 ------------MaxPage ve BooksCount cixaran view
 create view vw_MaxPage_BooksCount
 as
 select * from
 (
 select a.Id ,a.Name as Fullname,count(b.Id) as BooksCount,max(b.PageCount) as MaxPageCount from Authors as a
 join Books as b
 on a.Id=b.Author_Id
 group by a.Id, a.Name 
 )as InfoBooks

 select * from vw_MaxPage_BooksCount