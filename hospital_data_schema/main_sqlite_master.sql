-- No source text available
INSERT INTO sqlite_master (type, name, tbl_name, rootpage, sql) VALUES ('table', 'Physician', 'Physician', 2, 'CREATE TABLE Physician (
  Employee_ID INTEGER NOT NULL,
  Name VARCHAR(30) NOT NULL,
  Position VARCHAR(30) NOT NULL,
  SSN INTEGER NOT NULL,
  CONSTRAINT pk_physician PRIMARY KEY(Employee_ID)
)');
INSERT INTO sqlite_master (type, name, tbl_name, rootpage, sql) VALUES ('table', 'Department', 'Department', 3, 'CREATE TABLE Department (
  Department_ID INTEGER NOT NULL,
  Name VARCHAR(30) NOT NULL,
  Head INTEGER NOT NULL,
  CONSTRAINT pk_Department PRIMARY KEY(Department_ID),
  CONSTRAINT fk_Department_Physician_Employee_ID FOREIGN KEY(Head) REFERENCES Physician(Employee_ID)
)');
INSERT INTO sqlite_master (type, name, tbl_name, rootpage, sql) VALUES ('table', 'Affiliated_With', 'Affiliated_With', 4, 'CREATE TABLE Affiliated_With (
  Physician INTEGER NOT NULL,
  Department INTEGER NOT NULL,
  Primary_Affiliation BOOLEAN NOT NULL,
  CONSTRAINT fk_Affiliated_With_Physician_Employee_ID FOREIGN KEY(Physician) REFERENCES Physician(Employee_ID),
  CONSTRAINT fk_Affiliated_With_Department_Department_ID FOREIGN KEY(Department) REFERENCES Department(Department_ID),
  PRIMARY KEY(Physician, Department)
)');
INSERT INTO sqlite_master (type, name, tbl_name, rootpage, sql) VALUES ('index', 'sqlite_autoindex_Affiliated_With_1', 'Affiliated_With', 5, null);
INSERT INTO sqlite_master (type, name, tbl_name, rootpage, sql) VALUES ('table', 'Procedures', 'Procedures', 6, 'CREATE TABLE Procedures (
  Code INTEGER PRIMARY KEY NOT NULL,
  Name VARCHAR(30) NOT NULL,
  Cost REAL NOT NULL
)');
INSERT INTO sqlite_master (type, name, tbl_name, rootpage, sql) VALUES ('table', 'Trained_In', 'Trained_In', 7, 'CREATE TABLE Trained_In (
  Physician INTEGER NOT NULL,
  Treatment INTEGER NOT NULL,
  Certification_Date DATETIME NOT NULL,
  Certification_Expires DATETIME NOT NULL,
  CONSTRAINT fk_Trained_In_Physician_Employee_ID FOREIGN KEY(Physician) REFERENCES Physician(Employee_ID),
  CONSTRAINT fk_Trained_In_Procedures_Code FOREIGN KEY(Treatment) REFERENCES Procedures(Code),
  PRIMARY KEY(Physician, Treatment)
)');
INSERT INTO sqlite_master (type, name, tbl_name, rootpage, sql) VALUES ('index', 'sqlite_autoindex_Trained_In_1', 'Trained_In', 8, null);
INSERT INTO sqlite_master (type, name, tbl_name, rootpage, sql) VALUES ('table', 'Patient', 'Patient', 9, 'CREATE TABLE Patient (
  SSN INTEGER PRIMARY KEY NOT NULL,
  Name VARCHAR(30) NOT NULL,
  Address VARCHAR(30) NOT NULL,
  Phone VARCHAR(30) NOT NULL,
  Insurance_ID INTEGER NOT NULL,
  PCP INTEGER NOT NULL,
  CONSTRAINT fk_Patient_Physician_Employee_ID FOREIGN KEY(PCP) REFERENCES Physician(Employee_ID)
)');
INSERT INTO sqlite_master (type, name, tbl_name, rootpage, sql) VALUES ('table', 'Nurse', 'Nurse', 10, 'CREATE TABLE Nurse (
  Employee_ID INTEGER PRIMARY KEY NOT NULL,
  Name VARCHAR(30) NOT NULL,
  Position VARCHAR(30) NOT NULL,
  Registered BOOLEAN NOT NULL,
  SSN INTEGER NOT NULL
)');
INSERT INTO sqlite_master (type, name, tbl_name, rootpage, sql) VALUES ('table', 'Appointment', 'Appointment', 11, 'CREATE TABLE Appointment (
  AppointmentID INTEGER PRIMARY KEY NOT NULL,
  Patient INTEGER NOT NULL,
  Prep_Nurse INTEGER,
  Physician INTEGER NOT NULL,
  Start DATETIME NOT NULL,
  End DATETIME NOT NULL,
  Examination_Room TEXT NOT NULL,
  CONSTRAINT fk_Appointment_Patient_SSN FOREIGN KEY(Patient) REFERENCES Patient(SSN),
  CONSTRAINT fk_Appointment_Nurse_Employee_ID FOREIGN KEY(Prep_Nurse) REFERENCES Nurse(Employee_ID),
  CONSTRAINT fk_Appointment_Physician_Employee_ID FOREIGN KEY(Physician) REFERENCES Physician(Employee_ID)
)');
INSERT INTO sqlite_master (type, name, tbl_name, rootpage, sql) VALUES ('table', 'Medication', 'Medication', 12, 'CREATE TABLE Medication (
  Code INTEGER PRIMARY KEY NOT NULL,
  Name VARCHAR(30) NOT NULL,
  Brand VARCHAR(30) NOT NULL,
  Description VARCHAR(30) NOT NULL
)');
INSERT INTO sqlite_master (type, name, tbl_name, rootpage, sql) VALUES ('table', 'Prescribes', 'Prescribes', 13, 'CREATE TABLE Prescribes (
  Physician INTEGER NOT NULL,
  Patient INTEGER NOT NULL,
  Medication INTEGER NOT NULL,
  Date DATETIME NOT NULL,
  Appointment INTEGER,
  Dose VARCHAR(30) NOT NULL,
  PRIMARY KEY(Physician, Patient, Medication, Date),
  CONSTRAINT fk_Prescribes_Physician_Employee_ID FOREIGN KEY(Physician) REFERENCES Physician(Employee_ID),
  CONSTRAINT fk_Prescribes_Patient_SSN FOREIGN KEY(Patient) REFERENCES Patient(SSN),
  CONSTRAINT fk_Prescribes_Medication_Code FOREIGN KEY(Medication) REFERENCES Medication(Code),
  CONSTRAINT fk_Prescribes_Appointment_AppointmentID FOREIGN KEY(Appointment) REFERENCES Appointment(AppointmentID)
)');
INSERT INTO sqlite_master (type, name, tbl_name, rootpage, sql) VALUES ('index', 'sqlite_autoindex_Prescribes_1', 'Prescribes', 14, null);
INSERT INTO sqlite_master (type, name, tbl_name, rootpage, sql) VALUES ('table', 'Block', 'Block', 15, 'CREATE TABLE Block (
  Block_Floor INTEGER NOT NULL,
  Block_Code INTEGER NOT NULL,
  PRIMARY KEY(Block_Floor, Block_Code)
)');
INSERT INTO sqlite_master (type, name, tbl_name, rootpage, sql) VALUES ('index', 'sqlite_autoindex_Block_1', 'Block', 16, null);
INSERT INTO sqlite_master (type, name, tbl_name, rootpage, sql) VALUES ('table', 'Room', 'Room', 18, 'CREATE TABLE Room (
  Room_Number INTEGER PRIMARY KEY NOT NULL,
  RoomType VARCHAR(30) NOT NULL,
  Block_Floor INTEGER NOT NULL,
  Block_Code INTEGER NOT NULL,
  Unavailable BOOLEAN NOT NULL,
  CONSTRAINT fk_Room_Block_PK FOREIGN KEY(Block_Floor, Block_Code) REFERENCES Block(Block_Floor, Block_Code)
)');
INSERT INTO sqlite_master (type, name, tbl_name, rootpage, sql) VALUES ('table', 'On_Call', 'On_Call', 20, 'CREATE TABLE On_Call (
  Nurse INTEGER NOT NULL,
  Block_Floor INTEGER NOT NULL,
  Block_Code INTEGER NOT NULL,
  On_Call_Start DATETIME NOT NULL,
  On_Call_End DATETIME NOT NULL,
  PRIMARY KEY(Nurse, Block_Floor, Block_Code, On_Call_Start, On_Call_End),
  CONSTRAINT fk_OnCall_Nurse_Employee_ID FOREIGN KEY(Nurse) REFERENCES Nurse(Employee_ID),
  CONSTRAINT fk_OnCall_Block_Floor FOREIGN KEY(Block_Floor, Block_Code) REFERENCES Block(Block_Floor, Block_Code)
)');
INSERT INTO sqlite_master (type, name, tbl_name, rootpage, sql) VALUES ('index', 'sqlite_autoindex_On_Call_1', 'On_Call', 21, null);
INSERT INTO sqlite_master (type, name, tbl_name, rootpage, sql) VALUES ('table', 'Stay', 'Stay', 22, 'CREATE TABLE Stay (
  Stay_ID INTEGER PRIMARY KEY NOT NULL,
  Patient INTEGER NOT NULL,
  Room INTEGER NOT NULL,
  Stay_Start DATETIME NOT NULL,
  Stay_End DATETIME NOT NULL,
  CONSTRAINT fk_Stay_Patient_SSN FOREIGN KEY(Patient) REFERENCES Patient(SSN),
  CONSTRAINT fk_Stay_Room_Number FOREIGN KEY(Room) REFERENCES Room(Room_Number)
)');
INSERT INTO sqlite_master (type, name, tbl_name, rootpage, sql) VALUES ('table', 'Undergoes', 'Undergoes', 23, 'CREATE TABLE Undergoes (
  Patient INTEGER NOT NULL,
  Procedures INTEGER NOT NULL,
  Stay INTEGER NOT NULL,
  Date DATETIME NOT NULL,
  Physician INTEGER NOT NULL,
  Assisting_Nurse INTEGER,
  PRIMARY KEY(Patient, Procedures, Stay, Date),
  CONSTRAINT fk_Undergoes_Patient_SSN FOREIGN KEY(Patient) REFERENCES Patient(SSN),
  CONSTRAINT fk_Undergoes_Procedures_Code FOREIGN KEY(Procedures) REFERENCES Procedures(Code),
  CONSTRAINT fk_Undergoes_Stay_StayID FOREIGN KEY(Stay) REFERENCES Stay(Stay_ID),
  CONSTRAINT fk_Undergoes_Physician_Employee_ID FOREIGN KEY(Physician) REFERENCES Physician(Employee_ID),
  CONSTRAINT fk_Undergoes_Nurse_Employee_ID FOREIGN KEY(Assisting_Nurse) REFERENCES Nurse(Employee_ID)
)');
INSERT INTO sqlite_master (type, name, tbl_name, rootpage, sql) VALUES ('index', 'sqlite_autoindex_Undergoes_1', 'Undergoes', 24, null);