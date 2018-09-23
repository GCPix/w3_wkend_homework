DROP TABLE tickets;
DROP TABLE screenings;
DROP TABLE films;
DROP TABLE customers;

CREATE TABLE customers(
id SERIAL4 PRIMARY KEY,
name VARCHAR(255),
funds INT2

);

CREATE TABLE films(
id SERIAL4 PRIMARY KEY,
title VARCHAR(255),
price INT2
);

CREATE TABLE screenings(
id SERIAL4 PRIMARY KEY,
film_id INT4 REFERENCES films(id) ON DELETE CASCADE,
start_time varchar(255),
max_seats INT2,
seats_available INT2
);

CREATE TABLE tickets(
id SERIAL4 PRIMARY KEY,
film_id INT4 REFERENCES films(id) ON DELETE CASCADE,
customer_id INT4 REFERENCES customers(id) ON DELETE CASCADE,
screening_id INT4 REFERENCES screenings(id) ON DELETE CASCADE
);
