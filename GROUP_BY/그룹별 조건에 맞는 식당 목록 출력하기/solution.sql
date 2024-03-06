SELECT
    A.MEMBER_NAME,
    B.REVIEW_TEXT,
    DATE_FORMAT(B.REVIEW_DATE, '%Y-%m-%d') AS REVIEW_DATE
FROM
    MEMBER_PROFILE AS A
JOIN
    REST_REVIEW AS B ON A.MEMBER_ID = B.MEMBER_ID
WHERE
    B.MEMBER_ID IN (
        SELECT
            MEMBER_ID
        FROM
            REST_REVIEW
        GROUP BY
            MEMBER_ID
        HAVING
            COUNT(MEMBER_ID) = (
                SELECT
                    COUNT(MEMBER_ID) AS MAX_REVIEW_COUNT
                FROM
                    REST_REVIEW
                GROUP BY
                    MEMBER_ID
                ORDER BY
                    MAX_REVIEW_COUNT DESC
                LIMIT
                    1
            )    
    )
ORDER BY
    B.REVIEW_DATE, B.REVIEW_TEXT