DROP TABLE IF EXISTS project, takes, student, instructor, course_dept, section, rooms, course, time_slot;

-- Course table
CREATE TABLE course (
  course_id VARCHAR(8), 
  title VARCHAR(50), 
  credits NUMERIC(2,0),
  PRIMARY KEY (course_id)
);

-- Section table
CREATE TABLE section (
  course_id VARCHAR(8), 
  sec_id VARCHAR(8),
  semester VARCHAR(6) CHECK (semester IN ('Fall', 'Winter', 'Spring', 'Summer')), 
  year NUMERIC(4,0), 
  PRIMARY KEY (course_id, sec_id, semester, year),
  FOREIGN KEY (course_id) REFERENCES course(course_id)
    ON DELETE CASCADE
);

-- Course_dept table
CREATE TABLE course_dept (
  course_id VARCHAR(8),
  dept_name VARCHAR(50),
  PRIMARY KEY (course_id, dept_name),
  FOREIGN KEY (course_id) REFERENCES course(course_id)
);

-- Time_slot table
CREATE TABLE time_slot (
  time_slot_id VARCHAR(4),
  day VARCHAR(3),
  start_time NUMERIC(2) CHECK (start_time >= 0 AND start_time < 24),
  end_time NUMERIC(2) CHECK (end_time >= 0 AND end_time < 24),
  PRIMARY KEY (time_slot_id, day, start_time)
);

-- Rooms table
CREATE TABLE rooms (
  course_id VARCHAR(8),
  sec_id VARCHAR(8), 
  year NUMERIC(4,0),
  semester VARCHAR(6),
  time_slot_id VARCHAR(4),
  day VARCHAR(3),
  start_time NUMERIC(2),
  building VARCHAR(15),
  room_number VARCHAR(7),
  FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section(course_id, sec_id, semester, year),
  FOREIGN KEY (time_slot_id, day, start_time) REFERENCES time_slot(time_slot_id, day, start_time)
);

-- Student table
CREATE TABLE student (
  ID VARCHAR(5), 
  name VARCHAR(20) NOT NULL, 
  dept_name VARCHAR(50), 
  tot_cred NUMERIC(3,0),
  PRIMARY KEY (ID)
);

-- Instructor table
CREATE TABLE instructor (
  ID VARCHAR(5), 
  name VARCHAR(20), 
  dept_name VARCHAR(50), 
  salary NUMERIC(8,2),
  PRIMARY KEY (ID)
);

-- Takes table
CREATE TABLE takes (
  ID VARCHAR(5), 
  course_id VARCHAR(8),
  sec_id VARCHAR(8), 
  semester VARCHAR(6),
  year NUMERIC(4,0),
  grade VARCHAR(2),
  PRIMARY KEY (ID, course_id, sec_id, semester, year),
  FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section(course_id, sec_id, semester, year),
  FOREIGN KEY (ID) REFERENCES student(ID)
);

-- Project table
CREATE TABLE project (
  s_id VARCHAR(5),
  course_id VARCHAR(8),
  sec_id VARCHAR(8),
  semester VARCHAR(6),
  year NUMERIC(4,0),
  num NUMERIC(2,0),
  name VARCHAR(50),
  i_id VARCHAR(5),
  max_score NUMERIC(3,0),
  score NUMERIC(3,0),
  PRIMARY KEY (s_id, course_id, sec_id, semester, year, num),
  FOREIGN KEY (s_id, course_id, sec_id, semester, year) REFERENCES takes(ID, course_id, sec_id, semester, year)
);