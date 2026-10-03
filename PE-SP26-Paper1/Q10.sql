INSERT INTO PlaylistTracks (PlaylistID, TrackID, AddedDate)
SELECT 
    10, 
    t.ID, 
    CAST('2026-03-06' AS DATE)
FROM Tracks t
JOIN Albums a ON t.AlbumID = a.ID
WHERE a.Title = 'Stars Dance';