-- Active: 1700694131644@@thebastards.ddns.net@27756@project2@public
SELECT EXTRACT(MONTH from month_beginning) AS month, lesson_type, lesson_count
FROM (
    SELECT date_trunc('month',time) AS month_beginning, 'Individual' AS lesson_type, count(*) AS lesson_count
    FROM (lesson JOIN individuallesson ON (lesson.id = individuallesson.lesson_id))
    WHERE EXTRACT(YEAR from time) = 2023
    GROUP BY date_trunc('month', time)

    UNION ALL

    SELECT date_trunc('month',time) AS month_beginning,'Group' AS lesson_type,count(*) AS lesson_count
    FROM (lesson JOIN grouplesson ON (lesson.id = grouplesson.lesson_id))
    WHERE EXTRACT(YEAR from time) = 2023
    GROUP BY date_trunc('month', time)

    UNION ALL

    SELECT date_trunc('month',time) AS month_beginning,'Ensemble' AS lesson_type,count(*) AS lesson_count
    FROM (lesson JOIN ensemble ON (lesson.id = ensemble.lesson_id))
    WHERE EXTRACT(YEAR from time) = 2023
    GROUP BY date_trunc('month', time)

    UNION ALL

    SELECT date_trunc('month',time) AS month_beginning,'Total' AS lesson_type,count(*) AS lesson_count
    FROM lesson WHERE EXTRACT(YEAR from time) = 2023
    GROUP BY date_trunc('month', time)
    ORDER BY month_beginning, lesson_type
);
