CREATE OR ALTER PROC listTopArtistByYear @year INT
AS
BEGIN
    WITH ArtistAdditions AS (
        SELECT 
            ar.Country,
            ar.ID AS ArtistID,
            ar.Name AS ArtistName,
            COUNT(pt.TrackID) AS TotalPlaylistAdditionsInYear,
            DENSE_RANK() OVER (
                PARTITION BY ar.Country 
                ORDER BY COUNT(pt.TrackID) DESC
            ) AS rnk
        FROM Artists ar
        JOIN Albums a ON ar.ID = a.ArtistID
        JOIN Tracks t ON a.ID = t.AlbumID
        JOIN PlaylistTracks pt ON t.ID = pt.TrackID
        WHERE YEAR(pt.AddedDate) = @year
        GROUP BY ar.Country, ar.ID, ar.Name
    )
    SELECT 
        Country,
        ArtistID,
        ArtistName,
        TotalPlaylistAdditionsInYear
    FROM ArtistAdditions
    WHERE rnk = 1;
END