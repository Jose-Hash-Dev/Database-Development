--All Halls Report:
Select * from halls 
LEFT JOIN shows ON halls.hall_id = shows.hall_id 
LEFT JOIN films ON shows.film_id = films.film_id;

--Single Hall Report:
Select * from halls 
LEFT JOIN shows ON halls.hall_id = shows.hall_id 
LEFT JOIN films ON shows.film_id = films.film_id WHERE halls.hall_id = 1;

--All Shows Report:
Select * from shows 
LEFT JOIN films ON shows.film_id = films.film_id 
LEFT JOIN halls ON halls.hall_id = shows.hall_id;

--Single Shows Report:
Select * from shows 
LEFT JOIN films ON shows.film_id = films.film_id 
LEFT JOIN halls ON halls.hall_id = shows.hall_id WHERE shows.show_id = 1;

--All Films Report (Show and Halls Wise):
Select * from films LEFT JOIN countries ON films.country_id = countries.country_id 
LEFT JOIN languages ON films.language_id = languages.language_id 
LEFT JOIN shows ON films.film_id = shows.film_id 
LEFT JOIN halls ON halls.hall_id = shows.hall_id;

--All Films Report (Category and Film Detail Wise):
Select * from films 
LEFT JOIN countries ON films.country_id = countries.country_id 
LEFT JOIN languages ON films.language_id = languages.language_id 
LEFT JOIN categories ON films.category_id = categories.category_id 
LEFT JOIN film_details ON films.film_id = film_details.film_id;

--Single Film Report:
Select * from films 
LEFT JOIN countries ON films.country_id = countries.country_id LEFT JOIN languages ON films.language_id = languages.language_id 
LEFT JOIN shows ON films.film_id = shows.film_id LEFT JOIN halls ON halls.hall_id = shows.hall_id WHERE films.film_id = 1;

--Show Wise Report (In Time Period):
Select * from shows LEFT JOIN films ON shows.film_id = films.film_id 
LEFT JOIN halls ON halls.hall_id = shows.hall_id WHERE shows.show_datetime >= '2019-06-01 00:00:00' and shows.show_datetime <= '2019-06-02 12:00:00'

--Show Count Report (In Time Period):
Select count(*) as TotalShows 
FROM (Select * FROM shows Where shows.show_datetime BETWEEN '2019-06-01 00:00:00' and '2019-06-12 12:00:00') as filtered_shows 
LEFT JOIN films ON filtered_shows.film_id = films.film_id LEFT JOIN halls ON halls.hall_id = filtered_shows.hall_id;

--Show Wise Report (For Single Film And In Time Period):
Select * from 
(Select * from shows WHERE shows.show_datetime BETWEEN '2019-06-01 00:00:00' AND '2019-06-06 12:00:00' AND shows.film_id = 1) as filtered_shows 
LEFT JOIN films ON filtered_shows.film_id = films.film_id 
LEFT JOIN halls ON halls.hall_id = filtered_shows.hall_id;

--All Customers Reservation Report (Show and Film):
Select customers.customer_name, shows.show_datetime, films.film_name, halls.hall_name, employees.employee_name as reservation_by_employee from customers 
INNER JOIN reservation ON customers.customer_id = reservation.customer_id 
LEFT JOIN shows ON reservation.show_id = shows.show_id 
LEFT JOIN films ON shows.film_id = films.film_id 
LEFT JOIN halls ON halls.hall_id = shows.hall_id 
LEFT JOIN employees ON reservation.employee_id = employees.employee_id;

--All Employees Reservation Report (Customer, Show and Film):
Select employees.employee_name, customers.customer_name, reservation.reservation_datetime, shows.show_datetime, films.film_name, halls.hall_name from employees 
INNER JOIN reservation ON employees.employee_id = reservation.employee_id 
LEFT JOIN customers ON customers.customer_id = reservation.customer_id 
LEFT JOIN shows ON reservation.show_id = shows.show_id 
LEFT JOIN films ON shows.film_id = films.film_id 
LEFT JOIN halls ON halls.hall_id = shows.hall_id;

--Tickets Sale Count For Single Show Report:
Select count(*) as TotalReservation from 
(Select shows.show_id from shows Where shows.show_id = 1) as filtered_shows 
INNER JOIN reservation ON filtered_shows.show_id = reservation.show_id

--Tickets Sale Amount Sum For Single Show Report:
Select SUM(tickets.ticket_price) as TotalSaleAmount from 
(Select shows.show_id from shows Where shows.show_id = 1) as filtered_shows 
INNER JOIN reservation ON filtered_shows.show_id = reservation.show_id 
LEFT JOIN tickets ON tickets.reservation_id = reservation.reservation_id

--Tickets Sold VS Ticket Availabe in Percentage All Shows Report:
Select films.film_name, shows.show_datetime, halls.hall_name, halls.hall_seats as TotalCapacity, 
COUNT(*) as TotalSold, (halls.hall_seats - COUNT(*)) as TotalAvailable, ((CAST(COUNT(*) AS DECIMAL(5,1))/CAST(halls.hall_seats AS DECIMAL(5,1)))*100.0) as SoldPercentage from reservation 
INNER JOIN shows ON shows.show_id = reservation.show_id 
INNER JOIN halls ON shows.hall_id = halls.hall_id 
INNER JOIN films ON shows.film_id = films.film_id GROUP BY halls.hall_seats, films.film_name, shows.show_datetime, halls.hall_name;

--Tickets Sold VS Ticket Availabe in Percentage Single Show Report:
Select films.film_name, shows.show_datetime, halls.hall_name, halls.hall_seats as TotalCapacity, 
COUNT(*) as TotalSold, (halls.hall_seats - COUNT(*)) as TotalAvailable, 
((CAST(COUNT(*) AS DECIMAL(5,1))/CAST(halls.hall_seats AS DECIMAL(5,1)))*100.0) as SoldPercentage from reservation 
INNER JOIN shows ON shows.show_id = reservation.show_id 
INNER JOIN halls ON shows.hall_id = halls.hall_id 
INNER JOIN films ON shows.film_id = films.film_id WHERE shows.show_id = 1 
GROUP BY halls.hall_seats, films.film_name, shows.show_datetime, halls.hall_name;

--Films Watched by Age Group (18-24):
Select films.film_name, shows.show_datetime from (Select * from customers where customers.customer_age BETWEEN 18 AND 24) as filtered_customers 
LEFT JOIN reservation ON reservation.customer_id = filtered_customers.customer_id 
LEFT JOIN shows ON reservation.show_id = shows.show_id 
LEFT JOIN films ON films.film_id = shows.film_id 
GROUP BY films.film_name, shows.show_datetime 
ORDER BY films.film_name;

--Films Over All Income Report:
Select films.film_name, 
SUM(tickets.ticket_price) AS filme_totlal_income, 
COUNT(tickets.ticket_id) AS totlal_tickets_sold, tickets.ticket_price from films 
LEFT JOIN shows ON shows.film_id = films.film_id 
LEFT JOIN reservation ON shows.show_id = reservation.show_id 
LEFT JOIN tickets ON reservation.reservation_id = tickets.reservation_id 
GROUP BY films.film_name, tickets.ticket_price 
ORDER BY filme_totlal_income DESC;

--Films Income Report Which Perform Better than Particular Film (e.g Film E):
Select films.film_name, 
SUM(tickets.ticket_price) AS film_totlal_income, 
COUNT(tickets.ticket_id) AS total_tickets_sold, tickets.ticket_price from films LEFT JOIN shows ON shows.film_id = films.film_id 
LEFT JOIN reservation ON shows.show_id = reservation.show_id 
LEFT JOIN tickets ON reservation.reservation_id = tickets.reservation_id 
GROUP BY films.film_name, tickets.ticket_price HAVING SUM(tickets.ticket_price) > (Select SUM(tickets.ticket_price) from films 
LEFT JOIN shows ON shows.film_id = films.film_id 
LEFT JOIN reservation ON shows.show_id = reservation.show_id 
LEFT JOIN tickets ON reservation.reservation_id = tickets.reservation_id WHERE films.film_id = 5) 
ORDER BY film_name;

--Shows Infographic Report:
Select main_show.show_datetime, films.film_name, 
(Select COUNT(customers.customer_id) from shows 
LEFT JOIN reservation ON reservation.show_id = shows.show_id 
LEFT JOIN customers ON reservation.customer_id = customers.customer_id WHERE shows.show_id = main_show.show_id) AS total_audience, 
(Select MIN(customers.customer_age) from shows LEFT JOIN reservation ON reservation.show_id = shows.show_id 
LEFT JOIN customers ON reservation.customer_id = customers.customer_id WHERE shows.show_id = main_show.show_id) AS min_age_group, 
(Select MAX(customers.customer_age) from shows LEFT JOIN reservation ON reservation.show_id = shows.show_id 
LEFT JOIN customers ON reservation.customer_id = customers.customer_id WHERE shows.show_id = main_show.show_id) AS max_age_group from shows as main_show 
LEFT JOIN films ON main_show.film_id = films.film_id ORDER BY main_show.show_datetime;

--Films Infographic Report:
Select main_film.film_name, 
(Select COUNT(customers.customer_id) from films 
LEFT JOIN shows ON shows.film_id = films.film_id 
LEFT JOIN reservation ON reservation.show_id = shows.show_id
LEFT JOIN customers ON reservation.customer_id = customers.customer_id WHERE films.film_id = main_film.film_id) AS total_audience, 
(Select MIN(customers.customer_age) from films 
LEFT JOIN shows ON shows.film_id = films.film_id 
LEFT JOIN reservation ON reservation.show_id = shows.show_id 
LEFT JOIN customers ON reservation.customer_id = customers.customer_id WHERE films.film_id = main_film.film_id) AS min_age_group, 
(Select MAX(customers.customer_age) from films LEFT JOIN shows ON shows.film_id = films.film_id 
LEFT JOIN reservation ON reservation.show_id = shows.show_id LEFT JOIN customers ON reservation.customer_id = customers.customer_id 
WHERE films.film_id = main_film.film_id) AS max_age_group from films as main_film ORDER BY main_film.film_name;


