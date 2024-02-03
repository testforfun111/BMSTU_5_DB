DROP TABLE if exists laptop.Customer CASCADE;
DROP TABLE if exists laptop.LaptopModel CASCADE;
DROP TABLE if exists laptop.Manufacturer CASCADE;
DROP TABLE if exists laptop.Orders CASCADE;

CREATE table laptop.Customer(
	CustomersID serial  PRIMARY KEY,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	Adress VARCHAR(50),
	Email VARCHAR(50),
	PhoneNumber VARCHAR(50)
);

create table laptop.LaptopModel
(
	ModelID serial  PRIMARY KEY,
	ModelName VARCHAR(50),
	ProcessorType VARCHAR(50),
	Price INT CHECK(Price >= 1 AND Price <= 2000),
	Weight FLOAT8 CHECK(Weight >= 1 AND Weight <= 5),
	RAM INT CHECK(RAM >= 1 AND RAM <= 100)
);

create table laptop.Manufacturer
(
	ManufacturerID serial  PRIMARY KEY,
	ManufacturerName VARCHAR(100),
	Country VARCHAR(100),
	YearFounded INT CHECK (YearFounded >= 1500 AND YearFounded <= 2023),
	Website VARCHAR(50)
);

create table laptop.Orders
(
	OrderID serial  PRIMARY KEY,
	OrderDate DATE CHECK(OrderDate <= CAST(CURRENT_TIMESTAMP AS DATE)),
	OrderPrice INT CHECK (OrderPrice >=1 AND OrderPrice <= 2000),
	Status VARCHAR CHECK (Status in ('Pending', 'Awaiting Payment', 'Awaiting Fulfillment', 'Awaiting Shipment', 'Awaiting Pickup', 'Completed', 'Shipped', 'Cancelled', 'Declined', 'Refunded')),
	
	CustomersID INT,
	FOREIGN KEY (CustomersID) REFERENCES laptop.Customer(CustomersID),
	
	ModelID INT,
	FOREIGN KEY (ModelID) REFERENCES laptop.LaptopModel(ModelID),
	
	ManufacturerID INT,
	FOREIGN KEY (ManufacturerID) REFERENCES laptop.Manufacturer(ManufacturerID)
);

COPY laptop.Customer (CustomersID, FirstName, LastName, Adress, Email, PhoneNumber) FROM 'E:\Customers.csv' DELIMITER ';' CSV;
COPY laptop.LaptopModel (ModelName, ProcessorType, Price, Weight, RAM) FROM 'E:\LaptopModels.csv' DELIMITER ';' CSV;
COPY laptop.Manufacturer (ManufacturerName, Country, YearFounded, Website) FROM 'E:\Manufacturers.csv' DELIMITER ';' csv;
COPY laptop.Orders (CustomersID, ModelID, ManufacturerID, OrderDate, OrderPrice, Status) FROM 'E:\Orders.csv' DELIMITER ';' CSV;

select * from laptop.Customer;
select * from laptop.LaptopModel;
select * from laptop.Manufacturer;
select * from laptop.Orders;