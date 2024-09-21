CREATE TABLE User_Events
(
    event_id INTEGER PRIMARY KEY,
    event_creator_id INTEGER NOT NULL,
    event_name VARCHAR2(100) NOT NULL,
    event_tagline VARCHAR2(100),
    event_description VARCHAR2(100),
    event_host VARCHAR2(100),
    event_type VARCHAR2(100),
    event_subtype VARCHAR2(100),
    event_address VARCHAR2(2000),
    event_city_id INTEGER Not Null,
    event_start_time TIMESTAMP,
    event_end_time TIMESTAMP,
    FOREIGN KEY (event_creator_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (event_city_id) REFERENCES Cities(city_id) ON DELETE CASCADE
);

CREATE TABLE Participants
(
    event_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    confirmation VARCHAR2(100) NOT NULL,
    PRIMARY KEY (event_id, user_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (event_id) REFERENCES User_Events(event_id) ON DELETE CASCADE,
    CHECK (confirmation IN ('Attending', 'Unsure', 'Declines', 'Not_Replied'))
);

CREATE TABLE Albums
(
    album_id INTEGER PRIMARY KEY,
    album_owner_id INTEGER NOT NULL,
    album_name VARCHAR2(100) NOT NULL,
    album_created_time TIMESTAMP NOT NULL,
    album_modified_time TIMESTAMP,
    album_link VARCHAR2(2000) NOT NULL,
    album_visibility VARCHAR2(100) NOT NULL,
    cover_photo_id INTEGER NOT NULL, -- circular dependency
    FOREIGN KEY (album_owner_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    CHECK (album_visibility IN ('Everyone', 'Friends', 'Friends_Of_Friends', 'Myself')) 
);

CREATE TABLE Photos
(
    photo_id INTEGER PRIMARY KEY,
    album_id INTEGER NOT NULL, -- circular dependency
    photo_caption VARCHAR2(2000),
    photo_created_time TIMESTAMP NOT NULL,
    photo_modified_time TIMESTAMP, --current?
    photo_link VARCHAR2(2000) NOT NULL,
    FOREIGN KEY (album_id) REFERENCES Albums(album_id) ON DELETE CASCADE,
);

CREATE TABLE Tags
(
    tag_photo_id INTEGER NOT NULL,
    tag_subject_id INTEGER NOT NULL,
    tag_created_time INTEGER NOT NULL,
    tag_x NUMBER NOT NULL,
    tag_y NUMBER NOT NULL,
    PRIMARY KEY (tag_photo_id, tag_subject_id),
    FOREIGN KEY (tag_photo_id) REFERENCES Photos(photo_id) ON DELETE CASCADE,
    FOREIGN KEY (tag_subject_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Question here
ALTER TABLE Albums ADD CONSTRAINT photo_covered
FOREIGN KEY (cover_photo_id) REFERENCES Photos(photo_id) INITIALLY DEFERRED DEFERRABLE;

ALTER TABLE Photos ADD CONSTRAINT Albums_belonged
FOREIGN KEY (album_id) REFERENCES Albums(album_id) INITIALLY DEFERRED DEFERRABLE;


CREATE SEQUENCE album_id_seq
    START WITH 1
    INCREMENT BY 1;

CREATE TRIGGER album_id_trigger
    BEFORE INSERT ON Albums
    FOR EACH ROW
        BEGIN
            SELECT album_id_seq.NEXTVAL INTO :NEW.album_id FROM DUAL;
        END;
/

-- ??
CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1;

CREATE TRIGGER user_id_trigger
    BEFORE INSERT ON Users
    FOR EACH ROW
        BEGIN
            SELECT user_id_seq.NEXTVAL INTO :NEW.user_id FROM DUAL;
        END;
/

CREATE SEQUENCE photo_id_seq
    START WITH 1
    INCREMENT BY 1;

CREATE TRIGGER photo_id_trigger
    BEFORE INSERT ON Photos
    FOR EACH ROW
        BEGIN
            SELECT photo_id_seq.NEXTVAL INTO :NEW.photo_id FROM DUAL;
        END;
/