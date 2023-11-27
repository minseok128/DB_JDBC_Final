CREATE TABLE Department (
    dept_name VARCHAR(50) PRIMARY KEY,
    building VARCHAR(50),
    budget DECIMAL
);

CREATE TABLE Course (
    course_id VARCHAR(50) PRIMARY KEY,
    title VARCHAR(100),
    credits INT
);

CREATE TABLE Classroom (
    building VARCHAR(50),
    room_number VARCHAR(50),
    capacity INT,
    PRIMARY KEY (building, room_number)
);

CREATE TABLE Time_slot (
    time_slot_id VARCHAR(50) PRIMARY KEY,
    day VARCHAR(10),
    start_time TIME,
    end_time TIME
);

CREATE TABLE Instructor (
    ID VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL,
    dept_name VARCHAR(50),
    FOREIGN KEY (dept_name) REFERENCES Department(dept_name)
);

CREATE TABLE Student (
    ID VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    tot_cred INT,
    dept_name VARCHAR(50),
    FOREIGN KEY (dept_name) REFERENCES Department(dept_name)
);

CREATE TABLE Section (
    course_id VARCHAR(50),
    sec_id VARCHAR(50),
    year INT,
    semester VARCHAR(20),
    PRIMARY KEY (course_id, sec_id, year, semester),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE Teaches (
    ID VARCHAR(50),
    course_id VARCHAR(50),
    sec_id VARCHAR(50),
    year INT,
    semester VARCHAR(20),
    PRIMARY KEY (ID, course_id, sec_id, year, semester),
    FOREIGN KEY (ID) REFERENCES Instructor(ID),
    FOREIGN KEY (course_id, sec_id, year, semester) REFERENCES Section(course_id, sec_id, year, semester)
);

CREATE TABLE Takes (
    ID VARCHAR(50),
    course_id VARCHAR(50),
    sec_id VARCHAR(50),
    year INT,
    semester VARCHAR(20),
    grade VARCHAR(5),
    PRIMARY KEY (ID, course_id, sec_id, year, semester),
    FOREIGN KEY (ID) REFERENCES Student(ID),
    FOREIGN KEY (course_id, sec_id, year, semester) REFERENCES Section(course_id, sec_id, year, semester)
);

CREATE TABLE Project (
    s_id VARCHAR(50),
    course_id VARCHAR(50),
    sec_id VARCHAR(50),
    year INT,
    semester VARCHAR(20),
    num INT,
    i_id VARCHAR(50),
    score INT,
    PRIMARY KEY (s_id, course_id, sec_id, year, semester, num),
    FOREIGN KEY (s_id, course_id, sec_id, year, semester) REFERENCES Takes(ID, course_id, sec_id, year, semester),
    FOREIGN KEY (i_id, course_id, sec_id, year, semester) REFERENCES Teaches(ID, course_id, sec_id, year, semester)
);

CREATE TABLE Course_dept (
    course_id VARCHAR(50),
    dept_name VARCHAR(50),
    PRIMARY KEY (course_id, dept_name),
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (dept_name) REFERENCES Department(dept_name)
);

CREATE TABLE Prereq (
    course_id VARCHAR(50),
    prereq_id VARCHAR(50),
    PRIMARY KEY (course_id, prereq_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id),
    FOREIGN KEY (prereq_id) REFERENCES Course(course_id)
);

CREATE TABLE Advisor (
    s_id VARCHAR(50),
    i_id VARCHAR(50),
    PRIMARY KEY (s_id, i_id),
    FOREIGN KEY (s_id) REFERENCES Student(ID),
    FOREIGN KEY (i_id) REFERENCES Instructor(ID)
);
