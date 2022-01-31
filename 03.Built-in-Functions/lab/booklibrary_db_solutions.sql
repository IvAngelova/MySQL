# Ex 01
SELECT `title`
FROM `books`
WHERE `title` LIKE 'The%'
# where SUBSTRING(title, 1, 3) = "The"
ORDER BY `id`;

# Ex 02
SELECT replace(`title`, 'The', '***') AS 'Title'
FROM `books`
WHERE SUBSTRING(title, 1, 3) = 'The'
ORDER BY `id`;

# Ex 03
SELECT round(sum(`cost`), 2) FROM `books`;

# Ex 04
SELECT concat(`first_name`, ' ', `last_name`) AS 'Full Name',
timestampdiff(day, `born`, `died`) AS 'Days Lived'
FROM `authors`;

# Ex 05
SELECT `title`
FROM `books`
WHERE `title` LIKE '%Harry%'
ORDER BY `id`;
