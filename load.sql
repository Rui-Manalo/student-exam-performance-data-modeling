INSERT INTO STUDENT
    SELECT student_id, age, gender FROM stg_clean;

INSERT INTO HOUSEHOLD
    SELECT student_id, family_income, parent_education, urban_rural FROM stg_clean;

INSERT INTO ENROLLMENT
    SELECT student_id, education_level, school_type, internet_access, device_availability
    FROM stg_clean;

INSERT INTO ACADEMIC_HISTORY
    SELECT student_id, previous_exam_score, previous_gpa, attendance_percentage,
           assignment_completion_rate, class_participation
    FROM stg_clean;

INSERT INTO STUDY_HABITS
    SELECT student_id, study_hours_per_day, self_study_hours, online_learning_hours,
           online_course_hours, private_tuition, study_consistency, study_environment,
           study_method, revision_frequency, practice_tests_completed, notes_quality,
           educational_app_usage
    FROM stg_clean;

INSERT INTO LIFESTYLE_WELLBEING
    SELECT student_id, sleep_hours, sleep_quality, daily_screen_time,
           physical_activity_hours, break_frequency, stress_level, motivation_level
    FROM stg_clean;

INSERT INTO EXAM_ATTEMPT
    SELECT ROW_NUMBER() OVER (ORDER BY student_id) AS attempt_id,
           student_id, exam_difficulty, exam_preparation_days, questions_attempted,
           questions_correct, time_management_score, exam_anxiety_level, exam_score,
           performance_grade, pass_status, performance_level
    FROM stg_clean;