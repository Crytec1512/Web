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
('Gamidov', 'Abdul', 'Bedrosovich', 3, 'N3348', 'FBIT'),
('Gorlov', 'Igor', 'Vitalievich', 3, 'K3321', 'FPIN'),
('Gorlov', 'Andrew', 'Borisovich', 3, 'K3331', 'FPIN'),
('Abdrahmanov', 'Martin','Marativich', 3, 'K3331', 'FPIN'),
('Griffin', 'Peter', NULL, 1 , 'N3150', 'FBIT'),
('Jakson', 'Michael', NULL, 2, 'N3252', 'FBIT'),
('Swanson', 'Joe', NULL, 4, 'N3446', 'FBIT'),
('Ivanova', 'Taisiya', 'Vladimirovna', 4, 'T34306', 'FBIO'),
('Ivanova', 'Ekaterina', 'Urievna', 3, 'T33304', 'FBIO'),
('Ivanova', 'Maria', 'Nikolaievna', 1, 'T3132', 'FBIO'),
('Kusnetsova', 'Eugenia', 'Anatolievna', 1, 'T3130', 'FBIO'),
('Kusnetsova', 'Maria', 'Vladislavovna', 1, 'T3130', 'FBIO'),
('Kusnetsiva', 'Anastasia', 'Segeevna', 1, 'T3131', 'FBIO'),
('Nikitina', 'Alina', 'Dmitrievna', 3, 'T33305', 'FBIO'),
('Nikitina', 'Varvara', 'Aleksandorvna', 4, 'T34302', 'FBIO'),
('Prohorova', 'Milena', 'Michaelovna', 4, 'T34303', 'FBIO'),
('Prohorova', 'Ekaterina', 'Vldimirovna', 3, 'T33311', 'FBIO'),
('Smirnova', 'Arina', 'Eugeniovna', 2, 'T3230', 'FBIO'),
('Philipova', 'Daria', 'Sergeevna', 2, 'T3231', 'FBIO');

