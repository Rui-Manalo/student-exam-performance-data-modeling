
CREATE TABLE raw_students AS
SELECT * FROM read_csv_auto('student_exam_performance.csv');



DROP TABLE raw_students;