--Radoslaw Schwichtenberg
--Baza danych wypo¿yczalnia kajaków
--   at:        2019-04-21 18:02:57 CEST
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g
/*Aby zaladowac skrypt w Run SQL Command Line
@sciezka_do_naszego_skryptu;

np.
@D:\Pulpit\#Systemybazdanych\projekt\skrypttworzacy.sql
*/
/*
DROP TABLE wypozyczenie PURGE;
DROP TABLE pracownik PURGE;
DROP TABLE klient PURGE;
DROP TABLE kajak PURGE;

*/


--wypozyczalnia_polnoc

connect / as sysdba;
create user wypozyczalnia_polnoc identified by "wyp";
grant all privileges to wypozyczalnia_polnoc identified by "wyp";
disconnect;

connect wypozyczalnia_polnoc/wyp;

CREATE TABLE kajak (
    id               INTEGER NOT NULL,
    typ              VARCHAR2(20) NOT NULL,
    data_produkcji   DATE NOT NULL
);

ALTER TABLE kajak ADD CONSTRAINT kajak_pk PRIMARY KEY ( id );

CREATE TABLE klient (
    id                    INTEGER NOT NULL,
    imie                  VARCHAR2(15) NOT NULL,
    nazwisko              VARCHAR2(25) NOT NULL,
    nr_karty_kredytowej   CHAR(20),
    firma                 VARCHAR2(50),
    ulica                 VARCHAR2(25) NOT NULL,
    numer                 VARCHAR2(8) NOT NULL,
    miasto                VARCHAR2(24) NOT NULL,
    kod                   CHAR(6) NOT NULL,
    nip                   CHAR(11),
    telefon               VARCHAR2(16)
);

ALTER TABLE klient ADD CONSTRAINT klient_pk PRIMARY KEY ( id );

CREATE TABLE pracownik (
    id           INTEGER NOT NULL,
    imie         VARCHAR2(15) NOT NULL,
    nazwisko     VARCHAR2(20) NOT NULL,
    data_zatr    DATE NOT NULL,
    pensja       NUMBER(8, 2) NOT NULL,
    stanowisko   VARCHAR2(20) NOT NULL,
    telefon      VARCHAR2(16) NOT NULL
);

ALTER TABLE pracownik ADD CONSTRAINT pracownik_pk PRIMARY KEY ( id );

CREATE TABLE wypozyczenie (
    id             INTEGER NOT NULL,
    data_wyp       DATE NOT NULL,
    data_oddania   DATE,
    kaucja         NUMBER(8, 2),
    cena           NUMBER(8, 2) NOT NULL,
    kajak_id       INTEGER NOT NULL,
    klient_id      INTEGER NOT NULL,
    pracownik_id   INTEGER NOT NULL
);

ALTER TABLE wypozyczenie ADD CONSTRAINT wypozyczenie_pk PRIMARY KEY ( id );

ALTER TABLE wypozyczenie
    ADD CONSTRAINT wypozyczenie_kajak_fk FOREIGN KEY ( kajak_id )
        REFERENCES kajak ( id );

ALTER TABLE wypozyczenie
    ADD CONSTRAINT wypozyczenie_klient_fk FOREIGN KEY ( klient_id )
        REFERENCES klient ( id );

ALTER TABLE wypozyczenie
    ADD CONSTRAINT wypozyczenie_pracownik_fk FOREIGN KEY ( pracownik_id )
        REFERENCES pracownik ( id );

CREATE SEQUENCE kajak_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER kajak_id_trg BEFORE
    INSERT ON kajak
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := kajak_id_seq.nextval;
END;
/

CREATE SEQUENCE klient_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER klient_id_trg BEFORE
    INSERT ON klient
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := klient_id_seq.nextval;
END;
/

CREATE SEQUENCE pracownik_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER pracownik_id_trg BEFORE
    INSERT ON pracownik
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := pracownik_id_seq.nextval;
END;
/

CREATE SEQUENCE wypozyczenie_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER wypozyczenie_id_trg BEFORE
    INSERT ON wypozyczenie
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := wypozyczenie_id_seq.nextval;
END;
/
--INSERTY
INSERT INTO klient(id,imie, nazwisko, nr_karty_kredytowej ,firma , ulica ,numer, miasto , kod  , nip , telefon) VALUES(1,'Janusz','Pawlacz','4707967582815609','Spóldzielnia Mleczarska','Lesna','1','Wroclaw','37-400','987-765-333','811-311-147');  
INSERT INTO klient(id,imie, nazwisko, nr_karty_kredytowej ,firma , ulica ,numer, miasto , kod  , nip , telefon) VALUES(2,'Angelina','Pawlacz','4707967582815609','Spóldzielnia Mleczarska','Lesna','1','Wroclaw','37-400','987-765-333','606-555-666');         

INSERT INTO pracownik(id,imie,nazwisko,data_zatr,stanowisko,pensja,telefon)
VALUES (1, 'Ryszard', 'Bagielski', '1999-05-01', 'prezes', 2100, '487-531-144');
INSERT INTO pracownik(id,imie,nazwisko,data_zatr,stanowisko,pensja,telefon)
VALUES (2, 'Waclaw', 'Kowalski', '1980-07-02', 'dyrektor', 2055, '676-531-144');

INSERT INTO kajak(id,typ,data_produkcji)
VALUES (1, 'Turystyczny','1995-01-01');
INSERT INTO kajak(id,typ,data_produkcji)
VALUES (2, 'Górski','2002-02-02');

INSERT INTO wypozyczenie (id, data_wyp,data_oddania,kaucja ,cena, kajak_id,klient_id ,pracownik_id)
VALUES (1, '2004-09-11',NULL, 200, 50,1,1,1);
INSERT INTO wypozyczenie(id,data_wyp,data_oddania,kaucja,cena,kajak_id,klient_id ,pracownik_id)
VALUES (2, '2004-09-15', '1998-09-20', 200, 300,2,2,2);

disconnect;




--wypozyczalnia_poludnie

connect / as sysdba
create user wypozyczalnia_poludnie identified by "wyp";
grant all privileges to wypozyczalnia_poludnie identified by "wyp";
disconnect;

connect wypozyczalnia_poludnie/wyp;

CREATE TABLE kajak (
    id               INTEGER NOT NULL,
    typ              VARCHAR2(20) NOT NULL,
    data_produkcji   DATE NOT NULL
);

ALTER TABLE kajak ADD CONSTRAINT kajak_pk PRIMARY KEY ( id );

CREATE TABLE klient (
    id                    INTEGER NOT NULL,
    imie                  VARCHAR2(15) NOT NULL,
    nazwisko              VARCHAR2(25) NOT NULL,
    nr_karty_kredytowej   CHAR(20),
    firma                 VARCHAR2(50),
    ulica                 VARCHAR2(25) NOT NULL,
    numer                 VARCHAR2(8) NOT NULL,
    miasto                VARCHAR2(24) NOT NULL,
    kod                   CHAR(6) NOT NULL,
    nip                   CHAR(11),
    telefon               VARCHAR2(16)
);

ALTER TABLE klient ADD CONSTRAINT klient_pk PRIMARY KEY ( id );

CREATE TABLE pracownik (
    id           INTEGER NOT NULL,
    imie         VARCHAR2(15) NOT NULL,
    nazwisko     VARCHAR2(20) NOT NULL,
    data_zatr    DATE NOT NULL,
    pensja       NUMBER(8, 2) NOT NULL,
    stanowisko   VARCHAR2(20) NOT NULL,
    telefon      VARCHAR2(16) NOT NULL
);

ALTER TABLE pracownik ADD CONSTRAINT pracownik_pk PRIMARY KEY ( id );

CREATE TABLE wypozyczenie (
    id             INTEGER NOT NULL,
    data_wyp       DATE NOT NULL,
    data_oddania   DATE,
    kaucja         NUMBER(8, 2),
    cena           NUMBER(8, 2) NOT NULL,
    kajak_id       INTEGER NOT NULL,
    klient_id      INTEGER NOT NULL,
    pracownik_id   INTEGER NOT NULL
);

ALTER TABLE wypozyczenie ADD CONSTRAINT wypozyczenie_pk PRIMARY KEY ( id );

ALTER TABLE wypozyczenie
    ADD CONSTRAINT wypozyczenie_kajak_fk FOREIGN KEY ( kajak_id )
        REFERENCES kajak ( id );

ALTER TABLE wypozyczenie
    ADD CONSTRAINT wypozyczenie_klient_fk FOREIGN KEY ( klient_id )
        REFERENCES klient ( id );

ALTER TABLE wypozyczenie
    ADD CONSTRAINT wypozyczenie_pracownik_fk FOREIGN KEY ( pracownik_id )
        REFERENCES pracownik ( id );

CREATE SEQUENCE kajak_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER kajak_id_trg BEFORE
    INSERT ON kajak
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := kajak_id_seq.nextval;
END;
/

CREATE SEQUENCE klient_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER klient_id_trg BEFORE
    INSERT ON klient
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := klient_id_seq.nextval;
END;
/

CREATE SEQUENCE pracownik_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER pracownik_id_trg BEFORE
    INSERT ON pracownik
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := pracownik_id_seq.nextval;
END;
/

CREATE SEQUENCE wypozyczenie_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER wypozyczenie_id_trg BEFORE
    INSERT ON wypozyczenie
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := wypozyczenie_id_seq.nextval;
END;
/
--INSERTY
INSERT INTO klient(id,imie, nazwisko, nr_karty_kredytowej ,firma , ulica ,numer, miasto , kod  , nip , telefon) VALUES(1,'Janusz','Kowalski','5007967582815555','Spóldzielnia Mieszkaniowa','Miejska','5','Wroclaw','50-002','600-755-333','510-018-669');  
INSERT INTO klient(id,imie, nazwisko, nr_karty_kredytowej ,firma , ulica ,numer, miasto , kod  , nip , telefon) VALUES(2,'Angelina','Kowalska','5007967582815555','Spóldzielnia Mieszkaniowa','Miejska','5','Wroclaw','50-002','600-755-333','606-555-666');         

INSERT INTO pracownik(id,imie,nazwisko,data_zatr,stanowisko,pensja,telefon)
VALUES (1, 'Dobromir', 'Sosnierz', '1999-05-01', 'prezes', 3000, '660-140-360');
INSERT INTO pracownik(id,imie,nazwisko,data_zatr,stanowisko,pensja,telefon)
VALUES (2, 'Jerzy', 'Las', '2000-05-03', 'dyrektor', 2700, '999-555-222');

INSERT INTO kajak(id,typ,data_produkcji)
VALUES (1, 'Turystyczny','2000-01-01');
INSERT INTO kajak(id,typ,data_produkcji)
VALUES (2, 'Górski','2002-02-02');

INSERT INTO wypozyczenie (id, data_wyp,data_oddania,kaucja ,cena, kajak_id,klient_id ,pracownik_id)
VALUES (1, '2003-05-11',NULL, 300, 20,1,1,1);
INSERT INTO wypozyczenie(id,data_wyp,data_oddania,kaucja,cena,kajak_id,klient_id ,pracownik_id)
VALUES (2, '2003-05-15', '2005-09-20', 300, 500,2,2,2);

disconnect;


--wypozyczalnia_wschod

connect / as sysdba
create user wypozyczalnia_wschod identified by "wyp";
grant all privileges to wypozyczalnia_wschod identified by "wyp";
disconnect;

connect wypozyczalnia_wschod/wyp;

CREATE TABLE kajak (
    id               INTEGER NOT NULL,
    typ              VARCHAR2(20) NOT NULL,
    data_produkcji   DATE NOT NULL
);

ALTER TABLE kajak ADD CONSTRAINT kajak_pk PRIMARY KEY ( id );

CREATE TABLE klient (
    id                    INTEGER NOT NULL,
    imie                  VARCHAR2(15) NOT NULL,
    nazwisko              VARCHAR2(25) NOT NULL,
    nr_karty_kredytowej   CHAR(20),
    firma                 VARCHAR2(50),
    ulica                 VARCHAR2(25) NOT NULL,
    numer                 VARCHAR2(8) NOT NULL,
    miasto                VARCHAR2(24) NOT NULL,
    kod                   CHAR(6) NOT NULL,
    nip                   CHAR(11),
    telefon               VARCHAR2(16)
);

ALTER TABLE klient ADD CONSTRAINT klient_pk PRIMARY KEY ( id );

CREATE TABLE pracownik (
    id           INTEGER NOT NULL,
    imie         VARCHAR2(15) NOT NULL,
    nazwisko     VARCHAR2(20) NOT NULL,
    data_zatr    DATE NOT NULL,
    pensja       NUMBER(8, 2) NOT NULL,
    stanowisko   VARCHAR2(20) NOT NULL,
    telefon      VARCHAR2(16) NOT NULL
);

ALTER TABLE pracownik ADD CONSTRAINT pracownik_pk PRIMARY KEY ( id );

CREATE TABLE wypozyczenie (
    id             INTEGER NOT NULL,
    data_wyp       DATE NOT NULL,
    data_oddania   DATE,
    kaucja         NUMBER(8, 2),
    cena           NUMBER(8, 2) NOT NULL,
    kajak_id       INTEGER NOT NULL,
    klient_id      INTEGER NOT NULL,
    pracownik_id   INTEGER NOT NULL
);

ALTER TABLE wypozyczenie ADD CONSTRAINT wypozyczenie_pk PRIMARY KEY ( id );

ALTER TABLE wypozyczenie
    ADD CONSTRAINT wypozyczenie_kajak_fk FOREIGN KEY ( kajak_id )
        REFERENCES kajak ( id );

ALTER TABLE wypozyczenie
    ADD CONSTRAINT wypozyczenie_klient_fk FOREIGN KEY ( klient_id )
        REFERENCES klient ( id );

ALTER TABLE wypozyczenie
    ADD CONSTRAINT wypozyczenie_pracownik_fk FOREIGN KEY ( pracownik_id )
        REFERENCES pracownik ( id );

CREATE SEQUENCE kajak_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER kajak_id_trg BEFORE
    INSERT ON kajak
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := kajak_id_seq.nextval;
END;
/

CREATE SEQUENCE klient_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER klient_id_trg BEFORE
    INSERT ON klient
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := klient_id_seq.nextval;
END;
/

CREATE SEQUENCE pracownik_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER pracownik_id_trg BEFORE
    INSERT ON pracownik
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := pracownik_id_seq.nextval;
END;
/

CREATE SEQUENCE wypozyczenie_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER wypozyczenie_id_trg BEFORE
    INSERT ON wypozyczenie
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := wypozyczenie_id_seq.nextval;
END;
/
--INSERTY
INSERT INTO klient(id,imie, nazwisko, nr_karty_kredytowej ,firma , ulica ,numer, miasto , kod  , nip , telefon) VALUES(1,'Dimitr','Kaliningrad','1112227582815444','Spóldzielnia budowlano - mieszkaniowa','Wojska Polskiego','1','Elblag','82-300','5323190169','666-665-654');  
INSERT INTO klient(id,imie, nazwisko, nr_karty_kredytowej ,firma , ulica ,numer, miasto , kod  , nip , telefon) VALUES(2,'Tatiana','Królewiec','1112227582815444','Spóldzielnia budowlano - mieszkaniowa','Wojska Polskiego','1','Elblag','82-300','5323190169','666-665-654');         

INSERT INTO pracownik(id,imie,nazwisko,data_zatr,stanowisko,pensja,telefon)
VALUES (1, 'Wincenty', 'Malbork', '2006-05-01', 'prezes', 4000, '777-777-360');
INSERT INTO pracownik(id,imie,nazwisko,data_zatr,stanowisko,pensja,telefon)
VALUES (2, 'Bo¿ena', 'Pole', '2006-05-03', 'dyrektor', 2700, '888-888-222');

INSERT INTO kajak(id,typ,data_produkcji)
VALUES (1, 'Turystyczny','2000-01-01');
INSERT INTO kajak(id,typ,data_produkcji)
VALUES (2, 'Górski','2002-02-02');

INSERT INTO wypozyczenie (id, data_wyp,data_oddania,kaucja ,cena, kajak_id,klient_id ,pracownik_id)
VALUES (1, '2006-07-11',NULL, 300, 20,1,1,1);
INSERT INTO wypozyczenie(id,data_wyp,data_oddania,kaucja,cena,kajak_id,klient_id ,pracownik_id)
VALUES (2, '2006-08-15', '2006-09-01', 400, 1000,2,2,2);

disconnect;

connect wypozyczalnia_polnoc/wyp;
CREATE public DATABASE link link_do_poludnie
CONNECT TO wypozyczalnia_poludnie IDENTIFIED BY wyp
USING 'xe';

CREATE public DATABASE link link_do_wschod
CONNECT TO wypozyczalnia_wschod IDENTIFIED BY wyp
USING 'xe';

CREATE SNAPSHOT migawka REFRESH NEXT sysdate + 1 AS SELECT * FROM klient@link_do_poludnie UNION SELECT * FROM klient@link_do_wschod;
disconnect;
