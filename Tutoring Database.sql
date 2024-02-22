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

-- Total Sent Feedback 

SELECT Count(Feedback) as Total_sent
FROM lesson_history
WHERE Feedback = 'sent'

-- Percentage of feedback sent per month - Shows the percentage of feedbacks sent out of total sessions per month.

SELECT 
(COUNT(CASE WHEN Feedback = 'sent' THEN 1 END) * 100.0) / COUNT(feedback) AS 'Sent Feedback Percentage'
FROM lesson_history
WHERE MONTH(Date) = 11 

-- Percentage of pending feedback per month - Shows the percentage of feedbacks still pending out of total sessions per month.

SELECT 
(COUNT(CASE WHEN Feedback = 'pending' THEN 1 END) * 100.0) / COUNT(feedback) AS 'Pending Feedback Percentage'
FROM lesson_history
WHERE MONTH(Date) = 10

-- Busiest day of the week - Shows the day of the week with the most number of sessions

SELECT TOP (1)
DATENAME(dw, DATE) as busiest_day, Count(Feedback) as total_sessions
FROM lesson_history
Group by  DATENAME(dw, DATE)
Order by total_sessions DESC

-- Frequency of students per curriculum - Shows the number students in a given curriculum, ie. UK, American, IB, SABIS

SELECT COUNT(Curriculum) as No_of_UK_students
FROM student_profile
WHERE Curriculum = 'UK'

-- Join Two Tables -- Join the table and combine them for data visualization

SELECT his.Date, his.Students, his.Topics, his.Feedback, 
prof.Year_level, prof.Curriculum, prof.study_plan
FROM dbo.lesson_history as his
Join dbo.student_profile as prof
	On his.Students = prof.Name
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
