SELECT count(*) AS no_of_students,no_of_siblings
FROM (
    student JOIN (
        SELECT siblingrelationship_id AS family,count(*) - 1 AS no_of_siblings 
        FROM student
        GROUP BY siblingrelationship_id
    ) ON student.siblingrelationship_id = family
)
GROUP BY no_of_siblings ORDER BY no_of_siblings;
