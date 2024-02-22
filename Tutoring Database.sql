
/* Introduction
Tutoring Database Data Exploration and Cleaning using SQL
Our project involves exploring and cleaning data from a tutoring database using SQL. 
We aim to extract valuable insights and perform necessary cleaning operations to enhance data quality. 
The skills employed include various SQL commands such as Select, Where, Count, Distinct, Order by, Group by, 
Joins, Case, CTE's, Temp Tables, Window Functions, and Aggregate Functions.
*/

/* Initial Data Exploration
We start by examining the lesson history data and student profiles. 
The initial data selected includes sessions with non-null dates, focusing on key information like date, students, topics, and feedback. 
This provides a clear view of the starting point for our analysis.
*/
	
SELECT * 
FROM lesson_history

SELECT * 
FROM student_profile 

SELECT Date, Students, Topics, Feedback
FROM lesson_history
WHERE Date is not null
ORDER BY 1, 4 DESC

/* Total Sessions and Students:
We calculate the total number of sessions and the count of distinct students. 
These metrics give us an overview of the overall activity within the tutoring database.
*/

SELECT Count (Feedback) as total_sessions
FROM lesson_history
WHERE Date is not null

SELECT Count(Distinct(Students)) as total_students
FROM lesson_history
WHERE Date is not null

/* Feedback Analysis:
Next, we analyze feedback data by determining the total number of sessions with feedback, the total number of sessions with sent feedback, 
	and the percentage of sent and pending feedback per month. 
This allows us to understand the engagement and responsiveness of the students.
*/
	
SELECT Count(Feedback) as Total_sent
FROM lesson_history
WHERE Feedback = 'sent'

-- Percentage of feedback sent in specific month i.e November

SELECT 
(COUNT(CASE WHEN Feedback = 'sent' THEN 1 END) * 100.0) / COUNT(feedback) AS 'Sent Feedback Percentage'
FROM lesson_history
WHERE MONTH(Date) = 11 

-- Percentage of pending feedback per month

SELECT 
(COUNT(CASE WHEN Feedback = 'pending' THEN 1 END) * 100.0) / COUNT(feedback) AS 'Pending Feedback Percentage'
FROM lesson_history
WHERE MONTH(Date) = 10

/* Busiest Day of the Week:
Identifying the busiest day of the week involves grouping sessions by day and determining the day with the highest number of sessions. 
This information can help optimize scheduling and resource allocation.
*/

SELECT TOP (1)
DATENAME(dw, DATE) as busiest_day, Count(Feedback) as total_sessions
FROM lesson_history
Group by  DATENAME(dw, DATE)
Order by total_sessions DESC

/* Curriculum-based Analysis:
We explore the distribution of students across different curricula.
This analysis provides insights into the concentration of students in specific educational programs.
*/

SELECT curriculum, COUNT(*) as curriculum_count
FROM student_profile
WHERE curriculum is not null
GROUP BY curriculum

/* Joining Tables for Comprehensive Analysis:
To enrich our analysis, we combine the lesson history and student profile tables using a join operation. 
This combined table includes relevant details such as date, students, topics, feedback, year level, curriculum, and study plan.
*/

SELECT his.Date, his.Students, his.Topics, his.Feedback, 
prof.Year_level, prof.Curriculum, prof.study_plan
FROM dbo.lesson_history as his
Join dbo.student_profile as prof
	On his.Students = prof.full_ame
WHERE Date is not null
ORDER BY 1, 4 DESC

-- CTE

WITH combinedtable as 
(
SELECT his.Date, his.Students, his.Topics, his.Feedback, 
prof.Year_level, prof.Curriculum, prof.study_plan
FROM dbo.lesson_history as his
Join dbo.student_profile as prof
	On his.Students = prof.Name
--WHERE Date is not null
--ORDER BY 1, 4 DESC
)
SELECT 
(COUNT(CASE WHEN Curriculum = 'UK' THEN 1 END) * 100.0) / COUNT(Curriculum) AS 'Percentage of UK Students'
FROM combinedtable






--
