/*

For this assignment we'll be using a special 'hospital' database, which contains data describing doctors, patients,
nurses, staffing schedules, procedures, prescriptions, and more! You will see that this hospital has a world class
staff :)

Before jumping into the questions, it would be helpful to review the database schema and each table!

Write a SQL statement showing a list of physician names, the total number of procedures
each Physician is certified to perform, and the total number of procedures each Physician performed.
Only show physicians who have been trained in a procedure or performed a procedure.
Please write your SQL script using a CTE.

Your result should look like this

      ```
        physicians              | num_trained_procedures | performed_procedures
        ------------------------+------------------------+------------
        Christopher Turk        | 5                      | 3
        John Wen                | 7                      | 2
        Kyle Percival Jensen    | 1                      | 2
        Todd Quinlan            | 3                      | 1
      ```
        (4 rows)
*/

WITH num_trained_procedures AS (
        SELECT P.Name AS physicians,
               COUNT(T.Physician) AS num_trained_procedures
        FROM Physician P
            LEFT JOIN Trained_In T ON P.Employee_ID = T.Physician
        GROUP BY P.Name
),
    performed_procedures AS (
        SELECT P.Name AS physicians,
               COUNT(U.Physician) AS performed_procedures
        FROM Physician P
            LEFT JOIN Undergoes U ON P.Employee_ID = U.Physician
        GROUP BY P.Name
    )
SELECT N.physicians, N.num_trained_procedures, P.performed_procedures
FROM num_trained_procedures N
LEFT JOIN performed_procedures P ON N.physicians = P.physicians
WHERE N.num_trained_procedures > 0 OR P.performed_procedures > 0;

/*
What is the total number of hours each nurse spent on call across call shifts?
How many shifts did each nurse work?

Your final output should display the nurse's name, total number of hours worked, and total number of call shifts worked,
which looks like...

      ```
        Name              | tot_call_hours | num_shifts
        ------------------+----------------+------------
        Carla Espinosa    | 14             | 2
        Laverne Roberts   | 7              | 1
        Paul Flowers      | 24             | 3
      ```
        (3 rows)
*/

SELECT N.Name,
       SUM(CAST((julianday(On_Call_End) - julianday(On_Call_Start)) * 24.0 As INTEGER)) AS tot_call_hours,
       COUNT(C.Nurse) AS num_shifts
FROM On_Call C
    LEFT JOIN Nurse N ON C.Nurse = N.Employee_ID
GROUP BY Name;

/*
 What is the average amount of days that patients stayed in the hospital?

 Your result should look like

```
    avg_days
    --------
    76.2
```
    (1 row)

*/

SELECT AVG(CAST((julianday(Stay_End) - julianday(Stay_Start)) As INTEGER)) AS avg_days
FROM Stay;


/*
WHOA! That's a pretty long average time to stay in the hospital!!! What is going on here?

Let's look at the total number of days each patient stayed in the hospital. Order your query by
the total days patients stayed in the hospital. Who stayed in the hospital the longest?

Your result should look like

      ```
        Name                | tot_days
        --------------------+----------------
        Kim K. West         | 365
        Random J. Patient   | 11
        Dennis Doe          | 1
        Dougie Dougerson    | 1
        John Smith          | 3
      ```
        (5 rows)
*/

SELECT P.Name,
    CAST((julianday(S.Stay_End) - julianday(S.Stay_Start)) As INTEGER) AS tot_days
FROM Stay S
    LEFT JOIN Patient P ON S.Patient = P.SSN
GROUP BY Name
ORDER BY tot_days DESC;


/*
What is the hospital room utilization for each Block Code?
Express your solution in decimals. Order by percent unavailable descending

Your result should be...

      ```
        block_code  | percent_utilized
        ------------+-----------------
        1           | 0.25
        3           | 0.167
        2           | 0.167
      ```
        (3 rows)
*/

SELECT Block_Code,
       ROUND((CAST(COUNT(CASE WHEN Unavailable THEN 1 END) AS FLOAT) / COUNT(Room_Number)),3) AS percent_utilized
FROM Room
GROUP BY Block_Code
ORDER BY percent_utilized DESC;

/*
Have any doctors performed a procedure for which they're not trained?
Write a query that shows the doctor, procedure, date of procedure, and name of the patient
for any instances where a doctor performed a procedure for which they're not trained.

Your result:

      ```
        physician               | procedure             | date       | patient
        ------------------------+-----------------------+------------+-----------
        Christopher Turk        | Complete Walletectomy | 2008-05-10 | Dennis Doe
        Kyle Percival Jensen    | Heart Transplant      | 2020-03-13 | Kim K. West
        Kyle Percival Jensen    | Cardioversion         | 2021-03-31 | Dougie Dougerson
      ```
        (3 rows)
*/

SELECT P.Name AS Physician, Pr.Name AS Procedure, U.Date, Pt.Name AS Patient
  FROM Physician P, Undergoes U, Patient Pt, Procedures Pr
  WHERE U.Patient = Pt.SSN
    AND U.Procedures = Pr.Code
    AND U.Physician = P.Employee_ID
    AND NOT EXISTS
              (
                SELECT * FROM Trained_In T
                WHERE T.Treatment = U.Procedures
                AND T.Physician = U.Physician
              );


/*
  What is the average dose of medication prescribed to a patient
  who hasn't had an appointment by doctor? Show the name of the doctor,
  the average dose they have prescribed to all of their patients without appointments,
  as well as the rank of average dose of medication prescribed descending (e.g.,
  the doctor with the highest average dose should show up first)

  Your table should look like

  ```
        physician_name              | average_dose  | dose_rank
        ----------------------------+---------------+------------
        Kyle Percival Jensen        | 125           | 1
        Gregory House               | 20            | 2
        Nauman Alabaster Charania   | 17.5          | 3
        Molly Clock                 | 5             | 4
  ```
        (4 rows)

*/

SELECT P.Name,
       AVG(Pr.Dose) as average_dose,
       RANK() OVER (ORDER BY AVG(Pr.Dose) DESC) AS dose_rank
FROM Prescribes Pr
    CROSS JOIN  Physician P on Pr.Physician = P.Employee_ID
WHERE Pr.Appointment IS NULL
GROUP BY Pr.Physician;


/*
Write a query that shows doctors who performed a procedure and the total revenue they received each year
(e.g., your query will calculate the sum of revenues from procedures by doctor and year).

Your table should look like

  ```
        physician_name          | year  | revenue
        ------------------------+-------+------------
        Christopher Turk        | 2008  | 10000
        Kyle Percival Jensen    | 2020  | 10000
        Christopher Turk        | 2008  | 5600
        Todd Quinlan            | 2008  | 4899
        John Wen                | 2008  | 3750
        Kyle Percival Jensen    | 2021  | 3500
        Christopher Turk        | 2008  | 1500
        John Wen                | 2008  | 25
```
        (8 rows)
*/

SELECT (SELECT P.Name
        FROM Physician P
        WHERE U.Physician = P.Employee_ID) as physician_name,
      strftime('%Y',U.Date) AS year,
      SUM(P.Cost) AS revenue
FROM Undergoes U
    CROSS JOIN Procedures P on U.Procedures = P.Code
GROUP BY name, year
ORDER BY revenue DESC;


/*
This seems to be a pretty alarming hospital...

I am concerned...have any doctors performed a procedure they were certified to perform, but that
the actual procedure was done after the doctor's certification in that procedure expired?

Your table should show the doctor's name, the name of the proedure, the date the procedure was performed,
the patient who received the procedure, and the date the doctor's certification for that procedure expired, like this:

     ```
        physician_name          | procedure                  | procedure_date  | patient_name | cert_expiration_date
        ------------------------+----------------------------+-----------------+--------------+---------------------
        Todd Quinlan            | Obfuscated Dermogastrotomy | 2008-05-10 | Dennis Doe   | 2007-12-31
        Kyle Percival Jensen    | Heart Transplant           | 2020-03-13 | Kim K. West  | 2008-12-31
      ```
        (2 rows)
*/

SELECT P.Name AS physician_name,
       Pr.Name AS procedure,
       U.Date as procedure_date,
       Pt.Name AS patient_name,
       T.Certification_Expires AS cert_expiration_date
  FROM Physician P, Undergoes U, Patient Pt, Procedures Pr, Trained_In T
  WHERE U.Patient = Pt.SSN
    AND U.Procedures = Pr.Code
    AND U.Physician = P.Employee_ID
    AND Pr.Code = T.Treatment
    AND P.Employee_ID = T.Physician
    AND U.Date > T.Certification_Expires;

/*

Have patients ever met with doctors who are not their primary care providers (PCP)? Show a list of instances where
this has happened. Your table should include the patient's name, the physician they met with (not their PCP),
their actual PCP, and the day of the week of their appointment (hint, a CASE statement might be useful here).
Do patients meet with doctors other than PCP more during the week or more during the weekend?

Your table should look like...

     ```
        patient_name  | physician_name       | primary_care_physician_name| day_of_week
        --------------+----------------------+----------------------------+---------------------
        Yeezy         | Kyle Percival Jensen | Nauman Alabaster Charania  | Sunday
        Dennis Doe    | Percival Cox         | Christopher Turk           | Friday
      ```
        (5 rows)



*/



SELECT Pt.Name AS patient_name,
       Ph.Name AS physician_name,
       PhPCP.Name AS primary_care_physician_name,
       CASE
            CAST(strftime('%w',A.Start) AS INTEGER)
            WHEN 0 THEN 'Sunday'
            WHEN 1 THEN 'Monday'
            WHEN 2 THEN 'Tuesday'
            WHEN 3 THEN 'Wednesday'
            WHEN 4 THEN 'Thursday'
            WHEN 5 THEN 'Friday'
            ELSE 'Saturday'
        END AS day_of_week
  FROM Patient Pt, Physician Ph, Physician PhPCP,
       Appointment A LEFT JOIN Nurse N ON A.Prep_Nurse = N.Employee_ID
 WHERE A.Patient = Pt.SSN
   AND A.Physician = Ph.Employee_ID
   AND Pt.PCP = PhPCP.Employee_ID
   AND A.Physician <> Pt.PCP;

