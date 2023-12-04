SELECT COUNT(lesson.id) AS "No of Lessons", person_id, person.name
FROM instructor
JOIN instructor_lesson ON instructor.person_id = instructor_lesson.instructor_person_id
JOIN lesson ON instructor_lesson.lesson_id = lesson.id
JOIN person ON instructor.person_id=person.id
WHERE EXTRACT(YEAR FROM time) = EXTRACT(YEAR FROM CURRENT_DATE) AND EXTRACT(MONTH FROM time) = EXTRACT(MONTH FROM CURRENT_DATE)
GROUP BY person_id,person.name HAVING COUNT(lesson.id) > 0;
