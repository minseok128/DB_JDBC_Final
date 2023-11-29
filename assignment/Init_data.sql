DELETE FROM project;
DELETE FROM takes;
DELETE FROM student;
DELETE FROM instructor;
DELETE FROM course_dept;
DELETE FROM section;
DELETE FROM rooms;
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
('CSE101', 'Computer Science Department'),
('CSE101', 'English Department'),
('CSE101', 'History Department'),
('MAT101', 'Mathematics Department'),
('MAT101', 'Computer Science Department'),
('ENG101', 'English Department'),
('ENG101', 'History Department'),
('HIS101', 'History Department');

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

-- 여기까지 함

-- Student table
INSERT INTO student (ID, name, dept_name, tot_cred) VALUES 
('S5678', 'Chris Green', 'BioDept', 45),
('S6789', 'Pat Lee', 'LitDept', 36),
('S7890', 'Alex Kim', 'HistDept', 27),
('S1234', 'John Doe', 'CompSci', 32),
('S2345', 'Jane Smith', 'MathDept', 28),
('S3456', 'Alice Johnson', 'CompSci', 20),
('S4567', 'Bob Brown', 'PhysDept', 16);


-- Instructor table
INSERT INTO instructor (ID, name, dept_name, salary) VALUES 
('I5678', 'Dr. Green', 'BioDept', 80000.00),
('I6789', 'Dr. Lee', 'LitDept', 82000.00),
('I7890', 'Dr. Kim', 'HistDept', 78000.00),
('I1234', 'Dr. Smith', 'CompSci', 75000.00),
('I2345', 'Dr. Jones', 'MathDept', 72000.00),
('I3456', 'Dr. White', 'PhysDept', 70000.00),
('I4567', 'Dr. Black', 'CompSci', 68000.00);


-- Takes table
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES 
('S5678', 'BIO101', 'S3', 'Spring', 2023, 'A'),
('S6789', 'ENGL101', 'L3', 'Winter', 2023, 'B'),
('S7890', 'HIST101', 'L4', 'Summer', 2023, 'C'),
('S1234', 'CS101', 'L1', 'Fall', 2023, 'A'),
('S2345', 'MATH101', 'S1', 'Fall', 2023, 'B'),
('S3456', 'CS102', 'L2', 'Spring', 2023, 'C'),
('S4567', 'PHYS101', 'S2', 'Spring', 2023, 'D');



-- Project table
INSERT INTO project (s_id, course_id, sec_id, semester, year, num, name, i_id, max_score, score) VALUES 
('S1234', 'CS101', 'L1', 'Fall', 2023, 1, 'Project 1', 'I1234', 100, 95),
('S2345', 'MATH101', 'S1', 'Fall', 2023, 2, 'Project 2', 'I2345', 100, 85),
('S3456', 'CS102', 'L2', 'Spring', 2023, 3, 'Project 3', 'I3456', 100, 75),
('S4567', 'PHYS101', 'S2', 'Spring', 2023, 4, 'Project 4', 'I4567', 100, 90),
('S5678', 'BIO101', 'S3', 'Spring', 2023, 1, 'Bio Research', 'I5678', 100, 88),
('S6789', 'ENGL101', 'L3', 'Winter', 2023, 1, 'Literature Review', 'I6789', 100, 92),
('S7890', 'HIST101', 'L4', 'Summer', 2023, 1, 'Historical Analysis', 'I7890', 100, 85);



