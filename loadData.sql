INSERT INTO Users (user_id,first_name,last_name,year_of_birth,month_of_birth,day_of_birth,gender)
SELECT DISTINCT user_id,first_name,last_name,year_of_birth,month_of_birth,day_of_birth,gender
FROM project1.Public_User_Information;

INSERT INTO Cities (city_name, state_name, country_name)
SELECT DISTINCT current_city, current_state, current_country
FROM project1.Public_User_Information
UNION
SELECT DISTINCT hometown_city, hometown_state, hometown_country
FROM project1.Public_User_Information;


INSERT INTO Programs (institution,concentration,degree)
SELECT DISTINCT institution_name,program_concentration,program_degree
FROM project1.Public_User_Information
WHERE institution_name IS NOT NULL;

INSERT INTO User_Current_Cities (user_id,current_city_id)
SELECT DISTINCT P.user_id, C.city_id 
FROM project1.Public_User_Information P, Cities C
WHERE P.current_city = C.city_name
AND P.current_state = C.state_name
AND P.current_country = C.country_name;

INSERT INTO User_Hometown_Cities (user_id,hometown_city_id)
SELECT DISTINCT P.user_id, C.city_id 
FROM project1.Public_User_Information P, Cities C
WHERE P.hometown_city = C.city_name
AND P.hometown_state = C.state_name
AND P.hometown_country = C.country_name;

INSERT INTO Education (user_id,program_id,program_year)
SELECT P.user_id, E.program_id, P.program_year
FROM project1.Public_User_Information P, Programs E
WHERE P.institution_name = E.institution
AND P.program_concentration = E.concentration
AND P.program_degree = E.degree;

INSERT INTO Friends (user1_id, user2_id)
SELECT DISTINCT
    LEAST(P.user1_id, P.user2_id) AS user1_id,
    GREATEST(P.user1_id, P.user2_id) AS user2_id
FROM project1.Public_Are_Friends P;

SET AUTOCOMMIT OFF;

INSERT INTO Albums (album_id, album_owner_id, album_name, album_created_time, album_modified_time, album_link, album_visibility, cover_photo_id)
SELECT DISTINCT album_id, owner_id, album_name, album_created_time, album_modified_time, album_link, album_visibility, cover_photo_id
FROM project1.Public_Photo_Information;

INSERT INTO Photos (photo_id, album_id, photo_caption, photo_created_time, photo_modified_time, photo_link)
SELECT DISTINCT photo_id, album_id, photo_caption, photo_created_time, photo_modified_time, photo_link
FROM project1.Public_Photo_Information;

COMMIT;
SET AUTOCOMMIT ON;

INSERT INTO Tags (tag_photo_id, tag_subject_id, tag_created_time, tag_x, tag_y)
SELECT DISTINCT photo_id, tag_subject_id, tag_created_time, tag_x_coordinate, tag_y_coordinate
FROM project1.Public_Tag_Information;

INSERT INTO User_Events (event_id, event_creator_id, event_name, event_tagline, event_description, event_host, event_type, event_subtype, event_address, event_city_id, event_start_time, event_end_time)
SELECT DISTINCT E.event_id, E.event_creator_id, E.event_name, E.event_tagline, E.event_description, E.event_host, E.event_type, E.event_subtype, E.event_address, E.event_address, C.city_id, E.event_start_time, E.event_end_time
FROM project1.Public_Event_Information E, Cities C
WHERE E.event_city = C.city_name
AND E.event_state = C.state_name
AND E.event_country = C.country_name;

