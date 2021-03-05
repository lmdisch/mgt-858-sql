create table Block
(
    Block_Floor INTEGER not null,
    Block_Code  INTEGER not null,
    primary key (Block_Floor, Block_Code)
);

INSERT INTO Block (Block_Floor, Block_Code) VALUES (1, 1);
INSERT INTO Block (Block_Floor, Block_Code) VALUES (1, 2);
INSERT INTO Block (Block_Floor, Block_Code) VALUES (1, 3);
INSERT INTO Block (Block_Floor, Block_Code) VALUES (2, 1);
INSERT INTO Block (Block_Floor, Block_Code) VALUES (2, 2);
INSERT INTO Block (Block_Floor, Block_Code) VALUES (2, 3);
INSERT INTO Block (Block_Floor, Block_Code) VALUES (3, 1);
INSERT INTO Block (Block_Floor, Block_Code) VALUES (3, 2);
INSERT INTO Block (Block_Floor, Block_Code) VALUES (3, 3);
INSERT INTO Block (Block_Floor, Block_Code) VALUES (4, 1);
INSERT INTO Block (Block_Floor, Block_Code) VALUES (4, 2);
INSERT INTO Block (Block_Floor, Block_Code) VALUES (4, 3);