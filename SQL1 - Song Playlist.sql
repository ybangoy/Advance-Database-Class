-- create
CREATE TABLE SONG_PLAYLIST (
  songID INTEGER PRIMARY KEY,
  song VARCHAR(100) NOT NULL,
  `year` INTEGER NOT NULL,
  artist VARCHAR(100) NOT NULL,
  genre VARCHAR(50) NOT NULL,
  platinum_award BOOLEAN NOT NULL
);

-- insert
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

-- 1: Which genres have the most platinum songs?
SELECT
  genre,
  COUNT(*) AS song_count,
  SUM(platinum_award) AS platinum_count,
  GROUP_CONCAT(
    CASE WHEN platinum_award = TRUE
      THEN CONCAT(song, ' - ', artist)
    END
    ORDER BY songID SEPARATOR ', '
  ) AS platinum_songs
FROM SONG_PLAYLIST
GROUP BY genre
ORDER BY platinum_count DESC;

-- 2: Which years had the most successful songs?
SELECT
  `year`,
  SUM(platinum_award) AS platinum_count,
  GROUP_CONCAT(
    CASE WHEN platinum_award = TRUE
      THEN CONCAT(song, ' - ', artist)
    END
    ORDER BY songID SEPARATOR ', '
  ) AS platinum_songs
FROM SONG_PLAYLIST
GROUP BY `year`
ORDER BY platinum_count DESC;

-- 3: Which specific songs did not receive a platinum award?
SELECT
  songID,
  song,
  artist,
  `year`,
  genre
FROM SONG_PLAYLIST
WHERE platinum_award = FALSE
ORDER BY `year`, songID;
