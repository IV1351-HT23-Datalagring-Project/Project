SELECT 
    CASE
        WHEN EXTRACT(ISODOW FROM lesson.time)=1 THEN 'Mon'
        WHEN EXTRACT(ISODOW FROM lesson.time)=2 THEN 'Tue'
        WHEN EXTRACT(ISODOW FROM lesson.time)=3 THEN 'Wed'
        WHEN EXTRACT(ISODOW FROM lesson.time)=4 THEN 'Thu'
        WHEN EXTRACT(ISODOW FROM lesson.time)=5 THEN 'Fri'
        WHEN EXTRACT(ISODOW FROM lesson.time)=6 THEN 'Sat'
        WHEN EXTRACT(ISODOW FROM lesson.time)=7 THEN 'Sun'
    END AS "weekday",
    ensemble.genre AS Genre,

    CASE 
        WHEN lesson.maxCapacity - COUNT(student_lesson.student_person_id) = 0 THEN 'No Seats'
        WHEN (lesson.maxCapacity - COUNT(student_lesson.student_person_id) = 1) OR (lesson.maxCapacity - COUNT(student_lesson.student_person_id) = 2) THEN '1 or 2 Seats'
        ELSE 'Many Seats'
    END AS "No of Free Seats"
FROM 
    lesson
JOIN 
    ensemble ON lesson.id = ensemble.lesson_id
LEFT JOIN 
    student_lesson ON lesson.id = student_lesson.lesson_id
WHERE 
    date_trunc('week', lesson.time) = date_trunc('week', current_date + interval '1 week')
GROUP BY 
     lesson.time, ensemble.genre,lesson.maxCapacity;
