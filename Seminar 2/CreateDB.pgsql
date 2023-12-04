
CREATE TABLE Address (
 id SERIAL,
 city VARCHAR(50),
 street VARCHAR(100),
 postalcode CHAR(5)
);

CREATE TABLE InstrumentBrand (
 id SERIAL,
 brand VARCHAR(50)
);

CREATE TABLE InstrumentType (
 id SERIAL,
 type VARCHAR(50)
);

CREATE TABLE Person (
 id SERIAL,
 personNumber CHAR(12) NOT NULL,
 name VARCHAR(100),
 phoneNumber VARCHAR(30),
 email VARCHAR(100)
);

CREATE TABLE Proficiency (
 id SERIAL,
 skillLevel VARCHAR(30),
 instrumentType VARCHAR(30)
);

CREATE TABLE Room (
 id SERIAL,
 roomName VARCHAR(50),
 capacity INT,
 handicapAccessible BOOLEAN NOT NULL,
 address_id INT NOT NULL
);

CREATE TABLE SiblingRelationship (
 id SERIAL
);

CREATE TABLE Student (
 person_id INT NOT NULL,
 siblingrelationship_id INT NOT NULL
);

CREATE TABLE address_person (
 address_id INT NOT NULL,
 person_id INT NOT NULL
);

CREATE TABLE ContactPerson (
 id SERIAL,
 name VARCHAR(100) NOT NULL,
 phoneNumber VARCHAR(30) NOT NULL,
 student_person_id INT
);

CREATE TABLE Instructor (
 person_id INT NOT NULL,
 employment_id VARCHAR(30) NOT NULL
);

CREATE TABLE Instrument (
 id SERIAL,
 description TEXT,
 type_id INT NOT NULL,
 brand_id INT NOT NULL
);

CREATE TABLE Lesson (
 id SERIAL,
 lessonName VARCHAR(30),
 time TIMESTAMP NOT NULL,
 duration INTERVAL,
 room_id INT,
 minCapacity INT NOT NULL DEFAULT 1,
 maxCapacity INT NOT NULL DEFAULT 1,
 price INT NOT NULL DEFAULT 0
);

CREATE TABLE Lesson_Proficiency (
 proficiency_id INT NOT NULL,
 lesson_id INT NOT NULL
);

CREATE TABLE person_proficiency (
 person_id INT NOT NULL,
 proficiency_id INT NOT NULL
);

CREATE TABLE Rental (
 id SERIAL,
 startTime TIMESTAMP NOT NULL,
 endTime TIMESTAMP NOT NULL,
 price INT,
 instrument_id INT NOT NULL,
 person_id INT NOT NULL
);

CREATE TABLE student_lesson (
 lesson_id INT NOT NULL,
 student_person_id INT NOT NULL
);

CREATE TABLE Ensemble (
 lesson_id INT NOT NULL,
 genre VARCHAR(30)
);

CREATE TABLE GroupLesson (
 lesson_id INT NOT NULL
);

CREATE TABLE IndividualLesson (
 lesson_id INT NOT NULL
);

CREATE TABLE instructor_lesson (
 lesson_id INT NOT NULL,
 instructor_person_id INT NOT NULL
);


ALTER TABLE Address ADD CONSTRAINT PK_Address PRIMARY KEY (id);
ALTER TABLE InstrumentBrand ADD CONSTRAINT PK_InstrumentBrand PRIMARY KEY (id);
ALTER TABLE InstrumentBrand ADD CONSTRAINT UC_InstrumentBrand UNIQUE (brand);
ALTER TABLE InstrumentType ADD CONSTRAINT PK_InstrumentType PRIMARY KEY (id);
ALTER TABLE InstrumentType ADD CONSTRAINT UC_InstrumentType UNIQUE (type);
ALTER TABLE Person ADD CONSTRAINT PK_Person PRIMARY KEY (id);
ALTER TABLE Person ADD CONSTRAINT UC_Person_personNumber UNIQUE (personNumber);
ALTER TABLE Person ADD CONSTRAINT UC_Person_phoneNumber UNIQUE (phoneNumber);
ALTER TABLE Person ADD CONSTRAINT UC_Person_email UNIQUE (email);
ALTER TABLE Proficiency ADD CONSTRAINT PK_Proficiency PRIMARY KEY (id);
ALTER TABLE Room ADD CONSTRAINT PK_Room PRIMARY KEY (id);
ALTER TABLE Room ADD CONSTRAINT FK_Room_Address FOREIGN KEY (address_id) REFERENCES Address(id) ON DELETE CASCADE;
ALTER TABLE SiblingRelationship ADD CONSTRAINT PK_SiblingRelationship PRIMARY KEY (id);
ALTER TABLE Student ADD CONSTRAINT PK_Student PRIMARY KEY (person_id);
ALTER TABLE Student ADD CONSTRAINT FK_Student_Person FOREIGN KEY (person_id) REFERENCES Person(id) ON DELETE CASCADE;
ALTER TABLE Student ADD CONSTRAINT FK_Student_SiblingRelationship FOREIGN KEY (siblingrelationship_id) REFERENCES SiblingRelationship(id) ON DELETE SET NULL;
ALTER TABLE address_person ADD CONSTRAINT PK_address_person PRIMARY KEY (address_id, person_id);
ALTER TABLE address_person ADD CONSTRAINT FK_address_person_Address FOREIGN KEY (address_id) REFERENCES Address(id) ON DELETE CASCADE;
ALTER TABLE address_person ADD CONSTRAINT FK_address_person_Person FOREIGN KEY (person_id) REFERENCES Person(id) ON DELETE CASCADE;
ALTER TABLE ContactPerson ADD CONSTRAINT PK_ContactPerson PRIMARY KEY (id);
ALTER TABLE ContactPerson ADD CONSTRAINT FK_ContactPerson_Student FOREIGN KEY (student_person_id) REFERENCES Student(person_id) ON DELETE CASCADE;
ALTER TABLE Instructor ADD CONSTRAINT PK_Instructor PRIMARY KEY (person_id);
ALTER TABLE Instructor ADD CONSTRAINT FK_Instructor_Person FOREIGN KEY (person_id) REFERENCES Person(id) ON DELETE CASCADE;
ALTER TABLE Instrument ADD CONSTRAINT PK_Instrument PRIMARY KEY (id);
ALTER TABLE Instrument ADD CONSTRAINT FK_Instrument_InstrumentType FOREIGN KEY (type_id) REFERENCES InstrumentType(id) ON DELETE CASCADE;
ALTER TABLE Instrument ADD CONSTRAINT FK_Instrument_InstrumentBrand FOREIGN KEY (brand_id) REFERENCES InstrumentBrand(id) ON DELETE CASCADE;
ALTER TABLE Lesson ADD CONSTRAINT PK_Lesson PRIMARY KEY (id);
ALTER TABLE Lesson ADD CONSTRAINT FK_Lesson_Room FOREIGN KEY (room_id) REFERENCES Room(id) ON DELETE SET NULL;
ALTER TABLE Lesson_Proficiency ADD CONSTRAINT PK_Lesson_Proficiency PRIMARY KEY (proficiency_id, lesson_id);
ALTER TABLE Lesson_Proficiency ADD CONSTRAINT FK_Lesson_Proficiency_Proficiency FOREIGN KEY (proficiency_id) REFERENCES Proficiency(id) ON DELETE CASCADE;
ALTER TABLE Lesson_Proficiency ADD CONSTRAINT FK_Lesson_Proficiency_Lesson FOREIGN KEY (lesson_id) REFERENCES Lesson(id) ON DELETE CASCADE;
ALTER TABLE person_proficiency ADD CONSTRAINT PK_person_proficiency PRIMARY KEY (person_id, proficiency_id);
ALTER TABLE person_proficiency ADD CONSTRAINT FK_person_proficiency_Person FOREIGN KEY (person_id) REFERENCES Person(id) ON DELETE CASCADE;
ALTER TABLE person_proficiency ADD CONSTRAINT FK_person_proficiency_Proficiency FOREIGN KEY (proficiency_id) REFERENCES Proficiency(id) ON DELETE CASCADE;
ALTER TABLE Rental ADD CONSTRAINT PK_Rental PRIMARY KEY (id);
ALTER TABLE Rental ADD CONSTRAINT FK_Rental_Instrument FOREIGN KEY (instrument_id) REFERENCES Instrument(id) ON DELETE SET NULL;
ALTER TABLE Rental ADD CONSTRAINT FK_Rental_Student FOREIGN KEY (person_id) REFERENCES Student(person_id) ON DELETE SET NULL;
ALTER TABLE student_lesson ADD CONSTRAINT PK_student_lesson PRIMARY KEY (lesson_id, student_person_id);
ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_Lesson FOREIGN KEY (lesson_id) REFERENCES Lesson(id) ON DELETE CASCADE;
ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_Student FOREIGN KEY (student_person_id) REFERENCES Student(person_id) ON DELETE CASCADE;
ALTER TABLE Ensemble ADD CONSTRAINT PK_Ensemble PRIMARY KEY (lesson_id);
ALTER TABLE Ensemble ADD CONSTRAINT FK_Ensemble_Lesson FOREIGN KEY (lesson_id) REFERENCES Lesson(id) ON DELETE CASCADE;
ALTER TABLE GroupLesson ADD CONSTRAINT PK_GroupLesson PRIMARY KEY (lesson_id);
ALTER TABLE GroupLesson ADD CONSTRAINT FK_GroupLesson_Lesson FOREIGN KEY (lesson_id) REFERENCES Lesson(id) ON DELETE CASCADE;
ALTER TABLE IndividualLesson ADD CONSTRAINT PK_IndividualLesson PRIMARY KEY (lesson_id);
ALTER TABLE IndividualLesson ADD CONSTRAINT FK_IndividualLesson_Lesson FOREIGN KEY (lesson_id) REFERENCES Lesson(id) ON DELETE CASCADE;
ALTER TABLE instructor_lesson ADD CONSTRAINT PK_instructor_lesson PRIMARY KEY (lesson_id, instructor_person_id);
ALTER TABLE instructor_lesson ADD CONSTRAINT FK_instructor_lesson_Lesson FOREIGN KEY (lesson_id) REFERENCES Lesson(id) ON DELETE CASCADE;
ALTER TABLE instructor_lesson ADD CONSTRAINT FK_instructor_lesson_Instructor FOREIGN KEY (instructor_person_id) REFERENCES Instructor(person_id) ON DELETE CASCADE;
