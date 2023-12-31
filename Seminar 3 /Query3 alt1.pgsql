SELECT instructor_person_id, person.name, month_lesson_count
FROM (
    person JOIN (
        SELECT instructor_person_id,count(*) as month_lesson_count FROM (
            instructor_lesson JOIN (
                SELECT id FROM lesson WHERE date_trunc('month', time) = date_trunc('month',current_date) AND date_trunc('year', time) = date_trunc('year', current_date)
                ) ON id = instructor_lesson.lesson_id
            ) GROUP BY instructor_person_id
        ) ON instructor_person_id = person.id)
WHERE month_lesson_count > 0;