create database AirLine;
use AirLine;

create table Customers(
    customer_id int primary key AUTO_INCREMENT,
    name varchar(100),
    email varchar(100),
    phone varchar(15)

);


--.details of flights/-- 
create table flights(
    flight_id int primary key auto_increment,
    origin varchar(100),
    destination varchar(100),
    departure_time datetime,
    arrival_time datetime,
    total_seats int
);


-- --details of each seat to get booked

create table seats (
    seat_id int primary key auto_increment,
    flight_id int,
    seat_number varchar(10),
    class enum('Economy','Business'),
    is_booked boolean default false,
    foreign key (flight_id) references flights(flight_id)
);

-- schema for bookings---- 

create table bookings(
    booking_id int primary key auto_increment,
    customer_id int,
    flight_id int,
    seat_id int,
    booking_date datetime default current_timestamp,
    status enum('Booked', 'Cancelled') default 'Booked',
    foreign key (customer_id) references Customers(customer_id),
    foreign key (flight_id) references flights(flight_id),
    foreign key (seat_id) references seats (seat_id) 

);


INSERT INTO Customers (name, email, phone) VALUES
('Yagna', 'yagna@example.com', '9876543210'),
('Jagadish', 'jagadish@example.com', '9823456710'),
('Ratna', 'ratna@example.com', '9812345670'),
('Ramagopal', 'ramagopal@example.com', '9898765432'),
('Ravi Kumar', 'ravi.k@example.com', '9123456780'),
('Anita Rao', 'anita.r@example.com', '9012345678');



INSERT INTO Flights (origin, destination, departure_time, arrival_time, total_seats) VALUES
('Hyderabad', 'Delhi', '2025-07-15 08:00:00', '2025-07-15 10:30:00', 5),
('Mumbai', 'Chennai', '2025-07-16 09:00:00', '2025-07-16 11:15:00', 5),
('Bangalore', 'Kolkata', '2025-07-17 07:30:00', '2025-07-17 10:00:00', 5),
('Pune', 'Goa', '2025-07-18 06:00:00', '2025-07-18 07:15:00', 4),
('Delhi', 'Jaipur', '2025-07-19 05:30:00', '2025-07-19 06:15:00', 4);

-- Flight 1 (Hyderabad → Delhi)
INSERT INTO Seats (flight_id, seat_number, class) VALUES
(1, '1A', 'Economy'), (1, '1B', 'Economy'), (1, '1C', 'Business'),
(1, '2A', 'Economy'), (1, '2B', 'Business');

-- Flight 2 (Mumbai → Chennai)
INSERT INTO Seats (flight_id, seat_number, class) VALUES
(2, '3A', 'Economy'), (2, '3B', 'Economy'), (2, '3C', 'Business'),
(2, '4A', 'Economy'), (2, '4B', 'Business');

-- Flight 3 (Bangalore → Kolkata)
INSERT INTO Seats (flight_id, seat_number, class) VALUES
(3, '5A', 'Economy'), (3, '5B', 'Economy'), (3, '5C', 'Business'),
(3, '6A', 'Economy'), (3, '6B', 'Business');

-- Flight 4 (Pune → Goa)
INSERT INTO Seats (flight_id, seat_number, class) VALUES
(4, '7A', 'Economy'), (4, '7B', 'Economy'), (4, '8A', 'Business'), (4, '8B', 'Economy');

-- Flight 5 (Delhi → Jaipur)
INSERT INTO Seats (flight_id, seat_number, class) VALUES
(5, '9A', 'Economy'), (5, '9B', 'Economy'), (5, '10A', 'Business'), (5, '10B', 'Economy');


-- Booking Yagna on Flight 1, Seat 1A
INSERT INTO Bookings (customer_id, flight_id, seat_id, status) VALUES (1, 1, 1, 'Booked');

-- Booking Jagadish on Flight 2, Seat 6 (3A)
INSERT INTO Bookings (customer_id, flight_id, seat_id, status) VALUES (2, 2, 6, 'Booked');

-- Booking Ratna on Flight 3, Seat 11 (5A)
INSERT INTO Bookings (customer_id, flight_id, seat_id, status) VALUES (3, 3, 11, 'Booked');

-- Booking Ramagopal on Flight 4, Seat 16 (7A)
INSERT INTO Bookings (customer_id, flight_id, seat_id, status) VALUES (4, 4, 16, 'Booked');

-- Booking Ravi Kumar on Flight 5, Seat 21 (9A)
INSERT INTO Bookings (customer_id, flight_id, seat_id, status) VALUES (5, 5, 21, 'Booked');

-- Booking Anita Rao on Flight 2, Seat 7 (3B)
INSERT INTO Bookings (customer_id, flight_id, seat_id, status) VALUES (6, 2, 7, 'Booked');


UPDATE Seats SET is_booked = TRUE WHERE seat_id IN (1, 6, 11, 16, 21, 7);

DELIMITER $$

CREATE TRIGGER trg_after_booking_insert
AFTER INSERT ON Bookings
FOR EACH ROW
BEGIN
  UPDATE Seats
  SET is_booked = TRUE
  WHERE seat_id = NEW.seat_id;
END$$

DELIMITER ;



DELIMITER $$

CREATE TRIGGER trg_after_booking_update
AFTER UPDATE ON Bookings
FOR EACH ROW
BEGIN
  IF NEW.status = 'Cancelled' THEN
    UPDATE Seats
    SET is_booked = FALSE
    WHERE seat_id = NEW.seat_id;
  END IF;
END$$

DELIMITER ;



CREATE VIEW BookingSummary AS
SELECT
    B.booking_id,
    C.name AS customer_name,
    F.origin,
    F.destination,
    F.departure_time,
    F.arrival_time,
    S.seat_number,
    S.class,
    B.booking_date,
    B.status
FROM Bookings B
JOIN Customers C ON B.customer_id = C.customer_id
JOIN Flights F ON B.flight_id = F.flight_id
JOIN Seats S ON B.seat_id = S.seat_id;



SELECT * FROM BookingSummary
WHERE status = 'Booked'
ORDER BY booking_date DESC;
