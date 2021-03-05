create table Patient
(
    SSN          INTEGER     not null
        primary key,
    Name         VARCHAR(30) not null,
    Address      VARCHAR(30) not null,
    Phone        VARCHAR(30) not null,
    Insurance_ID INTEGER     not null,
    PCP          INTEGER     not null
        constraint fk_Patient_Physician_Employee_ID
            references Physician
);

INSERT INTO Patient (SSN, Name, Address, Phone, Insurance_ID, PCP) VALUES (100000001, 'John Smith', '42 Foobar Lane', '555-0256', 68476213, 1);
INSERT INTO Patient (SSN, Name, Address, Phone, Insurance_ID, PCP) VALUES (100000002, 'Grace Ritchie', '37 Snafu Drive', '555-0512', 36546321, 2);
INSERT INTO Patient (SSN, Name, Address, Phone, Insurance_ID, PCP) VALUES (100000003, 'Random J. Patient', '101 Omgbbq Street', '555-1204', 65465421, 2);
INSERT INTO Patient (SSN, Name, Address, Phone, Insurance_ID, PCP) VALUES (100000004, 'Dennis Doe', '1100 Foobaz Avenue', '555-2048', 68421879, 3);
INSERT INTO Patient (SSN, Name, Address, Phone, Insurance_ID, PCP) VALUES (100000005, 'Kim K. West', '1800 Clusterfarce Way', '867-5309', 68421499, 3);
INSERT INTO Patient (SSN, Name, Address, Phone, Insurance_ID, PCP) VALUES (100000006, 'Dougie Dougerson', '1500 Penny Lane', '505-4313', 58421499, 1);
INSERT INTO Patient (SSN, Name, Address, Phone, Insurance_ID, PCP) VALUES (100000007, 'Yeezy', '808 Heartbreak Lane', '202-2112', 68421498, 11);
INSERT INTO Patient (SSN, Name, Address, Phone, Insurance_ID, PCP) VALUES (100000008, 'Elon Albert Musk', '1500 Mars Blvd', '202-2143', 32139029, 1);