-- 01_schema.sql

-- PostgreSQL does not support 'IF NOT EXISTS' in the CREATE DATABASE syntax
-- You should create the database manually or through your Docker setup

-- Companies table
CREATE TABLE IF NOT EXISTS Companies (
  CompanyId SERIAL PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Address VARCHAR(255),
  ContactPerson VARCHAR(255)
);

-- Employees table
CREATE TABLE IF NOT EXISTS Employees (
  EmployeeId SERIAL PRIMARY KEY,
  CompanyId INT NOT NULL,
  FirstName VARCHAR(255),
  LastName VARCHAR(255),
  Email VARCHAR(255),
  Phone VARCHAR(255),
  Role VARCHAR(255), 
  FOREIGN KEY (CompanyId) REFERENCES Companies (CompanyId)
);

-- Resources table
CREATE TABLE IF NOT EXISTS Resources (
  ResourceId SERIAL PRIMARY KEY,
  CompanyId INT NOT NULL,
  Identifier VARCHAR(255),
  Type VARCHAR(255),
  Capacity INT,
  FOREIGN KEY (CompanyId) REFERENCES Companies (CompanyId)
);

-- Assignments table
CREATE TABLE IF NOT EXISTS Assignments (
  AssignmentId SERIAL PRIMARY KEY,
  ResourceId INT NOT NULL,
  EmployeeId INT,
  StartTime TIMESTAMP,
  EndTime TIMESTAMP,
  Status VARCHAR(255),
  CompanyId INT NOT NULL,
  FOREIGN KEY (ResourceId) REFERENCES Resources (ResourceId),
  FOREIGN KEY (EmployeeId) REFERENCES Employees (EmployeeId),
  FOREIGN KEY (CompanyId) REFERENCES Companies (CompanyId)
);

-- Reservations table
CREATE TABLE IF NOT EXISTS Reservations (
  ReservationId SERIAL PRIMARY KEY,
  ResourceId INT NOT NULL,
  EmployeeId INT,
  CustomerId INT,
  StartTime TIMESTAMP,
  EndTime TIMESTAMP,
  Status VARCHAR(255), 
  FOREIGN KEY (ResourceId) REFERENCES Resources (ResourceId),
  FOREIGN KEY (EmployeeId) REFERENCES Employees (EmployeeId)
);
