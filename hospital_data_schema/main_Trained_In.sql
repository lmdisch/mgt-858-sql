create table Trained_In
(
    Physician             INTEGER  not null
        constraint fk_Trained_In_Physician_Employee_ID
            references Physician,
    Treatment             INTEGER  not null
        constraint fk_Trained_In_Procedures_Code
            references Procedures,
    Certification_Date    DATETIME not null,
    Certification_Expires DATETIME not null,
    primary key (Physician, Treatment)
);

INSERT INTO Trained_In (Physician, Treatment, Certification_Date, Certification_Expires) VALUES (3, 1, '2008-01-01', '2008-12-31');
INSERT INTO Trained_In (Physician, Treatment, Certification_Date, Certification_Expires) VALUES (3, 2, '2008-01-01', '2008-12-31');
INSERT INTO Trained_In (Physician, Treatment, Certification_Date, Certification_Expires) VALUES (3, 5, '2008-01-01', '2008-12-31');
INSERT INTO Trained_In (Physician, Treatment, Certification_Date, Certification_Expires) VALUES (3, 6, '2008-01-01', '2008-12-31');
INSERT INTO Trained_In (Physician, Treatment, Certification_Date, Certification_Expires) VALUES (3, 7, '2008-01-01', '2008-12-31');
INSERT INTO Trained_In (Physician, Treatment, Certification_Date, Certification_Expires) VALUES (6, 2, '2008-01-01', '2008-12-31');
INSERT INTO Trained_In (Physician, Treatment, Certification_Date, Certification_Expires) VALUES (6, 5, '2007-01-01', '2007-12-31');
INSERT INTO Trained_In (Physician, Treatment, Certification_Date, Certification_Expires) VALUES (6, 6, '2008-01-01', '2008-12-31');
INSERT INTO Trained_In (Physician, Treatment, Certification_Date, Certification_Expires) VALUES (7, 1, '2008-01-01', '2008-12-31');
INSERT INTO Trained_In (Physician, Treatment, Certification_Date, Certification_Expires) VALUES (7, 2, '2008-01-01', '2008-12-31');
INSERT INTO Trained_In (Physician, Treatment, Certification_Date, Certification_Expires) VALUES (7, 3, '2008-01-01', '2008-12-31');
INSERT INTO Trained_In (Physician, Treatment, Certification_Date, Certification_Expires) VALUES (7, 4, '2008-01-01', '2008-12-31');
INSERT INTO Trained_In (Physician, Treatment, Certification_Date, Certification_Expires) VALUES (7, 5, '2008-01-01', '2008-12-31');
INSERT INTO Trained_In (Physician, Treatment, Certification_Date, Certification_Expires) VALUES (7, 6, '2008-01-01', '2008-12-31');
INSERT INTO Trained_In (Physician, Treatment, Certification_Date, Certification_Expires) VALUES (7, 7, '2008-01-01', '2008-12-31');
INSERT INTO Trained_In (Physician, Treatment, Certification_Date, Certification_Expires) VALUES (10, 1, '2007-01-01', '2007-12-31');
INSERT INTO Trained_In (Physician, Treatment, Certification_Date, Certification_Expires) VALUES (10, 19, '2007-01-01', '2008-12-31');