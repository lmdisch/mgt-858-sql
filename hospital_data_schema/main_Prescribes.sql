create table Prescribes
(
    Physician   INTEGER     not null
        constraint fk_Prescribes_Physician_Employee_ID
            references Physician,
    Patient     INTEGER     not null
        constraint fk_Prescribes_Patient_SSN
            references Patient,
    Medication  INTEGER     not null
        constraint fk_Prescribes_Medication_Code
            references Medication,
    Date        DATETIME    not null,
    Appointment INTEGER
        constraint fk_Prescribes_Appointment_AppointmentID
            references Appointment,
    Dose        VARCHAR(30) not null,
    primary key (Physician, Patient, Medication, Date)
);

INSERT INTO Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) VALUES (1, 100000001, 1, '2008-04-24 10:47', 13216584, '5');
INSERT INTO Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) VALUES (9, 100000004, 2, '2008-04-27 10:53', 86213939, '10');
INSERT INTO Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) VALUES (9, 100000004, 2, '2008-04-30 16:53', null, '5');
INSERT INTO Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) VALUES (10, 100000005, 5, '2008-04-30 16:53', null, '100');
INSERT INTO Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) VALUES (10, 100000005, 4, '2008-04-27 10:53', null, '150');
INSERT INTO Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) VALUES (11, 100000007, 5, '2008-04-27 10:53', null, '30');
INSERT INTO Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) VALUES (11, 100000008, 3, '2008-04-30 16:53', null, '5');
INSERT INTO Prescribes (Physician, Patient, Medication, Date, Appointment, Dose) VALUES (13, 100000006, 2, '2008-04-27 10:53', null, '20');