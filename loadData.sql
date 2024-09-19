INSERT INTO Users (user_id,first_name,last_name,year_of_birth,month_of_birth,day_of_birth,gender)
SELECT user_id,first_name,last_name,year_of_birth,month_of_birth,day_of_birth,gender
FROM Public_User_Information;

INSERT INTO Cities (city_name,state_name,country_name)
SELECT DISTINCT current_city, current_state,current_country
FROM Public_User_Information;

INSERT INTO Cities (city_name,state_name,country_name)
SELECT DISTINCT hometown_city, hometown_state,hometown_country
FROM Public_User_Information;

INSERT INTO Programs (institution,concentration,degree)
SELECT DISTINCT institution_name,program_concentration,program_degree
FROM Public_User_Information;

INSERT INTO User_Current_Cities (user_id,current_city_id)
SELECT P.user_id, C.city_id 
FROM Public_User_Information P, Cities C
WHERE P.current_city = C.city_name
AND P.current_state = C.state_name
AND P.current_country = C.country_name;

INSERT INTO User_Hometown_Cities (user_id,hometown_city_id)
SELECT P.user_id, C.city_id 
FROM Public_User_Information P, Cities C
WHERE P.hometown_city = C.city_name
AND P.hometown_state = C.state_name
AND P.hometown_country = C.country_name;

INSERT INTO Education (user_id,program_id,program_year)
SELECT P.user_id, E.program_id, P.program_year
FROM Public_User_Information P, Programs E
WHERE P.institution_name = E.institution
AND P.program_concentration = E.concentration
AND P.program_degree = E.degree;

INSERT INTO Friends
SELECT * FROM Public_Are_Friends
WHERE user1_id < user2_id


