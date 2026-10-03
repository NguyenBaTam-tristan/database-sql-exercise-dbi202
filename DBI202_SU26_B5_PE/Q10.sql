update Books
set total_copies = isnull((select total_copies from Books b where b.book_id = Books.book_id),0)
				+ 2
where Books.category_id = (select distinct c.category_id
	from Categories c
	join Books b on c.category_id = b.category_id
	where c.category_name = ('Science Fiction'))


