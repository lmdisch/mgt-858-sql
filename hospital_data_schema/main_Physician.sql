create table Physician
(
    Employee_ID INTEGER     not null
        constraint pk_physician
            primary key,
    Name        VARCHAR(30) not null,
    Position    VARCHAR(30) not null,
    SSN         INTEGER     not null
);

INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (1, 'John Dorian', 'Staff Internist', 111111111);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (2, 'Elliot Reid', 'Attending Physician', 222222222);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (3, 'Christopher Turk', 'Surgical Attending Physician', 333333333);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (4, 'Percival Cox', 'Senior Attending Physician', 444444444);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (5, 'Bob Kelso', 'Head Chief of Medicine', 555555555);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (6, 'Todd Quinlan', 'Surgical Attending Physician', 666666666);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (7, 'John Wen', 'Surgical Attending Physician', 777777777);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (8, 'Keith Dudemeister', 'MD Resident', 888888888);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (9, 'Molly Clock', 'Attending Psychiatrist', 999999999);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (10, 'Kyle Percival Jensen', 'Cardiac Sequelogist ', 111111112);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (11, 'Nauman Alabaster Charania', 'MD Resident', 111111113);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (12, 'Mehmet Oz', 'Cardiothoracic Surgeon', 111111114);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (13, 'Gregory House', 'Diagnostician', 111111115);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (14, 'Cristina Yang', 'Surgical Attending Physician', 111111116);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (15, 'Doogie Howser', 'Resident Surgeon', 111111117);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (16, 'Dana Scully', 'Surgical Attending Physician / Skeptic', 111111118);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (17, 'Shaun Murphy', 'Attending Internal Medicine Physician', 111111119);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (18, 'Leonard "Bones" McCoy', 'Attending Emergency Medicine Physician', 111111120);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (19, 'Stephen Strange', 'Attending Neurosurgery Attending', 111111121);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (20, 'Bruce Banner', 'Attending Radiologist', 111111122);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (21, 'Allison Camerson', 'Resident Diagnostician', 111111123);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (22, 'Robert Chase', 'Resident Diagnostician', 111111124);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (23, 'Eric Foreman', 'Resident Diagnostician', 111111125);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (24, 'Sandra Lee', 'Attending Dermatologist & Cosmetic Surgeon ', 111111126);
INSERT INTO Physician (Employee_ID, Name, Position, SSN) VALUES (25, 'Derek Shepherd', 'Attending Neurosurgeon', 111111127);