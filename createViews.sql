CREATE VIEW View_User_Information AS
SELECT 
    U.user_id,
    U.first_name,
    U.last_name,
    U.year_of_birth,
    U.month_of_birth,
    U.day_of_birth,
    U.gender,
    C1.city_name AS current_city_name,
    C1.state_name AS current_state_name,
    C1.country_name AS current_country_name,
    C2.city_name AS hometown_city_name,
    C2.state_name AS hometown_state_name,
    C2.country_name AS hometown_country_name,
    P.institution,
    E.program_year,
    P.concentration,
    P.degree
FROM Users U
JOIN User_Current_Cities UC ON U.user_id = UC.user_id
JOIN Cities C1 ON UC.current_city_id = C1.city_id
JOIN User_Hometown_Cities HC ON U.user_id = HC.user_id
JOIN Cities C2 ON HC.hometown_city_id = C2.city_id
LEFT JOIN Education E on U.user_id = E.user_id
LEFT JOIN Programs P ON E.program_id = P.program_id;

CREATE VIEW VIEW_ARE_FRIENDS AS
SELECT user1_id,user2_id
FROM Friends;