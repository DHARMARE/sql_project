create database movie;

use movie;

-- Creating Movie Table
CREATE TABLE Movie (
    mov_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year YEAR NOT NULL,
    duration INT NOT NULL, -- duration in minutes
    language VARCHAR(50) NOT NULL,
    release_date DATE NOT NULL,
    release_country VARCHAR(50) NOT NULL
);

-- Creating Actor Table
CREATE TABLE Actor (
    act_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL
);

-- Creating Movie_Cast Table
CREATE TABLE Movie_Cast (
    mov_id INT,
    act_id INT,
    role VARCHAR(100),
    PRIMARY KEY (mov_id, act_id),
    FOREIGN KEY (mov_id) REFERENCES Movie(mov_id),
    FOREIGN KEY (act_id) REFERENCES Actor(act_id)
);

-- Creating Director Table
CREATE TABLE Director (
    dir_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL
);

-- Creating Movie_Director Table
CREATE TABLE Movie_Director (
    mov_id INT,
    dir_id INT,
    PRIMARY KEY (mov_id, dir_id),
    FOREIGN KEY (mov_id) REFERENCES Movie(mov_id),
    FOREIGN KEY (dir_id) REFERENCES Director(dir_id)
);

-- Creating Genres Table
CREATE TABLE Genres (
    gen_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL
);

-- Creating Movie_Genres Table
CREATE TABLE Movie_Genres (
    mov_id INT,
    gen_id INT,
    PRIMARY KEY (mov_id, gen_id),
    FOREIGN KEY (mov_id) REFERENCES Movie(mov_id),
    FOREIGN KEY (gen_id) REFERENCES Genres(gen_id)
);

-- Creating Reviewer Table
CREATE TABLE Reviewer (
    rev_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Creating Rating Table
CREATE TABLE Rating (
    mov_id INT,
    rev_id INT,
    stars INT CHECK (stars BETWEEN 1 AND 5),
    num_ratings INT NOT NULL,
    PRIMARY KEY (mov_id, rev_id),
    FOREIGN KEY (mov_id) REFERENCES Movie(mov_id),
    FOREIGN KEY (rev_id) REFERENCES Reviewer(rev_id)
);

-- Inserting records into the Movie Table
INSERT INTO Movie (title, release_year, duration, language, release_date, release_country)
VALUES
('The Godfather', 1972, 175, 'English', '1972-03-24', 'USA'),
('Pulp Fiction', 1994, 154, 'English', '1994-10-14', 'USA'),
('Inception', 2010, 148, 'English', '2010-07-16', 'USA');

-- Inserting records into the Actor Table
INSERT INTO Actor (first_name, last_name, gender)
VALUES
('Marlon', 'Brando', 'Male'),
('Al', 'Pacino', 'Male'),
('John', 'Travolta', 'Male'),
('Leonardo', 'DiCaprio', 'Male'),
('Ellen', 'Page', 'Female');

-- Inserting records into the Movie_Cast Table
INSERT INTO Movie_Cast (mov_id, act_id, role)
VALUES
(1, 1, 'Vito Corleone'),
(1, 2, 'Michael Corleone'),
(2, 3, 'Vincent Vega'),
(3, 4, 'Dom Cobb'),
(3, 5, 'Ariadne');

-- Inserting records into the Director Table
INSERT INTO Director (first_name, last_name)
VALUES
('Francis Ford', 'Coppola'),
('Quentin', 'Tarantino'),
('Christopher', 'Nolan');

-- Inserting records into the Movie_Director Table
INSERT INTO Movie_Director (mov_id, dir_id)
VALUES
(1, 1),
(2, 2),
(3, 3);

-- Inserting records into the Genres Table
INSERT INTO Genres (title)
VALUES
('Crime'),
('Drama'),
('Action'),
('Thriller'),
('Science Fiction');

-- Inserting records into the Movie_Genres Table
INSERT INTO Movie_Genres (mov_id, gen_id)
VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 4),
(3, 3),
(3, 5);

-- Inserting records into the Reviewer Table
INSERT INTO Reviewer (name)
VALUES
('Roger Ebert'),
('Peter Travers'),
('James Berardinelli');

-- Inserting records into the Rating Table
INSERT INTO Rating (mov_id, rev_id, stars, num_ratings)
VALUES
(1, 1, 5, 1500),
(1, 2, 5, 1200),
(2, 1, 4, 1300),
(2, 3, 5, 1100),
(3, 2, 5, 1400);

SELECT 
    m.title AS Movie,
    g.title AS Genre
FROM 
    Movie m
JOIN 
    Movie_Genres mg ON m.mov_id = mg.mov_id
JOIN 
    Genres g ON mg.gen_id = g.gen_id
ORDER BY 
    m.title;
    
SELECT 
    a.first_name,
    a.last_name,
    mc.role
FROM 
    Actor a
JOIN 
    Movie_Cast mc ON a.act_id = mc.act_id
JOIN 
    Movie m ON mc.mov_id = m.mov_id
WHERE 
    m.title = 'The Godfather' AND
    mc.role = 'Michael Corleone';
    
SELECT 
    m.title AS Movie,
    AVG(r.stars) AS Average_Rating
FROM 
    Movie m
JOIN 
    Rating r ON m.mov_id = r.mov_id
GROUP BY 
    m.title
ORDER BY 
    m.title;
    
SELECT 
    m.title AS Movie,
    d.first_name,
    d.last_name
FROM 
    Movie m
JOIN 
    Movie_Director md ON m.mov_id = md.mov_id
JOIN 
    Director d ON md.dir_id = d.dir_id
WHERE 
    m.release_year = 2010;



