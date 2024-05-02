-- Setting up session parameters
SET timezone = 'UTC';

-- Dropping tables if they exist
DROP TABLE IF EXISTS Assignments CASCADE;
DROP TABLE IF EXISTS Companies CASCADE;
DROP TABLE IF EXISTS Employees CASCADE;
DROP TABLE IF EXISTS Reservations CASCADE;
DROP TABLE IF EXISTS Resources CASCADE;

-- Creating ENUM types
CREATE TYPE status_type AS ENUM ('Scheduled', 'Active', 'Completed', 'Cancelled');
CREATE TYPE role_type AS ENUM ('Driver', 'EventManager', 'Waitstaff', 'Support', 'Other');
CREATE TYPE resource_type AS ENUM ('Vehicle', 'Room', 'Table', 'Equipment', 'Other');
CREATE TYPE reservation_status AS ENUM ('Pending', 'Confirmed', 'Cancelled');

-- Creating Companies table
CREATE TABLE Companies (
  CompanyId SERIAL PRIMARY KEY,
  Name VARCHAR(255) NOT NULL,
  Address VARCHAR(255),
  ContactPerson VARCHAR(255)
);

-- Inserting data into Companies
INSERT INTO Companies (CompanyId, Name, Address, ContactPerson) VALUES
(1,	'Company A',	'Address A',	'Contact Person A'),
(2,	'Company B',	'Address B',	'Contact Person B'),
(3,	'Company C',	'Address C',	'Contact Person C'),
(4,	'Company D',	'Address D',	'Contact Person D'),
(5,	'Company E',	'Address E',	'Contact Person E'),
(6,	'Company F',	'Address F',	'Contact Person F'),
(7,	'Company G',	'Address G',	'Contact Person G'),
(8,	'Company H',	'Address H',	'Contact Person H'),
(9,	'Company I',	'Address I',	'Contact Person I'),
(10,	'Company J',	'Address J',	'Contact Person J'),
(11,	'Company K',	'Address K',	'Contact Person K'),
(12,	'Company L',	'Address L',	'Contact Person L');

-- Creating Employees table
CREATE TABLE Employees (
  EmployeeId SERIAL PRIMARY KEY,
  CompanyId INT NOT NULL REFERENCES Companies(CompanyId),
  FirstName VARCHAR(255),
  LastName VARCHAR(255),
  Email VARCHAR(255),
  Phone VARCHAR(255),
  Role role_type
);

-- Inserting data into Employees
INSERT INTO Employees (EmployeeId, CompanyId, FirstName, LastName, Email, Phone, Role) VALUES
(1,	1,	'John',	'Doe',	'john.doe@example.com',	'123456789',	'Driver'),
(2,	1,	'Jane',	'Smith',	'jane.smith@example.com',	'987654321',	'Waitstaff'),
(3,	1,	'Alice',	'Johnson',	'alice.johnson@example.com',	'555123456',	'Driver'),
(4,	2,	'Bob',	'Williams',	'bob.williams@example.com',	'555987654',	'EventManager'),
(5,	2,	'Eva',	'Brown',	'eva.brown@example.com',	'555111222',	'Support'),
(6,	2,	'Charlie',	'Davis',	'charlie.davis@example.com',	'555333444',	'Waitstaff'),
(7,	3,	'David',	'Miller',	'david.miller@example.com',	'555777888',	'Driver'),
(8,	3,	'Emily',	'Wilson',	'emily.wilson@example.com',	'555666999',	'Waitstaff'),
(9,	3,	'Frank',	'Taylor',	'frank.taylor@example.com',	'555444777',	'Support'),
(10,	4,	'Grace',	'Anderson',	'grace.anderson@example.com',	'555222333',	'Driver'),
(11,	4,	'Henry',	'Martinez',	'henry.martinez@example.com',	'555888999',	'EventManager'),
(12,	5,	'Isabella',	'Martinez',	'isabella.martinez@example.com',	'555123456',	'Driver'),
(13,	5,	'Jack',	'Hernandez',	'jack.hernandez@example.com',	'555987654',	'Waitstaff'),
(14,	5,	'Liam',	'Lopez',	'liam.lopez@example.com',	'555111222',	'Driver'),
(15,	6,	'Mia',	'Gonzalez',	'mia.gonzalez@example.com',	'555333444',	'EventManager'),
(16,	6,	'Noah',	'Rodriguez',	'noah.rodriguez@example.com',	'555777888',	'Support'),
(17,	6,	'Olivia',	'Perez',	'olivia.perez@example.com',	'555666999',	'Waitstaff'),
(18,	7,	'Sophia',	'Sanchez',	'sophia.sanchez@example.com',	'555444777',	'Support'),
(19,	7,	'William',	'Torres',	'william.torres@example.com',	'555222333',	'Driver'),
(20,	7,	'Ava',	'Rivera',	'ava.rivera@example.com',	'555888999',	'EventManager'),
(21,	8,	'Benjamin',	'Fisher',	'benjamin.fisher@example.com',	'555123456',	'Driver'),
(22,	8,	'Charlotte',	'Butler',	'charlotte.butler@example.com',	'555987654',	'Waitstaff'),
(23,	8,	'Daniel',	'Russell',	'daniel.russell@example.com',	'555111222',	'Driver'),
(24,	9,	'Elizabeth',	'Hamilton',	'elizabeth.hamilton@example.com',	'555333444',	'EventManager'),
(25,	9,	'Gabriel',	'Griffin',	'gabriel.griffin@example.com',	'555777888',	'Support'),
(26,	9,	'Hannah',	'Hayes',	'hannah.hayes@example.com',	'555666999',	'Waitstaff'),
(27,	10,	'Ian',	'King',	'ian.king@example.com',	'555444777',	'Support'),
(28,	10,	'Jasmine',	'Hughes',	'jasmine.hughes@example.com',	'555222333',	'Driver'),
(29,	10,	'Kevin',	'Mitchell',	'kevin.mitchell@example.com',	'555888999',	'EventManager'),
(30,	11,	'Lily',	'Owens',	'lily.owens@example.com',	'555123456',	'Driver'),
(31,	11,	'Mason',	'Barnes',	'mason.barnes@example.com',	'555987654',	'Waitstaff'),
(32,	11,	'Natalie',	'Coleman',	'natalie.coleman@example.com',	'555111222',	'Driver'),
(33,	12,	'Oliver',	'Cooper',	'oliver.cooper@example.com',	'555333444',	'EventManager'),
(34,	12,	'Penelope',	'Diaz',	'penelope.diaz@example.com',	'555777888',	'Support'),
(35,	12,	'Quinn',	'Edwards',	'quinn.edwards@example.com',	'555666999',	'Waitstaff');

-- Creating Resources table
CREATE TABLE Resources (
  ResourceId SERIAL PRIMARY KEY,
  CompanyId INT NOT NULL REFERENCES Companies(CompanyId),
  Identifier VARCHAR(255),
  Type resource_type,
  Capacity INT
);

-- Inserting data into Resources
INSERT INTO Resources (ResourceId, CompanyId, Identifier, Type, Capacity) VALUES
(1,	1,	'Bus 1',	'Vehicle',	50),
(2,	1,	'Bus 2',	'Vehicle',	40),
(3,	2,	'Room A',	'Room',	100),
(4,	2,	'Room B',	'Room',	80),
(5,	3,	'Table 1',	'Table',	6),
(6,	3,	'Table 2',	'Table',	4),
(7,	4,	'Equipment 1',	'Equipment',	NULL),
(8,	4,	'Equipment 2',	'Equipment',	NULL),
(9,	5,	'Car 1',	'Vehicle',	5),
(10,	5,	'Car 2',	'Vehicle',	4),
(11,	6,	'Conference Room',	'Room',	20),
(12,	6,	'Meeting Room',	'Room',	15),
(13,	7,	'Table 3',	'Table',	8),
(14,	7,	'Table 4',	'Table',	10),
(15,	8,	'Projector',	'Equipment',	NULL),
(16,	8,	'Sound System',	'Equipment',	NULL),
(17,	9,	'Van 1',	'Vehicle',	8),
(18,	9,	'Van 2',	'Vehicle',	6),
(19,	10,	'Dining Hall',	'Room',	200),
(20,	10,	'Lounge Area',	'Room',	50),
(21,	11,	'Table 5',	'Table',	12),
(22,	11,	'Table 6',	'Table',	15),
(23,	12,	'Laptop',	'Equipment',	NULL),
(24,	12,	'Printer',	'Equipment',	NULL),
(25,	1,	'Bus 3',	'Vehicle',	35),
(26,	2,	'Room C',	'Room',	70),
(27,	3,	'Table 3',	'Table',	8),
(28,	4,	'Equipment 3',	'Equipment',	NULL),
(29,	5,	'Car 3',	'Vehicle',	6),
(30,	6,	'Board Room',	'Room',	12),
(31,	7,	'Table 5',	'Table',	12),
(32,	8,	'Microphone',	'Equipment',	NULL),
(33,	9,	'Van 3',	'Vehicle',	10),
(34,	10,	'Conference Hall',	'Room',	150),
(35,	11,	'Table 7',	'Table',	8),
(36,	12,	'Scanner',	'Equipment',	NULL);

-- Creating Assignments table
CREATE TABLE Assignments (
  AssignmentId SERIAL PRIMARY KEY,
  ResourceId INT NOT NULL REFERENCES Resources(ResourceId),
  EmployeeId INT REFERENCES Employees(EmployeeId),
  StartTime TIMESTAMP,
  EndTime TIMESTAMP,
  Status status_type,
  CompanyId INT NOT NULL REFERENCES Companies(CompanyId)
);

-- Inserting data into Assignments
INSERT INTO Assignments (AssignmentId, ResourceId, EmployeeId, StartTime, EndTime, Status, CompanyId) VALUES
(148,	1,	1,	'2024-05-01 08:00:00',	'2024-05-01 17:00:00',	'Scheduled',	1),
(149,	2,	NULL,	'2024-05-02 10:00:00',	'2024-05-02 14:00:00',	'Active',	1),
(150,	3,	3,	'2024-05-03 09:00:00',	'2024-05-03 18:00:00',	'Completed',	1),
(151,	4,	4,	'2024-05-01 08:00:00',	'2024-05-01 17:00:00',	'Scheduled',	2),
(152,	5,	NULL,	'2024-05-02 10:00:00',	'2024-05-02 14:00:00',	'Active',	2),
(153,	6,	6,	'2024-05-03 09:00:00',	'2024-05-03 18:00:00',	'Completed',	2),
(154,	7,	7,	'2024-05-01 08:00:00',	'2024-05-01 17:00:00',	'Scheduled',	3),
(155,	8,	NULL,	'2024-05-02 10:00:00',	'2024-05-02 14:00:00',	'Active',	3),
(156,	9,	9,	'2024-05-03 09:00:00',	'2024-05-03 18:00:00',	'Completed',	3),
(157,	10,	10,	'2024-05-01 08:00:00',	'2024-05-01 17:00:00',	'Scheduled',	4),
(158,	11,	NULL,	'2024-05-02 10:00:00',	'2024-05-02 14:00:00',	'Active',	4),
(159,	12,	12,	'2024-05-03 09:00:00',	'2024-05-03 18:00:00',	'Completed',	4),
(160,	13,	13,	'2024-05-01 08:00:00',	'2024-05-01 17:00:00',	'Scheduled',	5),
(161,	14,	NULL,	'2024-05-02 10:00:00',	'2024-05-02 14:00:00',	'Active',	5),
(162,	15,	15,	'2024-05-03 09:00:00',	'2024-05-03 18:00:00',	'Completed',	5),
(163,	16,	16,	'2024-05-01 08:00:00',	'2024-05-01 17:00:00',	'Scheduled',	6),
(164,	17,	NULL,	'2024-05-02 10:00:00',	'2024-05-02 14:00:00',	'Active',	6),
(165,	18,	18,	'2024-05-03 09:00:00',	'2024-05-03 18:00:00',	'Completed',	6),
(166,	19,	19,	'2024-05-01 08:00:00',	'2024-05-01 17:00:00',	'Scheduled',	7),
(167,	20,	NULL,	'2024-05-02 10:00:00',	'2024-05-02 14:00:00',	'Active',	7),
(168,	21,	21,	'2024-05-03 09:00:00',	'2024-05-03 18:00:00',	'Completed',	7),
(169,	22,	22,	'2024-05-01 08:00:00',	'2024-05-01 17:00:00',	'Scheduled',	8),
(170,	23,	NULL,	'2024-05-02 10:00:00',	'2024-05-02 14:00:00',	'Active',	8),
(171,	24,	24,	'2024-05-03 09:00:00',	'2024-05-03 18:00:00',	'Completed',	8),
(172,	25,	25,	'2024-05-01 08:00:00',	'2024-05-01 17:00:00',	'Scheduled',	9),
(173,	26,	NULL,	'2024-05-02 10:00:00',	'2024-05-02 14:00:00',	'Active',	9),
(174,	27,	27,	'2024-05-03 09:00:00',	'2024-05-03 18:00:00',	'Completed',	9),
(175,	28,	28,	'2024-05-01 08:00:00',	'2024-05-01 17:00:00',	'Scheduled',	10),
(176,	29,	NULL,	'2024-05-02 10:00:00',	'2024-05-02 14:00:00',	'Active',	10),
(177,	30,	30,	'2024-05-03 09:00:00',	'2024-05-03 18:00:00',	'Completed',	10),
(178,	31,	31,	'2024-05-01 08:00:00',	'2024-05-01 17:00:00',	'Scheduled',	11),
(179,	32,	NULL,	'2024-05-02 10:00:00',	'2024-05-02 14:00:00',	'Active',	11),
(180,	33,	33,	'2024-05-03 09:00:00',	'2024-05-03 18:00:00',	'Completed',	11);
-- Creating Reservations table
CREATE TABLE Reservations (
  ReservationId SERIAL PRIMARY KEY,
  ResourceId INT NOT NULL REFERENCES Resources(ResourceId),
  EmployeeId INT REFERENCES Employees(EmployeeId),
  CustomerId INT,
  StartTime TIMESTAMP,
  EndTime TIMESTAMP,
  Status reservation_status
);
