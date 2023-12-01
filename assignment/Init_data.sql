DELETE FROM project;
DELETE FROM takes;
DELETE FROM rooms;
DELETE FROM course_dept;
DELETE FROM section;
DELETE FROM student;
DELETE FROM instructor;
DELETE FROM course;
DELETE FROM time_slot;

-- Course table
INSERT INTO course (course_id, title, credits) VALUES 
('CSE101', 'Computer Science I', 4),
('MAT101', 'Calculus I', 3),
('ENG101', 'English Literature', 3),
('HIS101', 'World History', 3);

-- Section table
INSERT INTO section (course_id, sec_id, semester, year) VALUES 
('CSE101', 'S0', 'Winter', 2023),
('CSE101', 'S1', 'Winter', 2023),
('MAT101', 'S0', 'Fall', 2022),
('HIS101', 'S1', 'Fall', 2022),
('ENG101', 'S1', 'Spring', 2021);

-- Course_dept table
INSERT INTO course_dept (course_id, dept_name) VALUES 
('CSE101', 'Computer Science Dept'),
('CSE101', 'English Dep'),
('CSE101', 'History Dept'),
('MAT101', 'Mathematics Dept'),
('MAT101', 'Computer Science Dept'),
('ENG101', 'English Dept'),
('ENG101', 'History Dept'),
('HIS101', 'History Dept');

-- Time_slot table
INSERT INTO time_slot (time_slot_id, day, start_time, end_time) VALUES 
('A', 'Mon', 11, 13),
('A', 'Wen', 13, 14),
('A', 'Fri', 15, 16),
('B', 'Tue', 9, 11),
('B', 'Tue', 15, 17),
('C', 'Sat', 10, 13);

-- Rooms table
INSERT INTO rooms (course_id, sec_id, year, semester, time_slot_id, day, start_time, building, room_number) VALUES 
-- CSE101, S0, Winter 2023, Time Slot A
('CSE101', 'S0', 2023, 'Winter', 'A', 'Mon', 11, '310', '723'),
('CSE101', 'S0', 2023, 'Winter', 'A', 'Wen', 13, '310', '727'),
('CSE101', 'S0', 2023, 'Winter', 'A', 'Fri', 15, '208', '101'),
-- CSE101, S1, Winter 2023, Time Slot B
('CSE101', 'S1', 2023, 'Winter', 'B', 'Tue', 9, '207', '212'),
('CSE101', 'S1', 2023, 'Winter', 'B', 'Tue', 15, '310', '727'),
-- MAT101, S0, Fall 2022, Time Slot B
('MAT101', 'S0', 2022, 'Fall', 'B', 'Tue', 9, '301', '123'),
('MAT101', 'S0', 2022, 'Fall', 'B', 'Tue', 15, '107', '111'),
-- HIS101, S1, Fall 2022, Time Slot B
('HIS101', 'S1', 2022, 'Fall', 'B', 'Tue', 9, '208', '109'),
('HIS101', 'S1', 2022, 'Fall', 'B', 'Tue', 15, '208', '108'),
-- ENG101, S1, Spring 2021, Time Slot C
('ENG101', 'S1', 2021, 'Spring', 'C', 'Sat', 10, '310', '519');

-- Student table
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES 
('01111', 'Minseok','Computer Science Dept', 73),
('06789', 'Kiyoun', 'Computer Science Dept', 36),
('07890', 'Alex', 'English Dep', 27),
('02345', 'Smith', 'History Dept', 28),
('04567', 'Bob', 'Mathematics Dept', 16);

-- Instructor table
INSERT INTO instructor (ID, name, dept_name, salary) VALUES 
('15678', 'Dr. Lee', 'English Dep', 80000.00),
('16789', 'Dr. Kang', 'Computer Science Dept', 82000.00),
('17890', 'Dr. Kim', 'History Dept', 78000.00),
('11234', 'Dr. Peak', 'Mathematics Dept', 75000.00),
('12345', 'Dr. Son', 'Computer Science Dept', 72000.00);

-- Takes table
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES 
('01111', 'CSE101', 'S0', 'Winter', 2023, 'A'),
('06789', 'CSE101', 'S1', 'Winter', 2023, 'B'),
('07890', 'ENG101', 'S1', 'Spring', 2021, 'C'),
('02345', 'HIS101', 'S1', 'Fall', 2022, 'B+'),
('04567', 'MAT101', 'S0', 'Fall', 2022, 'A-'),
('01111', 'MAT101', 'S0', 'Fall', 2022, 'A');

-- Project table
INSERT INTO project (s_id, course_id, sec_id, semester, year, num, name, i_id, max_score, score) VALUES 
('01111', 'CSE101', 'S0', 'Winter', 2023, 1, 'Data Structures Project I', '16789', 100, 90),
('01111', 'CSE101', 'S0', 'Winter', 2023, 2, 'Algorithm Design I', '15678', 100, 95),
('06789', 'CSE101', 'S1', 'Winter', 2023, 1, 'Algorithm Design I', '16789', 100, 85),
('07890', 'ENG101', 'S1', 'Spring', 2021, 1, 'Literary Analysis', '15678', 100, 78),
('02345', 'HIS101', 'S1', 'Fall', 2022, 1, 'Historical Research', '17890', 100, 82),
('04567', 'MAT101', 'S0', 'Fall', 2022, 1, 'Advanced Calculus Project', '11234', 100, 88),
('01111', 'MAT101', 'S0', 'Fall', 2022, 1, 'Basic Algebra I', '16789', 100, 35),
('01111', 'MAT101', 'S0', 'Fall', 2022, 2, 'Linear Algebra Study', '11234', 100, 93);
