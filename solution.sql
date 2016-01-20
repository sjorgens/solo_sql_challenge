--1. Which authors are represented in our store?
SELECT * FROM authors;

--2. Which authors are also distinguished authors?
SELECT * FROM distinguished_authors;

--3. Which authors are not distinguished authors?
SELECT * FROM authors
LEFT OUTER JOIN distinguished_authors
ON authors.id = distinguished_authors.id
WHERE distinguished_authors.id IS null;

--4. How many authors are represented in our store?
SELECT COUNT (*) FROM authors;

--5. Who are the favorite authors of the employee with the first name of Michael?
SELECT authors_and_titles[1:100][1:1] FROM favorite_authors
JOIN employees
ON favorite_authors.employee_id = employees.id
WHERE employees.first_name = 'Michael';

--6. What are the titles of all the books that are in stock today?
SELECT DISTINCT books.title
FROM daily_inventory
	JOIN editions
		ON daily_inventory.isbn = editions.isbn
	JOIN books
		ON editions.book_id = books.id
WHERE daily_inventory.is_stocked = true;

--7. Insert one of your favorite books into the database.
--Hint: You'll want to create data in at least 2 other tables to completely create this book.
INSERT INTO books (id, title, author_id, subject_id) VALUES (41479, 'Moby Dick', 25044, 3);
INSERT INTO authors (id, last_name, first_name) VALUES (25044, 'Melville', 'Hermann');
INSERT INTO editions (isbn, book_id, edition, publisher_id, publication, type) VALUES ('0141199601', 41479, 15, 172, '2015-11-24', 'h');

--8. What authors have books that are not in stock?
SELECT authors.first_name, authors.last_name
FROM stock
	JOIN editions
		ON stock.isbn = editions.isbn
	JOIN books
		ON editions.book_id = books.id
	JOIN authors
		ON books.author_id = authors.id
WHERE stock.stock = 0;

--9. What is the title of the book that has the most stock?
SELECT books.title, SUM(stock.stock) AS stock
FROM stock
	JOIN editions
		ON editions.isbn = stock.isbn
	JOIN books
		ON books.id = editions.book_id
GROUP BY books.title
ORDER BY stock DESC
LIMIT 1;