use cinema_database

-- Database: `cinema_database`
-- --------------------------------------------------------
--
-- Table structure for table `employees`
--
CREATE TABLE employees
(
  employee_id int NOT NULL IDENTITY,
  employee_name varchar(50) NOT NULL,
  employee_surname varchar(50) NOT NULL,
  username varchar(50),
  password varchar(50),

  PRIMARY KEY (employee_id),
  CONSTRAINT username UNIQUE (username)
);
-- --------------------------------------------------------
--
-- Table structure for table `customers`
--
CREATE TABLE customers 
(
  customer_id int NOT NULL IDENTITY,
  customer_name varchar(50) NOT NULL,
  customer_surname varchar(20) NOT NULL,
  customer_age int DEFAULT NULL,
  customer_gender varchar(2) NOT NULL,
  customer_email varchar(50) NOT NULL,

  PRIMARY KEY (customer_id),
  CONSTRAINT customer_email UNIQUE (customer_email)
);
-- --------------------------------------------------------
--
-- Table structure for table `categories`
--
CREATE TABLE categories 
(
  category_id int NOT NULL IDENTITY,
  category_name varchar(50) NOT NULL,

  PRIMARY KEY (category_id),
  CONSTRAINT category_name UNIQUE (category_name)
);
--
-- Table structure for table `countries`
--
CREATE TABLE countries 
(
  country_id int NOT NULL IDENTITY,
  country_name varchar(50) NOT NULL,

  PRIMARY KEY (country_id),
  CONSTRAINT country_name UNIQUE (country_name)
);
-- --------------------------------------------------------
--
-- Table structure for table `languages`
--
CREATE TABLE languages 
(
  language_id int NOT NULL IDENTITY,
  language_name varchar(50) NOT NULL,

  PRIMARY KEY (language_id),
  CONSTRAINT language_name UNIQUE (language_name)

);
-- --------------------------------------------------------
--
-- Table structure for table `films`
--
CREATE TABLE films 
(
  film_id int NOT NULL IDENTITY,
  film_name varchar(50) NOT NULL,
  category_id int NOT NULL,
  release_year date NOT NULL,
  country_id int DEFAULT NULL,
  language_id int DEFAULT NULL,
  film_description varchar(250),

  PRIMARY KEY (film_id),
  CONSTRAINT film_name UNIQUE (film_name)

);
-- --------------------------------------------------------
--
-- Table structure for table `film_details`
--

CREATE TABLE film_details 
(
  film_detail_id int NOT NULL IDENTITY,
  film_id int NOT NULL UNIQUE,
  film_director varchar(50) DEFAULT NULL,
  film_producer varchar(50) DEFAULT NULL,
  film_cast_detail varchar(250),
  film_plot varchar(250),

  PRIMARY KEY (film_detail_id)
);
-- --------------------------------------------------------
--
-- Table structure for table `halls`
--
CREATE TABLE halls 
(
  hall_id int NOT NULL IDENTITY,
  hall_name varchar(50) NOT NULL ,
  hall_rows int NOT NULL,
  hall_seats int NOT NULL,

  PRIMARY KEY (hall_id),
  CONSTRAINT hall_name UNIQUE (hall_name)
);
-- --------------------------------------------------------
--
-- Table structure for table `hall_seats_detail`
--

CREATE TABLE hall_seats_detail 
(
  seat_id int NOT NULL IDENTITY,
  seat_number int NOT NULL,
  row_number int NOT NULL,
  hall_id int NOT NULL,

  PRIMARY KEY (seat_id)
)  ;	
-- --------------------------------------------------------
--
-- Table structure for table `reservation`
--
CREATE TABLE reservation 
(
  reservation_id int NOT NULL IDENTITY,
  customer_id int NOT NULL,
  show_id int NOT NULL,
  employee_id int NOT NULL,
  reservation_datetime datetime DEFAULT NULL,

  PRIMARY KEY (reservation_id)
)  ;
-- --------------------------------------------------------
--
-- Table structure for table `shows`
--
CREATE TABLE shows 
(
  show_id int NOT NULL IDENTITY,
  show_datetime datetime DEFAULT NULL,
  hall_id int DEFAULT NULL,
  film_id int DEFAULT NULL,

  PRIMARY KEY (show_id)
)  ;
-- --------------------------------------------------------
--
-- Table structure for table `tickets`
--
CREATE TABLE tickets
(
  ticket_id int NOT NULL IDENTITY,
  seat_id int NOT NULL,
  ticket_price int NOT NULL,
  show_id int NOT NULL,
  reservation_id int DEFAULT NULL,

  PRIMARY KEY (ticket_id)
)  ;
--
-- Adding Relationship
--
----------------------------
ALTER TABLE films  
ADD CONSTRAINT FK_FilmsCategories FOREIGN KEY (category_id)     
    REFERENCES categories (category_id)

ALTER TABLE films  
ADD CONSTRAINT FK_FilmsCountries FOREIGN KEY (country_id)     
    REFERENCES countries (country_id)

ALTER TABLE films  
ADD CONSTRAINT FK_FilmsLanguages FOREIGN KEY (language_id)     
    REFERENCES languages (language_id)

ALTER TABLE film_details  
ADD CONSTRAINT FK_FilmDetailsFilms FOREIGN KEY (film_id)     
    REFERENCES films (film_id)
	
ALTER TABLE hall_seats_detail    
ADD CONSTRAINT FK_HallSeatsDetailHalls FOREIGN KEY (hall_id)     
    REFERENCES halls (hall_id)     
	
ALTER TABLE reservation    
ADD CONSTRAINT FK_ReservationCustomers FOREIGN KEY (customer_id)     
    REFERENCES customers (customer_id)    
	
ALTER TABLE reservation  
ADD CONSTRAINT FK_ReservationShows FOREIGN KEY (show_id)     
    REFERENCES shows (show_id)

ALTER TABLE reservation
ADD CONSTRAINT FK_ReservationEmployees FOREIGN KEY (employee_id)     
    REFERENCES employees (employee_id) 
	
ALTER TABLE shows    
ADD CONSTRAINT FK_ShowsHalls FOREIGN KEY (hall_id)     
    REFERENCES halls (hall_id)     
	
ALTER TABLE shows    
ADD CONSTRAINT FK_ShowsFilms FOREIGN KEY (film_id)     
    REFERENCES films (film_id)     
	
ALTER TABLE tickets    
ADD CONSTRAINT FK_TicketsShows FOREIGN KEY (show_id)     
    REFERENCES shows (show_id)     
	
ALTER TABLE tickets    
ADD CONSTRAINT FK_TicketsHallSeatsDetail FOREIGN KEY (seat_id)     
    REFERENCES hall_seats_detail (seat_id)     
	
ALTER TABLE tickets    
ADD CONSTRAINT FK_TicketsReservation FOREIGN KEY (reservation_id)     
    REFERENCES reservation (reservation_id)     

--
-- Adding data to tables
--
INSERT INTO employees ([employee_name], [employee_surname], [username], [password]) VALUES
('Latisha', 'Cason', 'latisha@gmail.com', 'Lw8@#!/V'),
('Leonore', 'Hiler', 'leonore@outlook.com', '2ZwXea?G'),
('Carol', 'Hoang', 'carol@gmail.com', 'u6?cZq[;'),
('Fermin', 'Scriber', 'fermin@gmail.com', 'C67.{/z-'),
('Dominica', 'Hurston', 'domicica@outlook.com', '}Gc>Y9h>'),
('Dale', 'Hove', 'dale@yahoo.com', 'mf;=F9K{'),
('Greg', 'Corle', 'greg@gmail.com', 'aP2}t&5z'),
('Willetta', 'Boyington', 'willetta@outlook.com', 'W>6hv{?5'),
('Melvina', 'Leister', 'melvina@outlook.com', 'Sc)qBp5&'),
('Dalene', 'Cuddy', 'dalene@gmail.com', '7u,Y(Zp2'); -- 10

INSERT INTO customers ([customer_name], [customer_surname], [customer_gender],[customer_age], [customer_email]) VALUES
('Dashawn', 'Olson', 'M', 36, 'dashawn@hotmail.com'),
('Anton', 'Ortiz', 'M', 24, 'anton@gmail.com'),
('Gilbert', 'Benton', 'M', 24, 'gilbert@hotmail.com'),
('Valentino', 'Stuart', 'M', 28, 'valentiono@outlook.com'),
('London', 'Benitez', 'M', 34, 'london@hotmail.com'),
('Ashtyn', 'Fletcher', 'F', 45, 'ashtyn@gmail.com'),
('Talan', 'King', 'M', 17, 'talan@hotmail.com'),
('Jamiya', 'Morse', 'F', 29, 'jamiya@hotmail.com'),
('Camille', 'Shaw', 'F', 21, 'camille@gmail.com'),
('Zayden', 'Salazar', 'M', 27, 'zayden@outlook.com'),
('Easton', 'Conway', 'M', 47, 'easton@hotmail.com'),
('Yaritza', 'Hunt', 'M', 35, 'yaritza@gmail.com'),
('Soren', 'Rivers', 'F', 32, 'soren@outlook.com'),
('Tia', 'Roy', 'M', 19, 'tia@hotmail.com'),
('Carlo', 'Perkins', 'M', 20, 'carlo@hotmail.com'),
('Lisa', 'Mullen', 'F', 21, 'lisa@hotmail.com'),
('Annabelle ', 'Rollins', 'F', 24, 'alina@gmail.com'),
('Avery ', 'Cole', 'M', 73, 'avery@hotmail.com'),
('Leland', 'Vaughan', 'F', 72, 'leland@hotmail.com'),
('Johnny', 'Valentine', 'M', 16, 'johnny@outlook.com'),
('Sanai', 'Shepard', 'F', 45, 'sanai@hotmail.com'),
('Luke', 'Rios', 'M', 53, 'luke@hotmail.com'),
('Rene', 'Whitehead', 'F', 39, 'rene@gmail.com'),
('Albert', 'Harrison', 'M', 46, 'albert@hotmail.com'),
('Heather', 'Marsh', 'M', 67, 'heather@outlook.com'),
('Rodolfo', 'Shelton', 'M', 23, 'rodo@yandex.com'),
('Emanuel', 'Burns', 'M', 34, 'emanuel45@hotmail.com'),
('Sam', 'Wright', 'M', 31, 'sammy01@hotmail.com'),
('Kelvin', 'Farmer', 'M', 18, 'kelvin1989@microsoft.com'),
('Karla	', 'Rose', 'F', 18,'karla.rose@yandex.com'),
('Nancy	', 'Peterson', 'F', 42, 'nanpet@hotmail.com'),
('Denise', 'Floyd', 'M', 29, 'deni.floyd@yandex.com'),
('Jessie', 'Nunez', 'F', 19, 'jessie2000@microsoft.com'),
('Fannie', 'Elliott', 'M', 38, 'frannie@hotmail.com'),
('Irene	', 'Harrison', 'F', 42,'ireneh@yandex.com'),
('Evan', 'Rhodes', 'M', 34, 'ewan@hotmail.com'),
('Shari', 'Davidson', 'F', 19, 'shari@hotmail.com'),
('Doyle', 'Brady', 'M', 19,'doyle@hotmail.com'),
('Leslie', 'Bowman', 'F', 21,'leslie@hotmail.com'),
('Leah', 'Gomez', 'M', 22,'leah@hotmail.com'),
('Esther', 'Fleming', 'F', 27,'esther@microsoft.com'),
('Belinda', 'Rice', 'F', 33,'belinda@yandex.com'),
('Ramon', 'Bryant', 'M', 32,'ramon@microsoft.com'),
('Tricia', 'Hunt', 'F', 31,'tricia@hotmail.com'),
('Blake', 'Bowman', 'M', 28,'blake@microsoft.com'),
('Lucy', 'Ford', 'F', 19,'lucy19@outlook.com'),
('Jody', 'Price', 'F', 21,'jodpri44@microsoft.com'),
('Antoinette', 'Higgins', 'F', 23,'higgy_98@microsoft.com'),
('Vickie', 'Ward', 'F', 19,'vickie_w@gmail.com'),
('Julie', 'Stanley', 'F', 31,'julstan@hotmail.com'); -- 50

INSERT INTO categories ([category_name]) VALUES
('Comedy'),
('Sci-Fi'),
('Horror'),
('Romance'),
('Action'),
('Thriller'),
('Drama'),
('War'),
('Mystery'),
('Crime'),
('Animation'),
('Adventure'),
('Fantasy'),
('Comedy-Romance'),
('Action-Comedy'); -- 15

INSERT INTO countries ([country_name]) VALUES
('USA'),
('Latvia'),
('France'),
('Turkey'),
('UK'),
('Italy');

INSERT INTO languages ([language_name]) VALUES
('English'),
('French'),
('Latvian'),
('Spanish'),
('Russian'),
('Turkish');

INSERT INTO films ([film_name], [category_id], [release_year], [country_id], [language_id], [film_description]) VALUES
-- Category: Sci-Fi
('Avengers: Endgame', 2, '2019-02-12', 1, 1, 'The fast-paced life of a young girl take a sharp turn as a neighbor enters her life'),
('Terminator: Dark Fate', 2, '2019-03-21', 1, 1, 'The calm life of a teenage girl will be changed completely as a new friend enters her life'),
('Brightburn', 2, '2019-04-13', 3, 3, 'The secluded life of a boy is going the complete opposite way as a strange boy enters his life'),
('Westworld', 2, '2016-02-06', 5, 3, 'The carefree life of a woman will change forever as a strange girl enters her life'),
('The Society', 2, '2019-02-22', 1, 1, 'The laid-back life of a elderly man changes for better or worse as a new friend enters his life'),
-- Category: Horror
('The Walking Dead', 3, '2010-11-06', 5, 4, 'The fast-paced life of a boy will be permanently altered as a strange boy enters his life'),
('Stranger Things', 3, '2013-03-05', 5, 6, 'The quiet life of a young girl will be permanently altered as a childhood friend enters her life'),
('Supernatural', 3, '2014-11-21', 2, 6, 'The stressful life of a teenage girl will change forever as a stranger enters her life.'),
('What We Do in the Shadows', 3, '1996-01-16', 3, 1, 'The peaceful life of a elderly man take a sharp turn as a strange boy enters his life'),
('The Perfection', 3, '2012-11-16', 3, 2, 'The peaceful life of a teenage boy will be changed completely as a strange man enters his life'),
-- Category: Crime
('Lucifer', 10, '2015-01-31', 4, 5, 'The casual life of a boy changes in an instant as a neighbor enters his life'),
('Breaking Bad', 10, '2017-01-14', 1, 1, 'The carefree life of a young guy changes for better or worse as a new friend enters his life'),
('John Wick', 10, '2016-01-16', 1, 3, 'The unexciting life of a teenage girl take a sharp turn as a new friend enters her life'),
('The Blacklist', 10, '2013-01-26', 1, 3, 'The rough life of a elderly man will be permanently altered as a new friend enters his life'),
('Barry', 10, '2011-01-06', 1, 4, 'The hectic life of a teenage boy take a sharp turn as a lost friend enters his life'),
-- Category: Adventure
('Game of Thrones', 12, '1998-11-05', 1, 1, 'The peaceful life of a young girl will change forever as a stranger enters her life'),
('Aladdin', 12, '2001-01-06', 2, 2, 'This is description for Film A'),
('His Dark Materials', 12, '2003-01-16', 1, 2, 'This is description for Film A'),
('Godzilla: King of the Monsters', 12, '1990-01-06', 6, 4, 'This is description for Film A'),
('Spider-Man: Far from Home', 12, '2019-01-06', 6, 6, 'This is description for Film A'),
-- Category: Fantasy
('Shazam', 13, '2018-01-06', 1, 1, 'This is description for Film A'),
('Toy Story 4', 13, '2018-07-26', 1, 2, 'This is description for Film A'),
('Lost', 13, '2010-02-06', 1, 6, 'This is description for Film A'),
('Good Omens', 13, '2011-05-13', 2, 3, 'This is description for Film A'),
('Star Wars', 13, '2004-03-06', 2, 3, 'This is description for Film A'),
-- Category: Comedy
('Dead To Me', 1, '2001-11-19',1 , 3, 'This is description for Film A'),
('The Big Bang Theory', 1, '2007-01-23', 4, 3, 'This is description for Film A'),
('Booksmart', 1, '2009-10-06', 4, 4, 'This is description for Film A'),
('Brooklyn Nine-Nine', 1, '2019-02-24', 4, 1, 'This is description for Film A'),
('Easy', 1, '2018-01-06', 1, 1, 'This is description for Film A'),
-- Category: Romance
('Vikings', 4, '2006-11-19', 1, 1, 'This is description for Film A'),
('Riverdale', 4, '2001-12-14', 2, 2, 'This is description for Film A'),
('Friends', 4, '2002-01-06', 3, 3, 'This is description for Film A'),
('Student of the Year 2', 4, '2018-01-13', 1, 2, 'This is description for Film A'); -- 34

INSERT INTO film_details ([film_id], [film_director], [film_producer], [film_cast_detail], [film_plot]) VALUES
(1, 'Marie', 'Little', 'Maryjane Gibbs, Lance Mcfarland', 'This is plot for Film 1'),
(2, 'Kamryn', 'Carson', 'Frida Wade, Pierce Frye', 'This is plot for Film 2'),
(3, 'Brylee', 'Rasmussen', 'Chelsea Flowers, Marisa Burnett', 'This is plot for Film 3'),
(4, 'Nigel', 'Peck', 'Emily Douglas, Lennon Pratt', 'This is plot for Film 4'),
(5, 'Juliette', 'Knapp', 'Lennon Pratt, Cast J', 'This is plot for Film 5'),
(6, 'Jaylee', 'Lowe', 'Mia Owens, Jefferson Hanna', 'This is plot for Film 6'),
(7, 'Cesar', 'Barron', 'Ayana Andrade, Kaleb Graves', 'This is plot for Film 7'),
(8, 'Salvatore', 'Hooper', 'Hugo Powers, Lennon Pratt', 'This is plot for Film 8'),
(9, 'Eliza', 'Keller', 'Abel Reid, Meadow Cain', 'This is plot for Film 9'),
(10, 'Konnor ', 'Guzman', 'Braylen Thornton, Kaitlin Stevenson', 'This is plot for Film 10'),
(11, 'Chloe', 'Dixon', 'Gabriel Harrington, Kale Andersen', 'This is plot for Film 11'),
(12, 'Ibrahim', 'Hancock', 'Felicity Gill, Luca Cox', 'This is plot for Film 12'),
(13, 'Luciana', 'Woods', 'Jensen Mueller, Alisha Livingston', 'This is plot for Film 13'),
(14, 'Cesar', 'Chaney', 'Geovanni Lane, Ernest Ortega', 'This is plot for Film 14'),
(15, 'Katrina', 'Kemp', 'Moshe Walters, Houston Cuevas', 'This is plot for Film 15'),
(16, 'Kristina', 'Zuniga', 'Marley Robbins, Sloane Mcneil', 'This is plot for Film 16'),
(17, 'Karter', 'Palmer', 'Keyla Thomas, Blaze Jones', 'This is plot for Film 17'),
(18, 'Beatrice', 'Rowe', 'Destinee Villarreal, Jamarion Keller', 'This is plot for Film 18'),
(19, 'Ashton', 'Vaughan', 'Journey Miles, Ashlyn Christensen', 'This is plot for Film 19'),
(20, 'Libby', 'Potts', 'Sullivan Page, Rhett Herrera', 'This is plot for Film 20'),
(21, 'Silas', 'Guzman', 'Josiah Pugh, Damien Day', 'This is plot for Film 21'),
(22, 'Belinda', 'Craig', 'Derick Curry, Kaylynn Hickman', 'This is plot for Film 22'),
(23, 'Matthew', 'Horton', 'Collin Duran, Quentin Harding', 'This is plot for Film 23'),
(24, 'Raiden', 'Tyler', 'Clara Gutierrez, Haylie Proctor', 'This is plot for Film 24'),
(25, 'Arianna', 'Davenport', 'Karma Browning, Marcos Daniels', 'This is plot for Film 25'),
(26, 'Eliza', 'Keller', 'Barrett Mccann, Jerry Pennington', 'This is plot for Film 26'),
(27, 'Immanuel', 'Tanner', 'Reid Wright, Keira Harper', 'This is plot for Film 27'),
(28, 'Kenneth', 'Raymond', 'Antonio Avila, Bryan Hobbs', 'This is plot for Film 28'),
(29, 'Ashton', 'Vaughan', 'Arielle West, Mauricio Mcintyre', 'This is plot for Film 29'),
(30, 'Bridget', 'Fischer', 'Angie Frazier, Cale Waller', 'This is plot for Film 30'),
(31, 'Cassie', 'Hoover', 'Kaelyn Christian, Bridger Hunt', 'This is plot for Film 31'),
(32, 'Karter', 'Palmer', 'Raegan Larson, Isabell Cervantes', 'This is plot for Film 32'),
(33, 'Fisher', 'Russell', 'Shane Odom, Bailee Wilkerson', 'This is plot for Film 33'),
(34, 'Raiden', 'Tyler', 'Pierce Rose, Stella Pham', 'This is plot for Film 34'); -- 34

INSERT INTO halls ([hall_name], [hall_rows], [hall_seats]) VALUES
('Hall A', 5, 5),
('Hall B', 5, 5),
('Hall C', 5, 5),
('Hall E', 5, 5),
('Hall F', 5, 5);

INSERT INTO hall_seats_detail ([seat_number], [row_number], [hall_id]) VALUES

--Hall 1
(1, 1, 1),
(2, 1, 1),
(3, 1, 1),
(4, 1, 1), 
(5, 1, 1),

(1, 2, 1),
(2, 2, 1),
(3, 2, 1),
(4, 2, 1), 
(5, 2, 1),

(1, 3, 1),
(2, 3, 1),
(3, 3, 1),
(4, 3, 1), 
(5, 3, 1),

(1, 4, 1),
(2, 4, 1),
(3, 4, 1),
(4, 4, 1), 
(5, 4, 1),

(1, 5, 1),
(2, 5, 1),
(3, 5, 1),
(4, 5, 1), 
(5, 5, 1),
--Hall 2
(1, 1, 2),
(2, 1, 2),
(3, 1, 2),
(4, 1, 2), 
(5, 1, 2),

(1, 2, 2),
(2, 2, 2),
(3, 2, 2),
(4, 2, 2), 
(5, 2, 2),

(1, 3, 2),
(2, 3, 2),
(3, 3, 2),
(4, 3, 2), 
(5, 3, 2),

(1, 4, 2),
(2, 4, 2),
(3, 4, 2),
(4, 4, 2), 
(5, 4, 2),

(1, 5, 2),
(2, 5, 2),
(3, 5, 2),
(4, 5, 2), 
(5, 5, 2),
--Hall 3
(1, 1, 3),
(2, 1, 3),
(3, 1, 3),
(4, 1, 3), 
(5, 1, 3),

(1, 2, 3),
(2, 2, 3),
(3, 2, 3),
(4, 2, 3), 
(5, 2, 3),

(1, 3, 3),
(2, 3, 3),
(3, 3, 3),
(4, 3, 3), 
(5, 3, 3),

(1, 4, 3),
(2, 4, 3),
(3, 4, 3),
(4, 4, 3), 
(5, 4, 3),

(1, 5, 3),
(2, 5, 3),
(3, 5, 3),
(4, 5, 3), 
(5, 5, 3),
--Hall 4
(1, 1, 4),
(2, 1, 4),
(3, 1, 4),
(4, 1, 4), 
(5, 1, 4),

(1, 2, 4),
(2, 2, 4),
(3, 2, 4),
(4, 2, 4), 
(5, 2, 4),

(1, 3, 4),
(2, 3, 4),
(3, 3, 4),
(4, 3, 4), 
(5, 3, 4),

(1, 4, 4),
(2, 4, 4),
(3, 4, 4),
(4, 4, 4), 
(5, 4, 4),

(1, 5, 4),
(2, 5, 4),
(3, 5, 4),
(4, 5, 4), 
(5, 5, 4),
--Hall 5
(1, 1, 5),
(2, 1, 5),
(3, 1, 5),
(4, 1, 5), 
(5, 1, 5),

(1, 2, 5),
(2, 2, 5),
(3, 2, 5),
(4, 2, 5), 
(5, 2, 5),

(1, 3, 5),
(2, 3, 5),
(3, 3, 5),
(4, 3, 5), 
(5, 3, 5),

(1, 4, 5),
(2, 4, 5),
(3, 4, 5),
(4, 4, 5), 
(5, 4, 5),

(1, 5, 5),
(2, 5, 5),
(3, 5, 5),
(4, 5, 5), 
(5, 5, 5),

--Hall 1
(1, 1, 1),
(2, 1, 1),
(3, 1, 1),
(4, 1, 1), 
(5, 1, 1),

(1, 1, 2),
(2, 1, 2),
(3, 1, 2),
(4, 1, 2), 
(5, 1, 2),

(1, 1, 3),
(2, 1, 3),
(3, 1, 3),
(4, 1, 3), 
(5, 1, 3),

(1, 1, 4),
(2, 1, 4),
(3, 1, 4),
(4, 1, 4), 
(5, 1, 4),

(1, 1, 5),
(2, 1, 5),
(3, 1, 5),
(4, 1, 5), 
(5, 1, 5); -- 100

INSERT INTO shows ([show_datetime], [hall_id], [film_id]) VALUES

--Hall: 1 
('2019-06-01 12:00:00', 1, 1),
('2019-06-01 15:00:00', 1, 2),
('2019-06-01 18:00:00', 1, 3),
('2019-06-01 21:00:00', 1, 4),

('2019-06-02 12:00:00', 1, 5),
('2019-06-02 15:00:00', 1, 6),
('2019-06-02 18:00:00', 1, 7),
('2019-06-02 21:00:00', 1, 8),

('2019-06-03 12:00:00', 1, 9),
('2019-06-03 15:00:00', 1, 10),
('2019-06-03 18:00:00', 1, 11),
('2019-06-03 21:00:00', 1, 12),

('2019-06-04 12:00:00', 1, 13),
('2019-06-04 15:00:00', 1, 14),
('2019-06-04 18:00:00', 1, 15),
('2019-06-04 21:00:00', 1, 16),

('2019-06-05 12:00:00', 1, 17),
('2019-06-05 15:00:00', 1, 18),
('2019-06-05 18:00:00', 1, 19),
('2019-06-05 21:00:00', 1, 20),

('2019-06-06 12:00:00', 1, 21),
('2019-06-06 15:00:00', 1, 22),
('2019-06-06 18:00:00', 1, 23),
('2019-06-06 21:00:00', 1, 24),

('2019-06-07 12:00:00', 1, 25),
('2019-06-07 15:00:00', 1, 26),
('2019-06-07 18:00:00', 1, 27),
('2019-06-07 21:00:00', 1, 28),

('2019-06-08 12:00:00', 1, 29),
('2019-06-08 15:00:00', 1, 30),
('2019-06-08 18:00:00', 1, 31),
('2019-06-08 21:00:00', 1, 32),

('2019-06-09 12:00:00', 1, 33),
('2019-06-09 15:00:00', 1, 34),
('2019-06-09 18:00:00', 1, 1),
('2019-06-09 21:00:00', 1, 2),

('2019-06-09 12:00:00', 1, 3),
('2019-06-09 15:00:00', 1, 4),
('2019-06-09 18:00:00', 1, 5),
('2019-06-09 21:00:00', 1, 6),

('2019-06-10 12:00:00', 1, 7),
('2019-06-10 15:00:00', 1, 8),
('2019-06-10 18:00:00', 1, 9),
('2019-06-10 21:00:00', 1, 10),

('2019-06-11 12:00:00', 1, 11),
('2019-06-11 15:00:00', 1, 12),
('2019-06-11 18:00:00', 1, 13),
('2019-06-11 21:00:00', 1, 14),

('2019-06-12 12:00:00', 1, 15),
('2019-06-12 15:00:00', 1, 16),
('2019-06-12 18:00:00', 1, 17),
('2019-06-12 21:00:00', 1, 18),

('2019-06-13 12:00:00', 1, 19),
('2019-06-13 15:00:00', 1, 20),
('2019-06-13 18:00:00', 1, 21),
('2019-06-13 21:00:00', 1, 22),

('2019-06-14 12:00:00', 1, 23),
('2019-06-14 15:00:00', 1, 24),
('2019-06-14 18:00:00', 1, 25),
('2019-06-14 21:00:00', 1, 26),

('2019-06-15 12:00:00', 1, 27),
('2019-06-15 15:00:00', 1, 28),
('2019-06-15 18:00:00', 1, 29),
('2019-06-15 21:00:00', 1, 30),

('2019-06-16 12:00:00', 1, 31),
('2019-06-16 15:00:00', 1, 32),
('2019-06-16 18:00:00', 1, 33),
('2019-06-16 21:00:00', 1, 34),

('2019-06-17 12:00:00', 1, 1),
('2019-06-17 15:00:00', 1, 2),
('2019-06-17 18:00:00', 1, 3),
('2019-06-17 21:00:00', 1, 4),

('2019-06-18 12:00:00', 1, 5),
('2019-06-18 15:00:00', 1, 6),
('2019-06-18 18:00:00', 1, 7),
('2019-06-18 21:00:00', 1, 8),

('2019-06-19 12:00:00', 1, 9),
('2019-06-19 15:00:00', 1, 10),
('2019-06-19 18:00:00', 1, 11),
('2019-06-19 21:00:00', 1, 12),

('2019-06-20 12:00:00', 1, 13),
('2019-06-20 15:00:00', 1, 14),
('2019-06-20 18:00:00', 1, 15),
('2019-06-20 21:00:00', 1, 16),

('2019-06-21 12:00:00', 1, 17),
('2019-06-21 15:00:00', 1, 18),
('2019-06-21 18:00:00', 1, 19),
('2019-06-21 21:00:00', 1, 20),

('2019-06-22 12:00:00', 1, 21),
('2019-06-22 15:00:00', 1, 22),
('2019-06-22 18:00:00', 1, 23),
('2019-06-22 21:00:00', 1, 24),

('2019-06-23 12:00:00', 1, 25),
('2019-06-23 15:00:00', 1, 26),
('2019-06-23 18:00:00', 1, 27),
('2019-06-23 21:00:00', 1, 28),

('2019-06-24 12:00:00', 1, 29),
('2019-06-24 15:00:00', 1, 30),
('2019-06-24 18:00:00', 1, 31),
('2019-06-24 21:00:00', 1, 32),

('2019-06-25 12:00:00', 1, 33),
('2019-06-25 15:00:00', 1, 34),
('2019-06-25 18:00:00', 1, 1),
('2019-06-25 21:00:00', 1, 2),

('2019-06-26 12:00:00', 1, 3),
('2019-06-26 15:00:00', 1, 4),
('2019-06-26 18:00:00', 1, 5),
('2019-06-26 21:00:00', 1, 6),

('2019-06-27 12:00:00', 1, 7),
('2019-06-27 15:00:00', 1, 8),
('2019-06-27 18:00:00', 1, 9),
('2019-06-27 21:00:00', 1, 10),

('2019-06-28 12:00:00', 1, 11),
('2019-06-28 15:00:00', 1, 12),
('2019-06-28 18:00:00', 1, 13),
('2019-06-28 21:00:00', 1, 14),

('2019-06-29 12:00:00', 1, 15),
('2019-06-29 15:00:00', 1, 16),
('2019-06-29 18:00:00', 1, 17),
('2019-06-29 21:00:00', 1, 18),

('2019-06-30 12:00:00', 1, 18),
('2019-06-30 15:00:00', 1, 20),
('2019-06-30 18:00:00', 1, 21),
('2019-06-30 21:00:00', 1, 22),
--Hall: 2
('2019-06-01 12:00:00', 2, 1),
('2019-06-01 15:00:00', 2, 2),
('2019-06-01 18:00:00', 2, 3),
('2019-06-01 21:00:00', 2, 4),

('2019-06-02 12:00:00', 2, 5),
('2019-06-02 15:00:00', 2, 6),
('2019-06-02 18:00:00', 2, 7),
('2019-06-02 21:00:00', 2, 8),

('2019-06-03 12:00:00', 2, 9),
('2019-06-03 15:00:00', 2, 10),
('2019-06-03 18:00:00', 2, 11),
('2019-06-03 21:00:00', 2, 12),

('2019-06-04 12:00:00', 2, 13),
('2019-06-04 15:00:00', 2, 14),
('2019-06-04 18:00:00', 2, 15),
('2019-06-04 21:00:00', 2, 16),

('2019-06-05 12:00:00', 2, 17),
('2019-06-05 15:00:00', 2, 18),
('2019-06-05 18:00:00', 2, 19),
('2019-06-05 21:00:00', 2, 20),

('2019-06-06 12:00:00', 2, 21),
('2019-06-06 15:00:00', 2, 22),
('2019-06-06 18:00:00', 2, 23),
('2019-06-06 21:00:00', 2, 24),

('2019-06-07 12:00:00', 2, 25),
('2019-06-07 15:00:00', 2, 26),
('2019-06-07 18:00:00', 2, 27),
('2019-06-07 21:00:00', 2, 28),

('2019-06-08 12:00:00', 2, 29),
('2019-06-08 15:00:00', 2, 30),
('2019-06-08 18:00:00', 2, 31),
('2019-06-08 21:00:00', 2, 32),

('2019-06-09 12:00:00', 2, 33),
('2019-06-09 15:00:00', 2, 34),
('2019-06-09 18:00:00', 2, 1),
('2019-06-09 21:00:00', 2, 2),

('2019-06-09 12:00:00', 2, 3),
('2019-06-09 15:00:00', 2, 4),
('2019-06-09 18:00:00', 2, 5),
('2019-06-09 21:00:00', 2, 6),

('2019-06-10 12:00:00', 2, 7),
('2019-06-10 15:00:00', 2, 8),
('2019-06-10 18:00:00', 2, 9),
('2019-06-10 21:00:00', 2, 10),

('2019-06-11 12:00:00', 2, 11),
('2019-06-11 15:00:00', 2, 12),
('2019-06-11 18:00:00', 2, 13),
('2019-06-11 21:00:00', 2, 14),

('2019-06-12 12:00:00', 2, 15),
('2019-06-12 15:00:00', 2, 16),
('2019-06-12 18:00:00', 2, 17),
('2019-06-12 21:00:00', 2, 18),

('2019-06-13 12:00:00', 2, 19),
('2019-06-13 15:00:00', 2, 20),
('2019-06-13 18:00:00', 2, 21),
('2019-06-13 21:00:00', 2, 22),

('2019-06-14 12:00:00', 2, 23),
('2019-06-14 15:00:00', 2, 24),
('2019-06-14 18:00:00', 2, 25),
('2019-06-14 21:00:00', 2, 26),

('2019-06-15 12:00:00', 2, 27),
('2019-06-15 15:00:00', 2, 28),
('2019-06-15 18:00:00', 2, 29),
('2019-06-15 21:00:00', 2, 30),

('2019-06-16 12:00:00', 2, 31),
('2019-06-16 15:00:00', 2, 32),
('2019-06-16 18:00:00', 2, 33),
('2019-06-16 21:00:00', 2, 34),

('2019-06-17 12:00:00', 2, 1),
('2019-06-17 15:00:00', 2, 2),
('2019-06-17 18:00:00', 2, 3),
('2019-06-17 21:00:00', 2, 4),

('2019-06-18 12:00:00', 2, 5),
('2019-06-18 15:00:00', 2, 6),
('2019-06-18 18:00:00', 2, 7),
('2019-06-18 21:00:00', 2, 8),

('2019-06-19 12:00:00', 2, 9),
('2019-06-19 15:00:00', 2, 10),
('2019-06-19 18:00:00', 2, 11),
('2019-06-19 21:00:00', 2, 12),

('2019-06-20 12:00:00', 2, 13),
('2019-06-20 15:00:00', 2, 14),
('2019-06-20 18:00:00', 2, 15),
('2019-06-20 21:00:00', 2, 16),

('2019-06-21 12:00:00', 2, 17),
('2019-06-21 15:00:00', 2, 18),
('2019-06-21 18:00:00', 2, 19),
('2019-06-21 21:00:00', 2, 20),

('2019-06-22 12:00:00', 2, 21),
('2019-06-22 15:00:00', 2, 22),
('2019-06-22 18:00:00', 2, 23),
('2019-06-22 21:00:00', 2, 24),

('2019-06-23 12:00:00', 2, 25),
('2019-06-23 15:00:00', 2, 26),
('2019-06-23 18:00:00', 2, 27),
('2019-06-23 21:00:00', 2, 28),

('2019-06-24 12:00:00', 2, 29),
('2019-06-24 15:00:00', 2, 30),
('2019-06-24 18:00:00', 2, 31),
('2019-06-24 21:00:00', 2, 32),

('2019-06-25 12:00:00', 2, 33),
('2019-06-25 15:00:00', 2, 34),
('2019-06-25 18:00:00', 2, 1),
('2019-06-25 21:00:00', 2, 2),

('2019-06-26 12:00:00', 2, 3),
('2019-06-26 15:00:00', 2, 4),
('2019-06-26 18:00:00', 2, 5),
('2019-06-26 21:00:00', 2, 6),

('2019-06-27 12:00:00', 2, 7),
('2019-06-27 15:00:00', 2, 8),
('2019-06-27 18:00:00', 2, 9),
('2019-06-27 21:00:00', 2, 10),

('2019-06-28 12:00:00', 2, 11),
('2019-06-28 15:00:00', 2, 12),
('2019-06-28 18:00:00', 2, 13),
('2019-06-28 21:00:00', 2, 14),

('2019-06-29 12:00:00', 2, 15),
('2019-06-29 15:00:00', 2, 16),
('2019-06-29 18:00:00', 2, 17),
('2019-06-29 21:00:00', 2, 18),

('2019-06-30 12:00:00', 2, 18),
('2019-06-30 15:00:00', 2, 20),
('2019-06-30 18:00:00', 2, 21),
('2019-06-30 21:00:00', 2, 22),
--Hall: 3
('2019-06-01 12:00:00', 3, 1),
('2019-06-01 15:00:00', 3, 2),
('2019-06-01 18:00:00', 3, 3),
('2019-06-01 21:00:00', 3, 4),

('2019-06-02 12:00:00', 3, 5),
('2019-06-02 15:00:00', 3, 6),
('2019-06-02 18:00:00', 3, 7),
('2019-06-02 21:00:00', 3, 8),

('2019-06-03 12:00:00', 3, 9),
('2019-06-03 15:00:00', 3, 10),
('2019-06-03 18:00:00', 3, 11),
('2019-06-03 21:00:00', 3, 12),

('2019-06-04 12:00:00', 3, 13),
('2019-06-04 15:00:00', 3, 14),
('2019-06-04 18:00:00', 3, 15),
('2019-06-04 21:00:00', 3, 16),

('2019-06-05 12:00:00', 3, 17),
('2019-06-05 15:00:00', 3, 18),
('2019-06-05 18:00:00', 3, 19),
('2019-06-05 21:00:00', 3, 20),

('2019-06-06 12:00:00', 3, 21),
('2019-06-06 15:00:00', 3, 22),
('2019-06-06 18:00:00', 3, 23),
('2019-06-06 21:00:00', 3, 24),

('2019-06-07 12:00:00', 3, 25),
('2019-06-07 15:00:00', 3, 26),
('2019-06-07 18:00:00', 3, 27),
('2019-06-07 21:00:00', 3, 28),

('2019-06-08 12:00:00', 3, 29),
('2019-06-08 15:00:00', 3, 30),
('2019-06-08 18:00:00', 3, 31),
('2019-06-08 21:00:00', 3, 32),

('2019-06-09 12:00:00', 3, 33),
('2019-06-09 15:00:00', 3, 34),
('2019-06-09 18:00:00', 3, 1),
('2019-06-09 21:00:00', 3, 2),

('2019-06-09 12:00:00', 3, 3),
('2019-06-09 15:00:00', 3, 4),
('2019-06-09 18:00:00', 3, 5),
('2019-06-09 21:00:00', 3, 6),

('2019-06-10 12:00:00', 3, 7),
('2019-06-10 15:00:00', 3, 8),
('2019-06-10 18:00:00', 3, 9),
('2019-06-10 21:00:00', 3, 10),

('2019-06-11 12:00:00', 3, 11),
('2019-06-11 15:00:00', 3, 12),
('2019-06-11 18:00:00', 3, 13),
('2019-06-11 21:00:00', 3, 14),

('2019-06-12 12:00:00', 3, 15),
('2019-06-12 15:00:00', 3, 16),
('2019-06-12 18:00:00', 3, 17),
('2019-06-12 21:00:00', 3, 18),

('2019-06-13 12:00:00', 3, 19),
('2019-06-13 15:00:00', 3, 20),
('2019-06-13 18:00:00', 3, 21),
('2019-06-13 21:00:00', 3, 22),

('2019-06-14 12:00:00', 3, 23),
('2019-06-14 15:00:00', 3, 24),
('2019-06-14 18:00:00', 3, 25),
('2019-06-14 21:00:00', 3, 26),

('2019-06-15 12:00:00', 3, 27),
('2019-06-15 15:00:00', 3, 28),
('2019-06-15 18:00:00', 3, 29),
('2019-06-15 21:00:00', 3, 30),

('2019-06-16 12:00:00', 3, 31),
('2019-06-16 15:00:00', 3, 32),
('2019-06-16 18:00:00', 3, 33),
('2019-06-16 21:00:00', 3, 34),

('2019-06-17 12:00:00', 3, 1),
('2019-06-17 15:00:00', 3, 2),
('2019-06-17 18:00:00', 3, 3),
('2019-06-17 21:00:00', 3, 4),

('2019-06-18 12:00:00', 3, 5),
('2019-06-18 15:00:00', 3, 6),
('2019-06-18 18:00:00', 3, 7),
('2019-06-18 21:00:00', 3, 8),

('2019-06-19 12:00:00', 3, 9),
('2019-06-19 15:00:00', 3, 10),
('2019-06-19 18:00:00', 3, 11),
('2019-06-19 21:00:00', 3, 12),

('2019-06-20 12:00:00', 3, 13),
('2019-06-20 15:00:00', 3, 14),
('2019-06-20 18:00:00', 3, 15),
('2019-06-20 21:00:00', 3, 16),

('2019-06-21 12:00:00', 3, 17),
('2019-06-21 15:00:00', 3, 18),
('2019-06-21 18:00:00', 3, 19),
('2019-06-21 21:00:00', 3, 20),

('2019-06-22 12:00:00', 3, 21),
('2019-06-22 15:00:00', 3, 22),
('2019-06-22 18:00:00', 3, 23),
('2019-06-22 21:00:00', 3, 24),

('2019-06-23 12:00:00', 3, 25),
('2019-06-23 15:00:00', 3, 26),
('2019-06-23 18:00:00', 3, 27),
('2019-06-23 21:00:00', 3, 28),

('2019-06-24 12:00:00', 3, 29),
('2019-06-24 15:00:00', 3, 30),
('2019-06-24 18:00:00', 3, 31),
('2019-06-24 21:00:00', 3, 32),

('2019-06-25 12:00:00', 3, 33),
('2019-06-25 15:00:00', 3, 34),
('2019-06-25 18:00:00', 3, 1),
('2019-06-25 21:00:00', 3, 2),

('2019-06-26 12:00:00', 3, 3),
('2019-06-26 15:00:00', 3, 4),
('2019-06-26 18:00:00', 3, 5),
('2019-06-26 21:00:00', 3, 6),

('2019-06-27 12:00:00', 3, 7),
('2019-06-27 15:00:00', 3, 8),
('2019-06-27 18:00:00', 3, 9),
('2019-06-27 21:00:00', 3, 10),

('2019-06-28 12:00:00', 3, 11),
('2019-06-28 15:00:00', 3, 12),
('2019-06-28 18:00:00', 3, 13),
('2019-06-28 21:00:00', 3, 14),

('2019-06-29 12:00:00', 3, 15),
('2019-06-29 15:00:00', 3, 16),
('2019-06-29 18:00:00', 3, 17),
('2019-06-29 21:00:00', 3, 18),

('2019-06-30 12:00:00', 3, 18),
('2019-06-30 15:00:00', 3, 20),
('2019-06-30 18:00:00', 3, 21),
('2019-06-30 21:00:00', 3, 22),
--Hall: 4
('2019-06-01 12:00:00', 4, 1),
('2019-06-01 15:00:00', 4, 2),
('2019-06-01 18:00:00', 4, 3),
('2019-06-01 21:00:00', 4, 4),

('2019-06-02 12:00:00', 4, 5),
('2019-06-02 15:00:00', 4, 6),
('2019-06-02 18:00:00', 4, 7),
('2019-06-02 21:00:00', 4, 8),

('2019-06-03 12:00:00', 4, 9),
('2019-06-03 15:00:00', 4, 10),
('2019-06-03 18:00:00', 4, 11),
('2019-06-03 21:00:00', 4, 12),

('2019-06-04 12:00:00', 4, 13),
('2019-06-04 15:00:00', 4, 14),
('2019-06-04 18:00:00', 4, 15),
('2019-06-04 21:00:00', 4, 16),

('2019-06-05 12:00:00', 4, 17),
('2019-06-05 15:00:00', 4, 18),
('2019-06-05 18:00:00', 4, 19),
('2019-06-05 21:00:00', 4, 20),

('2019-06-06 12:00:00', 4, 21),
('2019-06-06 15:00:00', 4, 22),
('2019-06-06 18:00:00', 4, 23),
('2019-06-06 21:00:00', 4, 24),

('2019-06-07 12:00:00', 4, 25),
('2019-06-07 15:00:00', 4, 26),
('2019-06-07 18:00:00', 4, 27),
('2019-06-07 21:00:00', 4, 28),

('2019-06-08 12:00:00', 4, 29),
('2019-06-08 15:00:00', 4, 30),
('2019-06-08 18:00:00', 4, 31),
('2019-06-08 21:00:00', 4, 32),

('2019-06-09 12:00:00', 4, 33),
('2019-06-09 15:00:00', 4, 34),
('2019-06-09 18:00:00', 4, 1),
('2019-06-09 21:00:00', 4, 2),

('2019-06-09 12:00:00', 4, 3),
('2019-06-09 15:00:00', 4, 4),
('2019-06-09 18:00:00', 4, 5),
('2019-06-09 21:00:00', 4, 6),

('2019-06-10 12:00:00', 4, 7),
('2019-06-10 15:00:00', 4, 8),
('2019-06-10 18:00:00', 4, 9),
('2019-06-10 21:00:00', 4, 10),

('2019-06-11 12:00:00', 4, 11),
('2019-06-11 15:00:00', 4, 12),
('2019-06-11 18:00:00', 4, 13),
('2019-06-11 21:00:00', 4, 14),

('2019-06-12 12:00:00', 4, 15),
('2019-06-12 15:00:00', 4, 16),
('2019-06-12 18:00:00', 4, 17),
('2019-06-12 21:00:00', 4, 18),

('2019-06-13 12:00:00', 4, 19),
('2019-06-13 15:00:00', 4, 20),
('2019-06-13 18:00:00', 4, 21),
('2019-06-13 21:00:00', 4, 22),

('2019-06-14 12:00:00', 4, 23),
('2019-06-14 15:00:00', 4, 24),
('2019-06-14 18:00:00', 4, 25),
('2019-06-14 21:00:00', 4, 26),

('2019-06-15 12:00:00', 4, 27),
('2019-06-15 15:00:00', 4, 28),
('2019-06-15 18:00:00', 4, 29),
('2019-06-15 21:00:00', 4, 30),

('2019-06-16 12:00:00', 4, 31),
('2019-06-16 15:00:00', 4, 32),
('2019-06-16 18:00:00', 4, 33),
('2019-06-16 21:00:00', 4, 34),

('2019-06-17 12:00:00', 4, 1),
('2019-06-17 15:00:00', 4, 2),
('2019-06-17 18:00:00', 4, 3),
('2019-06-17 21:00:00', 4, 4),

('2019-06-18 12:00:00', 4, 5),
('2019-06-18 15:00:00', 4, 6),
('2019-06-18 18:00:00', 4, 7),
('2019-06-18 21:00:00', 4, 8),

('2019-06-19 12:00:00', 4, 9),
('2019-06-19 15:00:00', 4, 10),
('2019-06-19 18:00:00', 4, 11),
('2019-06-19 21:00:00', 4, 12),

('2019-06-20 12:00:00', 4, 13),
('2019-06-20 15:00:00', 4, 14),
('2019-06-20 18:00:00', 4, 15),
('2019-06-20 21:00:00', 4, 16),

('2019-06-21 12:00:00', 4, 17),
('2019-06-21 15:00:00', 4, 18),
('2019-06-21 18:00:00', 4, 19),
('2019-06-21 21:00:00', 4, 20),

('2019-06-22 12:00:00', 4, 21),
('2019-06-22 15:00:00', 4, 22),
('2019-06-22 18:00:00', 4, 23),
('2019-06-22 21:00:00', 4, 24),

('2019-06-23 12:00:00', 4, 25),
('2019-06-23 15:00:00', 4, 26),
('2019-06-23 18:00:00', 4, 27),
('2019-06-23 21:00:00', 4, 28),

('2019-06-24 12:00:00', 4, 29),
('2019-06-24 15:00:00', 4, 30),
('2019-06-24 18:00:00', 4, 31),
('2019-06-24 21:00:00', 4, 32),

('2019-06-25 12:00:00', 4, 33),
('2019-06-25 15:00:00', 4, 34),
('2019-06-25 18:00:00', 4, 1),
('2019-06-25 21:00:00', 4, 2),

('2019-06-26 12:00:00', 4, 3),
('2019-06-26 15:00:00', 4, 4),
('2019-06-26 18:00:00', 4, 5),
('2019-06-26 21:00:00', 4, 6),

('2019-06-27 12:00:00', 4, 7),
('2019-06-27 15:00:00', 4, 8),
('2019-06-27 18:00:00', 4, 9),
('2019-06-27 21:00:00', 4, 10),

('2019-06-28 12:00:00', 4, 11),
('2019-06-28 15:00:00', 4, 12),
('2019-06-28 18:00:00', 4, 13),
('2019-06-28 21:00:00', 4, 14),

('2019-06-29 12:00:00', 4, 15),
('2019-06-29 15:00:00', 4, 16),
('2019-06-29 18:00:00', 4, 17),
('2019-06-29 21:00:00', 4, 18),

('2019-06-30 12:00:00', 4, 18),
('2019-06-30 15:00:00', 4, 20),
('2019-06-30 18:00:00', 4, 21),
('2019-06-30 21:00:00', 4, 22),
--Hall: 5
('2019-06-01 12:00:00', 5, 1),
('2019-06-01 15:00:00', 5, 2),
('2019-06-01 18:00:00', 5, 3),
('2019-06-01 21:00:00', 5, 4),

('2019-06-02 12:00:00', 5, 5),
('2019-06-02 15:00:00', 5, 6),
('2019-06-02 18:00:00', 5, 7),
('2019-06-02 21:00:00', 5, 8),

('2019-06-03 12:00:00', 5, 9),
('2019-06-03 15:00:00', 5, 10),
('2019-06-03 18:00:00', 5, 11),
('2019-06-03 21:00:00', 5, 12),

('2019-06-04 12:00:00', 5, 13),
('2019-06-04 15:00:00', 5, 14),
('2019-06-04 18:00:00', 5, 15),
('2019-06-04 21:00:00', 5, 16),

('2019-06-05 12:00:00', 5, 17),
('2019-06-05 15:00:00', 5, 18),
('2019-06-05 18:00:00', 5, 19),
('2019-06-05 21:00:00', 5, 20),

('2019-06-06 12:00:00', 5, 21),
('2019-06-06 15:00:00', 5, 22),
('2019-06-06 18:00:00', 5, 23),
('2019-06-06 21:00:00', 5, 24),

('2019-06-07 12:00:00', 5, 25),
('2019-06-07 15:00:00', 5, 26),
('2019-06-07 18:00:00', 5, 27),
('2019-06-07 21:00:00', 5, 28),

('2019-06-08 12:00:00', 5, 29),
('2019-06-08 15:00:00', 5, 30),
('2019-06-08 18:00:00', 5, 31),
('2019-06-08 21:00:00', 5, 32),

('2019-06-09 12:00:00', 5, 33),
('2019-06-09 15:00:00', 5, 34),
('2019-06-09 18:00:00', 5, 1),
('2019-06-09 21:00:00', 5, 2),

('2019-06-09 12:00:00', 5, 3),
('2019-06-09 15:00:00', 5, 4),
('2019-06-09 18:00:00', 5, 5),
('2019-06-09 21:00:00', 5, 6),

('2019-06-10 12:00:00', 5, 7),
('2019-06-10 15:00:00', 5, 8),
('2019-06-10 18:00:00', 5, 9),
('2019-06-10 21:00:00', 5, 10),

('2019-06-11 12:00:00', 5, 11),
('2019-06-11 15:00:00', 5, 12),
('2019-06-11 18:00:00', 5, 13),
('2019-06-11 21:00:00', 5, 14),

('2019-06-12 12:00:00', 5, 15),
('2019-06-12 15:00:00', 5, 16),
('2019-06-12 18:00:00', 5, 17),
('2019-06-12 21:00:00', 5, 18),

('2019-06-13 12:00:00', 5, 19),
('2019-06-13 15:00:00', 5, 20),
('2019-06-13 18:00:00', 5, 21),
('2019-06-13 21:00:00', 5, 22),

('2019-06-14 12:00:00', 5, 23),
('2019-06-14 15:00:00', 5, 24),
('2019-06-14 18:00:00', 5, 25),
('2019-06-14 21:00:00', 5, 26),

('2019-06-15 12:00:00', 5, 27),
('2019-06-15 15:00:00', 5, 28),
('2019-06-15 18:00:00', 5, 29),
('2019-06-15 21:00:00', 5, 30),

('2019-06-16 12:00:00', 5, 31),
('2019-06-16 15:00:00', 5, 32),
('2019-06-16 18:00:00', 5, 33),
('2019-06-16 21:00:00', 5, 34),

('2019-06-17 12:00:00', 5, 1),
('2019-06-17 15:00:00', 5, 2),
('2019-06-17 18:00:00', 5, 3),
('2019-06-17 21:00:00', 5, 4),

('2019-06-18 12:00:00', 5, 5),
('2019-06-18 15:00:00', 5, 6),
('2019-06-18 18:00:00', 5, 7),
('2019-06-18 21:00:00', 5, 8),

('2019-06-19 12:00:00', 5, 9),
('2019-06-19 15:00:00', 5, 10),
('2019-06-19 18:00:00', 5, 11),
('2019-06-19 21:00:00', 5, 12),

('2019-06-20 12:00:00', 5, 13),
('2019-06-20 15:00:00', 5, 14),
('2019-06-20 18:00:00', 5, 15),
('2019-06-20 21:00:00', 5, 16),

('2019-06-21 12:00:00', 5, 17),
('2019-06-21 15:00:00', 5, 18),
('2019-06-21 18:00:00', 5, 19),
('2019-06-21 21:00:00', 5, 20),

('2019-06-22 12:00:00', 5, 21),
('2019-06-22 15:00:00', 5, 22),
('2019-06-22 18:00:00', 5, 23),
('2019-06-22 21:00:00', 5, 24),

('2019-06-23 12:00:00', 5, 25),
('2019-06-23 15:00:00', 5, 26),
('2019-06-23 18:00:00', 5, 27),
('2019-06-23 21:00:00', 5, 28),

('2019-06-24 12:00:00', 5, 29),
('2019-06-24 15:00:00', 5, 30),
('2019-06-24 18:00:00', 5, 31),
('2019-06-24 21:00:00', 5, 32),

('2019-06-25 12:00:00', 5, 33),
('2019-06-25 15:00:00', 5, 34),
('2019-06-25 18:00:00', 5, 1),
('2019-06-25 21:00:00', 5, 2),

('2019-06-26 12:00:00', 5, 3),
('2019-06-26 15:00:00', 5, 4),
('2019-06-26 18:00:00', 5, 5),
('2019-06-26 21:00:00', 5, 6),

('2019-06-27 12:00:00', 5, 7),
('2019-06-27 15:00:00', 5, 8),
('2019-06-27 18:00:00', 5, 9),
('2019-06-27 21:00:00', 5, 10),

('2019-06-28 12:00:00', 5, 11),
('2019-06-28 15:00:00', 5, 12),
('2019-06-28 18:00:00', 5, 13),
('2019-06-28 21:00:00', 5, 14),

('2019-06-29 12:00:00', 5, 15),
('2019-06-29 15:00:00', 5, 16),
('2019-06-29 18:00:00', 5, 17),
('2019-06-29 21:00:00', 5, 18),

('2019-06-30 12:00:00', 5, 18),
('2019-06-30 15:00:00', 5, 20),
('2019-06-30 18:00:00', 5, 21),
('2019-06-30 21:00:00', 5, 22);

INSERT INTO reservation ([customer_id], [show_id], [employee_id], [reservation_datetime]) VALUES
(1, 1, 10, '2018-05-12 13:55:00'),
(2, 1, 2, '2019-05-12 12:00:00'),
(3, 3, 3, '2019-05-12 15:12:00'),
(4, 1, 7, '2019-05-14 22:45:00'),
(5, 2, 2, '2019-05-14 12:00:00'),
(6, 7, 3, '2019-05-14 18:12:00'),
(7, 5, 1, '2019-05-14 13:55:00'),
(8, 6, 2, '2019-05-15 18:45:00'),
(9, 20, 7, '2019-05-17 03:12:00'),
(10, 5, 3, '2019-05-17 21:00:00'),
(11, 2, 10, '2019-05-21 13:39:00'),
(12, 4, 3, '2019-05-21 11:55:00'),
(13, 8, 10, '2019-05-21 03:34:00'),
(14, 13, 2, '2019-05-21 15:00:00'),
(15, 12, 5, '2019-05-23 16:00:00'),
(16, 19, 10, '2019-05-23 14:12:00'),
(17, 14, 2, '2019-05-23 05:45:00'),
(18, 15, 5, '2019-05-24 12:00:00'),
(19, 2, 1, '2019-05-24 03:00:00'),
(20, 7, 2, '2019-05-24 13:55:00'),
(21, 10, 1, '2019-05-24 03:00:00'),
(22, 4, 3, '2019-05-24 15:45:00'),
(23, 10, 1, '2019-05-25 16:00:00'),
(24, 13, 1, '2019-05-25 03:12:00'),
(25, 16, 7, '2019-05-25 23:45:00'),
(26, 11, 1, '2018-05-26 16:45:00'),
(27, 20, 4, '2019-05-26 17:00:00'),
(28, 12, 3, '2019-05-26 17:15:00'),
(29, 18, 5, '2019-05-26 03:00:00'),
(30, 15, 2, '2019-05-27 03:15:00'),
(31, 13, 4, '2019-05-27 05:43:00'),
(32, 15, 8, '2019-05-28 01:15:00'),
(33, 17, 2, '2019-05-28 05:00:00'),
(34, 14, 7, '2019-05-28 07:00:00'),
(35, 15, 3, '2019-05-28 03:45:00'),
(36, 2, 10, '2019-05-28 00:00:00'),
(37, 12, 3, '2019-05-28 13:15:00'),
(38, 12, 10, '2019-05-28 03:00:00'),
(39, 13, 7, '2019-05-29 03:15:00'),
(40, 12, 5, '2019-05-29 14:00:00'),
(41, 20, 6, '2019-05-29 21:44:00'),
(42, 13, 1, '2019-05-29 05:15:00'),
(43, 3, 5, '2019-05-29 15:00:00'),
(44, 12, 1, '2019-05-29 03:00:00'),
(45, 5, 8, '2019-05-30 03:45:00'),
(46, 9, 1, '2019-05-31 11:15:00'),
(47, 14, 3, '2019-05-31 09:00:00'),
(48, 17, 5, '2019-05-31 19:13:00'),
(49, 3, 1, '2019-05-31 03:45:00'),
(50, 16, 7, '2019-05-31 22:00:00');

INSERT INTO tickets ([seat_id], [ticket_price], [show_id], [reservation_id]) VALUES
(1, 10, 1, 1),
(2, 10, 1, 2),
(3, 10, 1, 3),
(4, 10, 1, 4),
(5, 10, 1, 5),
(6, 15, 2, 6),
(7, 15, 2, 7),
(8, 20, 3, 8),
(9, 20, 3, 9),
(10, 30, 3, 10),
(11, 40, 3, 11),
(12, 30, 3, 12),
(13, 10, 3, 13),
(14, 50, 3, 14),
(15, 45, 3, 15),
(16, 25, 3, 16),
(17, 30, 3, 17),
(18, 5, 3, 18),
(19, 20, 3, 19),
(20, 25, 3, 20),
(21, 30, 3, 21),
(22, 15, 3, 22),
(23, 25, 3, 23),
(24, 30, 3, 24),
(25, 15, 3, 25),
(26, 10, 1, 26),
(27, 10, 1, 27),
(28, 10, 1, 28),
(29, 10, 1, 29),
(30, 10, 1, 30),
(31, 15, 2, 31),
(32, 15, 2, 32),
(33, 20, 3, 33),
(34, 20, 3, 34),
(35, 30, 3, 35),
(36, 40, 3, 36),
(37, 30, 3, 37),
(38, 10, 3, 38),
(39, 50, 3, 39),
(40, 45, 3, 40),
(41, 25, 3, 41),
(42, 30, 3, 42),
(43, 5, 3, 43),
(44, 20, 3, 44),
(45, 25, 3, 45),
(46, 30, 3, 46),
(47, 15, 3, 47),
(48, 25, 3, 48),
(49, 30, 3, 49),
(50, 15, 3, 50); -- 50
