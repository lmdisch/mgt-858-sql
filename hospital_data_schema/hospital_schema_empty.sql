/*physicians table*******************************************************************************************************************/
DROP TABLE IF EXISTS physicians;
CREATE TABLE physicians (
  employee_id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  employee_name text UNIQUE NOT NULL CHECK (char_length(employee_name) > 0 AND char_length(employee_name) <= 100),
  employee_position text NOT NULL,
  SSN int NOT NULL 
); 

/*departments table*******************************************************************************************************************/
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
  department_id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  department_name text NOT NULL,
  head_employee int NOT NULL REFERENCES physicians(employee_id) ON UPDATE CASCADE
);

/*affiliated_with table*******************************************************************************************************************/
DROP TABLE IF EXISTS affiliated_with CASCADE;
CREATE TABLE affiliated_with (
  physician_id int NOT NULL REFERENCES physicians(employee_id) ON UPDATE CASCADE,
  department_id int NOT NULL REFERENCES departments(department_id) ON UPDATE CASCADE,
  primary_affiliation bool NOT NULL
);

/*procedures table*******************************************************************************************************************/
DROP TABLE IF EXISTS procedures CASCADE;
CREATE TABLE procedures (
  procedure_code int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  procedure_name text NOT NULL,
  procedure_cost int NOT NULL
);

/*trained_in table*******************************************************************************************************************/
DROP TABLE IF EXISTS trained_in CASCADE;
CREATE TABLE trained_in (
  table_code int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  physician_id int NOT NULL REFERENCES physicians(employee_id) ON UPDATE CASCADE,
  procedure_id int NOT NULL REFERENCES procedures(procedure_code) ON UPDATE CASCADE,
  certification_length daterange NOT NULL
);

/*patients table*******************************************************************************************************************/
DROP TABLE IF EXISTS patients CASCADE;
CREATE TABLE patients (
  patient_id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  SSN int UNIQUE NOT NULL,
  patient_name text NOT NULL,
  address text NOT NULL,
  phone text NOT NULL,
  insurance_id int NOT NULL,
  primary_care_provider int NOT NULL REFERENCES physicians(employee_id)
);

                                                                                               
/*nurses table*******************************************************************************************************************/
DROP TABLE IF EXISTS nurses CASCADE;
CREATE TABLE nurses (
  nurse_id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  nurse_name text NOT NULL,
  nurse_position text NOT NULL,
  registered bool NOT NULL,
  SSN int NOT NULL
);
                                                                                    
/*appointments table*******************************************************************************************************************/
DROP TABLE IF EXISTS appointments CASCADE;
CREATE TABLE appointments (
  appointment_id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  patient_id int NOT NULL REFERENCES patients(SSN) ON UPDATE CASCADE,
  prep_nurse int NOT NULL REFERENCES nurses(nurse_id) ON UPDATE CASCADE,
  physician int  NOT NULL REFERENCES physicians(employee_id) ON UPDATE CASCADE,
  appointment_date date NOT NULL,
  exam_room text NOT NULL
);

/*medications table*******************************************************************************************************************/
DROP TABLE IF EXISTS medications CASCADE;
CREATE TABLE medications (
  code int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name text NOT NULL,
  brand text NOT NULL,
  description text NOT NULL
);

/*prescribes table*******************************************************************************************************************/
DROP TABLE IF EXISTS prescribes CASCADE;
CREATE TABLE prescribes (
  physician int NOT NULL REFERENCES physicians(employee_id) ON UPDATE CASCADE,
  patient int NOT NULL REFERENCES patients(SSN) ON UPDATE CASCADE,
  medication int NOT NULL REFERENCES medications(code) ON UPDATE CASCADE,
  appt_date date NOT NULL,
  dose text NOT NULL
);

/*room_available table*******************************************************************************************************************/
DROP TABLE IF EXISTS rooms CASCADE;
CREATE TABLE rooms (
	room_number int UNIQUE NOT NULL PRIMARY KEY,
	room_type text NOT NULL
);

/*room_stays table*******************************************************************************************************************/
DROP TABLE IF EXISTS room_stays CASCADE;
CREATE TABLE room_stays (
	room_day_id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	room_number int NOT NULL REFERENCES rooms(room_number) ON UPDATE CASCADE,
	room_date date NOT NULL,
	patient_SSN int REFERENCES patients(SSN) ON UPDATE CASCADE,
	room_available bool NOT NULL
);

/*stays table*******************************************************************************************************************/
DROP TABLE IF EXISTS stays CASCADE;
CREATE TABLE stays (
  stay_id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  patient_SSN int NOT NULL REFERENCES patients(SSN) ON UPDATE CASCADE,
  room_number int NOT NULL REFERENCES rooms(room_number) ON UPDATE CASCADE,
  stay_start date NOT NULL,
  stay_end date NOT NULL
);

/*undergoes table*******************************************************************************************************************/
DROP TABLE IF EXISTS undergoes CASCADE;
CREATE TABLE undergoes (
  patient int NOT NULL REFERENCES patients(SSN) ON UPDATE CASCADE,
  procedure int NOT NULL REFERENCES procedures(procedure_code) ON UPDATE CASCADE,
  surgery_date date NOT NULL,
  physician int NOT NULL REFERENCES physicians(employee_id) ON UPDATE CASCADE,
  nurse int REFERENCES nurses(nurse_id) ON UPDATE CASCADE
);
