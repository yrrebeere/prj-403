create database wasail;
use wasail;
INSERT INTO user_tables (phone_number, name, password, username, language, user_type, created_at, updated_at) VALUES
(03215566778899, 'Fizza Adeel', 12345, 'fizza', 'English', 'Vendor', '2023-12-17T12:34:56', '2023-12-19T12:34:56');
SELECT * FROM wasail.user_tables;

INSERT INTO user_tables (phone_number, name, password, username, language, user_type, created_at, updated_at) VALUES
(03215566778899, 'Fizza Adeel', 12345, 'fizza', 'English', 'Vendor', '2023-12-17T12:34:56', '2023-12-19T12:34:56');
SELECT * FROM wasail.user_tables;

INSERT INTO vendors (vendor_name, delivery_locations, created_at, updated_at, user_table_user_id) VALUES
('Jalal Sons', 'Dha', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 1);
SELECT * FROM wasail.vendors;

INSERT INTO grocery_stores (store_name, image, store_address, created_at, updated_at, user_table_user_id) VALUES
('Alfatah', 'Assets/Images/Products/lays-salted.png', '522-Statelife', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 1);
SELECT * FROM wasail.grocery_stores;

INSERT INTO orders (order_date, delivery_date, total_bill, order_status, created_at, updated_at, grocery_store_store_id, vendor_vendor_id) VALUES
('2023-01-01','2023-01-05','1000', 'Delivered', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 1,1);
SELECT * FROM wasail.orders;

INSERT INTO order_details (quantity, unit_price, total_price, created_at, updated_at, order_order_id) VALUES
('200','20','4000', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 1);
SELECT * FROM wasail.order_details;

INSERT INTO products (product_name,image,created_at, updated_at) VALUES
('lays','Assets/Images/Products/lays-salted.png','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('cocacola','Assets/Images/Products/cocacola.jpg','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('dasani-water','Assets/Images/Products/dasani-water.png','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('pepsi','Assets/Images/Products/pepsi.jpg','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('pepsi','Assets/Images/Products/pepsi.jpg','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('olpers-milk','Assets/Images/Products/olpers-milk.jpg','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('nestle-milk','Assets/Images/Products/nestle-milk.jpg','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('shan-noodles','Assets/Images/Products/shan-noodles.jpg','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('knorr-noodles','Assets/Images/Products/knorr-noodles.png','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('knorr-ketchup','Assets/Images/Products/knorr-ketchup.png','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('aquafina-water','Assets/Images/Products/aquafina-water.png','2023-12-17T12:34:56', '2023-12-19T12:34:56');
SELECT * FROM wasail.products;

INSERT INTO product_categories (category_name, created_at, updated_at) VALUES
('drinks','2023-12-17T12:34:56', '2023-12-19T12:34:56');
SELECT * FROM wasail.product_categories;

INSERT INTO product_inventories (price, available_amount, listed_amount,vendor_vendor_id, product_product_id ,created_at, updated_at) VALUES
('200','50', '25', 1, 1,'2023-12-19T12:34:56','2023-12-19T12:34:56');
SELECT * FROM wasail.product_inventories;
SELECT * FROM wasail.vendors;

INSERT INTO grocery_stores (store_name, store_address, created_at, updated_at, user_table_user_id) VALUES
('Alfatah', '522-Statelife', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 1);
SELECT * FROM wasail.grocery_stores;

INSERT INTO orders (order_date, delivery_date, total_bill, order_status, created_at, updated_at, grocery_store_store_id, vendor_vendor_id) VALUES
('2023-01-01','2023-01-05','1000', 'Delivered', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 1,1);
SELECT * FROM wasail.orders;

INSERT INTO order_details (quantity, unit_price, total_price, created_at, updated_at, order_order_id) VALUES
('200','20','4000', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 1);
SELECT * FROM wasail.order_details;

INSERT INTO products (product_name,image,created_at, updated_at) VALUES
('Coca-Cola','Assets/Images/Products/lays-salted.png','2023-12-17T12:34:56', '2023-12-19T12:34:56');
SELECT * FROM wasail.products;

INSERT INTO product_categories (category_name, created_at, updated_at) VALUES
('drinks','2023-12-17T12:34:56', '2023-12-19T12:34:56');
SELECT * FROM wasail.product_categories;

INSERT INTO product_inventories (price, available_amount, listed_amount,vendor_vendor_id, product_product_id ,created_at, updated_at) VALUES
('200','50', '25', 1, 1,'2023-12-19T12:34:56','2023-12-19T12:34:56');
SELECT * FROM wasail.product_inventories;

INSERT INTO lists (created_at, updated_at, grocery_store_store_id, vendor_vendor_id) VALUES
('2023-12-17T12:34:56', '2023-12-19T12:34:56', 1, 1);
SELECT * FROM wasail.lists;