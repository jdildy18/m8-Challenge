
-- Write a sql query to find the total rental amount paid for each film. Return film_id and total_film 

SELECT f.film_id, sum(amount) as 'total_amount'
from payment p 
join rental r 
on (p.rental_id = r.rental_id)
	join inventory i 
	on (i.inventory_id = r.inventory_id)
	join film f 
	on f.film_id = i.film_id 
	group by f.film_id;



-- Create a view called total_rental using a query from the previous step

CREATE VIEW total_rental_amount as 
SELECT f.film_id, sum(amount) as 'total_amount'
from payment p 
join rental r 
on (p.rental_id = r.rental_id)
	join inventory i 
	on (i.inventory_id = r.inventory_id)
	join film f 
	on f.film_id = i.film_id 
	group by f.film_id;

-- Write a sql query to find the total number of copies in inventory for each film. Return film_id and total_copies

SELECT film_id, count(inventory_id) as 'total_copies'
FROM inventory i 
GROUP BY film_id;


-- Create a view named total_film_copies using the query from the previous step

CREATE VIEW total_film_copies as 
SELECT film_id, count(inventory_id) as 'total_copies'
FROM inventory i 
GROUP BY film_id;


-- Write a sql query that combines data from the film table, total_rental_amount view, total_fim_copies view 
-- to find all film s with a total rental amount greater than 200.00, and display the following columns: film_id
-- rental _duration, rental_rate, replacement_cost, rating, total_copies, total_amount 

SELECT f.film_id, title, description, rental_duration, rental_rate, replacement_cost, rating, tfc.total_copies as 'total_copies', tra.total_amount as 'total_amount'
FROM film f 
JOIN total_film_copies tfc 
ON tfc.film_id = f.film_id 
JOIN total_rental_amount tra 
ON tra.film_id = tfc.film_id 
WHERE tra.total_amount > 200;



