--Cody Grinstead
--HomeWork 4

--Todo Make One-Many Relationships,create data, query data



CREATE DATABASE Homework4


CREATE TABLE Equipment(
    SerNo INT,
    Date_Purchased DATE, 
    CONSTRAINT EquipmentKey PRIMARY KEY SerNo
)

CREATE TABLE Repaired(
    Date_Repaired DATE,
    SerNo INT,
    FOREIGN KEY (SerNo) REFERENCES Equipment
)

CREATE TABLE Located(
    Building CHAR(20),
    Room CHAR(10),
    CONSTRAINT LocalBuildKey PRIMARY KEY Building,
    CONSTRAINT LocalRoomKey PRIMARY KEY Room
)

Create Table Located_At(
    Since DATE,
    Building CHAR(20),
    Room CHAR(10),
    FOREIGN KEY (SerNo) REFERENCES Equipment,
    FOREIGN KEY (Building) REFERENCES Located,
    FOREIGN KEY (Room) REFERENCES Located
)

CREATE TABLE Equipment_Type(
    E_Type CHAR(20),
    CONSTRAINT EquipTypeKey PRIMARY KEY E_Type
)

CREATE Table Is_Of_Type(
    E_Type CHAR(20),
    SerNo INT,
    FOREIGN KEY (SerNo) REFERENCES Equipment,
    FOREIGN KEY (E_Type) REFERENCES Equipment_Type
)

CREATE TABLE Replacement_Schedule(
    Months INT,
    Replacement_Cost MONEY,
    CONSTRAINT ReplacementKey PRIMARY KEY Months 
)

CREATE TABLE Has_A_Schedule(
    E_Type CHAR(20),
    Months INT,
    FOREIGN KEY (E_Type) REFERENCES Equipment_Type,
    FOREIGN KEY (Months) REFERENCES Replacement_Schedule
)

CREATE TABLE Vendor(
    Ven_Name CHAR(20),
    Price_Agreement MONEY,
    CONSTRAINT VendorKey PRIMARY KEY Ven_Name
)

CREATE TABLE Is_From(
    Ven_Name CHAR(20),
    E_Type CHAR(20),
    FOREIGN KEY (Ven_Name) REFERENCES Vendor,
    FOREIGN KEY (E_Type) REFERENCES Equipment_Type
)

CREATE TABLE Cost_Center(
    Center_Name CHAR(20),
    CONSTRAINT CenterKey PRIMARY KEY Center_Name
)

Create TABLE Owned_By
(
    SerNo INT,
    Center_Name,
    FOREIGN KEY (SerNo) REFERENCES Equipment,
    FOREIGN KEY (Center_Name) REFERENCES Cost_Center
)

CREATE TABLE Budget(
    Category CHAR(20),
    Year INT,
    Amount MONEY,
    CONSTRAINT BudgetCatKey PRIMARY KEY Category,
    CONSTRAINT BudgetYearKey PRIMARY KEY Year
)

CREATE TABLE Has_A_Budget(
    Center_Name CHAR(20),
    Category CHAR(20),
    Year INT,
    FOREIGN KEY (Center_Name) REFERENCES Cost_Center,
    FOREIGN KEY (Category) REFERENCES Budget,
    FOREIGN KEY (Year) REFERENCES Budget
)

CREATE TABLE Part_Of(--What is system/subsystem
    SerNo INT,
    FOREIGN KEY (SerNo) REFERENCES Equipment
)


--Table Drops
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

