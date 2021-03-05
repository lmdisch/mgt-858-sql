/*

For this assignment we'll be using a special 'hospital' scheme, which contains data describing doctors, patients,
nurses, staffing schedules, procedures, prescriptions, and more!

Write a SQL statement showing a list of Physician Names, the total number of procedures
each Physician is certified to perform, and the total number of procedures each Physician performed.
Only show physicians who have been trained in a procedure or performed a procedure.
Please write your SQL script using a CTE.

Your result should look like this

      ```
        Name              | num_trained_procedures | performed_procedures
        ------------------+------------------------+------------
        Christopher Turk  | 5                      | 3
        John Wen          | 7                      | 2
        Todd Quinlan      | 3                      | 1
      ```
  */

WITH num_trained_procedures AS (
        SELECT P.Name AS Physicians,
               COUNT(T.Physician) AS num_trained_procedures
        FROM Physician P
            LEFT JOIN Trained_In T ON P.Employee_ID = T.Physician
        GROUP BY P.Name
),
    performed_procedures AS (
        SELECT P.Name AS Physicians,
               COUNT(U.Physician) AS performed_procedures
        FROM Physician P
            LEFT JOIN Undergoes U ON P.Employee_ID = U.Physician
        GROUP BY P.Name
    )
SELECT N.Physicians, N.num_trained_procedures, P.performed_procedures
FROM num_trained_procedures N
LEFT JOIN performed_procedures P ON N.Physicians = P.Physicians
WHERE N.num_trained_procedures > 0 OR P.performed_procedures > 0;

/*QUESTION 2: What is the total number of hours each nurse spent on call across call shifts?
  How many shifts did each nurse work?
  Your final output should display the nurse's name, total number of hours worked, and
  total number of call shifts worked*/

SELECT N.Name,
       SUM(CAST((julianday(On_Call_End) - julianday(On_Call_Start)) * 24.0 As INTEGER)) AS tot_call_hours,
       COUNT(C.Nurse) AS num_shifts
FROM On_Call C
    LEFT JOIN Nurse N ON C.Nurse = N.Employee_ID
GROUP BY Name;

/*QUESTION 3: For patients that stayed in the hospital, How many days did they stay in the hospital?*/
SELECT P.Name,
    CAST((julianday(S.Stay_End) - julianday(S.Stay_Start)) As INTEGER) AS tot_days
FROM Stay S
    LEFT JOIN Patient P ON S.Patient = P.SSN
GROUP BY Name;

/*Question 4: What percent of hospital rooms are unavailable for each Block Code?
  Express your solution in decimals. Order by percent unavailable descending.*/

SELECT Block_Code,
       ROUND((CAST(COUNT(CASE WHEN Unavailable THEN 1 END) AS FLOAT) / COUNT(Room_Number)),3) AS percent_utilized
FROM Room
GROUP BY Block_Code
ORDER BY percent_utilized DESC;








