/*

For this assignment we'll be using a special 'hospital' database 👨‍⚕️👩‍⚕️💉, which contains data describing doctors, patients, 
nurses, staffing schedules, procedures, prescriptions, and more! 

You will see that this hospital has a world class staff :)

Before jumping into the questions, it would be helpful to review the database schema and corresponding tables. We'll leave it to you and your
newfound skills on how to do this.

Let's dive into this data.

To get started, let's figure out who are top-money making doctors are. 🤑🤑🤑

Write a query that shows doctors who performed a procedure and the total revenue they received in the dataset
(e.g., your query will calculate the sum of revenues for each procedures by doctor).


Your result should look like:

      ```
        physician               | revenue 
        ------------------------+-----------
        John Wen    		    | 48524                 
        Christopher Turk        | 27200         
        Bruce Banner    		| 24025       
        Stephen Strange			| 7525
        Kyle Percival Jensen    | 5025          
        Todd Quinlan			| 4899				
      ```
        (6 rows)
*/

SELECT 
	(SELECT P.employee_name
  	 FROM physicians P
  	 WHERE U.physician = P.employee_id
	) AS physician_name,
    SUM(Pr.procedure_cost) AS revenue
FROM undergoes U
    JOIN procedures Pr ON U.procedure = Pr.procedure_code
GROUP BY physician_name
ORDER BY revenue DESC;

/*

CHA-ching 🤑🤑, I love seeing our physicians bringing in money to the hospital. I'm now curious when these revenues were actually
generated. Are we earning revenue consistently every week?

Write a SQL query that shows the revenue earned for each week that a procedure was performed and the cumulative revenue earned up to that point (e.g., 
your table should show the week [if a procedure was performed], the revenues earned in that week, and the total revenues earned up to that week)

Your result should look like:

	```
		week	weekly_revenue	 running_total_revenue
		------+----------------+---------------------
		01	  | 5625		   | 5625
		03	  | 1500	       | 7125
		05	  | 3750	       | 10875
		06	  | 5600	       | 16475
		07	  | 1000	       | 17475
		09	  | 13100	       | 30575
		10	  | 25		       | 30600
		11	  | 4500	       | 35100
		13	  | 26025	       | 61125
		14	  | 4899	       | 66024
		18	  | 1025	       | 67049
		20	  | 5000	       | 72049
		22	  | 15000	       | 87049
		23	  | 15500	       | 102549
		24	  | 3750	       | 106299
		29	  | 6000	       | 112299
		31	  | 4899	       | 117198
	```
		(17 rows)
*/

WITH int_table AS (
	SELECT 
    	TO_CHAR(U.surgery_date,'WW') AS week,
    	SUM(Pr.procedure_cost) AS weekly_revenue
    FROM undergoes U
    	JOIN procedures Pr ON U.procedure = Pr.procedure_code
    GROUP BY week
    ORDER BY week
)
SELECT 
	week,
    weekly_revenue,
    SUM(weekly_revenue) OVER (ORDER BY week) AS running_total_revenue
FROM int_table;

/*

The hospital management is really surprised how much revenues fluctuate from week to week (and that some weeks we don't perform 
procedures at all!!). 

For the data we do have, calculate the rolling average weekly revenue of the current week and past 3 weeks where there was revenue.

Your rolling average weekly revenue should be shown to two decimal places.

Your result should look like:

	```
		week	weekly_revenue	 rolling_avg_revenue
		------+----------------+---------------------
		01	  | 5625		   | 5625.00
		03	  | 1500	       | 3562.50
		05	  | 3750	       | 3625.00
		06	  | 5600	       | 4118.75
		07	  | 1000	       | 2962.50
		09	  | 13100	       | 5862.50
		10	  | 25		       | 4931.25
		11	  | 4500	       | 4656.25
		13	  | 26025	       | 10912.50
		14	  | 4899	       | 8862.25
		18	  | 1025	       | 9112.25
		20	  | 5000	       | 9237.25
		22	  | 15000	       | 6481.00
		23	  | 15500	       | 9131.25
		24	  | 3750	       | 9812.50
		29	  | 6000	       | 10062.50
		31	  | 4899	       | 7537.25
	```
		(17 rows)
*/

WITH int_table AS (
	SELECT 
    	TO_CHAR(U.surgery_date,'WW') AS week,
    	SUM(Pr.procedure_cost) AS weekly_revenue
    FROM undergoes U
    	JOIN procedures Pr ON U.procedure = Pr.procedure_code
    GROUP BY week
    ORDER BY week
)
SELECT 
	week,
    weekly_revenue,
    ROUND(AVG(weekly_revenue) OVER (ORDER BY week rows BETWEEN 3 preceding AND current row),2) AS rolling_avg_revenue
FROM int_table;

/*

Let's take a closer look at our physicians trained to do procedures. 

Write a SQL statement showing a list of physician names, the total number of procedures
each physician is certified to perform, and the total number of procedures each physician has performed.

Only show physicians who have been trained in a procedure or who have performed a procedure.

Order your query by the number of procedures a physician has performed, descending.

Please write your SQL script using a CTE.


Your result should look like:

      ```
        physician               | num_trained_procedures | num_performed_procedures
        ------------------------+------------------------+-------------------------
        John Wen    		    | 6                      | 9
        Bruce Banner            | 1                      | 6
        Christopher Turk    	| 5                      | 5
        Kyle Percival Jensen    | 4                      | 3
        Stephen Strange			| 2						 | 2
        Todd Quinlan			| 3						 | 1
      ```
        (6 rows)
*/

WITH num_trained_procedures AS (
      SELECT P.employee_name as physician,
             COUNT(T.physician_id) AS num_trained_procedures
      FROM physicians P
  		LEFT JOIN trained_in T ON P.employee_id = T.physician_id
      GROUP BY P.employee_name
  ),
  	performed_procedures AS (
      SELECT P.employee_name as physician,
      		 COUNT(U.physician) AS num_performed_procedures
      FROM physicians P
      	LEFT JOIN undergoes U on P.employee_id = U.physician
      GROUP BY P.employee_name
  )
SELECT 	N.physician,
		N.num_trained_procedures,
        Pr.num_performed_procedures
FROM num_trained_procedures N
	LEFT JOIN performed_procedures Pr ON N.physician = Pr.physician
WHERE N.num_trained_procedures > 0 OR Pr.num_performed_procedures > 0;

/*

Hmm...I know we are just looking at counts of procedures performed, but something seems off. Let's dig deeper.

Have any doctors performed a procedure that they were certified to perform, but the actual procedure was done after 
the doctor's certification in that procedure expired?

Write a SQL query to find out.

Your table should show the physician's name, the name of the procedure, the date the procedure was performed,
the patient who received the procedure, and the date the doctor's certification for that procedure expired.

Please format the procedure date and certification expiration date in the format 'MM/DD/YYYY'.

Order your results by the certification expiration date, ascending.


Your result should look like:

     ```
        physician_name          | procedure                  | procedure_date  | patient_name   | cert_expiration_date
        ------------------------+----------------------------+-----------------+----------------+---------------------
        Kyle Percival Jensen    | Partial SQLelectomy        | 05/15/2020      | Darius Oliver  | 01/01/2017
        John wen 				| Obfuscated Dermogastrotomy | 08/01/2020      | Amber Wright	| 01/01/2018
        Christopher Turk		| Reverse Rhinopodoplasty    | 03/02/2020      | Dennis Doe     | 01/01/2019
      ```
        (3 rows)


** Hint: Be careful with the daterange range type in PostgreSQL. You may find the following documentation helpful: 
- https://www.postgresql.org/docs/9.3/rangetypes.html
- https://www.postgresql.org/docs/13/functions-formatting.html **
*/

SELECT P.employee_name AS physician_name,
       Pr.procedure_name AS procedure,
       TO_CHAR(U.surgery_date,'MM/DD/YYYY') AS procedure_date,
       Pt.patient_name AS patient_name,
       TO_CHAR(upper(T.certification_length),'MM/DD/YYYY') AS cert_expiration_date
FROM physicians P, undergoes U, patients Pt, procedures Pr, trained_in T
WHERE U.patient = Pt.SSN
  AND U.procedure = Pr.procedure_code
  AND U.physician = P.employee_id
  AND Pr.procedure_code = T.procedure_id
  AND P.employee_id = T.physician_id
  AND U.surgery_date > upper(T.certification_length)
ORDER BY cert_expiration_date ASC;

/*

Welp...that is concerning. Looks like we need to have a chat with a few doctors about their procedure licensing requirements. 

Given this, let's find out if any doctors have performed procedures that they are not certified to perform at all...

Write a query that shows the doctor, procedure, date of procedure, and name of the patient for any instances where a doctor 
performed a procedure for which they're not trained to perform.

Again, please format the procedure date in the format 'MM/DD/YYYY'. Order your results by most recent procedure date 
to oldest procedure date.


Your result should look like:

    ```
		physician			   | procedure				    | procedure_date	| patient
		-----------------------+----------------------------+-------------------+--------------
		Stephen Strange		   | Magic-ectomy				| 07/15/2020		| Wanda Maximoff
		Bruce Banner		   | Appendectomy				| 04/30/2020		| Steven Lopez
		Bruce Banner		   | Magic-ectomy				| 03/30/2020		| Megan Castro
		Bruce Banner		   | Complete SQLelectomy		| 03/29/2020		| Megan Moore
		Bruce Banner		   | Follicular Demiectomy		| 03/25/2020		| William Spencer
		Kyle Percival Jensen   | Follicular Demiectomy		| 03/09/2020		| Lisa Powell
		Bruce Banner		   | Magic-ectomy				| 02/28/2020		| Melinda Smith
		Bruce Banner		   | Reverse Appendectomy		| 02/13/2020		| Mary Graham
		Stephen Strange		   | Reverse Rhinopodoplasty	| 01/16/2020		| Stephen Anderson
		Stephen Strange		   | Follicular Demiectomy		| 01/02/2020		| Lisa Lee
	```
        (10 rows)
*/

SELECT 	P.employee_name AS physician, 
		Pr.procedure_name AS procedure, 
        TO_CHAR(U.surgery_date,'MM/DD/YYYY') AS procedure_date, 
        Pt.patient_name AS patient
FROM physicians P, undergoes U, patients Pt, procedures Pr
WHERE U.patient = Pt.SSN
  AND U.procedure = Pr.procedure_code
  AND U.physician = P.employee_id
  AND NOT EXISTS
              (
                SELECT * FROM trained_in T
                WHERE T.procedure_id = U.procedure
                AND T.physician_id = U.physician
              )
 ORDER BY procedure_date DESC;

/*

Looks like we might need to fire 3 of our physicians (and Dr. Banner is one of our top three revenue generators 😭😭😭!!))

Now, let's take a look at some patient data. 

What is the minimum, average, and max amount of time (in days) that patients have stayed in the hospital 
(for those patients that did stay in the hospital)?

Express your calculages to one decimal place.


Your result should look like:

     ```
        min_days  | avg_days   | max_days
        ----------+------------+----------
        1.0       | 4.8        | 97.0
     ```
        (1 row)

** Hint: Be careful about calculating the difference between two dates in postgreSQL. You might find the date_part function useful here. 
Don't forget to convert your difference in days to a numeric value!! 
- https://www.postgresql.org/docs/8.1/functions-datetime.html
- https://www.postgresql.org/docs/8.1/functions-math.html
*/

SELECT 
    ROUND(MIN(DATE_PART('day',stay_end::timestamp - stay_start::timestamp))::numeric,1) AS min_days,
	ROUND(AVG(DATE_PART('day',stay_end::timestamp - stay_start::timestamp))::numeric,1) AS avg_days,
    ROUND(MAX(DATE_PART('day',stay_end::timestamp - stay_start::timestamp))::numeric,1) AS max_days
FROM stays;

/*

This is really interesting...it looks like we have some patients who are outliers and stay in the hospital much longer than others.

Now that we know the min, average, and max, let's make a histogram of the number of days the patients spend in the hospital so we can 
get a better look at this distribution.

For this histogram, let's use the awesome WIDTH_BUCKET function in PostgreSQL to create bins. Use the values you just calculated in the 
previous query to help solve this. Let's see some granularity and add in 20 bins into the WIDTH_BUCKET parameter**.


Your result should look like:

	 ```
		bin_name        | num_patients
		----------------+---------------
		1 to 4 days		| 824
		5 to 9 days		| 36
		10 to 14 days	| 2
		15 to 19 days	| 1
		20 to 24 days	| 2
		29 to 33 days	| 2
		34 to 38 days	| 1
		39 to 43 days	| 2
		49 to 52 days	| 1
		53 to 57 days	| 2
		63 to 67 days	| 1
		68 to 72 days	| 1
		77 to 81 days	| 4
		87 to 91 days	| 2
		97 to 100 days	| 1
	 ```
		(15 rows)


**Hint: Here, because our range of hospital stay length ranges from 1 through 97, you might not actually end up with 20 bins.
It would also be helpful to review the CONCAT function (or other ways to concatenate information) to achieve the above result. While you 
could use the other options to create histograms in PostgreSQL (e.g., calculate values using the FLOOR function, 
let's stick to using the WIDTH_BUCKET function :)**
*/

SELECT 
    CONCAT(1 + ((bucket-1) * (97-1)/20), ' to ', (1 + (bucket) * (97-1)/20) - 1, ' days') AS bin_name, 
    num_patients 
    FROM (
        SELECT 
      		width_bucket(ROUND(DATE_PART('day',stay_end::timestamp - stay_start::timestamp)::numeric,1), 1, 97, 20) AS bucket, 
            COUNT(*) AS num_patients
        FROM stays
        GROUP BY bucket 
        ORDER BY bucket
    ) AS bucket_table;

/*ALT SOLUTION OF EQUAL BIN SIZES USING FLOOR FUNCTION*/
SELECT
    bin_floor,
    CONCAT(bin_floor, ' to ', bin_ceiling, ' days') AS bin_name,
    COUNT(*) as num_patients
FROM (
	SELECT 
		FLOOR(ROUND(DATE_PART('day',stay_end::timestamp - stay_start::timestamp)::numeric,1)/5.00)*5 AS bin_floor,
		FLOOR(ROUND(DATE_PART('day',stay_end::timestamp - stay_start::timestamp)::numeric,1)/5.00)*5 + 4 AS bin_ceiling
	FROM stays
) AS intermediate
GROUP BY bin_floor, bin_name
ORDER BY bin_floor;

/*
Have patients ever met with doctors who are not their primary care providers (PCP)? 

Show a list of instances where
this has happened. Your table should include the patient's name, the physician they met with (not their PCP),
their actual PCP, and the day of the week of their appointment (hint, a CASE statement might be useful here).
Do patients meet with doctors other than PCP more during the week or more during the weekend?

Your result should look like...

     ```
        patient_name  	| physician_name            | primary_care_physician_name | day_of_week
        ----------------+---------------------------+-----------------------------+---------------------
        Alejandro Evans | John Wen    	            | Bob Kelso            	      | Saturday
        Kanye West    	| Nauman Ferdinand Charania | Kyle Percival Jensen	      | Saturday
      ```
        (2 rows)
*/

SELECT Pt.patient_name AS patient_name,
       Ph.employee_name AS physician_name,
       PhPCP.employee_name AS pcp_name,
       TO_CHAR(App.appointment_date,'Day') AS day_of_week
FROM patients Pt, physicians Ph, physicians PhPCP, appointments App 
	LEFT JOIN nurses N 
    	ON App.prep_nurse = N.nurse_id
WHERE App.patient_id = Pt.SSN
	AND App.physician = Ph.employee_id
   	AND Pt.primary_care_provider = PhPCP.employee_id
   	AND App.physician <> Pt.primary_care_provider;

/*

With some patients staying in the hospital for almost 100 days, I'd be really curious to see what our room utilization has
looked like over the data.

Write a SQL query to calculate the average room utilization for each month in the dataset (data is from January 2020 to August 2020).

Show room utilization to two decimal places (e.g., if room utilization is 26.27%, have the table show "26.27")


Your result should look like:

	 ```
		month |	room_utilization      
		------+-----------------
		1	  | 26.29
		2	  | 30.52 
		3	  | 35.43
		4	  | 33.22
		5	  | 30.05
		6	  | 33.67
		7	  | 29.46
		8	  | 45.00
	 ```
		(8 rows)
*/

SELECT 
	EXTRACT(MONTH FROM room_date) AS month,
    ROUND(AVG(CAST(room_available = false AS int))*100,2) AS room_utilization
FROM room_stays
GROUP BY month
ORDER BY month;

/*

Using the above utilization table, let's now show a table that shows the percent change in utilization from month to month. 

Write a SQL query to calculate the month over month percent change from the previous table.


Your result should look like:

	 ```
		month |	room_utilization  | percent_change 
		------+-------------------+-----------------
		1	  | 26.29             | null
		2	  | 30.52 		      | 16.09
		3	  | 35.43             | 16.09
		4	  | 33.22             | -6.24
		5	  | 30.05             | -9.54
		6	  | 33.67             | 12.05
		7	  | 29.46             | -12.50
		8	  | 45.00             | 52.75
	 ```
		(8 rows)
*/

WITH room_util AS (
  	SELECT 
      EXTRACT(MONTH FROM room_date) AS month,
      ROUND(AVG(CAST(room_available = false AS int))*100,2) AS room_utilization
	FROM room_stays
	GROUP BY month
	ORDER BY month
)
SELECT month,
       room_utilization,
       ROUND(((room_utilization/lag(room_utilization,1) OVER (ORDER BY month)) - 1) * 100,2) AS percent_change
FROM room_util;

