-- 1. ROW COUNT CHECK
SELECT
    (SELECT COUNT(*) FROM raw_students)          AS raw_row_count,
    (SELECT COUNT(*) FROM STUDENT)                AS student_row_count,
    (SELECT COUNT(*) FROM HOUSEHOLD)               AS household_row_count,
    (SELECT COUNT(*) FROM ENROLLMENT)              AS enrollment_row_count,
    (SELECT COUNT(*) FROM ACADEMIC_HISTORY)        AS academic_history_row_count,
    (SELECT COUNT(*) FROM STUDY_HABITS)            AS study_habits_row_count,
    (SELECT COUNT(*) FROM LIFESTYLE_WELLBEING)     AS lifestyle_wellbeing_row_count,
    (SELECT COUNT(*) FROM EXAM_ATTEMPT)            AS exam_attempt_row_count;


-- 2. DUPLICATE KEY CHECK
SELECT student_id, COUNT(*) AS occurrences
FROM STUDENT
GROUP BY student_id
HAVING COUNT(*) > 1;


-- 3. REFERENTIAL INTEGRITY CHECK
SELECT h.student_id FROM HOUSEHOLD h
LEFT JOIN STUDENT s ON s.student_id = h.student_id
WHERE s.student_id IS NULL;

SELECT e.student_id FROM ENROLLMENT e
LEFT JOIN STUDENT s ON s.student_id = e.student_id
WHERE s.student_id IS NULL;

SELECT a.student_id FROM ACADEMIC_HISTORY a
LEFT JOIN STUDENT s ON s.student_id = a.student_id
WHERE s.student_id IS NULL;

SELECT sh.student_id FROM STUDY_HABITS sh
LEFT JOIN STUDENT s ON s.student_id = sh.student_id
WHERE s.student_id IS NULL;

SELECT lw.student_id FROM LIFESTYLE_WELLBEING lw
LEFT JOIN STUDENT s ON s.student_id = lw.student_id
WHERE s.student_id IS NULL;

SELECT ea.student_id FROM EXAM_ATTEMPT ea
LEFT JOIN STUDENT s ON s.student_id = ea.student_id
WHERE s.student_id IS NULL;


-- 4. CATEGORICAL VALUE CHECK
SELECT DISTINCT gender FROM STUDENT;
SELECT DISTINCT family_income, parent_education, urban_rural FROM HOUSEHOLD;
SELECT DISTINCT education_level, school_type, device_availability FROM ENROLLMENT;
SELECT DISTINCT class_participation FROM ACADEMIC_HISTORY;
SELECT DISTINCT study_consistency, study_environment, study_method,
       revision_frequency, notes_quality, educational_app_usage FROM STUDY_HABITS;
SELECT DISTINCT sleep_quality, break_frequency, motivation_level FROM LIFESTYLE_WELLBEING;
SELECT DISTINCT exam_difficulty, performance_grade, pass_status, performance_level
FROM EXAM_ATTEMPT;


-- 5. NUMERIC RANGE CHECK
SELECT * FROM STUDENT
WHERE age NOT BETWEEN 10 AND 100;

SELECT * FROM ACADEMIC_HISTORY
WHERE previous_exam_score NOT BETWEEN 0 AND 100
   OR previous_gpa NOT BETWEEN 0 AND 4.0
   OR attendance_percentage NOT BETWEEN 0 AND 100
   OR assignment_completion_rate NOT BETWEEN 0 AND 100;

SELECT * FROM LIFESTYLE_WELLBEING
WHERE stress_level NOT BETWEEN 1 AND 10;

SELECT * FROM EXAM_ATTEMPT
WHERE exam_score NOT BETWEEN 0 AND 100
   OR time_management_score NOT BETWEEN 0 AND 100
   OR exam_anxiety_level NOT BETWEEN 1 AND 10;


-- 6. BOOLEAN FLAG CHECK
SELECT * FROM STUDY_HABITS WHERE private_tuition NOT IN (0, 1);
SELECT * FROM ENROLLMENT WHERE internet_access NOT IN (0, 1);


-- 7. CROSS FIELD BUSINESS RULE CHECKd
SELECT * FROM EXAM_ATTEMPT
WHERE questions_correct > questions_attempted;


-- 8. STUDENT ID FORMAT CHECK
SELECT student_id FROM STUDENT
WHERE student_id !~ '^STU_\d{6}$';


-- 9. SPOT CHECK SAMPLE

SELECT s.student_id, s.age, s.gender, h.family_income, sh.study_hours_per_day,
       ea.exam_score, ea.pass_status
FROM STUDENT s
JOIN HOUSEHOLD h ON h.student_id = s.student_id
JOIN STUDY_HABITS sh ON sh.student_id = s.student_id
JOIN EXAM_ATTEMPT ea ON ea.student_id = s.student_id
USING SAMPLE 10 ROWS;