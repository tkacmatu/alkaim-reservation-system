-- source hunkajirak/db/create_script.sql
DROP FUNCTION IF EXISTS remove_all();
CREATE or replace FUNCTION remove_all() RETURNS void AS $$
DECLARE
    rec RECORD;
    cmd text;
BEGIN
    cmd := '';

    FOR rec IN SELECT
            'DROP SEQUENCE ' || quote_ident(n.nspname) || '.'
                || quote_ident(c.relname) || ' CASCADE;' AS name
        FROM
            pg_catalog.pg_class AS c
        LEFT JOIN
            pg_catalog.pg_namespace AS n
        ON
            n.oid = c.relnamespace
        WHERE
            relkind = 'S' AND
            n.nspname NOT IN ('pg_catalog', 'pg_toast') AND
            pg_catalog.pg_table_is_visible(c.oid)
    LOOP
        cmd := cmd || rec.name;
    END LOOP;

    FOR rec IN SELECT
            'DROP TABLE ' || quote_ident(n.nspname) || '.'
                || quote_ident(c.relname) || ' CASCADE;' AS name
        FROM
            pg_catalog.pg_class AS c
        LEFT JOIN
            pg_catalog.pg_namespace AS n
        ON
            n.oid = c.relnamespace WHERE relkind = 'r' AND
            n.nspname NOT IN ('pg_catalog', 'pg_toast') AND
            pg_catalog.pg_table_is_visible(c.oid)
    LOOP
        cmd := cmd || rec.name;
    END LOOP;

    EXECUTE cmd;
    RETURN;
END;
$$ LANGUAGE plpgsql;
select remove_all();

CREATE TABLE address (
    address_id SERIAL NOT NULL,
    country VARCHAR(40),
    city VARCHAR(40) NOT NULL,
    street VARCHAR(40) NOT NULL,
    postal_code VARCHAR(20)
);
ALTER TABLE address ADD CONSTRAINT pk_address PRIMARY KEY (address_id);

CREATE TABLE aikilam_homepage (
    id_aikilam_homepage SERIAL NOT NULL
);
ALTER TABLE aikilam_homepage ADD CONSTRAINT pk_aikilam_homepage PRIMARY KEY (id_aikilam_homepage);

CREATE TABLE guest (
    guest_id SERIAL NOT NULL,
    address_id INTEGER NOT NULL,
    room_id INTEGER NOT NULL,
    first_name VARCHAR(40) NOT NULL,
    last_name VARCHAR(40) NOT NULL,
    phone_number VARCHAR(30),
    email_address VARCHAR(80) NOT NULL,
    payment_method VARCHAR(20)
);
ALTER TABLE guest ADD CONSTRAINT pk_guest PRIMARY KEY (guest_id);

CREATE TABLE location (
    location_name_id SERIAL NOT NULL,
    location_name VARCHAR(30) NOT NULL,
    description VARCHAR(2048) NOT NULL
);
ALTER TABLE location ADD CONSTRAINT pk_location PRIMARY KEY (location_name_id);

CREATE TABLE reservation (
    reservation_id SERIAL NOT NULL,
    id_aikilam_homepage INTEGER,
    agency_id INTEGER,
    date_of_reservation DATE NOT NULL,
    number_of_guests INTEGER NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    number_of_nights INTEGER NOT NULL,
    payment_status VARCHAR(30) NOT NULL
);
ALTER TABLE reservation ADD CONSTRAINT pk_reservation PRIMARY KEY (reservation_id);

CREATE TABLE room (
    room_id SERIAL NOT NULL,
    class_name_id INTEGER NOT NULL,
    location_name_id INTEGER NOT NULL,
    number_of_beds INTEGER NOT NULL
);
ALTER TABLE room ADD CONSTRAINT pk_room PRIMARY KEY (room_id);

CREATE TABLE room_class (
    class_name_id SERIAL NOT NULL,
    class_name VARCHAR(30) NOT NULL,
    description VARCHAR(2048) NOT NULL
);
ALTER TABLE room_class ADD CONSTRAINT pk_room_class PRIMARY KEY (class_name_id);

CREATE TABLE sales_report (
    sales_report_id SERIAL NOT NULL,
    id_aikilam_homepage INTEGER,
    agency_id INTEGER,
    date DATE NOT NULL,
    number_of_reservations INTEGER NOT NULL,
    number_of_guests INTEGER NOT NULL,
    number_of_rooms INTEGER NOT NULL
);
ALTER TABLE sales_report ADD CONSTRAINT pk_sales_report PRIMARY KEY (sales_report_id);

CREATE TABLE travel_agency (
    agency_id SERIAL NOT NULL,
    agency_name VARCHAR(64) NOT NULL
);
ALTER TABLE travel_agency ADD CONSTRAINT pk_travel_agency PRIMARY KEY (agency_id);

CREATE TABLE reservation_guest (
    reservation_id INTEGER NOT NULL,
    guest_id INTEGER NOT NULL
);
ALTER TABLE reservation_guest ADD CONSTRAINT pk_reservation_guest PRIMARY KEY (reservation_id, guest_id);

ALTER TABLE guest ADD CONSTRAINT fk_guest_address FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE CASCADE;
ALTER TABLE guest ADD CONSTRAINT fk_guest_room FOREIGN KEY (room_id) REFERENCES room (room_id) ON DELETE CASCADE;

ALTER TABLE reservation ADD CONSTRAINT fk_reservation_aikilam_homepage FOREIGN KEY (id_aikilam_homepage) REFERENCES aikilam_homepage (id_aikilam_homepage) ON DELETE CASCADE;
ALTER TABLE reservation ADD CONSTRAINT fk_reservation_travel_agency FOREIGN KEY (agency_id) REFERENCES travel_agency (agency_id) ON DELETE CASCADE;

ALTER TABLE room ADD CONSTRAINT fk_room_room_class FOREIGN KEY (class_name_id) REFERENCES room_class (class_name_id) ON DELETE CASCADE;
ALTER TABLE room ADD CONSTRAINT fk_room_location FOREIGN KEY (location_name_id) REFERENCES location (location_name_id) ON DELETE CASCADE;

ALTER TABLE sales_report ADD CONSTRAINT fk_sales_report_aikilam_homepag FOREIGN KEY (id_aikilam_homepage) REFERENCES aikilam_homepage (id_aikilam_homepage) ON DELETE CASCADE;
ALTER TABLE sales_report ADD CONSTRAINT fk_sales_report_travel_agency FOREIGN KEY (agency_id) REFERENCES travel_agency (agency_id) ON DELETE CASCADE;

ALTER TABLE reservation_guest ADD CONSTRAINT fk_reservation_guest_reservatio FOREIGN KEY (reservation_id) REFERENCES reservation (reservation_id) ON DELETE CASCADE;
ALTER TABLE reservation_guest ADD CONSTRAINT fk_reservation_guest_guest FOREIGN KEY (guest_id) REFERENCES guest (guest_id) ON DELETE CASCADE;

ALTER TABLE reservation ADD CONSTRAINT xc_reservation_id_aikilam_homep CHECK ((id_aikilam_homepage IS NOT NULL AND agency_id IS NULL) OR (id_aikilam_homepage IS NULL AND agency_id IS NOT NULL));

ALTER TABLE sales_report ADD CONSTRAINT xc_sales_report_id_aikilam_home CHECK ((id_aikilam_homepage IS NOT NULL AND agency_id IS NULL) OR (id_aikilam_homepage IS NULL AND agency_id IS NOT NULL));