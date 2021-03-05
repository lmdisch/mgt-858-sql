create table Appointment
(
    AppointmentID    INTEGER  not null
        primary key,
    Patient          INTEGER  not null
        constraint fk_Appointment_Patient_SSN
            references Patient,
    Prep_Nurse       INTEGER
        constraint fk_Appointment_Nurse_Employee_ID
            references Nurse,
    Physician        INTEGER  not null
        constraint fk_Appointment_Physician_Employee_ID
            references Physician,
    Start            DATETIME not null,
    End              DATETIME not null,
    Examination_Room TEXT     not null
);

INSERT INTO Appointment (AppointmentID, Patient, Prep_Nurse, Physician, Start, End, Examination_Room) VALUES (13216584, 100000001, 101, 1, '2008-04-24 10:00', '2008-04-24 11:00', 'A');
INSERT INTO Appointment (AppointmentID, Patient, Prep_Nurse, Physician, Start, End, Examination_Room) VALUES (20392049, 100000007, 103, 10, '2008-04-27 10:00', '2008-04-27 11:00', 'D');
INSERT INTO Appointment (AppointmentID, Patient, Prep_Nurse, Physician, Start, End, Examination_Room) VALUES (26548913, 100000002, 101, 2, '2008-04-24 10:00', '2008-04-24 11:00', 'B');
INSERT INTO Appointment (AppointmentID, Patient, Prep_Nurse, Physician, Start, End, Examination_Room) VALUES (36549879, 100000001, 102, 1, '2008-04-25 10:00', '2008-04-25 11:00', 'A');
INSERT INTO Appointment (AppointmentID, Patient, Prep_Nurse, Physician, Start, End, Examination_Room) VALUES (46846589, 100000004, 103, 4, '2008-04-25 10:00', '2008-04-25 11:00', 'B');
INSERT INTO Appointment (AppointmentID, Patient, Prep_Nurse, Physician, Start, End, Examination_Room) VALUES (59871321, 100000004, null, 4, '2008-04-26 10:00', '2008-04-26 11:00', 'C');
INSERT INTO Appointment (AppointmentID, Patient, Prep_Nurse, Physician, Start, End, Examination_Room) VALUES (69879231, 100000003, 103, 2, '2008-04-26 11:00', '2008-04-26 12:00', 'C');
INSERT INTO Appointment (AppointmentID, Patient, Prep_Nurse, Physician, Start, End, Examination_Room) VALUES (76983231, 100000001, null, 3, '2008-04-26 12:00', '2008-04-26 13:00', 'C');
INSERT INTO Appointment (AppointmentID, Patient, Prep_Nurse, Physician, Start, End, Examination_Room) VALUES (86213939, 100000004, 102, 9, '2008-04-27 10:00', '2008-04-21 11:00', 'A');
INSERT INTO Appointment (AppointmentID, Patient, Prep_Nurse, Physician, Start, End, Examination_Room) VALUES (93216548, 100000002, 101, 2, '2008-04-27 10:00', '2008-04-27 11:00', 'B');