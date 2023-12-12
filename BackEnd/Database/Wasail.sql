create database wasail;
use wasail;

CREATE TABLE user_table (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    phone_number BIGINT,
    name VARCHAR(255),
    password VARCHAR(255),
    username VARCHAR(255),
    language ENUM('English', 'Urdu', 'Roman Urdu'),
    user_type ENUM('Admin', 'Grocery Store', 'Vendor')
);

INSERT INTO user_table (phone_number, name, password, username, language, user_type) VALUES
(03215566778899, 'Fizza Adeel', 12345, 'fizza', 'English', 'Vendor');

SELECT * FROM user_table;