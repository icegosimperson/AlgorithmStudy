WITH TMP AS(
    SELECT MEMBER_ID
         , COUNT(*) `CNT`
         , RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
         , REVIEW_DATE
         , REVIEW_TEXT
    FROM REST_REVIEW
    GROUP BY MEMBER_ID
)

SELECT B.MEMBER_NAME, A.REVIEW_TEXT, DATE_FORMAT(A.REVIEW_DATE, '%Y-%m-%d') `REVIEW_DATE`
FROM REST_REVIEW A
         JOIN MEMBER_PROFILE B USING(MEMBER_ID)
         JOIN TMP C USING(MEMBER_ID)
WHERE C.RNK = 1
ORDER BY A.REVIEW_DATE ASC, A.REVIEW_TEXT ASC