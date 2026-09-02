
CREATE TABLE STUDENT (
    student_id VARCHAR PRIMARY KEY, age INTEGER, gender VARCHAR
);
CREATE TABLE HOUSEHOLD (
    student_id VARCHAR PRIMARY KEY REFERENCES STUDENT(student_id),
    family_income VARCHAR, parent_education VARCHAR, urban_rural VARCHAR
);
CREATE TABLE ENROLLMENT (
    student_id VARCHAR PRIMARY KEY REFERENCES STUDENT(student_id),
    education_level VARCHAR, school_type VARCHAR,
    internet_access INTEGER, device_availability VARCHAR
);
CREATE TABLE ACADEMIC_HISTORY (
    student_id VARCHAR PRIMARY KEY REFERENCES STUDENT(student_id),
    previous_exam_score DOUBLE, previous_gpa DOUBLE,
    attendance_percentage DOUBLE, assignment_completion_rate DOUBLE,
    class_participation VARCHAR
);
CREATE TABLE STUDY_HABITS (
    student_id VARCHAR PRIMARY KEY REFERENCES STUDENT(student_id),
    study_hours_per_day DOUBLE, self_study_hours DOUBLE,
    online_learning_hours DOUBLE, online_course_hours DOUBLE,
    private_tuition INTEGER, study_consistency VARCHAR,
    study_environment VARCHAR, study_method VARCHAR,
    revision_frequency VARCHAR, practice_tests_completed INTEGER,
    notes_quality VARCHAR, educational_app_usage VARCHAR
);
CREATE TABLE LIFESTYLE_WELLBEING (
    student_id VARCHAR PRIMARY KEY REFERENCES STUDENT(student_id),
    sleep_hours DOUBLE, sleep_quality VARCHAR, daily_screen_time DOUBLE,
    physical_activity_hours DOUBLE, break_frequency VARCHAR,
    stress_level INTEGER, motivation_level VARCHAR
);
CREATE TABLE EXAM_ATTEMPT (
    attempt_id INTEGER PRIMARY KEY, student_id VARCHAR REFERENCES STUDENT(student_id),
    exam_difficulty VARCHAR, exam_preparation_days INTEGER,
    questions_attempted INTEGER, questions_correct INTEGER,
    time_management_score DOUBLE, exam_anxiety_level DOUBLE,
    exam_score DOUBLE, performance_grade VARCHAR,
    pass_status VARCHAR, performance_level VARCHAR
);