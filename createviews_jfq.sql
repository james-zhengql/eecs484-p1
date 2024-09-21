CREATE VIEW View_Photo_Information AS
SELECT
    A.album_id,
    A.album_owner_id,
    P2.photo_id,
    A.album_name,
    A.album_created_time,
    A.album_modified_time,
    A.album_link,
    A.album_visibility,
    P.photo_id,
    P.photo_caption,
    P.photo_created_time,
    P.photo_modified_time,
    P.photo_link
FROM Albums A
JOIN Photos P ON A.album_id = P.album_id
JOIN Photos P2 ON A.cover_photo_id = P2.photo_id

CREATE VIEW View_Event_Information AS
SELECT
    E.event_id,
    E.event_creator_id,
    E.event_name,
    E.event_tagline,
    E.event_description,
    E.event_host,
    E.event_type,
    E.event_subtype,
    E.event_address,
    C.city_name,
    C.state_name,
    C.country_name,
    E.event_start_time,
    E.event_end_time
FROM User_Events E
JOIN Cities C ON E.event_city_id = C.city_id


CREATE VIEW View_Tag_Information AS
SELECT
    P.photo_id,
    T.tag_subject_id
    T.tag_created_time,
    T.tag_x,
    T.tag_y
FROM Tags T
JOIN Photos P ON T.tag_photo_id = P.photo_id

