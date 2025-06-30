
set sql_safe_updates = 0;
-- Création de la base de données
drop DATABASE tp_sql_avancee;
CREATE DATABASE tp_sql_avancee;
USE tp_sql_avancee;

-- Création de la table Books
CREATE TABLE Books (
book_id INT PRIMARY KEY,
title VARCHAR(100) NOT NULL,
author_id INT,
publisher_id INT,
price DECIMAL(10, 2),
publication_date DATE,
stock INT,
FOREIGN KEY (author_id) REFERENCES Authors(author_id),
FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id)
);

-- Création de la table Authors
CREATE TABLE Authors (
author_id INT PRIMARY KEY,
author_name VARCHAR(100) NOT NULL,
birth_date DATE
);

-- Création de la table Publishers
CREATE TABLE Publishers (
publisher_id INT PRIMARY KEY,
publisher_name VARCHAR(100) NOT NULL,
country VARCHAR(50)
);

-- Création de la table Orders
CREATE TABLE Orders (
order_id INT PRIMARY KEY,
book_id INT,
customer_name VARCHAR(100),
order_date DATE,
quantity INT,
FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Remplissage de la table Books
INSERT INTO Books (book_id, title, author_id, publisher_id, price,
publication_date, stock) VALUES
(1, 'Harry Potter and the Philosopher\'s Stone', 1, 1, 20.99,
'1997-06-26', 120),
(2, 'A Game of Thrones', 2, 2, 25.50, '1996-08-06', 80),
(3, 'The Hobbit', 3, 3, 15.00, '1937-09-21', 150),
(4, 'Murder on the Orient Express', 4, 3, 10.99, '1934-01-01', 60),
(5, 'The Shining', 5, 4, 18.75, '1977-01-28', 50),
(6, 'Foundation', 6, 6, 12.99, '1951-06-01', 100),
(7, 'The Handmaid\'s Tale', 7, 7, 14.99, '1985-03-17', 90),
(8, 'The Da Vinci Code', 8, 8, 19.99, '2003-03-18', 70),
(9, 'American Gods', 9, 9, 22.00, '2001-06-19', 110),
(10, 'Sherlock Holmes: A Study in Scarlet', 10, 10, 9.99,
'1887-11-01', 130),
(11, 'Harry Potter and the Chamber of Secrets', 1, 1, 22.99,
'1998-07-02', 110),
(12, 'A Clash of Kings', 2, 2, 27.50, '1998-11-16', 75),
(13, 'The Lord of the Rings', 3, 3, 35.00, '1954-07-29', 200),(14, 'The Murder of Roger Ackroyd', 4, 3, 11.50, '1926-06-01', 65),
(15, 'Carrie', 5, 4, 17.00, '1974-04-05', 45),
(16, 'I, Robot', 6, 6, 13.99, '1950-12-02', 95),
(17, 'Oryx and Crake', 7, 7, 16.50, '2003-05-06', 85),
(18, 'Inferno', 8, 8, 21.50, '2013-05-14', 60),
(19, 'Coraline', 9, 9, 10.50, '2002-08-04', 115),
(20, 'The Hound of the Baskervilles', 10, 10, 8.99, '1902-08-01',
125);

-- Remplissage de la table Authors
INSERT INTO Authors (author_id, author_name, birth_date) VALUES
(1, 'J.K. Rowling', '1965-07-31'),
(2, 'George R.R. Martin', '1948-09-20'),
(3, 'J.R.R. Tolkien', '1892-01-03'),
(4, 'Agatha Christie', '1890-09-15'),
(5, 'Stephen King', '1947-09-21'),
(6, 'Isaac Asimov', '1920-01-02'),
(7, 'Margaret Atwood', '1939-11-18'),
(8, 'Dan Brown', '1964-06-22'),
(9, 'Neil Gaiman', '1960-11-10'),
(10, 'Arthur Conan Doyle', '1859-05-22');

-- Remplissage de la table Publishers
INSERT INTO Publishers (publisher_id, publisher_name, country)
VALUES
(1, 'Bloomsbury', 'UK'),
(2, 'Bantam Books', 'USA'),
(3, 'HarperCollins', 'UK'),
(4, 'Scribner', 'USA'),
(5, 'Penguin Books', 'UK'),
(6, 'Random House', 'USA'),
(7, 'Hachette Livre', 'France'),
(8, 'Simon & Schuster', 'USA'),
(9, 'Macmillan', 'UK'),
(10, 'Scholastic', 'USA');

-- Remplissage de la table Orders
INSERT INTO Orders (order_id, book_id, customer_name, order_date,
quantity) VALUES
(1, 1, 'Alice', '2023-01-15', 2),
(2, 3, 'Bob', '2023-01-20', 1),
(3, 2, 'Charlie', '2023-01-25', 3),
(4, 4, 'Diana', '2023-02-10', 1),
(5, 1, 'Eve', '2023-02-15', 1),
(6, 5, 'Frank', '2023-03-05', 2),
(7, 7, 'Grace', '2023-03-10', 1),
(8, 8, 'Hannah', '2023-03-20', 1),
(9, 9, 'Ivy', '2023-04-01', 4),
(10, 10, 'Jack', '2023-04-15', 1),
(11, 6, 'Karen', '2023-04-25', 2),
(12, 12, 'Leo', '2023-05-10', 3),
(13, 13, 'Mia', '2023-05-15', 2),
(14, 14, 'Nina', '2023-06-01', 1),
(15, 15, 'Oscar', '2023-06-10', 2),
(16, 16, 'Paul', '2023-06-20', 1),
(17, 17, 'Quincy', '2023-07-05', 2),
(18, 18, 'Rachel', '2023-07-10', 1),
(19, 19, 'Sam', '2023-07-20', 3),
(20, 20, 'Tina', '2023-08-01', 1);

-- 1 Afficher les livres dont le prix est supérieur à la moyenne des prix des livres.
SELECT title, price
FROM Books
WHERE price > (SELECT AVG(price) FROM Books);

-- 2 Afficher les livres ayant un stock inférieur à la moyenne du stock des livres de leur éditeur.
SELECT B.title, B.stock, P.publisher_name
FROM Books B
JOIN Publishers P ON B.publisher_id = P.publisher_id
WHERE B.stock < (
    SELECT AVG(stock)
    FROM Books
    WHERE publisher_id = B.publisher_id
);

-- 3 Créer une vue book_details pour afficher les livres avec leur auteur, éditeur et prix.
CREATE VIEW book_details AS
SELECT 
    B.title AS book_title,
    A.author_name AS author,
    P.publisher_name AS publisher,
    B.price AS price
FROM Books B
JOIN Authors A ON B.author_id = A.author_id
JOIN Publishers P ON B.publisher_id = P.publisher_id;

-- 4 Créer une vue order_summary pour afficher les commandes avec le titre du livre, le client, la date de commande et le total (prix * quantité).
CREATE VIEW order_summary AS
SELECT 
    O.order_id,
    B.title AS book_title,
    O.customer_name,
    O.order_date,
    (B.price * O.quantity) AS total_price
FROM Orders O
JOIN Books B ON O.book_id = B.book_id;

-- 5 Créer un index sur la colonne price de la table Books.
CREATE INDEX idx_books_price ON Books(price);

-- 6 Créer un index composite sur les colonnes author_id et publisher_id.
CREATE INDEX idx_books_author_publisher ON Books(author_id, publisher_id);

-- 7 Afficher les livres publiés il y a plus de 20 ans.
SELECT title, publication_date
FROM Books
WHERE YEAR(CURDATE()) - YEAR(publication_date) > 20;

-- 8 Afficher le nombre de commandes passées par mois.
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(*) AS total_orders
FROM Orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- 9 Réduire le stock des livres commandés de 5 % pour simuler une erreur, puis annuler cette modification.
UPDATE Books
SET stock = stock * 0.95;
ROLLBACK; 

-- 10 Mettre à jour les prix des livres, avec une augmentation de 10 % pour ceux publiés avant l’an 2000, et valider la transaction.
BEGIN;
UPDATE Books
SET price = price * 1.10
WHERE publication_date < '2000-01-01';
COMMIT;

-- 11 Créer un trigger audit_price_change pour enregistrer les modifications des prix dans une table d’audit.
CREATE TABLE PriceAudit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    old_price DECIMAL(10, 2),
    new_price DECIMAL(10, 2),
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DELIMITER //

CREATE TRIGGER audit_price_change
AFTER UPDATE ON Books
FOR EACH ROW
BEGIN
    IF OLD.price <> NEW.price THEN
        INSERT INTO PriceAudit (book_id, old_price, new_price)
        VALUES (OLD.book_id, OLD.price, NEW.price);
    END IF;
END;
//


-- 12 Créer un trigger prevent_low_stock_order pour empêcher une commande si le stock disponible est inférieur à la quantité commandée.
CREATE TRIGGER prevent_low_stock_order
BEFORE INSERT ON Orders
FOR EACH ROW
BEGIN
    DECLARE current_stock INT;
    SELECT stock INTO current_stock FROM Books WHERE book_id = NEW.book_id;

    IF current_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock for this order.';
    END IF;
END;
//

DELIMITER ;


-- 13 Afficher les livres avec une colonne indiquant s'ils sont chers (Expensive) ou abordables (Affordable) selon un seuil de 20 €.
SELECT title, price,
       CASE 
           WHEN price > 20 THEN 'Expensive'
           ELSE 'Affordable'
       END AS price_category
FROM Books;

-- 14 Afficher les éditeurs avec une colonne indiquant s'ils sont internationaux (Yes) ou non (No) selon leur pays.
SELECT publisher_name, country,
       CASE 
           WHEN country <> 'France' THEN 'Yes'
           ELSE 'No'
       END AS is_international
FROM Publishers;

-- 15 Afficher le titre des livres et leur rang global basé sur le prix (RANK())
SET @rank = 0;

SELECT title, price, @rank := @rank + 1 AS price_rank
FROM Books
ORDER BY price DESC;


-- 16 Afficher le titre des livres et leur numéro de ligne dans l'ordre des prix décroissants (ROW_NUMBER()).
SET @row_number = 0;

SELECT title, price, @row_number := @row_number + 1 AS row_number
FROM Books
ORDER BY price DESC;


-- 17 Afficher le titre des livres, leur éditeur, et le prix moyen des livres par éditeur (AVG() avec OVER()).
SELECT B.title, P.publisher_name, B.price,
       (SELECT AVG(price) 
        FROM Books 
        WHERE publisher_id = B.publisher_id) AS avg_price_by_publisher
FROM Books B
JOIN Publishers P ON B.publisher_id = P.publisher_id;


-- 18 Afficher le titre des livres et la somme cumulative de leurs prix (SUM() avec OVER()).
SELECT B1.title, B1.price,
       (SELECT SUM(B2.price) 
        FROM Books B2 
        WHERE B2.publication_date <= B1.publication_date) AS cumulative_price
FROM Books B1
ORDER BY B1.publication_date;


-- 19 Afficher le titre des livres et leur rang par auteur basé sur le prix (RANK() avec PARTITION BY).
SET @author_id = NULL;
SET @rank = 0;

SELECT B.title, A.author_name, B.price,
       CASE 
           WHEN @author_id = B.author_id THEN @rank := @rank + 1
           ELSE @rank := 1 AND @author_id := B.author_id
       END AS rank_by_author
FROM Books B
JOIN Authors A ON B.author_id = A.author_id
ORDER BY B.author_id, B.price DESC;


-- 20 Afficher le titre des livres et le prix maximum pour chaque éditeur (MAX() avec PARTITION BY).
SELECT B.title, P.publisher_name, B.price,
       (SELECT MAX(price) 
        FROM Books 
        WHERE publisher_id = B.publisher_id) AS max_price_by_publisher
FROM Books B
JOIN Publishers P ON B.publisher_id = P.publisher_id;



