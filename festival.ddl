-- Generated by Oracle SQL Developer Data Modeler 19.4.0.350.1424
--   at:        2020-01-29 00:17:20 CET
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



CREATE TABLE backstage (
    sif_bs             INTEGER NOT NULL,
    kap_bs             INTEGER,
    bina_sif_bin       INTEGER NOT NULL,
    bina_zona_sif_zon  INTEGER NOT NULL,
    bina_zona_id_rf    INTEGER NOT NULL,
    bina_zona_ozn_fes  INTEGER NOT NULL
);

CREATE UNIQUE INDEX backstage__idx ON
    backstage (
        bina_sif_bin
    ASC,
        bina_zona_sif_zon
    ASC,
        bina_zona_id_rf
    ASC,
        bina_zona_ozn_fes
    ASC );

ALTER TABLE backstage
    ADD CONSTRAINT backstage_pk PRIMARY KEY ( sif_bs,
                                              bina_sif_bin,
                                              bina_zona_sif_zon,
                                              bina_zona_id_rf,
                                              bina_zona_ozn_fes );

CREATE TABLE bina (
    sif_bin       INTEGER NOT NULL,
    kap_bin       INTEGER,
    zona_sif_zon  INTEGER NOT NULL,
    zona_id_rf    INTEGER NOT NULL,
    zona_ozn_fes  INTEGER NOT NULL
);

ALTER TABLE bina
    ADD CONSTRAINT bina_pk PRIMARY KEY ( sif_bin,
                                         zona_sif_zon,
                                         zona_id_rf,
                                         zona_ozn_fes );

CREATE TABLE ceker (
    jmbg                    INTEGER NOT NULL,
    ulaz_sif_ulz            INTEGER,
    ulaz_realizacija_id_rf  INTEGER,
    ulaz_real_fest_ozn_fes  INTEGER
);

ALTER TABLE ceker ADD CONSTRAINT ceker_pk PRIMARY KEY ( jmbg );

CREATE TABLE dolazi (
    izv_sif_izv   INTEGER NOT NULL,
    rf_id_rf      INTEGER NOT NULL,
    rf_ozn_fes    INTEGER NOT NULL,
    bina_sif_bin  INTEGER NOT NULL,
    b_z_sif_zon   INTEGER NOT NULL,
    b_z_id_rf     INTEGER NOT NULL,
    b_z_ozn_fes   INTEGER NOT NULL
);

ALTER TABLE dolazi
    ADD CONSTRAINT dolazi_pk PRIMARY KEY ( izv_sif_izv,
                                           rf_id_rf,
                                           rf_ozn_fes );

CREATE TABLE festival (
    ozn_fes  INTEGER NOT NULL,
    naz_fes  VARCHAR2(20) NOT NULL
);

ALTER TABLE festival ADD CONSTRAINT festival_pk PRIMARY KEY ( ozn_fes );

CREATE TABLE ima_pristup (
    vip_karta_sif_kar  INTEGER NOT NULL,
    vip_karta_id_rf    INTEGER NOT NULL,
    vip_karta_ozn_fes  INTEGER NOT NULL,
    bs_sif_bs          INTEGER NOT NULL,
    bs_sif_bin         INTEGER NOT NULL,
    bs_sif_zon         INTEGER NOT NULL,
    bs_id_rf           INTEGER NOT NULL,
    bs_ozn_fes         INTEGER NOT NULL
);

ALTER TABLE ima_pristup
    ADD CONSTRAINT ima_pristup_pk PRIMARY KEY ( vip_karta_sif_kar,
                                                vip_karta_id_rf,
                                                vip_karta_ozn_fes,
                                                bs_sif_bs,
                                                bs_sif_bin,
                                                bs_sif_zon,
                                                bs_id_rf,
                                                bs_ozn_fes );

CREATE TABLE ima_ugovor (
    dat_su      DATE,
    pp_sif_pp   INTEGER NOT NULL,
    rf_id_rf    INTEGER NOT NULL,
    rf_ozn_fes  INTEGER NOT NULL
);

ALTER TABLE ima_ugovor
    ADD CONSTRAINT ima_ugovor_pk PRIMARY KEY ( rf_id_rf,
                                               rf_ozn_fes,
                                               pp_sif_pp );

CREATE TABLE izvodi_se (
    zona_sif_zon  INTEGER NOT NULL,
    zona_id_rf    INTEGER NOT NULL,
    zona_ozn_fes  INTEGER NOT NULL,
    zanr_sif_znr  INTEGER NOT NULL
);

ALTER TABLE izvodi_se
    ADD CONSTRAINT izvodi_se_pk PRIMARY KEY ( zona_sif_zon,
                                              zona_id_rf,
                                              zona_ozn_fes,
                                              zanr_sif_znr );

CREATE TABLE izvodjac (
    sif_izv  INTEGER NOT NULL,
    naz_izv  VARCHAR2(20) NOT NULL
);

ALTER TABLE izvodjac ADD CONSTRAINT izvodjac_pk PRIMARY KEY ( sif_izv );

CREATE TABLE karta (
    sif_kar             INTEGER NOT NULL,
    dat_pvk             DATE,
    dat_kvk             DATE,
    nar_pro             CHAR(1),
    bar_kod             INTEGER,
    real_id_rf          INTEGER NOT NULL,
    rf_f_ozn_fes        INTEGER NOT NULL,
    ceker_jmbg          INTEGER,
    tip_karte           VARCHAR2(20) NOT NULL,
    karta_sif_kar       INTEGER,
    karta_rf_id_rf      INTEGER,
    karta_rf_f_ozn_fes  INTEGER
);

ALTER TABLE karta
    ADD CONSTRAINT ch_inh_karta CHECK ( tip_karte IN (
        'Karta',
        'Staff_karta',
        'VIP_karta'
    ) );

ALTER TABLE karta
    ADD CONSTRAINT karta_pk PRIMARY KEY ( sif_kar,
                                          real_id_rf,
                                          rf_f_ozn_fes );

CREATE TABLE nudi (
    stand_sif_sta  INTEGER NOT NULL,
    zona_sif_zon   INTEGER NOT NULL,
    zona_id_rf     INTEGER NOT NULL,
    zona_ozn_fes   INTEGER NOT NULL
);

ALTER TABLE nudi
    ADD CONSTRAINT nudi_pk PRIMARY KEY ( stand_sif_sta,
                                         zona_sif_zon,
                                         zona_id_rf,
                                         zona_ozn_fes );

CREATE TABLE poslovni_partner (
    sif_pp  INTEGER NOT NULL,
    naz_pp  VARCHAR2(20) NOT NULL
);

ALTER TABLE poslovni_partner ADD CONSTRAINT poslovni_partner_pk PRIMARY KEY ( sif_pp );

CREATE TABLE pripada (
    izvodjac_sif_izv  INTEGER NOT NULL,
    zanr_sif_znr      INTEGER NOT NULL
);

ALTER TABLE pripada ADD CONSTRAINT pripada_pk PRIMARY KEY ( izvodjac_sif_izv,
                                                            zanr_sif_znr );

CREATE TABLE prodavac (
    jmbg                INTEGER NOT NULL,
    nudi_stand_sif_sta  INTEGER,
    nudi_zona_sif_zon   INTEGER,
    nudi_zona_id_rf     INTEGER,
    nudi_zona_ozn_fes   INTEGER,
    kol_pro             INTEGER
);

ALTER TABLE prodavac ADD CONSTRAINT prodavac_pk PRIMARY KEY ( jmbg );

CREATE TABLE radi (
    festival_ozn_fes  INTEGER NOT NULL,
    radnik_jmbg       INTEGER NOT NULL
);

ALTER TABLE radi ADD CONSTRAINT radi_pk PRIMARY KEY ( festival_ozn_fes,
                                                      radnik_jmbg );

CREATE TABLE radnik (
    jmbg         INTEGER NOT NULL,
    ime_rad      VARCHAR2(20),
    prz_rad      VARCHAR2(20),
    tip_radnika  VARCHAR2(4000) NOT NULL
);

ALTER TABLE radnik
    ADD CONSTRAINT ch_inh_radnik CHECK ( tip_radnika IN (
        'Ceker',
        'Prodavac',
        'Redar'
    ) );

ALTER TABLE radnik ADD CONSTRAINT radnik_pk PRIMARY KEY ( jmbg );

CREATE TABLE realizacija_festivala (
    id_rf             INTEGER NOT NULL,
    dat_poc           DATE,
    dat_kra           DATE,
    kap_rf            INTEGER,
    festival_ozn_fes  INTEGER NOT NULL
);

ALTER TABLE realizacija_festivala ADD CONSTRAINT realizacija_festivala_pk PRIMARY KEY ( id_rf,
                                                                                        festival_ozn_fes );

CREATE TABLE redar (
    jmbg          INTEGER NOT NULL,
    zona_sif_zon  INTEGER,
    zona_id_rf    INTEGER,
    zona_ozn_fes  INTEGER
);

ALTER TABLE redar ADD CONSTRAINT redar_pk PRIMARY KEY ( jmbg );

CREATE TABLE staff_karta (
    sif_kar       INTEGER NOT NULL,
    radi_ozn_fes  INTEGER NOT NULL,
    radi_jmbg     INTEGER NOT NULL,
    id_rf         INTEGER NOT NULL,
    ozn_fes       INTEGER NOT NULL
);

CREATE UNIQUE INDEX staff_karta__idx ON
    staff_karta (
        radi_ozn_fes
    ASC,
        radi_jmbg
    ASC );

ALTER TABLE staff_karta
    ADD CONSTRAINT staff_karta_pk PRIMARY KEY ( sif_kar,
                                                id_rf,
                                                ozn_fes );

CREATE TABLE stand (
    sif_sta          INTEGER NOT NULL,
    naz_sta          VARCHAR2(20),
    rbr_sta          INTEGER,
    iu_rf_id_rf      INTEGER,
    iu_rf_f_ozn_fes  INTEGER,
    iu_pp_sif_pp     INTEGER
);

ALTER TABLE stand ADD CONSTRAINT stand_pk PRIMARY KEY ( sif_sta );

CREATE TABLE ulaz (
    sif_ulz        INTEGER NOT NULL,
    rbr_ulz        INTEGER,
    rf_id_rf       INTEGER NOT NULL,
    rf_fl_ozn_fes  INTEGER NOT NULL
);

ALTER TABLE ulaz
    ADD CONSTRAINT ulaz_pk PRIMARY KEY ( sif_ulz,
                                         rf_id_rf,
                                         rf_fl_ozn_fes );

CREATE TABLE vip_karta (
    sif_kar  INTEGER NOT NULL,
    id_rf    INTEGER NOT NULL,
    ozn_fes  INTEGER NOT NULL
);

ALTER TABLE vip_karta
    ADD CONSTRAINT vip_karta_pk PRIMARY KEY ( sif_kar,
                                              id_rf,
                                              ozn_fes );

CREATE TABLE zanr (
    sif_znr  INTEGER NOT NULL,
    naz_zan  VARCHAR2(20) NOT NULL
);

ALTER TABLE zanr ADD CONSTRAINT zanr_pk PRIMARY KEY ( sif_znr );

CREATE TABLE zona (
    sif_zon       INTEGER NOT NULL,
    naz_zon       VARCHAR2(20),
    rf_id_rf      INTEGER NOT NULL,
    rf_f_ozn_fes  INTEGER NOT NULL
);

ALTER TABLE zona
    ADD CONSTRAINT zona_pk PRIMARY KEY ( sif_zon,
                                         rf_id_rf,
                                         rf_f_ozn_fes );

ALTER TABLE backstage
    ADD CONSTRAINT backstage_bina_fk FOREIGN KEY ( bina_sif_bin,
                                                   bina_zona_sif_zon,
                                                   bina_zona_id_rf,
                                                   bina_zona_ozn_fes )
        REFERENCES bina ( sif_bin,
                          zona_sif_zon,
                          zona_id_rf,
                          zona_ozn_fes );

ALTER TABLE bina
    ADD CONSTRAINT bina_zona_fk FOREIGN KEY ( zona_sif_zon,
                                              zona_id_rf,
                                              zona_ozn_fes )
        REFERENCES zona ( sif_zon,
                          rf_id_rf,
                          rf_f_ozn_fes );

ALTER TABLE ceker
    ADD CONSTRAINT ceker_radnik_fk FOREIGN KEY ( jmbg )
        REFERENCES radnik ( jmbg );

ALTER TABLE ceker
    ADD CONSTRAINT ceker_ulaz_fk FOREIGN KEY ( ulaz_sif_ulz,
                                               ulaz_realizacija_id_rf,
                                               ulaz_real_fest_ozn_fes )
        REFERENCES ulaz ( sif_ulz,
                          rf_id_rf,
                          rf_fl_ozn_fes );

ALTER TABLE dolazi
    ADD CONSTRAINT dolazi_bina_fk FOREIGN KEY ( bina_sif_bin,
                                                b_z_sif_zon,
                                                b_z_id_rf,
                                                b_z_ozn_fes )
        REFERENCES bina ( sif_bin,
                          zona_sif_zon,
                          zona_id_rf,
                          zona_ozn_fes );

ALTER TABLE dolazi
    ADD CONSTRAINT dolazi_izvodjac_fk FOREIGN KEY ( izv_sif_izv )
        REFERENCES izvodjac ( sif_izv );

ALTER TABLE dolazi
    ADD CONSTRAINT dolazi_rf_fk FOREIGN KEY ( rf_id_rf,
                                              rf_ozn_fes )
        REFERENCES realizacija_festivala ( id_rf,
                                           festival_ozn_fes );

ALTER TABLE ima_pristup
    ADD CONSTRAINT ima_pristup_backstage_fk FOREIGN KEY ( bs_sif_bs,
                                                          bs_sif_bin,
                                                          bs_sif_zon,
                                                          bs_id_rf,
                                                          bs_ozn_fes )
        REFERENCES backstage ( sif_bs,
                               bina_sif_bin,
                               bina_zona_sif_zon,
                               bina_zona_id_rf,
                               bina_zona_ozn_fes );

ALTER TABLE ima_pristup
    ADD CONSTRAINT ima_pristup_vip_karta_fk FOREIGN KEY ( vip_karta_sif_kar,
                                                          vip_karta_id_rf,
                                                          vip_karta_ozn_fes )
        REFERENCES vip_karta ( sif_kar,
                               id_rf,
                               ozn_fes );

ALTER TABLE ima_ugovor
    ADD CONSTRAINT iu_pp_fk FOREIGN KEY ( pp_sif_pp )
        REFERENCES poslovni_partner ( sif_pp );

ALTER TABLE ima_ugovor
    ADD CONSTRAINT iu_rf_fk FOREIGN KEY ( rf_id_rf,
                                          rf_ozn_fes )
        REFERENCES realizacija_festivala ( id_rf,
                                           festival_ozn_fes );

ALTER TABLE izvodi_se
    ADD CONSTRAINT izvodi_se_zanr_fk FOREIGN KEY ( zanr_sif_znr )
        REFERENCES zanr ( sif_znr );

ALTER TABLE izvodi_se
    ADD CONSTRAINT izvodi_se_zona_fk FOREIGN KEY ( zona_sif_zon,
                                                   zona_id_rf,
                                                   zona_ozn_fes )
        REFERENCES zona ( sif_zon,
                          rf_id_rf,
                          rf_f_ozn_fes );

ALTER TABLE karta
    ADD CONSTRAINT karta_ceker_fk FOREIGN KEY ( ceker_jmbg )
        REFERENCES ceker ( jmbg );

ALTER TABLE karta
    ADD CONSTRAINT karta_karta_fk FOREIGN KEY ( karta_sif_kar,
                                                karta_rf_id_rf,
                                                karta_rf_f_ozn_fes )
        REFERENCES karta ( sif_kar,
                           real_id_rf,
                           rf_f_ozn_fes );

ALTER TABLE karta
    ADD CONSTRAINT karta_realizacija_festivala_fk FOREIGN KEY ( real_id_rf,
                                                                rf_f_ozn_fes )
        REFERENCES realizacija_festivala ( id_rf,
                                           festival_ozn_fes );

ALTER TABLE nudi
    ADD CONSTRAINT nudi_stand_fk FOREIGN KEY ( stand_sif_sta )
        REFERENCES stand ( sif_sta );

ALTER TABLE nudi
    ADD CONSTRAINT nudi_zona_fk FOREIGN KEY ( zona_sif_zon,
                                              zona_id_rf,
                                              zona_ozn_fes )
        REFERENCES zona ( sif_zon,
                          rf_id_rf,
                          rf_f_ozn_fes );

ALTER TABLE pripada
    ADD CONSTRAINT pripada_izvodjac_fk FOREIGN KEY ( izvodjac_sif_izv )
        REFERENCES izvodjac ( sif_izv );

ALTER TABLE pripada
    ADD CONSTRAINT pripada_zanr_fk FOREIGN KEY ( zanr_sif_znr )
        REFERENCES zanr ( sif_znr );

ALTER TABLE prodavac
    ADD CONSTRAINT prodavac_nudi_fk FOREIGN KEY ( nudi_stand_sif_sta,
                                                  nudi_zona_sif_zon,
                                                  nudi_zona_id_rf,
                                                  nudi_zona_ozn_fes )
        REFERENCES nudi ( stand_sif_sta,
                          zona_sif_zon,
                          zona_id_rf,
                          zona_ozn_fes );

ALTER TABLE prodavac
    ADD CONSTRAINT prodavac_radnik_fk FOREIGN KEY ( jmbg )
        REFERENCES radnik ( jmbg );

ALTER TABLE radi
    ADD CONSTRAINT radi_festival_fk FOREIGN KEY ( festival_ozn_fes )
        REFERENCES festival ( ozn_fes );

ALTER TABLE radi
    ADD CONSTRAINT radi_radnik_fk FOREIGN KEY ( radnik_jmbg )
        REFERENCES radnik ( jmbg );

ALTER TABLE redar
    ADD CONSTRAINT redar_radnik_fk FOREIGN KEY ( jmbg )
        REFERENCES radnik ( jmbg );

ALTER TABLE redar
    ADD CONSTRAINT redar_zona_fk FOREIGN KEY ( zona_sif_zon,
                                               zona_id_rf,
                                               zona_ozn_fes )
        REFERENCES zona ( sif_zon,
                          rf_id_rf,
                          rf_f_ozn_fes );

ALTER TABLE realizacija_festivala
    ADD CONSTRAINT rf_f_fk FOREIGN KEY ( festival_ozn_fes )
        REFERENCES festival ( ozn_fes );

ALTER TABLE staff_karta
    ADD CONSTRAINT staff_karta_karta_fk FOREIGN KEY ( sif_kar,
                                                      id_rf,
                                                      ozn_fes )
        REFERENCES karta ( sif_kar,
                           real_id_rf,
                           rf_f_ozn_fes );

ALTER TABLE staff_karta
    ADD CONSTRAINT staff_karta_radi_fk FOREIGN KEY ( radi_ozn_fes,
                                                     radi_jmbg )
        REFERENCES radi ( festival_ozn_fes,
                          radnik_jmbg );

ALTER TABLE stand
    ADD CONSTRAINT stand_ima_ugovor_fk FOREIGN KEY ( iu_rf_id_rf,
                                                     iu_rf_f_ozn_fes,
                                                     iu_pp_sif_pp )
        REFERENCES ima_ugovor ( rf_id_rf,
                                rf_ozn_fes,
                                pp_sif_pp );

ALTER TABLE ulaz
    ADD CONSTRAINT ulaz_realizacija_festivala_fk FOREIGN KEY ( rf_id_rf,
                                                               rf_fl_ozn_fes )
        REFERENCES realizacija_festivala ( id_rf,
                                           festival_ozn_fes );

ALTER TABLE vip_karta
    ADD CONSTRAINT vip_karta_karta_fk FOREIGN KEY ( sif_kar,
                                                    id_rf,
                                                    ozn_fes )
        REFERENCES karta ( sif_kar,
                           real_id_rf,
                           rf_f_ozn_fes );

ALTER TABLE zona
    ADD CONSTRAINT zona_realizacija_festivala_fk FOREIGN KEY ( rf_id_rf,
                                                               rf_f_ozn_fes )
        REFERENCES realizacija_festivala ( id_rf,
                                           festival_ozn_fes );

CREATE OR REPLACE TRIGGER arc_fkarc_26_vip_karta BEFORE
    INSERT OR UPDATE OF sif_kar, id_rf, ozn_fes ON vip_karta
    FOR EACH ROW
DECLARE
    d VARCHAR2(20);
BEGIN
    SELECT
        a.tip_karte
    INTO d
    FROM
        karta a
    WHERE
            a.sif_kar = :new.sif_kar
        AND a.real_id_rf = :new.id_rf
        AND a.rf_f_ozn_fes = :new.ozn_fes;

    IF ( d IS NULL OR d <> 'VIP_karta' ) THEN
        raise_application_error(-20223, 'FK VIP_karta_Karta_FK in Table VIP_karta violates Arc constraint on Table Karta - discriminator column TIP_KARTE doesn''t have value ''VIP_karta''');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_26_staff_karta BEFORE
    INSERT OR UPDATE OF sif_kar, id_rf, ozn_fes ON staff_karta
    FOR EACH ROW
DECLARE
    d VARCHAR2(20);
BEGIN
    SELECT
        a.tip_karte
    INTO d
    FROM
        karta a
    WHERE
            a.sif_kar = :new.sif_kar
        AND a.real_id_rf = :new.id_rf
        AND a.rf_f_ozn_fes = :new.ozn_fes;

    IF ( d IS NULL OR d <> 'Staff_karta' ) THEN
        raise_application_error(-20223, 'FK Staff_karta_Karta_FK in Table Staff_karta violates Arc constraint on Table Karta - discriminator column TIP_KARTE doesn''t have value ''Staff_karta''');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_27_ceker BEFORE
    INSERT OR UPDATE OF jmbg ON ceker
    FOR EACH ROW
DECLARE
    d VARCHAR2(4000);
BEGIN
    SELECT
        a.tip_radnika
    INTO d
    FROM
        radnik a
    WHERE
        a.jmbg = :new.jmbg;

    IF ( d IS NULL OR d <> 'Ceker' ) THEN
        raise_application_error(-20223, 'FK Ceker_Radnik_FK in Table Ceker violates Arc constraint on Table Radnik - discriminator column TIP_RADNIKA doesn''t have value ''Ceker''');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_27_prodavac BEFORE
    INSERT OR UPDATE OF jmbg ON prodavac
    FOR EACH ROW
DECLARE
    d VARCHAR2(4000);
BEGIN
    SELECT
        a.tip_radnika
    INTO d
    FROM
        radnik a
    WHERE
        a.jmbg = :new.jmbg;

    IF ( d IS NULL OR d <> 'Prodavac' ) THEN
        raise_application_error(-20223, 'FK Prodavac_Radnik_FK in Table Prodavac violates Arc constraint on Table Radnik - discriminator column TIP_RADNIKA doesn''t have value ''Prodavac''');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_27_redar BEFORE
    INSERT OR UPDATE OF jmbg ON redar
    FOR EACH ROW
DECLARE
    d VARCHAR2(4000);
BEGIN
    SELECT
        a.tip_radnika
    INTO d
    FROM
        radnik a
    WHERE
        a.jmbg = :new.jmbg;

    IF ( d IS NULL OR d <> 'Redar' ) THEN
        raise_application_error(-20223, 'FK Redar_Radnik_FK in Table Redar violates Arc constraint on Table Radnik - discriminator column TIP_RADNIKA doesn''t have value ''Redar''');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            24
-- CREATE INDEX                             2
-- ALTER TABLE                             59
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           5
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
