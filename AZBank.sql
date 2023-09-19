CREATE DATABASE AZBank
GO 
Use AZBank
GO 

Create table Customer (
CustomerID int primary key,
CustomerName nvarchar(50),
City nvarchar(50),
Country nvarchar(50),
Phone nvarchar(15),
Email nvarchar(50)
);
Insert into Customer(CustomerID,CustomerName,City,Country,Phone,Email)
Values (1,N'huyhoang', N'Hanoi', N'Vietnam','012345678',N'huyhoang@gmail.com'),
(2,N'hoanghuy', N'Bacgiang', N'Vietnam','023456156',N'nghoang@gmail.com'),
(3,N'nghoang', N'Haiphong', N'Vietnam','0523461585',N'hoang@gmail.com'),
(4,N'hoanghuyng', N'Hanam', N'Vietnam','0443536434',N'huyhoang123@gmail.com'),
(5,N'nghuyhoang', N'Hanoi', N'Vietnam','03938953',N'huyhoangbeo@gmail.com'),
(6,N'dangkimthi', N'Hanoi', N'Vietnam','032848464',N'dkthi@gmail.com'),
(7,N'anhduyen', N'Namdinh', N'Vietnam','056423586',N'anhduyen@gmail.com');
GO
Select * from Customer

Create table CustomerAccount(
AccountNumber char(9) primary key ,
CustomerID int,
Balance money,
MinAccount money,
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
Insert into CustomerAccount(AccountNumber,CustomerID,Balance,MinAccount) Values (1000,1,1500,2000);
Insert into CustomerAccount(AccountNumber,CustomerID,Balance,MinAccount) Values(1100,2,1500,50000);
Insert into CustomerAccount(AccountNumber,CustomerID,Balance,MinAccount) Values(1200,4,15000,20000);
Insert into CustomerAccount(AccountNumber,CustomerID,Balance,MinAccount) Values(1300,3,1000,30000),
(1400,5,200,2000),
(1500,7,1500,20000),
(1600,6,1500,200000);
GO
Select * from CustomerAccount


Create table CustomerTransaction(
TransactionID int primary key,
AccountNumber char(9),
TransactionDate smalldatetime,
Amount money CHECK (Amount >= 1 AND Amount <= 1000000),
DepositorWithdraw bit,
FOREIGN KEY (AccountNumber) REFERENCES CustomerAccount(AccountNumber)
);
INSERT INTO CustomerTransaction (TransactionID, AccountNumber, TransactionDate, Amount, DepositorWithdraw)
VALUES(101, 1100, '2023-09-18', 1000, '1');
 INSERT INTO CustomerTransaction (TransactionID, AccountNumber, TransactionDate, Amount, DepositorWithdraw)
VALUES(102, 1000, '2023-09-19', 500, '0');
INSERT INTO CustomerTransaction (TransactionID, AccountNumber, TransactionDate, Amount, DepositorWithdraw)
VALUES (103, 1300, '2023-09-20', 20000, '1');
INSERT INTO CustomerTransaction (TransactionID, AccountNumber, TransactionDate, Amount, DepositorWithdraw)
VALUES(104,1200,'2023-09-20',500000,'1');
GO
select * from CustomerTransaction
SELECT * 
FROM Customer
WHERE City = 'Hanoi';
GO
SELECT CustomerName, Phone, Email, AccountNumber, Balance
FROM CustomerAccount CA
JOIN Customer C ON CA.CustomerID = C.CustomerID;
GO
CREATE VIEW CustomerTransactions AS
SELECT C.CustomerName, CT.AccountNumber, CT.TransactionDate, CT.Amount, CT.DepositorWithdraw
FROM CustomerTransaction CT
JOIN CustomerAccount CA ON CT.AccountNumber = CA.AccountNumber
JOIN Customer C ON CA.CustomerID = C.CustomerID;
GO