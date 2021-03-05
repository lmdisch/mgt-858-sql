create table Nurse
(
    Employee_ID INTEGER     not null
        primary key,
    Name        VARCHAR(30) not null,
    Position    VARCHAR(30) not null,
    Registered  BOOLEAN     not null,
    SSN         INTEGER     not null
);

INSERT INTO Nurse (Employee_ID, Name, Position, Registered, SSN) VALUES (101, 'Carla Espinosa', 'Head Nurse', 1, 111111110);
INSERT INTO Nurse (Employee_ID, Name, Position, Registered, SSN) VALUES (102, 'Laverne Roberts', 'Nurse', 1, 222222220);
INSERT INTO Nurse (Employee_ID, Name, Position, Registered, SSN) VALUES (103, 'Paul Flowers', 'Nurse', 0, 333333330);