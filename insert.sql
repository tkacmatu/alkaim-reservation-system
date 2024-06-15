-- Deleting all data from the database
CREATE or replace FUNCTION clean_tables() RETURNS void AS $$
declare
  l_stmt text;
begin
  select 'truncate ' || string_agg(format('%I.%I', schemaname, tablename) , ',')
    into l_stmt
  from pg_tables
  where schemaname in ('public');

  execute l_stmt || ' cascade';
end;
$$ LANGUAGE plpgsql;
select clean_tables();

-- Reset sequence
CREATE or replace FUNCTION restart_sequences() RETURNS void AS $$
DECLARE
i TEXT;
BEGIN
 FOR i IN (SELECT column_default FROM information_schema.columns WHERE column_default SIMILAR TO 'nextval%')
  LOOP
         EXECUTE 'ALTER SEQUENCE'||' ' || substring(substring(i from '''[a-z_]*')from '[a-z_]+') || ' '||' RESTART 1;';
  END LOOP;
END $$ LANGUAGE plpgsql;
select restart_sequences();

-- Insert data into the location table
insert into location (location_name_id, location_name, description)
values  (default, 'Left wing', 'This building is located on the north side of the resort, overlooking the gardens and the nearby tennis courts. The rooms here are spacious and modern, with plenty of natural light and comfortable furnishings.'),
        (default, 'Right wing', 'This building is situated on the south side of the resort, close to the main entrance and the lobby. The rooms here are more traditional in style, with elegant decor and luxurious amenities.'),
        (default, 'By the pool', 'This area is located in the center of the resort, surrounded by several buildings and amenities. The pool itself is large and inviting, with plenty of lounge chairs and umbrellas for relaxing in the sun. There''s also a poolside bar and grill where you can order drinks and snacks.'),
        (default, 'By the sea', 'This location is on the east side of the resort, overlooking the beach and the ocean. There are several buildings in this area, each with its own unique charm and style. You can take a stroll along the beach, go for a swim, or simply soak up the sun on the sand. There are also several restaurants and shops nearby, making this a popular spot for both relaxation and entertainment.');

-- Insert data into the room_class table
insert into room_class (class_name_id, class_name, description)
values  (default, 'Family Deluxe Room', 'These rooms offer the ultimate family experience, with even more space and upgraded amenities. You''ll have plenty of room to spread out and relax, with separate sleeping areas for parents and children. The decor is stylish and modern, with plenty of thoughtful touches to make your stay comfortable and enjoyable.'),
        (default, 'Family Room', 'These rooms are designed with families in mind, offering ample space and comfortable accommodations for parents and children. The decor is family-friendly, with bright colors and playful accents. Family rooms may have two separate sleeping areas or a partitioned space for added privacy.'),
        (default, 'Standard', 'This room class offers comfortable accommodations with all the essential amenities you need for a relaxing stay. The decor is simple and modern, with neutral colors and tasteful furnishings. Standard rooms may have a garden or courtyard view.'),
        (default, 'Standard Sea View', 'These rooms offer the same comfortable accommodations as the standard rooms'),
        (default, 'Superior', 'This room class offers a more spacious and luxurious experience, with upgraded amenities and elegant decor. The furnishings are stylish and comfortable, and the room may feature a private balcony or terrace with a view of the resort or the sea.');

-- Insert data into the room table
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (1, 5, 3, 3);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (2, 1, 3, 1);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (3, 1, 1, 2);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (4, 4, 1, 1);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (5, 4, 4, 4);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (6, 2, 2, 2);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (7, 5, 4, 3);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (8, 5, 2, 3);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (9, 1, 4, 4);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (10, 1, 1, 1);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (11, 5, 2, 3);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (12, 1, 4, 1);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (13, 1, 2, 1);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (14, 2, 4, 5);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (15, 3, 4, 2);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (16, 5, 3, 6);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (17, 2, 2, 2);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (18, 2, 3, 2);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (19, 1, 1, 1);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (20, 4, 3, 1);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (21, 4, 4, 4);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (22, 4, 3, 6);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (23, 5, 4, 3);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (24, 4, 1, 2);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (25, 3, 3, 1);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (26, 1, 1, 4);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (27, 1, 2, 1);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (28, 2, 1, 1);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (29, 5, 4, 4);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (30, 1, 3, 4);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (31, 3, 3, 1);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (32, 5, 2, 2);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (33, 2, 4, 4);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (34, 5, 3, 3);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (35, 5, 2, 2);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (36, 3, 1, 2);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (37, 3, 2, 6);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (38, 2, 1, 6);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (39, 5, 3, 3);
insert into room (room_id, class_name_id, location_name_id, number_of_beds) values (40, 4, 3, 1);
-- Set the sequence for the room table
select setval(pg_get_serial_sequence('room','room_id'),40);

-- Insert data into the address table
insert into address (address_id, country, city, street, postal_code) values (1, 'Indonesia', 'Ombul Barat', '67300 Gerald Circle', null);
insert into address (address_id, country, city, street, postal_code) values (2, null, 'Hovd', '48163 Graceland Court', null);
insert into address (address_id, country, city, street, postal_code) values (3, 'China', 'Sanxi', '41 Dovetail Place', null);
insert into address (address_id, country, city, street, postal_code) values (4, 'Bulgaria', 'Rakitovo', '99134 Carpenter Place', null);
insert into address (address_id, country, city, street, postal_code) values (5, 'Poland', 'Skwierzyna', '58 Express Way', '66-440');
insert into address (address_id, country, city, street, postal_code) values (6, 'Vietnam', 'Hai Riêng', '111 Prairie Rose Drive', null);
insert into address (address_id, country, city, street, postal_code) values (7, 'Indonesia', 'Pangalangan', '2 Oriole Park', null);
insert into address (address_id, country, city, street, postal_code) values (8, 'Togo', 'Lomé', '0371 Homewood Avenue', null);
insert into address (address_id, country, city, street, postal_code) values (9, 'Luxembourg', 'Boulaide', '7 Beilfuss Circle', 'L-9640');
insert into address (address_id, country, city, street, postal_code) values (10, 'Indonesia', 'Wonosobo', '625 Packers Place', null);
insert into address (address_id, country, city, street, postal_code) values (11, 'Indonesia', 'Banjar Budakeling', '3 Arizona Crossing', null);
insert into address (address_id, country, city, street, postal_code) values (12, 'Poland', 'Przewóz', '6 Merchant Terrace', '68-132');
insert into address (address_id, country, city, street, postal_code) values (13, 'Philippines', 'Sinubong', '65033 Alpine Place', '1711');
insert into address (address_id, country, city, street, postal_code) values (14, 'Canada', 'Claresholm', '0 Commercial Circle', 'V2T');
insert into address (address_id, country, city, street, postal_code) values (15, 'China', 'Chengshan', '08 Thompson Avenue', null);
insert into address (address_id, country, city, street, postal_code) values (16, 'Chile', 'Antofagasta', '8012 Lunder Pass', null);
insert into address (address_id, country, city, street, postal_code) values (17, 'Sweden', 'Uppsala', '6098 Hudson Road', null);
insert into address (address_id, country, city, street, postal_code) values (18, 'Portugal', 'Zambujeira do Mar', '04 American Ash Point', '7630-765');
insert into address (address_id, country, city, street, postal_code) values (19, 'China', 'Yanyang', '4 Spohn Terrace', null);
insert into address (address_id, country, city, street, postal_code) values (20, 'Belarus', 'Svislach', '2547 Shasta Plaza', null);
insert into address (address_id, country, city, street, postal_code) values (21, 'Greece', 'Kavásilas', '29212 Melvin Road', null);
insert into address (address_id, country, city, street, postal_code) values (22, 'China', 'Shangxing', '65 Declaration Terrace', null);
insert into address (address_id, country, city, street, postal_code) values (23, 'China', 'Huji', '055 Golf Course Alley', null);
insert into address (address_id, country, city, street, postal_code) values (24, null, 'Snegiri', '8 Warbler Trail', '143591');
insert into address (address_id, country, city, street, postal_code) values (25, 'Mexico', 'Hidalgo', '3 Jackson Parkway', null);
insert into address (address_id, country, city, street, postal_code) values (26, 'Portugal', 'Burgau', '55 Westport Crossing', '8650-104');
insert into address (address_id, country, city, street, postal_code) values (27, 'Croatia', 'Rešetari', '48 Haas Pass', null);
insert into address (address_id, country, city, street, postal_code) values (28, 'China', 'Jingtou', '44 Comanche Trail', null);
insert into address (address_id, country, city, street, postal_code) values (29, 'China', 'Zhihe', '5980 Waubesa Pass', null);
insert into address (address_id, country, city, street, postal_code) values (30, 'Indonesia', 'Pasar Kulon', '6632 Forest Run Drive', null);
insert into address (address_id, country, city, street, postal_code) values (31, 'Spain', 'Barcelona', '23 Carrer de la Marina', '08005');
insert into address (address_id, country, city, street, postal_code) values (32, 'Italy', 'Rome', '45 Via del Corso', null);
insert into address (address_id, country, city, street, postal_code) values (33, 'France', 'Paris', '12 Rue de Rivoli', '75001');
insert into address (address_id, country, city, street, postal_code) values (34, 'Germany', 'Berlin', '8 Unter den Linden', '10117');
insert into address (address_id, country, city, street, postal_code) values (35, 'Netherlands', 'Amsterdam', '10 Dam Square', '1012 NP');
insert into address (address_id, country, city, street, postal_code) values (36, 'Switzerland', 'Zurich', '3 Bahnhofstrasse', '8001');
insert into address (address_id, country, city, street, postal_code) values (37, 'Belgium', 'Brussels', '2 Grand Place', null);
insert into address (address_id, country, city, street, postal_code) values (38, 'Austria', 'Vienna', '1 Stephansplatz', '1010');
insert into address (address_id, country, city, street, postal_code) values (39, 'Denmark', 'Copenhagen', '9 Nyhavn', '1051');
insert into address (address_id, country, city, street, postal_code) values (40, 'Norway', 'Oslo', '22 Karl Johans gate', '0159');
insert into address (address_id, country, city, street, postal_code) values (41, 'Sweden', 'Stockholm', '14 Gamla stan', null);
insert into address (address_id, country, city, street, postal_code) values (42, 'Finland', 'Helsinki', '7 Senate Square', '00170');
insert into address (address_id, country, city, street, postal_code) values (43, 'Iceland', 'Reykjavik', '3 Laugavegur', '101');
insert into address (address_id, country, city, street, postal_code) values (44, 'Ireland', 'Dublin', '2 Grafton Street', null);
insert into address (address_id, country, city, street, postal_code) values (45, 'United Kingdom', 'London', '1 Trafalgar Square', 'WC2N 5DN');
insert into address (address_id, country, city, street, postal_code) values (46, 'Russia', 'Moscow', '1 Red Square', '109012');
insert into address (address_id, country, city, street, postal_code) values (47, 'Japan', 'Tokyo', '1-1-1 Shibakoen', null);
insert into address (address_id, country, city, street, postal_code) values (48, 'South Korea', 'Seoul', '50 Sowol-ro', '04637');
insert into address (address_id, country, city, street, postal_code) values (49, 'Australia', 'Sydney', '1 Circular Quay', 'NSW 2000');
insert into address (address_id, country, city, street, postal_code) values (50, 'New Zealand', 'Auckland', '135 Albert Street', null);
-- Set the sequence for the address table
select setval(pg_get_serial_sequence('address','address_id'),50);


-- Insert data into the guest table
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (1, '1', '1', 'Sofia', 'Rodriguez', null, 'wmcfade0@cpanel.net', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (2, '1', '1', 'Alejandro', 'Rodriguez', '+356 109 100 7966', 'vslaght1@stumbleupon.com', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (3, '2', '1', 'Carlos', 'Rodriguez', '+381 241 110 6040', 'bplascott2@accuweather.com', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (4, '3', '2', 'Ravi', 'Patel', null, 'kjirasek3@list-manage.com', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (5, '4', '3', 'Min-Jae', 'Kim', null, 'jcolloby4@utexas.edu', 'credit_card');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (6, '5', '3', 'Ji-Won', 'Kim', null, 'cbestar5@goo.ne.jp', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (7, '6', '4', 'Raj', 'Singh', null, 'ppassingham6@techcrunch.com', 'invoice');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (8, '7', '5', 'Maria', 'Garcia', null, 'fbernt7@surveymonkey.com', 'voucher');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (9, '7', '5', 'Luis', 'Garcia', '+46 920 202 7797', 'cchidgey8@ucsd.edu', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (10, '7', '5', 'Ana', 'Garcia', null, 'cleppingwell9@dailymotion.com', 'voucher');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (11, '7', '5', 'Juan', 'Garcia', null, 'gmaccomiskeya@elegantthemes.com', 'invoice');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (12, '8', '6', 'Seung-Hyun', 'Lee', null, 'arossib@xing.com', 'voucher');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (13, '9', '6', 'Min-Ji', 'Lee', null, 'mdudeneyc@unc.edu', 'invoice');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (14, '10', '7', 'Jose', 'Martinez', null, 'thayd@github.io', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (15, '11', '7', 'Ana', 'Martinez', null, 'rlillforde@amazon.co.jp', 'invoice');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (16, '12', '7', 'Miguel', 'Martinez', null, 'epenninof@twitpic.com', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (17, '13', '8', 'Luis', 'Hernandez', null, 'ustowersg@unc.edu', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (18, '13', '8', 'Carmen', 'Hernandez', null, 'ahoworthh@xing.com', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (19, '13', '8', 'Juan', 'Hernandez', '+1 785 308 1008', 'eklimpti@360.cn', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (20, '14', '9', 'Gillan', 'Perez', '+63 175 966 1165', 'gwillettj@shop-pro.jp', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (21, '14', '9', 'Arty', 'Perez', null, 'jcamoisk@typepad.com', 'credit_card');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (22, '15', '9', 'Venita', 'Perez', '+964 956 408 7108', 'jcarslakel@odnoklassniki.ru', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (23, '15', '9', 'Lonna', 'Perez', null, 'jramem@furl.net', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (24, '16', '10', 'Renata', 'Labbez', '+46 486 836 7645', 'bmaccostyn@w3.org', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (25, '17', '11', 'Blondelle', 'McDoual', null, 'kbottonero@newyorker.com', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (26, '17', '11', 'Darb', 'McDoual', null, 'wsunshinep@prlog.org', 'invoice');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (27, '17', '11', 'Cathee', 'Ortells', null, 'bpreatorq@utexas.edu', 'credit_card');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (28, '18', '12', 'Soul', 'Goodman', null, 'cludfordr@4shared.com', 'voucher');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (29, '19', '13', 'Walter', 'White', null, 'cizaks@ebay.co.uk', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (30, '20', '14', 'Mildred', 'Robjohns', null, 'asivellt@auda.org.au', 'credit_card');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (31, '20', '14', 'Thebault', 'Robjohns', null, 'asterlingu@google.com', 'voucher');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (32, '20', '14', 'Dita', 'Robjohns', null, 'ctunmorev@unblog.fr', 'invoice');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (33, '20', '14', 'Dynah', 'Robjohns', '+86 966 594 8574', 'cdymockew@tuttocitta.it', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (34, '20', '14', 'Sascha', 'Robjohns', null, 'nreltonx@artisteer.com', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (35, '21', '15', 'Zdeno', 'Dobrota', null, 'hburminghamy@youku.com', 'invoice');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (36, '22', '15', 'Lukas', 'Pies', '+62 256 302 1895', 'mfoskenz@deliciousdays.com', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (37, '23', '16', 'Constantia', 'Dellar', null, 'jsteinor10@reddit.com', 'credit_card');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (38, '23', '16', 'Mona', 'Dellar', '+420 494 114 3004', 'fkeeping11@over-blog.com', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (39, '23', '16', 'Mona', 'Dellar', '+86 173 477 3734', 'cspellesy12@mysql.com', 'credit_card');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (40, '23', '16', 'Jenny', 'Domico', '+66 802 342 5367', 'rspoors13@taobao.com', 'invoice');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (41, '23', '16', 'Davon', 'Domico', '+86 276 149 0915', 'isinnott14@elpais.com', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (42, '24', '16', 'Birgit', 'Domico', '+92 102 432 4719', 'nheistermann15@slashdot.org', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (43, '24', '17', 'Harry', 'Potter', null, 'lbeggio16@jimdo.com', 'credit_card');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (44, '24', '17', 'Ron', 'Whisley', '+86 880 587 7544', 'khentzer17@utexas.edu', 'credit_card');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (45, '25', '18', 'Harvey', 'Specter', '+57 597 392 1843', 'hferreo18@netscape.com', 'voucher');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (46, '26', '18', 'Mike', 'Ross', null, 'htoplis19@bravesites.com', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (47, '27', '19', 'Gregory', 'House', '+57 919 352 1402', 'ehurry1a@auda.org.au', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (48, '28', '20', 'James', 'Wilson', null, 'bfirpi1b@addtoany.com', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (49, '29', '21', 'Jake', 'Harper', null, 'ksteere1c@goodreads.com', 'invoice');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (50, '30', '21', 'Charlie', 'Harper', null, 'slenham1d@bbb.org', 'voucher');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (51, '31', '21', 'Alan', 'Harper', null, 'lbleue1e@zimbio.com', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (52, '32', '21', 'Evelyn', 'Harper', null, 'tneilan1f@macromedia.com', 'voucher');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (53, '33', '22', 'Peter', 'Whetson', null, 'bscammell1g@hexun.com', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (54, '33', '22', 'Adria', 'Whetson', null, 'dmethringham1h@amazon.co.jp', 'invoice');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (55, '33', '22', 'Jen', 'Whetson', '+86 528 784 8825', 'dfieldstone1i@usgs.gov', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (56, '33', '22', 'Rivy', 'Whetson', null, 'rbauman1j@qq.com', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (57, '33', '22', 'Saree', 'Whetson', null, 'kredbourn1k@umn.edu', 'credit_card');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (58, '33', '22', 'Ciro', 'Whetson', '+389 309 716 7033', 'mconwell1l@artisteer.com', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (59, '34', '23', 'Andrej', 'Hribenik', null, 'kjanas1m@comsenz.com', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (60, '34', '23', 'Kika', 'Hribenik', null, 'dwillars1n@amazon.com', 'invoice');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (61, '34', '23', 'Jacob', 'Hribenik', null, 'bcalder1o@comcast.net', 'voucher');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (62, '35', '24', 'Shaun', 'Murphy', '+30 680 951 8475', 'gcalan1p@marketwatch.com', 'credit_card');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (63, '35', '24', 'Lea', 'Murphy', '+420 577 386 4843', 'sgartland1q@huffingtonpost.com', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (64, '36', '25', 'Aaron', 'Glassman', null, 'klodeke1r@netvibes.com', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (65, '37', '26', 'Elton', 'John', null, 'jodee1s@berkeley.edu', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (66, '37', '26', 'Ed', 'Sheeran', '+55 181 270 5788', 'bmutlow1t@cnn.com', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (67, '37', '26', 'Michael', 'Jackson', '+51 249 293 2509', 'cdebroke1u@eepurl.com', 'voucher');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (68, '37', '26', 'Tom', 'Odel', null, 'dkirman1v@geocities.jp', 'invoice');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (69, '38', '27', 'Lisa', 'Cuddy', null, 'kdeluze1w@businesswire.com', 'invoice');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (70, '38', '28', 'Clerc', 'Tiltman', null, 'jwoolacott1x@themeforest.net', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (71, '39', '29', 'Erin', 'Brisley', null, 'purch1y@fema.gov', 'invoice');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (72, '40', '29', 'Rodrick', 'Brisley', null, 'akears1z@nba.com', 'invoice');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (73, '40', '29', 'Tess', 'Brisley', '+33 993 975 0483', 'dupcott20@accuweather.com', 'voucher');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (74, '40', '29', 'Alvina', 'Brisley', '+86 163 147 6104', 'briddich21@joomla.org', 'invoice');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (75, '41', '30', 'Tab', 'Redemile', '+48 675 574 6581', 'doscanlon22@desdev.cn', 'credit_card');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (76, '41', '30', 'Esme', 'Redemile', null, 'mlindfors23@sohu.com', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (77, '42', '30', 'Ranna', 'Redemile', '+86 531 213 3119', 'gmcgavin24@dedecms.com', 'credit_card');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (78, '42', '30', 'Danielle', 'Redemile', null, 'mmacintyre25@amazon.co.uk', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (79, '43', '31', 'Danielle', 'Banacka', '+66 641 609 5869', 'pmitrikhin26@prlog.org', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (80, '44', '32', 'Ellie', 'Wiliams', null, 'rshingles27@topsy.com', 'credit_card');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (81, '44', '32', 'Joel', 'Miller', null, 'sheimes28@oakley.com', 'invoice');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (82, '45', '33', 'Ema', 'Klucarova', '+86 882 926 7251', 'wwalbrun29@godaddy.com', 'invoice');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (83, '45', '33', 'Abika', 'Snohova', '+31 342 115 0205', 'dgoulthorp2a@yahoo.co.jp', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (84, '45', '33', 'Nina', 'Peniakova', '+967 182 774 2304', 'alayfield2b@google.ru', 'credit_card');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (85, '45', '33', 'Katka', 'Martincova', null, 'gcrease2c@xrea.com', 'credit_card');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (86, '46', '34', 'Saw', 'Turle', null, 'ogriniov2d@mediafire.com', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (87, '46', '34', 'Ella', 'Turle', null, 'jgladbeck2e@vinaora.com', 'invoice');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (88, '46', '34', 'Maddi', 'Turle', '+46 887 966 6651', 'uoleagham2f@w3.org', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (89, '47', '37', 'Sella', 'Polley', null, 'hvurley2g@networkadvertising.org', 'invoice');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (90, '47', '37', 'Luke', 'Polley', null, 'tsciacovelli2h@engadget.com', 'cash');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (91, '48', '37', 'Tobe', 'Vannoni', null, 'kgaymer2i@etsy.com', 'voucher');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (92, '48', '37', 'Marcel', 'Vannoni', null, 'khinzer2j@edublogs.org', 'voucher');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (93, '48', '37', 'Martin', 'Luciano', '+62 309 617 8701', 'mmoulder2k@china.com.cn', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (94, '48', '37', 'Stela', 'Luciano', '+62 805 366 1371', 'ksaban2l@chicagotribune.com', 'invoice');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (95, '49', '38', 'Robbin', 'Audritt', '+81 287 991 9621', 'ksollime2m@pinterest.com', 'credit_card');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (96, '49', '38', 'Weston', 'Audritt', null, 'kenglefield2n@google.co.uk', 'voucher');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (97, '49', '38', 'Rafaello', 'Audritt', null, 'cjullian2o@jalbum.net', 'voucher');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (98, '49', '38', 'Brier', 'Audritt', null, 'afortescue2p@360.cn', 'credit_card');
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (99, '49', '38', 'Brodie', 'Audritt', '+84 919 475 1932', 'pduplain2q@businessweek.com', null);
insert into guest (guest_id, address_id, room_id, first_name, last_name, phone_number, email_address, payment_method) values (100, '50', '40', 'Madlen', 'Akact', null, 'lvarnham2r@cisco.com', 'invoice');
-- Set the sequence for the room table
select setval(pg_get_serial_sequence('guest','guest_id'),100);

-- Insert data into the travel_agency table
insert into travel_agency (agency_id, agency_name)
values  (default, 'Bubo'),
        (default, 'BlueStyle'),
        (default, 'ETI'),
        (default, 'TUI');

insert into aikilam_homepage (id_aikilam_homepage)
values  (1);

-- Set correct datestyle
set datestyle = dmy;

-- Insert data into the reservation table
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (1, null, 1, '20.4.2023', 3, '2.5.2023', '9.5.2023', 7, 'failed');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (2, null, 4, '20.4.2023', 1, '6.5.2023', '9.5.2023', 3, 'refunded');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (3, null, 2, '20.4.2023', 2, '2.5.2023', '9.5.2023', 7, 'paid');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (4, null, 3, '20.4.2023', 1, '6.5.2023', '9.5.2023', 3, 'pending');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (5, null, 3, '21.4.2023', 4, '2.5.2023', '9.5.2023', 7, 'refunded');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (6, null, 3, '21.4.2023', 2, '3.5.2023', '10.5.2023', 7, 'pending');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (7, null, 3, '23.4.2023', 3, '2.5.2023', '10.5.2023', 8, 'chargeback');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (8, 1, null, '20.4.2023', 3, '4.5.2023', '10.5.2023', 6, 'refunded');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (9, null, 1, '20.4.2023', 4, '3.5.2023', '11.5.2023', 8, 'partially_paid');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (10, null, 4, '20.4.2023', 1, '1.5.2023', '10.5.2023', 9, 'pending');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (11, null, 2, '20.4.2023', 3, '2.5.2023', '8.5.2023', 6, 'chargeback');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (12, 1, null, '20.4.2023', 1, '1.5.2023', '8.5.2023', 7, 'paid');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (13, null, 4, '20.4.2023', 1, '4.5.2023', '13.5.2023', 9, 'failed');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (14, null, 1, '20.4.2023', 5, '6.5.2023', '11.5.2023', 5, 'refunded');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (15, null, 1, '21.4.2023', 2, '5.5.2023', '13.5.2023', 8, 'pending');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (16, null, 4, '21.4.2023', 6, '4.5.2023', '13.5.2023', 9, 'chargeback');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (17, null, 1, '21.4.2023', 2, '4.5.2023', '12.5.2023', 8, 'pending');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (18, null, 1, '21.4.2023', 2, '4.5.2023', '11.5.2023', 7, 'refunded');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (19, null, 2, '21.4.2023', 1, '2.5.2023', '10.5.2023', 8, 'refunded');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (20, null, 2, '21.4.2023', 1, '5.5.2023', '10.5.2023', 5, 'paid');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (21, 1, null, '22.4.2023', 4, '1.5.2023', '12.5.2023', 11, 'pending');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (22, 1, null, '23.4.2023', 6, '3.5.2023', '11.5.2023', 8, 'paid');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (23, null, 1, '22.4.2023', 3, '3.5.2023', '10.5.2023', 7, 'refunded');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (24, null, 2, '22.4.2023', 2, '6.5.2023', '8.5.2023', 2, 'partially_paid');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (25, null, 3, '23.4.2023', 1, '2.5.2023', '11.5.2023', 9, 'pending');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (26, null, 4, '21.4.2023', 4, '2.5.2023', '13.5.2023', 11, 'failed');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (27, null, 2, '22.4.2023', 1, '4.5.2023', '10.5.2023', 6, 'paid');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (28, 1, null, '23.4.2023', 1, '6.5.2023', '11.5.2023', 5, 'paid');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (29, null, 4, '22.4.2023', 4, '4.5.2023', '8.5.2023', 4, 'refunded');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (30, null, 4, '22.4.2023', 4, '5.5.2023', '13.5.2023', 8, 'pending');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (31, null, 4, '22.4.2023', 1, '5.5.2023', '8.5.2023', 3, 'failed');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (32, null, 1, '22.4.2023', 2, '3.5.2023', '10.5.2023', 7, 'paid');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (33, null, 3, '23.4.2023', 4, '2.5.2023', '13.5.2023', 11, 'pending');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (34, null, 2, '23.4.2023', 3, '2.5.2023', '8.5.2023', 6, 'partially_paid');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (35, null, 1, '22.4.2023', 6, '3.5.2023', '8.5.2023', 5, 'pending');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (36, null, 4, '23.4.2023', 5, '2.5.2023', '13.5.2023', 11, 'partially_paid');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (37, null, 1, '22.4.2023', 1, '2.5.2023', '9.5.2023', 7, 'failed');
-- Special reservations for D1 querry that wont be included in sales report!
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (38, null, 2, '22.4.2020', 1, '2.5.2019', '9.5.2020', 7, 'paid');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (39, null, 3, '22.4.2021', 1, '2.5.2021', '9.5.2021', 7, 'paid');
insert into reservation (reservation_id, id_aikilam_homepage, agency_id, date_of_reservation, number_of_guests, check_in, check_out, number_of_nights, payment_status) values (40, null, 4, '22.4.2022', 1, '2.5.2022', '9.5.2022', 7, 'paid');
-- Set the sequence for the reservation table
select setval(pg_get_serial_sequence('reservation','reservation_id'),38);

-- Insert into reservation_guest table
insert into reservation_guest (reservation_id, guest_id) values (1, 1);
insert into reservation_guest (reservation_id, guest_id) values (1, 2);
insert into reservation_guest (reservation_id, guest_id) values (1, 3);
insert into reservation_guest (reservation_id, guest_id) values (2, 4);
insert into reservation_guest (reservation_id, guest_id) values (3, 5);
insert into reservation_guest (reservation_id, guest_id) values (3, 6);
insert into reservation_guest (reservation_id, guest_id) values (4, 7);
insert into reservation_guest (reservation_id, guest_id) values (5, 8);
insert into reservation_guest (reservation_id, guest_id) values (5, 9);
insert into reservation_guest (reservation_id, guest_id) values (5, 10);
insert into reservation_guest (reservation_id, guest_id) values (5, 11);
insert into reservation_guest (reservation_id, guest_id) values (6, 12);
insert into reservation_guest (reservation_id, guest_id) values (6, 13);
insert into reservation_guest (reservation_id, guest_id) values (7, 14);
insert into reservation_guest (reservation_id, guest_id) values (7, 15);
insert into reservation_guest (reservation_id, guest_id) values (7, 16);
insert into reservation_guest (reservation_id, guest_id) values (8, 17);
insert into reservation_guest (reservation_id, guest_id) values (8, 18);
insert into reservation_guest (reservation_id, guest_id) values (8, 19);
insert into reservation_guest (reservation_id, guest_id) values (9, 20);
insert into reservation_guest (reservation_id, guest_id) values (9, 21);
insert into reservation_guest (reservation_id, guest_id) values (9, 22);
insert into reservation_guest (reservation_id, guest_id) values (9, 23);
insert into reservation_guest (reservation_id, guest_id) values (10, 24);
insert into reservation_guest (reservation_id, guest_id) values (11, 25);
insert into reservation_guest (reservation_id, guest_id) values (11, 26);
insert into reservation_guest (reservation_id, guest_id) values (11, 27);
insert into reservation_guest (reservation_id, guest_id) values (12, 28);
insert into reservation_guest (reservation_id, guest_id) values (13, 29);
insert into reservation_guest (reservation_id, guest_id) values (14, 30);
insert into reservation_guest (reservation_id, guest_id) values (14, 31);
insert into reservation_guest (reservation_id, guest_id) values (14, 32);
insert into reservation_guest (reservation_id, guest_id) values (14, 33);
insert into reservation_guest (reservation_id, guest_id) values (14, 34);
insert into reservation_guest (reservation_id, guest_id) values (15, 35);
insert into reservation_guest (reservation_id, guest_id) values (15, 36);
insert into reservation_guest (reservation_id, guest_id) values (16, 37);
insert into reservation_guest (reservation_id, guest_id) values (16, 38);
insert into reservation_guest (reservation_id, guest_id) values (16, 39);
insert into reservation_guest (reservation_id, guest_id) values (16, 40);
insert into reservation_guest (reservation_id, guest_id) values (16, 41);
insert into reservation_guest (reservation_id, guest_id) values (16, 42);
insert into reservation_guest (reservation_id, guest_id) values (17, 43);
insert into reservation_guest (reservation_id, guest_id) values (17, 44);
insert into reservation_guest (reservation_id, guest_id) values (18, 45);
insert into reservation_guest (reservation_id, guest_id) values (18, 46);
insert into reservation_guest (reservation_id, guest_id) values (19, 47);
insert into reservation_guest (reservation_id, guest_id) values (20, 48);
insert into reservation_guest (reservation_id, guest_id) values (21, 49);
insert into reservation_guest (reservation_id, guest_id) values (21, 50);
insert into reservation_guest (reservation_id, guest_id) values (21, 51);
insert into reservation_guest (reservation_id, guest_id) values (21, 52);
insert into reservation_guest (reservation_id, guest_id) values (22, 53);
insert into reservation_guest (reservation_id, guest_id) values (22, 54);
insert into reservation_guest (reservation_id, guest_id) values (22, 55);
insert into reservation_guest (reservation_id, guest_id) values (22, 56);
insert into reservation_guest (reservation_id, guest_id) values (22, 57);
insert into reservation_guest (reservation_id, guest_id) values (22, 58);
insert into reservation_guest (reservation_id, guest_id) values (23, 59);
insert into reservation_guest (reservation_id, guest_id) values (23, 60);
insert into reservation_guest (reservation_id, guest_id) values (23, 61);
insert into reservation_guest (reservation_id, guest_id) values (24, 62);
insert into reservation_guest (reservation_id, guest_id) values (24, 63);
insert into reservation_guest (reservation_id, guest_id) values (25, 64);
insert into reservation_guest (reservation_id, guest_id) values (26, 65);
insert into reservation_guest (reservation_id, guest_id) values (26, 66);
insert into reservation_guest (reservation_id, guest_id) values (26, 67);
insert into reservation_guest (reservation_id, guest_id) values (26, 68);
insert into reservation_guest (reservation_id, guest_id) values (27, 69);
insert into reservation_guest (reservation_id, guest_id) values (28, 70);
insert into reservation_guest (reservation_id, guest_id) values (29, 71);
insert into reservation_guest (reservation_id, guest_id) values (29, 72);
insert into reservation_guest (reservation_id, guest_id) values (29, 73);
insert into reservation_guest (reservation_id, guest_id) values (29, 74);
insert into reservation_guest (reservation_id, guest_id) values (30, 75);
insert into reservation_guest (reservation_id, guest_id) values (30, 76);
insert into reservation_guest (reservation_id, guest_id) values (30, 77);
insert into reservation_guest (reservation_id, guest_id) values (30, 78);
insert into reservation_guest (reservation_id, guest_id) values (31, 79);
insert into reservation_guest (reservation_id, guest_id) values (32, 80);
insert into reservation_guest (reservation_id, guest_id) values (32, 81);
insert into reservation_guest (reservation_id, guest_id) values (33, 82);
insert into reservation_guest (reservation_id, guest_id) values (33, 83);
insert into reservation_guest (reservation_id, guest_id) values (33, 84);
insert into reservation_guest (reservation_id, guest_id) values (33, 85);
insert into reservation_guest (reservation_id, guest_id) values (34, 86);
insert into reservation_guest (reservation_id, guest_id) values (34, 87);
insert into reservation_guest (reservation_id, guest_id) values (34, 88);
insert into reservation_guest (reservation_id, guest_id) values (35, 89);
insert into reservation_guest (reservation_id, guest_id) values (35, 90);
insert into reservation_guest (reservation_id, guest_id) values (35, 91);
insert into reservation_guest (reservation_id, guest_id) values (35, 92);
insert into reservation_guest (reservation_id, guest_id) values (35, 93);
insert into reservation_guest (reservation_id, guest_id) values (35, 94);
insert into reservation_guest (reservation_id, guest_id) values (36, 95);
insert into reservation_guest (reservation_id, guest_id) values (36, 96);
insert into reservation_guest (reservation_id, guest_id) values (36, 97);
insert into reservation_guest (reservation_id, guest_id) values (36, 98);
insert into reservation_guest (reservation_id, guest_id) values (36, 99);
insert into reservation_guest (reservation_id, guest_id) values (37, 100);
-- Special reservations for D1 querry that wont be included in sales report!
insert into reservation_guest (reservation_id, guest_id) values (38, 100);
insert into reservation_guest (reservation_id, guest_id) values (39, 100);
insert into reservation_guest (reservation_id, guest_id) values (40, 100);


-- Set the sequence for the room table
select setval(pg_get_serial_sequence('reservation_guest','reservation_id'),37);

-- Insert into the sales_report table
insert into sales_report (sales_report_id, id_aikilam_homepage, agency_id, date, number_of_reservations, number_of_guests, number_of_rooms) values (default, 1, null, '2023-04-20', 2, 4, 2);
insert into sales_report (sales_report_id, id_aikilam_homepage, agency_id, date, number_of_reservations, number_of_guests, number_of_rooms) values (default, null, 1, '2023-04-20', 3, 12, 3);
insert into sales_report (sales_report_id, id_aikilam_homepage, agency_id, date, number_of_reservations, number_of_guests, number_of_rooms) values (default, null, 2, '2023-04-20', 2, 5, 2);
insert into sales_report (sales_report_id, id_aikilam_homepage, agency_id, date, number_of_reservations, number_of_guests, number_of_rooms) values (default, null, 3, '2023-04-20', 1, 1, 1);
insert into sales_report (sales_report_id, id_aikilam_homepage, agency_id, date, number_of_reservations, number_of_guests, number_of_rooms) values (default, null, 4, '2023-04-20', 3, 3, 3);
insert into sales_report (sales_report_id, id_aikilam_homepage, agency_id, date, number_of_reservations, number_of_guests, number_of_rooms) values (default, null, 1, '2023-04-21', 3, 6, 3);
insert into sales_report (sales_report_id, id_aikilam_homepage, agency_id, date, number_of_reservations, number_of_guests, number_of_rooms) values (default, null, 2, '2023-04-21', 2, 2, 2);
insert into sales_report (sales_report_id, id_aikilam_homepage, agency_id, date, number_of_reservations, number_of_guests, number_of_rooms) values (default, null, 3, '2023-04-21', 2, 6, 2);
insert into sales_report (sales_report_id, id_aikilam_homepage, agency_id, date, number_of_reservations, number_of_guests, number_of_rooms) values (default, null, 4, '2023-04-21', 2, 10, 2);
insert into sales_report (sales_report_id, id_aikilam_homepage, agency_id, date, number_of_reservations, number_of_guests, number_of_rooms) values (default, 1, null, '2023-04-22', 1, 4, 1);
insert into sales_report (sales_report_id, id_aikilam_homepage, agency_id, date, number_of_reservations, number_of_guests, number_of_rooms) values (default, null, 1, '2023-04-22', 4, 12, 4);
insert into sales_report (sales_report_id, id_aikilam_homepage, agency_id, date, number_of_reservations, number_of_guests, number_of_rooms) values (default, null, 2, '2023-04-22', 2, 3, 2);
insert into sales_report (sales_report_id, id_aikilam_homepage, agency_id, date, number_of_reservations, number_of_guests, number_of_rooms) values (default, null, 4, '2023-04-22', 3, 9, 3);
insert into sales_report (sales_report_id, id_aikilam_homepage, agency_id, date, number_of_reservations, number_of_guests, number_of_rooms) values (default, 1, null, '2023-04-23', 2, 7, 2);
insert into sales_report (sales_report_id, id_aikilam_homepage, agency_id, date, number_of_reservations, number_of_guests, number_of_rooms) values (default, null, 2, '2023-04-23', 1, 3, 1);
insert into sales_report (sales_report_id, id_aikilam_homepage, agency_id, date, number_of_reservations, number_of_guests, number_of_rooms) values (default, null, 3, '2023-04-23', 3, 8, 3);
insert into sales_report (sales_report_id, id_aikilam_homepage, agency_id, date, number_of_reservations, number_of_guests, number_of_rooms) values (default, null, 4, '2023-04-23', 1, 5, 1);

-- End of the script