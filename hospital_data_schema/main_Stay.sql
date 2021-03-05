create table Stay
(
    Stay_ID    INTEGER  not null
        primary key,
    Patient    INTEGER  not null
        constraint fk_Stay_Patient_SSN
            references Patient,
    Room       INTEGER  not null
        constraint fk_Stay_Room_Number
            references Room,
    Stay_Start DATETIME not null,
    Stay_End   DATETIME not null
);

INSERT INTO Stay (Stay_ID, Patient, Room, Stay_Start, Stay_End) VALUES (3215, 100000001, 111, '2008-05-01', '2008-05-04');
INSERT INTO Stay (Stay_ID, Patient, Room, Stay_Start, Stay_End) VALUES (3216, 100000003, 123, '2008-05-03', '2008-05-14');
INSERT INTO Stay (Stay_ID, Patient, Room, Stay_Start, Stay_End) VALUES (3217, 100000004, 112, '2008-05-02', '2008-05-03');
INSERT INTO Stay (Stay_ID, Patient, Room, Stay_Start, Stay_End) VALUES (3218, 100000005, 112, '2020-03-13', '2021-03-13');
INSERT INTO Stay (Stay_ID, Patient, Room, Stay_Start, Stay_End) VALUES (3219, 100000006, 112, '2021-03-23', '2021-03-24');