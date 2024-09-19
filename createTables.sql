CREATE TABLE Users
(
    user_id INTEGER PRIMARY KEY,
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100) NOT NULL,
    year_of_birth INTEGER,
    month_of_birth INTEGER,
    day_of_birth INTEGER,
    gender VARCHAR2(100)
);

CREATE TABLE Friends
(
    user1_id INTEGER,
    user2_id INTEGER,
    PRIMARY KEY (user1_id, user2_id),
    FOREIGN KEY (user1_id) REFERENCES Users (user_id) ON DELETE CASCADE,
    FOREIGN KEY (user2_id) REFERENCES Users (user_id) ON DELETE CASCADE,
    CHECK (user1_id != user2_id)
);

CREATE TABLE Cities
(
    city_id INTEGER PRIMARY KEY,
    city_name VARCHAR2(100) NOT NULL,
    state_name VARCHAR2(100) NOT NULL,
    country_name VARCHAR2(100) NOT NULL,
    UNIQUE (city_name, state_name, country_name)
);

CREATE TABLE User_Current_Cities
(
    user_id INTEGER,
    current_city_id INTEGER,
    PRIMARY KEY (user_id, current_city_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (current_city_id) REFERENCES Cities(city_id) ON DELETE CASCADE
);

CREATE TABLE User_Hometown_Cities
(
    user_id INTEGER,
    hometown_city_id INTEGER,
    PRIMARY KEY (user_id, hometown_city_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (hometown_city_id) REFERENCES Cities(city_id) ON DELETE CASCADE
);

CREATE TABLE Messages
(
    message_id INTEGER NOT NULL,
    sender_id INTEGER NOT NULL,
    receiver_id INTEGER NOT NULL,
    message_content VARCHAR2(2000) NOT NULL,
    sent_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Programs
(
    program_id INTEGER PRIMARY KEY,
    institution VARCHAR2(100) NOT NULL,
    concentration VARCHAR2(100) NOT NULL,
    degree VARCHAR2(100) NOT NULL,
    UNIQUE (institution, concentration, degree)
);

CREATE TABLE Education
(
    user_id INTEGER NOT NULL,
    program_id INTEGER NOT NULL,
    program_year INTEGER NOT NULL,
    PRIMARY KEY (user_id, program_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (program_id) REFERENCES Programs(program_id) ON DELETE CASCADE
);


CREATE TRIGGER Order_Friend_Pairs
    BEFORE INSERT ON Friends
    FOR EACH ROW
        DECLARE temp INTEGER;
        BEGIN
            IF :NEW.user1_id > :NEW.user2_id THEN
                temp := :NEW.user2_id;
                :NEW.user2_id := :NEW.user1_id;
                :NEW.user1_id := temp;
            END IF;
        END;
/
 
CREATE SEQUENCE program_id_seq
    START WITH 1
    INCREMENT BY 1;

CREATE TRIGGER program_id_trigger
    BEFORE INSERT ON Programs
    FOR EACH ROW
        BEGIN
            SELECT program_id_seq.NEXTVAL INTO :NEW.program_id FROM DUAL;
        END;
/

CREATE SEQUENCE city_id_seq
    START WITH 1
    INCREMENT BY 1;

CREATE TRIGGER city_id_trigger
    BEFORE INSERT ON Cities
    FOR EACH ROW
        BEGIN
            SELECT city_id_seq.NEXTVAL INTO :NEW.city_id FROM DUAL;
        END;
/
