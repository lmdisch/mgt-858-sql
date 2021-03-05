create table Department
(
    Department_ID INTEGER     not null
        constraint pk_Department
            primary key,
    Name          VARCHAR(30) not null,
    Head          INTEGER     not null
        constraint fk_Department_Physician_Employee_ID
            references Physician
);

INSERT INTO Department (Department_ID, Name, Head) VALUES (1, 'General Medicine', 4);
INSERT INTO Department (Department_ID, Name, Head) VALUES (2, 'Surgery', 7);
INSERT INTO Department (Department_ID, Name, Head) VALUES (3, 'Psychiatry', 9);
INSERT INTO Department (Department_ID, Name, Head) VALUES (4, 'Diagnostics', 13);