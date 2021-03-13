#!/usr/bin/env python
# coding: utf-8

# # MGT 858: Database Systems
# ## Hospital Data Schema
# 
# The code written below seeks to add data to a postgresql database

# ### Import packages

# In[1]:


get_ipython().system('pip install faker')


# In[6]:


import random
import numpy as np
import pandas as pd
from datetime import timedelta
import datetime
import sqlite3
from faker import Faker


# ### Add randomly generated patients to the hospital 

# In[8]:


# Pre-existing SSNs for patients
SSN_list = [500000001, 500000002, 500000003, 500000004, 500000005, 500000006, 500000007, 500000008]

# Create randomly generated data for new patients
def add_patients(num_to_add):
    fake = Faker()
    for i in range(num_to_add):
        SSN = 500000009 + i
        SSN_list.append(SSN)
        full_name = fake.name()
        address = fake.address()
        phone_number = str(random.randint(100,999)) + "-" + str(random.randint(1000,9999))
        insurance_id = random.randint(10000000,99999999)
        pcp = random.randint(1,13)
        print(f"INSERT INTO patients (SSN, patient_name, address, phone, insurance_id, primary_care_provider) VALUES({SSN}, '{full_name}', '{address}', '{phone_number}', {insurance_id}, {pcp});")  


# In[9]:


# Call add_patients function and add 100 generated patients
add_patients(100)


# ## Add patient stays to the hospital for given set of rooms

# In[14]:


# Define hospital rooms
rooms =  [i+j for i in range(100, 700, 100) for j in range(1, 11)]

# Defines dates for which we will generate hospital stays
dates = pd.to_datetime(pd.date_range(start="2020-01-01",end="2020-05-10"))

# Defines a function that returns a dataframe of randomly generated patient stays
def patient_stays():
    # Create empty dataframe
    cols = ['date','patient_SSN','room_number','stay_start','stay_end']
    data = pd.DataFrame(columns = cols)
    
    # Create empty dictionaries to store patient and room data
    occupied_rooms = {}
    admitted_patients = {}
    
    # Iterate over all the days in the date range of interest
    for date in dates:
        daily_arrival = random.randint(0,3) # Here, we say on any day, between 0-3 people will arrive randomly
        daily_patient_arrival = random.sample(SSN_list,daily_arrival) # Select the 0-3 patients from the patient list
        
        # If the occupied_rooms/admitted_patients dictionary is not empty, subtract 1 day from the amount of 
        # time a patient is in the hospital from the total time they were set to stay in the hospital
        if len(occupied_rooms) != 0:
            occupied_rooms = {key: val - 1 for key, val in occupied_rooms.items()}
    
        if len(admitted_patients) != 0:
            admitted_patients = {key: val - 1 for key, val in admitted_patients.items()}
        
        # Delete patients and rooms from the list if they free up after a patient stay
        admitted_patients = {key:val for key, val in admitted_patients.items() if val >= 0}              
        occupied_rooms = {key:val for key, val in occupied_rooms.items() if val >= 0}    
        
        # Iterate over the randomly generated list of patients
        for patient in daily_patient_arrival:
            
            # If the randomly generated patient is already in the hospital, do nothing; 
            # If the randomly generated patient is new, assign them a room and hospital stay length in days
            if (patient not in admitted_patients):
                
                # Randomly sample a room
                assigned_room = random.choice(rooms)
                
                # If the room is already occupied, keep checking for a free room
                while (assigned_room in occupied_rooms): 
                    assigned_room = random.choice(rooms)

                # Here, we say people stay on average 2 day with a 1 day std.dev.    
                stay_length = abs(round(np.random.normal(2,1),0)) 
                stay_start = datetime.datetime.strptime(str(date),'%Y-%m-%d %H:%M:%S').date()
                stay_end = stay_start + datetime.timedelta(days=stay_length)
                
                # Add new patient/room (key) and stay_length (value) to the occupied_rooms and admitted_patients dictionaries
                occupied_rooms[assigned_room] = stay_length
                admitted_patients[patient] = stay_length

                data = data.append({'date':stay_start,'patient_SSN':patient,'room_number':assigned_room,'stay_start':stay_start,'stay_end':stay_end},ignore_index=True)
                
    return data


# ## Check added patient stay data for duplicates or error entries 

# In[15]:


# Call patient_stays function 
stay_data = patient_stays()

# Number of rows in data
print(len(stay_data.index))

# Check for duplicates (e.g., there should not be two entries with same data and room_number)
stay_data = stay_data.drop_duplicates(subset=['date','room_number'])

# Number of rows in clean data
print(len(stay_data.index))


# ## Create dataframe for each day and each hospital room

# In[ ]:


# Define function that creates dataframe with entry for each day in desired date range and each hospital room ("room_table")
def room_table():
    cols = ['date','room_number']
    room_df = pd.DataFrame(columns = cols)
    for date in dates:
        for room in rooms:
            current_room = room
            current_date = date
            room_df = room_df.append({'date':current_date,'room_number':current_room},ignore_index=True)
    return room_df        


# In[ ]:


# Call function
room_df = room_table()  


# ## Merge room_table with stay_data for database schema 

# In[ ]:


# Use python sqlite3 to merge
conn = sqlite3.connect(':memory:')

# Send room_df and stay_data to sql
room_df.to_sql('rooms', conn, index=False)
stay_data.to_sql('stay_data', conn, index=False)


# In[ ]:


# SQL code to merge the two tables
qry = '''
    SELECT a.date, a.room_number, b.patient_SSN, b.stay_start, b.stay_end
    FROM rooms a
        LEFT JOIN stay_data b ON (a.date >= b.stay_start AND a.date <= b.stay_end) AND a.room_number = b.room_number
    ORDER BY a.date, a.room_number;
    '''
# Send output of SQL query to pandas df
df = pd.read_sql_query(qry,conn)

# Output dataframes to csv for additional error checking
stay_data.to_csv('stay_data_check.csv')
df.to_csv('df_check.csv')


# ## Add availability column to dataframe and write INSERT INTO statements 

# In[ ]:


# Add new availability column (true=room available, false = room occupied)
df['room_available'] = np.where(np.isnan(df['patient_SSN']),True,False)

# Remove timestamp from date column
df['date'] = pd.to_datetime(df['date'])
df['date'] = df['date'].dt.date

# Convert patient_SSN from float64 to object
df['patient_SSNs'] = np.where(np.isnan(df['patient_SSN']),'Null',df['patient_SSN'])
df['patient_SSNs'] = df['patient_SSNs'].str.replace('.0','',regex=False)


# In[ ]:


# Create SQL insert statements for 'room_stays' table
for index, row in df.iterrows():
    print(f"INSERT INTO room_stays (room_number, room_date, patient_SSN, room_available) VALUES({row['room_number']},'{row['date']}',{row['patient_SSNs']},{row['room_available']});")


# In[ ]:


# Create SQL insert statements for 'rooms' table
for room in rooms:
    print(f"INSERT INTO rooms (room_number, room_type) VALUES({room},'Single');")


# In[ ]:


# Create SQL insert statements for 'stays' table
for index, row in df.iterrows():
    if row['patient_SSNs'] != 'Null':
        print(f"INSERT INTO stays (patient_SSN, room_number, stay_start, stay_end) VALUES({row['patient_SSNs']},{row['room_number']},'{row['stay_start']}','{row['stay_end']}');")

