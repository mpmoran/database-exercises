-- Michael Moran

-- 2.
USE albums_db;

-- 3.
DESCRIBE albums;

-- 4.
SELECT name FROM albums WHERE artist = 'Pink Floyd';

SELECT release_date FROM albums WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

SELECT genre FROM albums WHERE name = 'Nevermind';

SELECT name FROM albums WHERE release_date < 2000 AND release_date > 1989;

SELECT name FROM albums WHERE sales < 20;

SELECT name FROM albums WHERE genre = 'Rock';
-- Because the WHERE statement is looking for rows where the entry in the genre
-- column exactly matches "Rock"