SELECT 
    a.Title AS AlbumTitle,
    a.ReleaseYear,
    t.ID AS TrackID,
    t.Title AS TrackTitle,
    g.Name AS GenreName,
    p.Title AS PlaylistTitle,
    pt.AddedDate
FROM Albums a
JOIN Tracks t ON a.ID = t.AlbumID
JOIN Genres g ON t.GenreID = g.ID
LEFT JOIN PlaylistTracks pt ON t.ID = pt.TrackID
LEFT JOIN Playlists p ON pt.PlaylistID = p.ID
WHERE a.ReleaseYear > 2020 
  AND g.Name = 'Rock'
ORDER BY 
    PlaylistTitle DESC, 
    TrackTitle ASC;