CREATE TABLE students(
	surname text,
	name text,
	patronymic text,
	course integer,
	group_name text,
	faculty text);

INSERT INTO students (surname, name, patronymic, course, group_name, faculty)
VALUES ('Malakhov', 'Dmitriy', 'Aleksandrovich', 3, 'N3348', 'FBIT'),
('Suetin', 'Stepan', 'Dmitrievich', 3, 'N3348', 'FBIT'),
('Prohorov', 'Gregory', NULL, 3, 'N3348', 'FBIT'),
('Gamidov', 'Abdul', 'Bedrosovich', 3, 'N3348', 'FBIT');

