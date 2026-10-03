select c.id as 'courseId',
	c.code,
	c.title,
	a.id as 'AssessmentId',
	a.type as 'AssessmentType',
	a.name as 'AssessmentName',
	a.[percent]
from Courses c
join Assessments a on c.id = a.courseId
where c.title like 'Introduction%'
order by courseId asc
