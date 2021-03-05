create table Affiliated_With
(
    Physician           INTEGER not null
        constraint fk_Affiliated_With_Physician_Employee_ID
            references Physician,
    Department          INTEGER not null
        constraint fk_Affiliated_With_Department_Department_ID
            references Department,
    Primary_Affiliation BOOLEAN not null,
    primary key (Physician, Department)
);

INSERT INTO Affiliated_With (Physician, Department, Primary_Affiliation) VALUES (1, 1, 1);
INSERT INTO Affiliated_With (Physician, Department, Primary_Affiliation) VALUES (2, 1, 1);
INSERT INTO Affiliated_With (Physician, Department, Primary_Affiliation) VALUES (3, 1, 0);
INSERT INTO Affiliated_With (Physician, Department, Primary_Affiliation) VALUES (3, 2, 1);
INSERT INTO Affiliated_With (Physician, Department, Primary_Affiliation) VALUES (4, 1, 1);
INSERT INTO Affiliated_With (Physician, Department, Primary_Affiliation) VALUES (5, 1, 1);
INSERT INTO Affiliated_With (Physician, Department, Primary_Affiliation) VALUES (6, 2, 1);
INSERT INTO Affiliated_With (Physician, Department, Primary_Affiliation) VALUES (7, 1, 0);
INSERT INTO Affiliated_With (Physician, Department, Primary_Affiliation) VALUES (7, 2, 1);
INSERT INTO Affiliated_With (Physician, Department, Primary_Affiliation) VALUES (8, 1, 1);
INSERT INTO Affiliated_With (Physician, Department, Primary_Affiliation) VALUES (9, 3, 1);