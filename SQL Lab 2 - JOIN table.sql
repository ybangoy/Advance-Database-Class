-- 1. FIRST TABLE
CREATE TABLE SONG_PLAYLIST (
  songID INTEGER PRIMARY KEY,
  song VARCHAR(100) NOT NULL,
  `year` INTEGER NOT NULL,
  artist VARCHAR(100) NOT NULL,
  genre VARCHAR(50) NOT NULL,
  platinum_award BOOLEAN NOT NULL
);

-- INSERT TABLE 1
INSERT INTO SONG_PLAYLIST VALUES
(1, 'Anti-Hero', 2023, 'Taylor Swift', 'Pop', TRUE),
(2, 'God''s Plan', 2022, 'Drake', 'Hip-Hop', TRUE),
(3, 'Easy on Me', 2021, 'Adele', 'Pop', TRUE),
(4, 'Blinding Lights', 2020, 'The Weeknd', 'R&B', TRUE),
(5, 'Bad Guy', 2019, 'Billie Eilish', 'Pop', TRUE),
(6, 'Perfect', 2018, 'Ed Sheeran', 'Pop', TRUE),
(7, 'Kill Bill', 2023, 'SZA', 'R&B', FALSE),
(8, 'Tití Me Preguntó', 2022, 'Bad Bunny', 'Latin', TRUE),
(9, 'Levitating', 2021, 'Dua Lipa', 'Pop', FALSE),
(10, 'Circles', 2020, 'Post Malone', 'Hip-Hop', TRUE),
(11, 'Adore You', 2019, 'Harry Styles', 'Pop', TRUE),
(12, 'HUMBLE.', 2018, 'Kendrick Lamar', 'Hip-Hop', FALSE),
(13, 'drivers license', 2023, 'Olivia Rodrigo', 'Pop', FALSE),
(14, 'BREAK MY SOUL', 2022, 'Beyonce', 'R&B', TRUE),
(15, 'Flowers', 2021, 'Miley Cyrus', 'Pop', FALSE);

-- 2. SECOND TABLE
-- Uses SONG_PLAYLIST (songID) as its Foreign Key
CREATE TABLE EMPLOYEES (
  employeeID INTEGER PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  role VARCHAR(50) NOT NULL,
  assigned_songID INTEGER,
  FOREIGN KEY (assigned_songID) REFERENCES SONG_PLAYLIST(songID)
);

-- INSERT TABLE 2
INSERT INTO EMPLOYEES VALUES
(101, 'Alice', 'Smith', 'Music Director', 1),
(102, 'Bob', 'Jones', 'Radio DJ', 2),
(103, 'Charlie', 'Brown', 'Playlist Curator', 3),
(104, 'Diana', 'Prince', 'Radio DJ', 4),
(105, 'Evan', 'Wright', 'Playlist Curator', 5),
(106, 'Fiona', 'Gallagher', 'Intern DJ', 6),
(107, 'George', 'Clark', 'Senior Curator', 7),
(108, 'Hannah', 'Abbott', 'Radio DJ', 8),
(109, 'Ian', 'Malcolm', 'Guest Curator', 9),
(110, 'Julia', 'Roberts', 'Radio DJ', 10),
(111, 'Kevin', 'Hart', 'Playlist Curator', 11),
(112, 'Luna', 'Lovegood', 'Intern DJ', 12),
(113, 'Michael', 'Scott', 'Music Director', 13),
(114, 'Nina', 'Simone', 'Guest Curator', 14),
(115, 'Oscar', 'Martinez', 'Radio DJ', 15);

-- 3. JOIN INSIGHT

-- 1: Staff Workload Distribution by Genre
-- Goal: See which music genres require the most employee assignments.
SELECT 
    s.genre,
    COUNT(e.employeeID) AS total_employees_assigned
FROM EMPLOYEES e
JOIN SONG_PLAYLIST s ON e.assigned_songID = s.songID
GROUP BY s.genre
ORDER BY total_employees_assigned DESC;

--  2: High-Profile Assignments (Staff managing Platinum Hits)
-- Goal: Identify which employees are handling tracks that achieved platinum status.
SELECT 
    e.employeeID,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.role,
    s.song AS managed_song,
    s.artist AS song_artist
FROM EMPLOYEES e
JOIN SONG_PLAYLIST s ON e.assigned_songID = s.songID
WHERE s.platinum_award = TRUE
ORDER BY e.employeeID;

-- 3: Role Assignment Timeline (Are Managers handling newer or older tracks?)
-- Goal: Look at the average song release year based on the employee's role.
SELECT 
    e.role,
    MIN(s.`year`) AS oldest_track_year,
    MAX(s.`year`) AS newest_track_year,
    AVG(s.`year`) AS average_track_year
FROM EMPLOYEES e
JOIN SONG_PLAYLIST s ON e.assigned_songID = s.songID
GROUP BY e.role
ORDER BY average_track_year DESC;
