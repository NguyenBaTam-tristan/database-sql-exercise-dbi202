select distinct c.category_id, c.category_name
from Categories c
join Books b on c.category_id = b.category_id
join Publishers p on b.publisher_id = p.publisher_id
where p.country = 'UK' 
and year(b.published_year) between 1900 and 1999
