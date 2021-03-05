create table Room
(
    Room_Number INTEGER     not null
        primary key,
    RoomType    VARCHAR(30) not null,
    Block_Floor INTEGER     not null,
    Block_Code  INTEGER     not null,
    Unavailable BOOLEAN     not null,
    constraint fk_Room_Block_PK
        foreign key (Block_Floor, Block_Code) references Block
);

INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (101, 'Single', 1, 1, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (102, 'Single', 1, 1, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (103, 'Single', 1, 1, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (111, 'Single', 1, 2, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (112, 'Single', 1, 2, 1);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (113, 'Single', 1, 2, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (121, 'Single', 1, 3, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (122, 'Single', 1, 3, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (123, 'Single', 1, 3, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (201, 'Single', 2, 1, 1);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (202, 'Single', 2, 1, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (203, 'Single', 2, 1, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (211, 'Single', 2, 2, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (212, 'Single', 2, 2, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (213, 'Single', 2, 2, 1);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (221, 'Single', 2, 3, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (222, 'Single', 2, 3, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (223, 'Single', 2, 3, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (301, 'Single', 3, 1, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (302, 'Single', 3, 1, 1);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (303, 'Single', 3, 1, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (311, 'Single', 3, 2, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (312, 'Single', 3, 2, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (313, 'Single', 3, 2, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (321, 'Single', 3, 3, 1);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (322, 'Single', 3, 3, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (323, 'Single', 3, 3, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (401, 'Single', 4, 1, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (402, 'Single', 4, 1, 1);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (403, 'Single', 4, 1, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (411, 'Single', 4, 2, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (412, 'Single', 4, 2, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (413, 'Single', 4, 2, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (421, 'Single', 4, 3, 1);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (422, 'Single', 4, 3, 0);
INSERT INTO Room (Room_Number, RoomType, Block_Floor, Block_Code, Unavailable) VALUES (423, 'Single', 4, 3, 0);