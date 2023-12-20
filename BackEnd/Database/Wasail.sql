INSERT INTO user_tables (phone_number, name, password, username, language, user_type, created_at, updated_at) VALUES
(03215566778899, 'Fizza Adeel', 12345, 'fizza', 'English', 'Vendor', '2023-12-17T12:34:56', '2023-12-19T12:34:56');

INSERT INTO user_tables (phone_number, name, password, username, language, user_type, created_at, updated_at) VALUES
(03015353502, 'Ahmed', 54321, 'yrrebeere', 'Urdu', 'Vendor', '2023-12-17T12:34:56', '2023-12-19T12:34:56');

SELECT * FROM wasail.user_tables;

INSERT INTO vendors (vendor_name, delivery_locations, created_at, updated_at, user_table_user_id) VALUES
('Jalal Sons', 'Dha', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 1);
SELECT * FROM wasail.vendors;