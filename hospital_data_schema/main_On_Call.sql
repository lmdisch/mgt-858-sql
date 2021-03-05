create table On_Call
(
    Nurse         INTEGER  not null
        constraint fk_OnCall_Nurse_Employee_ID
            references Nurse,
    Block_Floor   INTEGER  not null,
    Block_Code    INTEGER  not null,
    On_Call_Start DATETIME not null,
    On_Call_End   DATETIME not null,
    primary key (Nurse, Block_Floor, Block_Code, On_Call_Start, On_Call_End),
    constraint fk_OnCall_Block_Floor
        foreign key (Block_Floor, Block_Code) references Block
);

INSERT INTO On_Call (Nurse, Block_Floor, Block_Code, On_Call_Start, On_Call_End) VALUES (101, 1, 1, '2008-11-04 11:00', '2008-11-04 19:00');
INSERT INTO On_Call (Nurse, Block_Floor, Block_Code, On_Call_Start, On_Call_End) VALUES (101, 1, 2, '2008-11-04 11:00', '2008-11-04 19:00');
INSERT INTO On_Call (Nurse, Block_Floor, Block_Code, On_Call_Start, On_Call_End) VALUES (102, 1, 3, '2008-11-04 11:00', '2008-11-04 19:00');
INSERT INTO On_Call (Nurse, Block_Floor, Block_Code, On_Call_Start, On_Call_End) VALUES (103, 1, 1, '2008-11-04 19:00', '2008-11-05 03:00');
INSERT INTO On_Call (Nurse, Block_Floor, Block_Code, On_Call_Start, On_Call_End) VALUES (103, 1, 2, '2008-11-04 19:00', '2008-11-05 03:00');
INSERT INTO On_Call (Nurse, Block_Floor, Block_Code, On_Call_Start, On_Call_End) VALUES (103, 1, 3, '2008-11-04 19:00', '2008-11-05 03:00');