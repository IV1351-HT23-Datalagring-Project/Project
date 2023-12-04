SELECT COUNT(lesson.id) AS "No of Lessons", person_id, person.name
FROM instructor
JOIN instructor_lesson ON instructor.person_id = instructor_lesson.instructor_person_id
JOIN lesson ON instructor_lesson.lesson_id = lesson.id
JOIN person ON instructor.person_id=person.id
WHERE EXTRACT(YEAR from time) = 2023 AND EXTRACT(MONTH from time) = 11
GROUP BY person_id,person.name WHERE "No of lessons" > 0 
