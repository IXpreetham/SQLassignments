CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    password VARCHAR(255),
    address VARCHAR(255),
    created_at DATETIME DEFAULT GETDATE()
);
ALTER TABLE Customers
ADD CONSTRAINT Customers_Email UNIQUE (email);

ALTER TABLE Customers
ADD CONSTRAINT Customers_phone UNIQUE (phone);



CREATE TABLE Restaurants (
    restaurant_id INT PRIMARY KEY,
    restaurant_name VARCHAR(150),
    owner_name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(255),
    rating DECIMAL(3,2),
    created_at DATETIME DEFAULT GETDATE()
);


CREATE TABLE Menu (
    menu_id INT PRIMARY KEY,
    restaurant_id INT,
    item_name VARCHAR(150),
    description TEXT,
    price DECIMAL(10,2),
    category VARCHAR(100),
    availability_status VARCHAR(50),
    created_at DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_Menu_Restaurant
    FOREIGN KEY (restaurant_id)
    REFERENCES Restaurants(restaurant_id)
);


CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    order_status VARCHAR(50),
    total_amount DECIMAL(10,2),
    payment_status VARCHAR(50),
    delivery_address VARCHAR(255),
    created_at DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_Orders_Customer
    FOREIGN KEY (customer_id)
    REFERENCES Customers(customer_id),

    CONSTRAINT FK_Orders_Restaurant
    FOREIGN KEY (restaurant_id)
    REFERENCES Restaurants(restaurant_id)
);



CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    menu_id INT,
    quantity INT,
    price DECIMAL(10,2),

    CONSTRAINT FK_OrderItems_Order
    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id),

    CONSTRAINT FK_OrderItems_Menu
    FOREIGN KEY (menu_id)
    REFERENCES Menu(menu_id)
);


CREATE TABLE Delivery_Agents (
    agent_id INT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20),
    vehicle_type VARCHAR(50),
    vehicle_number VARCHAR(50),
    status VARCHAR(50),
    created_at DATETIME DEFAULT GETDATE()
);


CREATE TABLE Deliveries (
    delivery_id INT PRIMARY KEY,
    order_id INT,
    agent_id INT, 
    pickup_time DATETIME,
    delivery_time DATETIME,
    delivery_status VARCHAR(50),

    CONSTRAINT FK_Deliveries_Order
    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id),

    CONSTRAINT FK_Deliveries_Agent
    FOREIGN KEY (agent_id)
    REFERENCES Delivery_Agents(agent_id)
);


CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    transaction_id VARCHAR(100),
    amount DECIMAL(10,2),
    paid_at DATETIME,

    CONSTRAINT FK_Payments_Order
    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id)
);


CREATE TABLE Templates (
    template_id INT PRIMARY KEY,
    template_name VARCHAR(100),
    channel VARCHAR(50),
    template_text TEXT,
    created_at DATETIME DEFAULT GETDATE()
);


CREATE TABLE Notifications (
    notification_id INT PRIMARY KEY,
    event_type VARCHAR(50),
    reference_id INT,
    receiver_id INT,
    receiver_type VARCHAR(50),
    notification_type VARCHAR(100),
    template_id INT,
    message TEXT,
    channel VARCHAR(50),
    status VARCHAR(50),
    retry_count INT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    sent_at DATETIME,

    CONSTRAINT FK_Notifications_Template
    FOREIGN KEY (template_id)
    REFERENCES Templates(template_id)
);




CREATE TABLE Notification_Attempts (
    attempt_id INT PRIMARY KEY,
    notification_id INT,
    attempt_number INT,
    status VARCHAR(50),
    attempted_at DATETIME,

    CONSTRAINT FK_Attempts_Notification
    FOREIGN KEY (notification_id)
    REFERENCES Notifications(notification_id)
);

CREATE TABLE Notification_Preferences (
    preference_id INT PRIMARY KEY,
    customer_id INT,
    sms_enabled BIT,
    email_enabled BIT,
    push_enabled BIT,
    updated_at DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_Preferences_Customer
    FOREIGN KEY (customer_id)
    REFERENCES Customers(customer_id)
);


CREATE TABLE Notification_Logs (
    log_id INT PRIMARY KEY,
    notification_id INT,
    old_status VARCHAR(50),
    new_status VARCHAR(50),
    changed_at DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_Logs_Notification
    FOREIGN KEY (notification_id)
    REFERENCES Notifications(notification_id)
);



INSERT INTO Customers 
(customer_id, name, email, phone, password, address)
VALUES
(1, 'Rahul', 'rahul@gmail.com', '9876543210', 'pass1', 'Hyderabad'),
(2, 'Sneha', 'sneha@gmail.com', '9123456780', 'pass2', 'Hyderabad'),
(3, 'Amit', 'amit@gmail.com', '9988776655', 'pass3', 'Chennai'),
(4, 'Priya', 'priya@gmail.com', '9012345678', 'pass4', 'Mumbai'),
(5, 'Sushanth', 'sushanth@gmail.com', '9988776655', 'pass5', 'Chennai'),
(6,'Nikita','nikita@gmail.com','6294190537','pass6','Mumbai'),
(7,'Vinay','vinay@gmail.com','9653408851','pass7','Hyderabad');

update customers set phone='9988776685' where customer_id='5';


INSERT INTO Restaurants
(restaurant_id, restaurant_name, owner_name, phone, email, address, rating)
VALUES
(101, 'Paradise Biryani', 'Ali Hemati', '7561906233', 'contact@paradisebiryani.com', 'Hyderabad',4.50),
(102, 'Mehfil Restaurant', 'Imran Khan', '9207852102', 'info@mehfilrestaurant.com', 'Hyderabad', 4.20),
(103, 'The Nawabs Restaurant', 'Rajesh Mehta', '8249836517', 'support@nawabs.com', 'Hyderabad', 4.60),
(104, 'ITC', 'Ratan Tata', '6281857520', 'help@itc.co.in', 'Mumbai', 4.01),
(105, 'Bombay Canteen','Mukesh choudary', '8275390155', 'care@bombaycanteen', 'Mumbai', 4.10),
(106, 'Annalakshmi Restaurant','Sushanth  Reddy', '8365281905', 'contact@annalakshmi.com', 'Chennai', 4.30),
(107, 'Avartana','Adepu Preetham', '6281857512', 'contact@avartana.com', 'Chennai', 4.40);



INSERT INTO Menu
(menu_id, restaurant_id, item_name, description, price, category, availability_status)
VALUES
(1, 101, 'Chicken Biryani', 'Signature Hyderabadi chicken biryani', 290.00, 'Main Course', 'Available'),
(2, 101, 'Paneer Butter Masala', 'Rich creamy paneer gravy', 240.00, 'Main Course', 'Available'),
(3, 101, 'Chicken 65', 'Crispy spicy chicken starter', 210.00, 'Starter', 'Available'),

(4, 102, 'Chicken Biryani', 'Traditional dum biryani', 275.00, 'Main Course', 'Available'),
(5, 102, 'Butter Naan', 'Soft butter naan', 45.00, 'Bread', 'Available'),
(6, 102, 'Gulab Jamun', 'Classic Indian sweet', 100.00, 'Dessert', 'Available'),

(7, 103, 'Mutton Biryani', 'Royal nawabi style biryani', 360.00, 'Main Course', 'Available'),
(8, 103, 'Tandoori Chicken', 'Charcoal grilled chicken', 330.00, 'Starter', 'Available'),
(9, 103, 'Paneer Butter Masala', 'Premium paneer gravy', 260.00, 'Main Course', 'Available'),

(10, 104, 'Dal Makhani', 'Slow cooked black lentils', 380.00, 'Main Course', 'Available'),
(11, 104, 'Malai Kofta', 'Creamy kofta curry', 400.00, 'Main Course', 'Available'),
(12, 104, 'Butter Naan', 'Luxury butter naan', 60.00, 'Bread', 'Available'),

(13, 105, 'Vada Pav', 'Mumbai street style vada pav', 70.00, 'Snack', 'Available'),
(14, 105, 'Pav Bhaji', 'Spicy bhaji with butter pav', 190.00, 'Main Course', 'Available'),
(15, 105, 'Masala Dosa', 'South Indian crispy dosa', 150.00, 'Breakfast', 'Available'),

(16, 106, 'Masala Dosa', 'Traditional masala dosa', 130.00, 'Breakfast', 'Available'),
(17, 106, 'Idli Sambar', 'Steamed idli with sambar', 90.00, 'Breakfast', 'Available'),
(18, 106, 'Paneer Butter Masala', 'Veg special paneer curry', 220.00, 'Main Course', 'Available'),

(19, 107, 'Truffle Dosa', 'Modern luxury dosa', 520.00, 'Main Course', 'Available'),
(20, 107, 'Chicken Biryani', 'Fine dine biryani version', 420.00, 'Main Course', 'Available'),
(21, 107, 'Chocolate Sphere Dessert', 'Molten chocolate dome dessert', 400.00, 'Dessert', 'Available');


INSERT INTO Orders
(order_id, customer_id, restaurant_id, order_status, total_amount, payment_status, delivery_address, created_at)
VALUES
(7001, 1, 101, 'Delivered', 580.00, 'Paid', 'Hyderabad', '2025-07-20 10:30:00'),
(7002, 1, 101, 'Delivered', 480.00, 'Paid', 'Hyderabad', '2025-07-21 10:30:00'),
(7003, 2, 102, 'Delivered', 90.00, 'Paid', 'Hyderabad', '2025-07-20 10:30:00'),
(7004, 2, 102, 'Delivered', 200.00, 'Paid', 'Hyderabad', '2025-07-20 10:30:00'),
(7005, 2, 102, 'Delivered', 550.00, 'Paid', 'Hyderabad', '2025-07-20 10:30:00'),
(7006, 3, 107, 'Placed', 800.00, 'Pending', 'Chennai', '2025-08-20 10:30:00'),
(7007, 4, 105, 'Cancelled', 580.00, 'Failed', 'Mumbai', '2025-06-20 10:30:00');

update orders set total_amount='560' where order_id='7007';

INSERT INTO Order_Items
(order_item_id, order_id, menu_id, quantity, price)
VALUES
(1, 7001, 1, 2, 580.00),
(2, 7002, 2, 2, 240.00),
(3, 7003, 5, 2, 45.00),
(4, 7004, 6, 2, 100.00),
(5, 7005, 4, 2, 275.00),
(6, 7006, 21, 2, 400.00),
(7, 7007, 14, 1, 190.00),
(8, 7007, 15, 2, 150.00),
(9, 7007, 13, 1, 70.00);


ALTER TABLE Delivery_Agents
ADD city VARCHAR(100);

INSERT INTO Delivery_Agents
(agent_id, name, phone, vehicle_type, vehicle_number, status, city)
VALUES
(201, 'Suresh Kumar', '9876501111', 'Bike', 'TS09AB1234', 'Available', 'Hyderabad'),
(202, 'Ravi Teja', '9876502222', 'Scooter', 'TS10CD5678', 'Busy', 'Hyderabad'),
(203, 'Mahesh Reddy', '9876503333', 'Bike', 'TS11EF4321', 'Available', 'Hyderabad'),
(204, 'Arjun Patel', '9876504444', 'Bike', 'MH12GH9876', 'Available', 'Mumbai'),
(205, 'Kiran Sharma', '9876505555', 'Scooter', 'MH14JK6543', 'Busy', 'Mumbai'),
(206, 'Vignesh Kumar', '9876506666', 'Bike', 'TN09LM1122', 'Available', 'Chennai'),
(207, 'Pradeep Nair', '9876507777', 'Scooter', 'TN10NO3344', 'Available', 'Chennai');


INSERT INTO Deliveries
(delivery_id, order_id, agent_id, pickup_time, delivery_time, delivery_status)
VALUES
(1, 7001, 201, '2025-07-20 11:00:00', '2025-07-20 11:40:00', 'Delivered'),
(2, 7002, 203, '2025-07-21 11:00:00', '2025-07-21 11:45:00', 'Delivered'),
(3, 7003, 201, '2025-07-20 11:10:00', '2025-07-20 11:35:00', 'Delivered'),
(4, 7004, 203, '2025-07-20 12:00:00', '2025-07-20 12:30:00', 'Delivered'),
(5, 7005, 201, '2025-07-20 13:00:00', '2025-07-20 13:50:00', 'Delivered'),
(6, 7006, 206, '2025-08-20 11:00:00', NULL, 'Out for Delivery');


INSERT INTO Payments
(payment_id, order_id, payment_method, payment_status, transaction_id, amount, paid_at)
VALUES
(1001, 7001, 'UPI', 'Success', 'TXN7001UPI', 580.00, '2025-07-20 10:32:00'),
(1002, 7002, 'Credit Card', 'Success', 'TXN7002CC', 480.00, '2025-07-21 10:32:00'),
(1003, 7003, 'UPI', 'Success', 'TXN7003UPI', 90.00, '2025-07-20 10:32:00'),
(1004, 7004, 'Cash', 'Success', 'TXN7004DC', 200.00, '2025-07-20 10:35:00'),
(1005, 7005, 'Net Banking', 'Success', 'TXN7005NB', 550.00, '2025-07-20 10:40:00'),
(1006, 7006, 'UPI', 'Pending', 'TXN7006UPI', 800.00, NULL),
(1007, 7007, 'Credit Card', 'Failed', 'TXN7007CC', 580.00, '2025-06-20 10:31:00');


INSERT INTO Templates
(template_id, template_name, channel, template_text)
VALUES
(1, 'Order Placed - SMS', 'SMS',
'Hi {customer_name}, your order #{order_id} has been placed successfully.'),
(2, 'Order Placed - Email', 'Email',
'Dear {customer_name}, your order #{order_id} is confirmed and will be prepared shortly.'),
(3, 'Payment Success - SMS', 'SMS',
'Payment of ₹{amount} for order #{order_id} was successful. Thank you!'),
(4, 'Payment Success - Email', 'Email',
'Your payment of ₹{amount} for order #{order_id} has been successfully processed.'),
(5, 'Payment Failed - SMS', 'SMS',
'Payment for order #{order_id} failed. Please retry to confirm your order.'),
(6, 'Out for Delivery - Push', 'Push',
'Your order #{order_id} is out for delivery. Agent {agent_name} is at the location.'),
(7, 'Order Delivered - SMS', 'SMS',
'Your order #{order_id} has been delivered. Enjoy your meal!'),
(8, 'Order Cancelled - Email', 'Email',
'Your order #{order_id} has been cancelled. If payment was deducted, refund will be processed.');


INSERT INTO Notifications
(notification_id, event_type, reference_id, receiver_id, receiver_type, 
notification_type, template_id, message, channel, status, sent_at)
VALUES
(1, 'ORDER', 7001, 1, 'CUSTOMER',
'Order Placed', 1,
'Hi Customer 1, your order #7001 has been placed successfully.',
'SMS', 'Sent', '2025-07-20 10:31:00'),
(2, 'PAYMENT', 7001, 1, 'CUSTOMER',
'Payment Success', 3,
'Payment of ₹580 for order #7001 was successful. Thank you!',
'SMS', 'Sent', '2025-07-20 10:32:00'),
(3, 'DELIVERY', 7001, 1, 'CUSTOMER',
'Order Delivered', 7,
'Your order #7001 has been delivered. Enjoy your meal!',
'SMS', 'Sent', '2025-07-20 11:40:00'),
(4, 'ORDER', 7006, 3, 'CUSTOMER',
'Order Placed', 1,
'Hi Customer 3, your order #7006 has been placed successfully.',
'SMS', 'Sent', '2025-08-20 10:31:00'),
(5, 'PAYMENT', 7006, 3, 'CUSTOMER',
'Payment Pending', 5,
'Payment for order #7006 failed. Please retry to confirm your order.',
'SMS', 'Failed', NULL),
(6, 'ORDER', 7007, 4, 'CUSTOMER',
'Order Cancelled', 8,
'Your order #7007 has been cancelled. Refund will be processed if applicable.',
'Email', 'Sent', '2025-06-20 10:35:00');

INSERT INTO Notifications
(notification_id, event_type, reference_id, receiver_id, receiver_type,
notification_type, template_id, message, channel, status, sent_at)
VALUES
(7, 'ORDER', 7001, 101, 'RESTAURANT',
'New Order Received', 2,
'New order #7001 has been placed. Please start preparing.',
'Push', 'Sent', '2025-07-20 10:31:00');

INSERT INTO Notifications
(notification_id, event_type, reference_id, receiver_id, receiver_type,
notification_type, template_id, message, channel, status, sent_at)
VALUES
(8, 'DELIVERY', 7001, 201, 'AGENT',
'New Delivery Assigned', 6,
'You have been assigned order #7001. Please pick up from restaurant.',
'Push', 'Sent', '2025-07-20 11:00:00');




INSERT INTO Notification_Attempts
(attempt_id, notification_id, attempt_number, status, attempted_at)
VALUES
(1, 1, 1, 'Sent', '2025-07-20 10:31:00'),
(2, 2, 1, 'Sent', '2025-07-20 10:32:00'),
(3, 3, 1, 'Sent', '2025-07-20 11:40:00'),
(4, 4, 1, 'Sent', '2025-08-20 10:31:00'),
(5, 5, 1, 'Failed', '2025-08-20 10:32:00'),
(6, 5, 2, 'Failed', '2025-08-20 10:35:00'),
(7, 6, 1, 'Sent', '2025-06-20 10:35:00');



INSERT INTO Notification_Preferences
(preference_id, customer_id, sms_enabled, email_enabled, push_enabled)
VALUES
(1, 1, 1, 1, 1),
(2, 2, 1, 0, 0),
(3, 3, 0, 1, 1),
(4, 4, 0, 0, 1);



INSERT INTO Notification_Logs
(log_id, notification_id, old_status, new_status, changed_at)
VALUES
(1, 1, 'Pending', 'Sent', '2025-07-20 10:31:00'),
(2, 2, 'Pending', 'Sent', '2025-07-20 10:32:00'),
(3, 3, 'Pending', 'Sent', '2025-07-20 11:40:00'),
(4, 4, 'Pending', 'Sent', '2025-08-20 10:31:00'),
(5, 5, 'Pending', 'Failed', '2025-08-20 10:32:00'),
(6, 6, 'Pending', 'Sent', '2025-06-20 10:35:00');



select o.order_id,n.event_type,n.receiver_type,n.notification_type,n.message,n.channel,n.status,n.sent_at from orders o join notifications n on o.order_id=n.reference_id where o.order_id=7001;

SELECT * FROM Notifications WHERE created_at >= '2026-02-19' AND created_at < '2026-02-21';
select * from Notifications WHERE CAST(created_at AS DATE) between '2026-02-19' and '2026-02-21';


select * from Notifications where event_type='ORDER';

select * from Notifications where status='Failed';

select * from Notifications WHERE CAST(created_at AS DATE) between '2026-02-19' and '2026-02-21';

select top 10 * from Notifications n where n.receiver_id=1 AND n.receiver_type = 'CUSTOMER' ORDER BY created_at DESC;

SELECT * FROM Notifications WHERE reference_id = 7001;
