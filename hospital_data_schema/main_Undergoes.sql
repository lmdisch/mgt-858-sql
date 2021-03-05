create table Undergoes
(
    Patient         INTEGER  not null
        constraint fk_Undergoes_Patient_SSN
            references Patient,
    Procedures      INTEGER  not null
        constraint fk_Undergoes_Procedures_Code
            references Procedures,
    Stay            INTEGER  not null
        constraint fk_Undergoes_Stay_StayID
            references Stay,
    Date            DATETIME not null,
    Physician       INTEGER  not null
        constraint fk_Undergoes_Physician_Employee_ID
            references Physician,
    Assisting_Nurse INTEGER
        constraint fk_Undergoes_Nurse_Employee_ID
            references Nurse,
    primary key (Patient, Procedures, Stay, Date)
);

INSERT INTO Undergoes (Patient, Procedures, Stay, Date, Physician, Assisting_Nurse) VALUES (100000001, 6, 3215, '2008-05-02', 3, 101);
INSERT INTO Undergoes (Patient, Procedures, Stay, Date, Physician, Assisting_Nurse) VALUES (100000001, 2, 3215, '2008-05-03', 7, 101);
INSERT INTO Undergoes (Patient, Procedures, Stay, Date, Physician, Assisting_Nurse) VALUES (100000004, 1, 3217, '2008-05-07', 3, 102);
INSERT INTO Undergoes (Patient, Procedures, Stay, Date, Physician, Assisting_Nurse) VALUES (100000004, 5, 3217, '2008-05-09', 6, null);
INSERT INTO Undergoes (Patient, Procedures, Stay, Date, Physician, Assisting_Nurse) VALUES (100000001, 7, 3217, '2008-05-10', 7, 101);
INSERT INTO Undergoes (Patient, Procedures, Stay, Date, Physician, Assisting_Nurse) VALUES (100000004, 4, 3217, '2008-05-10', 3, 103);
INSERT INTO Undergoes (Patient, Procedures, Stay, Date, Physician, Assisting_Nurse) VALUES (100000005, 19, 3218, '2020-03-13', 10, 103);
INSERT INTO Undergoes (Patient, Procedures, Stay, Date, Physician, Assisting_Nurse) VALUES (100000006, 20, 3219, '2021-03-13', 10, null);