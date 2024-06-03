USE master
DROP DATABASE Exam

CREATE DATABASE Exam
USE Exam

CREATE TABLE [User]
(
	ID INT PRIMARY KEY IDENTITY,
	FName NVARCHAR(20) NOT NULL,
	SName NVARCHAR(20) NOT NULL,
	MName NVARCHAR(20) NOT NULL,
	Email NVARCHAR(50) NOT NULL UNIQUE,
	GenderID INT NOT NULL,
	CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	[Login] NVARCHAR(50) UNIQUE NOT NULL,
	[Password] NVARCHAR(50) NOT NULL
)

CREATE TABLE Employee
(
	ID INT PRIMARY KEY IDENTITY,
	FName NVARCHAR(20) NOT NULL,
	SName NVARCHAR(20) NOT NULL,
	MName NVARCHAR(20) NOT NULL,
	Email NVARCHAR(50) NOT NULL UNIQUE,
	GenderID INT NOT NULL,
	RoleID INT NOT NULL,
	CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
	[Login] NVARCHAR(50) UNIQUE NOT NULL,
	[Password] NVARCHAR(50) NOT NULL
)

CREATE TABLE [Role]
(
	ID INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(20) NOT NULL,
)

CREATE TABLE Gender
(
	ID INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(20) NOT NULL,
)

CREATE TABLE Product
(
	ID INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(50) NOT NULL,
	QuantityInStock INT NOT NULL,
	Price DECIMAL(10,2) NOT NULL
)

CREATE TABLE ProductOrder
(
	ID INT PRIMARY KEY IDENTITY,
	OrderID INT NOT NULL,
	ProductID INT NOT NULL,
	Quantity INT NOT NULL,
)

CREATE TABLE [Order]
(
	ID INT PRIMARY KEY IDENTITY,
	UserID INT NOT NULL,
	EmployeeID INT NOT NULL,
	SaleDate datetime NOT NULL DEFAULT GETDATE(),
	TotalSum DECIMAL(10,2) NOT NULL,
	OrderStatusID INT NOT NULL DEFAULT 1
)

CREATE TABLE OrderStatus
(
	ID INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(50) UNIQUE NOT NULL
)

CREATE TABLE HistoryCost
(
	ID INT PRIMARY KEY IDENTITY,
	Title NVARCHAR(50) NOT NULL,
	OldCost DECIMAL(10,2) NOT NULL,
	NewCost DECIMAL(10,2) NOT NULL,
	ChangedAt DATETIME NOT NULL DEFAULT GETDATE(),
)

ALTER TABLE Employee ADD CONSTRAINT FK_Employee_Role
FOREIGN KEY (RoleID) REFERENCES [Role](ID)

ALTER TABLE Employee ADD CONSTRAINT FK_Employee_Gender
FOREIGN KEY (GenderID) REFERENCES Gender(ID)

ALTER TABLE [User] ADD CONSTRAINT FK_User_Gender
FOREIGN KEY (GenderID) REFERENCES Gender(ID)

ALTER TABLE ProductOrder ADD CONSTRAINT FK_ProductOrder_Order
FOREIGN KEY (OrderID) REFERENCES [Order](ID) 

ALTER TABLE ProductOrder ADD CONSTRAINT FK_ProductOrder_Product
FOREIGN KEY (ProductID) REFERENCES Product(ID) 

ALTER TABLE [Order] ADD CONSTRAINT FK_Order_User
FOREIGN KEY (UserID) REFERENCES [User](ID)

ALTER TABLE [Order] ADD CONSTRAINT FK_Order_Employee
FOREIGN KEY (EmployeeID) REFERENCES Employee(ID)

ALTER TABLE [Order] ADD CONSTRAINT FK_Order_Status
FOREIGN KEY (OrderStatusID) REFERENCES OrderStatus(ID)


INSERT INTO Gender
VALUES
	('Мужской'),
	('Женский');

	
INSERT INTO [Role]
VALUES
	('Администатор'),
	('Клиент'),
	('Менеджер');

INSERT INTO OrderStatus
VALUES
	('В работе'),
	('В пути'),
	('Завершено');

INSERT INTO [User]
VALUES 
	('Pavel','Asd','Lup','Pavel@mail.com','1','','host','123456'),
	('Des','Dsa','Syx','oidfgs@gmail.com','1','','post','123456'),
	('Proc','Mson','Dex','vcxzij@outlook.com','1','','lost','123456'),
	('Cyup','Loss','Vhew','asdasd@mail.com','1','','gost','123456'),
	('Kyle','Cozy','Sdvg','dpads@mail.ru','1','','sost','123456');

INSERT INTO Employee
VALUES 
	('Anna','Klar','Doxy','annak@gmail.com','2','1','','admin','123456'),
	('Ben','Cook','Troy','bencook@yahoo.com','1','3','','user','123456'),
	('Dina','Ross','Polk','dross@hotmail.com','2','3','','looser','123456'),
	('Eva','Stone','Grex','estone@aol.com','2','3','','goose','123456'),
	('Frank','Moe','York','frank.moe@mail.ru','1','2','','dack','123456');

INSERT INTO Product (Title, QuantityInStock, Price)
VALUES 
	('Laptop', 50, 999.99),
	('Smartphone', 200, 599.99),
	('Tablet', 150, 399.99),
	('Monitor', 80, 199.99),
	('Keyboard', 300, 49.99),
	('Mouse', 350, 29.99),
	('Printer', 40, 149.99),
	('Camera', 60, 799.99),
	('Headphones', 220, 99.99),
	('Speakers', 110, 129.99);

INSERT INTO [Order] (UserID, EmployeeID, SaleDate, TotalSum)
VALUES 
	(1, 3, '2023-05-01 10:30:00', 299.99),
	(2, 5, '2023-05-02 11:00:00', 499.99),
	(3, 2, '2023-05-03 12:45:00', 129.99),
	(4, 1, '2023-05-04 13:15:00', 199.99),
	(5, 4, '2023-05-05 14:30:00', 599.99),
	(1, 5, '2023-05-06 15:00:00', 799.99),
	(2, 4, '2023-05-07 16:20:00', 349.99),
	(3, 3, '2023-05-08 17:10:00', 99.99),
	(4, 2, '2023-05-09 18:25:00', 459.99),
	(5, 1, '2023-05-10 19:40:00', 259.99);

INSERT INTO ProductOrder (OrderID, ProductID, Quantity)
VALUES 
	(1, 2, 3),
	(1, 3, 2),
	(2, 1, 1),
	(2, 4, 4),
	(3, 5, 2),
	(4, 2, 1),
	(5, 3, 5),
	(6, 1, 2),
	(7, 4, 3),
	(8, 5, 1);


CREATE OR ALTER VIEW UserOrderDataView AS
SELECT
	CONCAT(FName,' ', SName, ' ', MName) AS 'FullName',
	email,
	o.SaleDate,
	os.Title
FROM [User] u
JOIN [Order] o ON o.UserID = u.ID
JOIN OrderStatus os ON o.OrderStatusID = os.ID

SELECT * FROM UserOrderDataView
