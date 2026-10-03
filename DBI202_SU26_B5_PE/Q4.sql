select distinct c.category_id, 
		c.category_name, 
		w.book_id, 
		w.title
from Categories c
left join (select b.book_id, 
	b.title, 
	b.category_id,
	l.loan_date, 
	m.gender
	from Books b
	join Loans l on b.book_id = l.book_id
	join Members m on l.member_id = m.member_id and m.gender = 'Female'
) w on c.category_id = w.category_id
and (month(w.loan_date) = 1 or month(w.loan_date) = 3)
order by c.category_name asc, w.title asc



