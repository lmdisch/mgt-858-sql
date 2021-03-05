create table Medication
(
    Code        INTEGER     not null
        primary key,
    Name        VARCHAR(30) not null,
    Brand       VARCHAR(30) not null,
    Description VARCHAR(30) not null
);

INSERT INTO Medication (Code, Name, Brand, Description) VALUES (1, 'Procrastin-X', 'X', 'N/A');
INSERT INTO Medication (Code, Name, Brand, Description) VALUES (2, 'Thesisin', 'Foo Labs', 'N/A');
INSERT INTO Medication (Code, Name, Brand, Description) VALUES (3, 'Awakin', 'Bar Laboratories', 'N/A');
INSERT INTO Medication (Code, Name, Brand, Description) VALUES (4, 'Crescavitin', 'Baz Industries', 'N/A');
INSERT INTO Medication (Code, Name, Brand, Description) VALUES (5, 'Melioraurin', 'Snafu Pharmaceuticals', 'N/A');