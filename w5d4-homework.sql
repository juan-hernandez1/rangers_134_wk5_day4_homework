-- 2. Add a new column in the customer table for Platinum Member. This can be a boolean.
-- Platinum Members are any customers who have spent over $200. 
-- Create a procedure that updates the Platinum Member column to True for any customer who has spent over $200 and False for any customer who has spent less than $200.
-- Use the payment and customer table.

SELECT *
FROM customer;

ALTER TABLE customer
ADD COLUMN platinum_member BOOLEAN DEFAULT False;


CREATE OR REPLACE PROCEDURE platinum_member()
LANGUAGE plpgsql
AS $$
BEGIN
		UPDATE customer
		SET platinum_member = True
		WHERE customer_id IN(
			SELECT customer_id
			FROM payment
			GROUP BY customer_id
			HAVING SUM(amount) > 200
			
);		
		COMMIT;
END;
$$


CALL platinum_member()

SELECT *
FROM customer
ORDER BY platinum_member DESC;