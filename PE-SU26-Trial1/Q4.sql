select distinct c.id as 'courseId',
	c.code as 'CourseCode',
	c.title
from Courses c
join enrollment e on c.id = e.courseId
join semesters s on e.semesterId = s.id
join Students st on e.studentId = st.id
where st.gender = 'Female'
and s.code in ('Fa2019', 'Fa2019_B5')


