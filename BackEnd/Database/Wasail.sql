use wasail;
INSERT INTO user_tables (phone_number, name, password, username, language, user_type, created_at, updated_at) VALUES
(03214377009, 'Fizza Adeel', 'password@123', 'fizza', 'English', 'Vendor', '2023-12-17T12:34:56', '2023-12-19T12:34:56');
SELECT * FROM wasail.user_tables;

INSERT INTO vendors (vendor_name, delivery_locations, image,created_at, updated_at, user_table_user_id) VALUES
('P&G', 'Gulberg', 'Assets/Images/Stores/esajees.png','2023-12-17T12:34:56', '2023-12-19T12:34:56', 1);
SELECT * FROM wasail.vendors;
 
INSERT INTO grocery_stores (store_name, image, store_address, created_at, updated_at, user_table_user_id) VALUES
('Esajees','Assets/Images/Stores/esajees.png' ,'Shop 175, Y Block Market, DHA Phase 3', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 1),
('Jalal Sons','Assets/Images/Stores/jalal_sons.png','Shop 5, H Block Market, DHA Phase 2', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 1),
('Alfatah', 'Assets/Images/Stores/alfatah.png','Shop 30, A Block Market, State Life', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 1);
SELECT * FROM wasail.grocery_stores;

INSERT INTO orders (order_date, delivery_date, total_bill, order_status, created_at, updated_at, grocery_store_store_id, vendor_vendor_id) VALUES
('2023-08-06','2023-08-19','45000', 'On Its Way', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 1, 1),
('2023-10-12','2023-10-19','23460', 'In Process', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 1, 1),
('2023-10-13','2023-10-25','2100', 'In Process', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 1, 1),
('2023-11-15','2023-11-21','10000', 'Delivered', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 1, 1),
('2023-10-07','2023-10-8','5050', 'On Its Way', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 2, 1),
('2023-08-06','2023-08-19','1935', 'In Process', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 2, 1),
('2024-01-01','2023-01-5','1935', 'Delivered', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 2, 1),
('2024-01-03','2023-01-8','1935', 'Delivered', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 2, 1),
('2023-12-01','2023-12-2','6750', 'On Its Way', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 3, 1),
('2023-10-16','2023-12-21','460', 'In Process', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 3, 1),
('2024-01-03','2024-01-07','1400', 'Delivered', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 3, 1);
SELECT * FROM wasail.orders;

INSERT INTO products (product_name,image,created_at, updated_at) VALUES
('Lays','Assets/Images/Products/lays-salted.png','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('Coca Cola','Assets/Images/Products/cocacola.jpg','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('Dasani Water','Assets/Images/Products/dasani-water.png','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('Pepsi','Assets/Images/Products/pepsi.jpg','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('Pepsi','Assets/Images/Products/pepsi.jpg','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('Olpers Milk','Assets/Images/Products/olpers-milk.jpg','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('Nestle Milk','Assets/Images/Products/nestle-milk.jpg','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('Shan Noodles','Assets/Images/Products/shan-noodles.jpg','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('Knorr Noodles','Assets/Images/Products/knorr-noodles.png','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('Knorr Ketchup','Assets/Images/Products/knorr-ketchup.png','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('Aquafina Water','Assets/Images/Products/aquafina-water.png','2023-12-17T12:34:56', '2023-12-19T12:34:56');
SELECT * FROM wasail.products;

INSERT INTO product_categories (category_name,image,created_at, updated_at) VALUES
('Drink','Assets/Images/Products/cocacola.jpg','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('Meat','Assets/Images/Products/meat.jpeg','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('Fish','Assets/Images/Products/fish.jpeg','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('Condiments','Assets/Images/Products/condiments.webp','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('Detergents','Assets/Images/Products/detergent.jpeg','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('Spices','Assets/Images/Products/spices.jpeg','2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('Dairy','Assets/Images/Products/olpers-milk.jpg','2023-12-17T12:34:56', '2023-12-19T12:34:56');
SELECT * FROM wasail.product_categories;

INSERT INTO product_inventories (price, available_amount, listed_amount,vendor_vendor_id, product_product_id ,created_at, updated_at) VALUES
('100','30', '25', 1, 1,'2023-12-19T12:34:56','2023-12-19T12:34:56'),
('50','50', '35', 1, 3,'2023-12-19T12:34:56','2023-12-19T12:34:56'),
('875','170', '155', 1, 4,'2023-12-19T12:34:56','2023-12-19T12:34:56'),
('155','100', '90', 1, 5,'2023-12-19T12:34:56','2023-12-19T12:34:56'),
('35','20', '15', 1, 6,'2023-12-19T12:34:56','2023-12-19T12:34:56'),
('1200','40', '40', 1, 7,'2023-12-19T12:34:56','2023-12-19T12:34:56'),
('245','10', '5', 1, 8,'2023-12-19T12:34:56','2023-12-19T12:34:56'),
('650','12', '12', 1, 9,'2023-12-19T12:34:56','2023-12-19T12:34:56'),
('365','35', '33', 1, 10,'2023-12-19T12:34:56','2023-12-19T12:34:56');
SELECT * FROM wasail.product_inventories;

INSERT INTO order_details (quantity, unit_price, total_price, created_at, updated_at, order_order_id,product_inventory_product_inventory_id) VALUES
('5','80','400', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 1,1),
('10','450','4500', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 1,1),
('25','25','625', '2023-12-17T12:34:56', '2023-12-19T12:34:56', 1,1);
SELECT * FROM wasail.order_details;

INSERT INTO lists (created_at, updated_at,grocery_store_store_id, vendor_vendor_id) VALUES
('2023-12-17T12:34:56', '2023-12-19T12:34:56', 1, 1),
('2023-12-17T12:34:56', '2023-12-19T12:34:56', 2, 1),
('2023-12-17T12:34:56', '2023-12-19T12:34:56', 3, 1);
SELECT * FROM wasail.lists;

INSERT INTO product_category_links (created_at, updated_at,product_product_id, product_category_product_category_id) VALUES
('2023-12-17T12:34:56', '2023-12-19T12:34:56', 1, 1),
('2023-12-17T12:34:56', '2023-12-19T12:34:56', 2, 1),
('2023-12-17T12:34:56', '2023-12-19T12:34:56', 3, 1);
SELECT * FROM wasail.product_category_links;

INSERT INTO admins (admin_role,email,user_table_user_id,created_at, updated_at) VALUES
('Administrator', 'fatima@gmail.com', 1, '2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('Moderator', 'fizza@gmail.com', 1, '2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('Editor', 'irtaza@gmail.com', 1, '2023-12-17T12:34:56', '2023-12-19T12:34:56'),
('Viewer', 'malaika@gmail.com', 1, '2023-12-17T12:34:56', '2023-12-19T12:34:56');
SELECT * FROM wasail.admins;

