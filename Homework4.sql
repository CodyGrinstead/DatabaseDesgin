--Cody Grinstead
--HomeWork 4

--Todo Make One-Many Relationships,create data, query data



CREATE DATABASE Homework4


CREATE TABLE Equipment(
    SerNo INT,
    Date_Purchased DATE, 
    CONSTRAINT EquipmentKey PRIMARY KEY (SerNo),
    CONSTRAINT SerPos CHECK(SerNo >0)
)

CREATE TABLE Repaired(
    Date_Repaired DATE,
    SerNo INT,
    FOREIGN KEY (SerNo) REFERENCES Equipment,
    CONSTRAINT SerPos CHECK(SerNo >0)
)

CREATE TABLE Located(
    Building CHAR(20),
    Room CHAR(10),
    CONSTRAINT LocalBuildKey PRIMARY KEY (Building),
    CONSTRAINT LocalRoomKey PRIMARY KEY (Room),
    CONSTRAINT RoomPos CHECK(Room >0)
)

Create Table Located_At(
    Since DATE,
    Building CHAR(20),
    Room CHAR(10),
    SerNo INT,
    FOREIGN KEY (SerNo) REFERENCES Equipment,
    FOREIGN KEY (Building) REFERENCES Located,
    FOREIGN KEY (Room) REFERENCES Located,
    CONSTRAINT WhereLocatedRestrict PRIMARY KEY(SerNo, Building,Room)
)


CREATE TABLE Part_Of(
    SerNo INT,
    FOREIGN KEY (SerNo) REFERENCES Equipment
)

CREATE TABLE Equipment_Type(
    E_Type CHAR(20),
    CONSTRAINT EquipTypeKey PRIMARY KEY (E_Type)
)

CREATE Table Is_Of_Type(
    E_Type CHAR(20),
    SerNo INT,
    FOREIGN KEY (SerNo) REFERENCES Equipment,
    FOREIGN KEY (E_Type) REFERENCES Equipment_Type,
    CONSTRAINT EquipIsTypeRest PRIMARY KEY (E_Type, SerNo)
)

CREATE TABLE Replacement_Schedule(
    Months INT,
    Replacement_Cost MONEY,
    CONSTRAINT ReplacementKey PRIMARY KEY (Months) 
)

CREATE TABLE Has_A_Schedule(
    E_Type CHAR(20),
    Months INT,
    FOREIGN KEY (E_Type) REFERENCES Equipment_Type,
    FOREIGN KEY (Months) REFERENCES Replacement_Schedule,
    CONSTRAINT ReplacementRestriction PRIMARY KEY (E_Type, Months)
)

CREATE TABLE Vendor(
    Ven_Name CHAR(20),
    Price_Agreement MONEY,
    CONSTRAINT VendorKey PRIMARY KEY (Ven_Name)
)

CREATE TABLE Is_From(
    Ven_Name CHAR(20),
    E_Type CHAR(20),
    FOREIGN KEY (Ven_Name) REFERENCES Vendor,
    FOREIGN KEY (E_Type) REFERENCES Equipment_Type
)

CREATE TABLE Cost_Center(
    Center_Name CHAR(20),
    CONSTRAINT CenterKey PRIMARY KEY (Center_Name)
)

Create TABLE Owned_By
(
    SerNo INT,
    Center_Name CHAR(20),
    FOREIGN KEY (SerNo) REFERENCES Equipment,
    FOREIGN KEY (Center_Name) REFERENCES Cost_Center,
    CONSTRAINT VendorRestriction PRIMARY KEY (SerNo, Center_Name)
)

CREATE TABLE Budget(
    Category CHAR(20),
    Year INT,
    Amount MONEY,
    CONSTRAINT BudgetCatKey PRIMARY KEY (Category),
    CONSTRAINT BudgetYearKey PRIMARY KEY (Year)
)

CREATE TABLE Has_A_Budget(
    Center_Name CHAR(20),
    Category CHAR(20),
    Year INT,
    FOREIGN KEY (Center_Name) REFERENCES Cost_Center,
    FOREIGN KEY (Category) REFERENCES Budget,
    FOREIGN KEY (Year) REFERENCES Budget,
    CONSTRAINT SingleBudgetPer PRIMARY KEY (Center_Name, Category, Year),
    CONSTRAINT YearPos CHECK(Year>999 and Year<9999)
)




--Table Drops
/*
DROP TABLE Equipment,
DROP TABLE Repaired,
DROP TABLE Equipment_Type,
DROP TABLE Is_Of_Type,
DROP TABLE Replacement_Schedule,
DROP TABLE Has_A_Schedule,
DROP TABLE Part_Of,
DROP TABLE Located,
DROP TABLE Located_At,
DROP TABLE Cost_Center,
DROP TABLE Owned_By,
DROP TABLE Budget,
DROP TABLE Has_A_Budget,
DROP TABLE Vendor,
DROP TABLE Is_From,
*/


Insert Into
    Equipment(SerNo, Date_Purchased)
VALUES
    (1,2015-01-01),
    (2,2015-02-02)

Insert Into
    Located(Room, Building)
VALUES 
    (1,"Wuben"),
    (1,"HH")

Insert Into
    Located_At(Since, SerNo, Building, Room)
VALUES 
    (2015-01-01,1,"Wuben",1),
    (2015-02-02,2,"HH",1)

Insert Into
    Repaired(Date_Repaired,SerNo)
VALUES
    (2016-01-05,1)

Insert Into 
    Equipment_Type(E_Type)
VALUES
    ("Computer"),
    ("Computer")

Insert Into
    Is_Of_Type(SerNo, E_Type)
VALUES
    (1,"Computer"),
    (2,"Computer")

Insert Into
    Replacement_Schedule(Months, Replacement_Cost)
VALUES
    (5,250.0000),
    (7,250.0000)

Insert Into
    Has_A_Schedule(Months,E_Type)
VALUES
    (5,"Computer"),
    (7,"Computer")

Insert Into
    Vendor(Ven_Name, Price_Agreement)
VALUES
    ("Cstore", 250.0000),
    ("Windowmart",250.0000)

Insert Into 
    Is_From(Ven_Name,E_Type)
VALUES
    ("Cstore","Computer"),
    ("Windowmart","Computer")

Insert Into
    Cost_Center(Center_Name)
VALUES
    ("CSCI"),
    ("English")

Insert Into
    Owned_By(SerNo,Center_Name)
VALUES
    (1,"CSCI"),
    (2,"English")

Insert Into 
    Budget(Category,Year,Amount)
VALUES
    ("Computer",2017,1000000.0000)


SELECT  SerNo,Date_Purchased,Center_Name,Category,Year,Amount,E_Type,Months,Replacement_Cost
FROM Equipment, Is_Of_Type, Equipment_Type, Has_A_Budget, Replacement_Schedule, Owned_By, Cost_Center, Has_A_Budget, Budget
WHERE   Equipment.SerNo = Is_Of_Type.SerNo and Is_Of_Type.E_Type = Equipment_Type.E_Type and Equipment_Type.E_Type = Has_A_Schedule.E_Type
        and Has_A_Schedule.Months=Replacement_Schedule.Months and Equipment.SerNo=Owned_By.SerNo and Owned_By.Center_Name=Cost_Center.Center_Name
        and Cost_Center.Center_Name = Has_A_Budget.Center_Name and Has_A_Budget.Year=Budget.Year and Equipment.SerNo = 1

