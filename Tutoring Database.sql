/*
Tutoring Database Data Exploration 

Skills used: Select, Where, Count, Distinct, Order by, Group by, Joins, Case,  CTE's, Temp Tables, Windows Functions, Aggregate Functions,

*/

SELECT * 
FROM lesson_history

SELECT * 
FROM student_profile

 -- Select data that we are going to be starting with.

SELECT Date, Students, Topics, Feedback
FROM lesson_history
WHERE Date is not null
ORDER BY 1, 4 DESC

-- Total Sessions - Shows how many sessions were conducted in total.

SELECT Count (Feedback) as total_sessions
FROM lesson_history
WHERE Date is not null

-- Total Students - Shows how many distinct students are there in total.

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
