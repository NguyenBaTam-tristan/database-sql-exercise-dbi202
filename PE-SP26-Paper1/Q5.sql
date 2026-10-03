SELECT 
    ar.ID AS ArtistID,
    ar.Name,
    ar.Gender,
    ar.Country,
    COUNT(DISTINCT a.ID) AS NumberOfAlbums,
    COUNT(DISTINCT CASE WHEN g.Name = 'Rock' THEN t.ID END) AS NumberOfTracks
FROM Artists ar
LEFT JOIN Albums a ON ar.ID = a.ArtistID 
    AND a.ReleaseYear BETWEEN 2020 AND 2024
LEFT JOIN Tracks t ON a.ID = t.AlbumID
LEFT JOIN Genres g ON t.GenreID = g.ID 
    AND g.Name = 'Rock'
GROUP BY 
    ar.ID, ar.Name, ar.Gender, ar.Country;