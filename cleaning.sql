CREATE OR REPLACE VIEW stg_clean AS
WITH deduped AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY student_id ORDER BY student_id) AS rn
    FROM raw_students
    WHERE student_id ~ '^STU_\d{6}$'        
),

typed AS (
    SELECT
        student_id,
        CASE WHEN TRY_CAST(age AS INTEGER) BETWEEN 10 AND 100
             THEN TRY_CAST(age AS INTEGER) END AS age,

        CASE LOWER(TRIM(gender))
            WHEN 'female' THEN 'Female' WHEN 'male' THEN 'Male'
            WHEN 'other'  THEN 'Other' END AS gender,

        CASE LOWER(TRIM(education_level))
            WHEN 'high school'   THEN 'High School'
            WHEN 'undergraduate' THEN 'Undergraduate' END AS education_level,

        CASE LOWER(TRIM(school_type))
            WHEN 'public' THEN 'Public' WHEN 'private' THEN 'Private'
            WHEN 'charter' THEN 'Charter' END AS school_type,

        NULLIF(TRIM(family_income), '') AS family_income,

        CASE LOWER(TRIM(parent_education))
            WHEN 'high school' THEN 'High School' WHEN 'associate' THEN 'Associate'
            WHEN 'bachelor' THEN 'Bachelor' WHEN 'master' THEN 'Master'
            WHEN 'doctorate' THEN 'Doctorate' END AS parent_education,

        CASE LOWER(TRIM(urban_rural))
            WHEN 'rural' THEN 'Rural' WHEN 'suburban' THEN 'Suburban'
            WHEN 'urban' THEN 'Urban' END AS urban_rural,

        CASE WHEN TRY_CAST(previous_exam_score AS DOUBLE) BETWEEN 0 AND 100
             THEN TRY_CAST(previous_exam_score AS DOUBLE) END AS previous_exam_score,
        CASE WHEN TRY_CAST(previous_gpa AS DOUBLE) BETWEEN 0 AND 4.0
             THEN TRY_CAST(previous_gpa AS DOUBLE) END AS previous_gpa,
        CASE WHEN TRY_CAST(attendance_percentage AS DOUBLE) BETWEEN 0 AND 100
             THEN TRY_CAST(attendance_percentage AS DOUBLE) END AS attendance_percentage,
        CASE WHEN TRY_CAST(assignment_completion_rate AS DOUBLE) BETWEEN 0 AND 100
             THEN TRY_CAST(assignment_completion_rate AS DOUBLE) END AS assignment_completion_rate,

        CASE LOWER(TRIM(class_participation))
            WHEN 'low' THEN 'Low' WHEN 'medium' THEN 'Medium' WHEN 'high' THEN 'High' END AS class_participation,

        TRY_CAST(study_hours_per_day AS DOUBLE) AS study_hours_per_day,
        TRY_CAST(self_study_hours AS DOUBLE) AS self_study_hours,
        TRY_CAST(online_learning_hours AS DOUBLE) AS online_learning_hours,
        TRY_CAST(online_course_hours AS DOUBLE) AS online_course_hours,

        CASE WHEN TRY_CAST(private_tuition AS INTEGER) IN (0, 1)
             THEN TRY_CAST(private_tuition AS INTEGER) END AS private_tuition,
        CASE WHEN TRY_CAST(internet_access AS INTEGER) IN (0, 1)
             THEN TRY_CAST(internet_access AS INTEGER) END AS internet_access,

        CASE LOWER(TRIM(study_consistency))
            WHEN 'low' THEN 'Low' WHEN 'medium' THEN 'Medium' WHEN 'high' THEN 'High' END AS study_consistency,

        CASE LOWER(TRIM(study_environment))
            WHEN 'quiet' THEN 'Quiet' WHEN 'moderate' THEN 'Moderate' WHEN 'noisy' THEN 'Noisy' END AS study_environment,

        CASE LOWER(TRIM(study_method))
            WHEN 'flashcards' THEN 'Flashcards' WHEN 'summarizing' THEN 'Summarizing'
            WHEN 'self-reading' THEN 'Self-Reading' WHEN 'practice tests' THEN 'Practice Tests'
            WHEN 'group study' THEN 'Group Study' END AS study_method,
        CASE LOWER(TRIM(revision_frequency))
            WHEN 'rarely' THEN 'Rarely' WHEN 'weekly' THEN 'Weekly' WHEN 'daily' THEN 'Daily' END AS revision_frequency,

        TRY_CAST(practice_tests_completed AS INTEGER) AS practice_tests_completed,

        CASE LOWER(TRIM(notes_quality))
            WHEN 'poor' THEN 'Poor' WHEN 'average' THEN 'Average' WHEN 'excellent' THEN 'Excellent' END AS notes_quality,

        TRY_CAST(sleep_hours AS DOUBLE) AS sleep_hours,
        CASE LOWER(TRIM(sleep_quality))
            WHEN 'poor' THEN 'Poor' WHEN 'fair' THEN 'Fair'
            WHEN 'good' THEN 'Good' WHEN 'excellent' THEN 'Excellent' END AS sleep_quality,
        TRY_CAST(daily_screen_time AS DOUBLE) AS daily_screen_time,
        TRY_CAST(physical_activity_hours AS DOUBLE) AS physical_activity_hours,

        CASE LOWER(TRIM(break_frequency))
            WHEN 'rarely' THEN 'Rarely' WHEN 'occasionally' THEN 'Occasionally'
            WHEN 'frequently' THEN 'Frequently' END AS break_frequency,
        CASE WHEN TRY_CAST(stress_level AS INTEGER) BETWEEN 1 AND 10
             THEN TRY_CAST(stress_level AS INTEGER) END AS stress_level,
        CASE LOWER(TRIM(motivation_level))
            WHEN 'low' THEN 'Low' WHEN 'medium' THEN 'Medium' WHEN 'high' THEN 'High' END AS motivation_level,

        CASE LOWER(TRIM(device_availability))
            WHEN 'shared' THEN 'Shared' WHEN 'dedicated' THEN 'Dedicated' END AS device_availability,
        CASE LOWER(TRIM(educational_app_usage))
            WHEN 'low' THEN 'Low' WHEN 'moderate' THEN 'Moderate' WHEN 'high' THEN 'High' END AS educational_app_usage,

        CASE LOWER(TRIM(exam_difficulty))
            WHEN 'easy' THEN 'Easy' WHEN 'medium' THEN 'Medium' WHEN 'hard' THEN 'Hard' END AS exam_difficulty,
        TRY_CAST(exam_preparation_days AS INTEGER) AS exam_preparation_days,
        TRY_CAST(questions_attempted AS INTEGER) AS questions_attempted_raw,
        TRY_CAST(questions_correct AS INTEGER) AS questions_correct_raw,
        CASE WHEN TRY_CAST(time_management_score AS DOUBLE) BETWEEN 0 AND 100
             THEN TRY_CAST(time_management_score AS DOUBLE) END AS time_management_score,
        CASE WHEN TRY_CAST(exam_anxiety_level AS DOUBLE) BETWEEN 1 AND 10
             THEN TRY_CAST(exam_anxiety_level AS DOUBLE) END AS exam_anxiety_level,
        CASE WHEN TRY_CAST(exam_score AS DOUBLE) BETWEEN 0 AND 100
             THEN TRY_CAST(exam_score AS DOUBLE) END AS exam_score,
        CASE UPPER(TRIM(performance_grade))
            WHEN 'A' THEN 'A' WHEN 'B' THEN 'B' WHEN 'C' THEN 'C'
            WHEN 'D' THEN 'D' WHEN 'F' THEN 'F' END AS performance_grade,
        CASE LOWER(TRIM(pass_status))
            WHEN 'pass' THEN 'Pass' WHEN 'fail' THEN 'Fail' END AS pass_status,
        CASE LOWER(TRIM(performance_level))
            WHEN 'low' THEN 'Low' WHEN 'medium' THEN 'Medium' WHEN 'high' THEN 'High' END AS performance_level
    FROM deduped
    WHERE rn = 1
)

SELECT
    * EXCLUDE (questions_attempted_raw, questions_correct_raw),
    CASE WHEN questions_correct_raw <= questions_attempted_raw
         THEN questions_attempted_raw END AS questions_attempted,
    CASE WHEN questions_correct_raw <= questions_attempted_raw
         THEN questions_correct_raw END   AS questions_correct
FROM typed;