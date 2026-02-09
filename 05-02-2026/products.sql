CREATE TABLE customers (
    cus_id BIGINT PRIMARY KEY,
    cus_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    city VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    product_id BIGINT PRIMARY KEY,
    prod_name VARCHAR(100) UNIQUE NOT NULL,
    prod_price DECIMAL(10,2) NOT NULL,
    model_year int 
);
CREATE TABLE orders (
    ord_id BIGINT PRIMARY KEY,
    cus_id BIGINT NOT NULL,
    date_ordered DATE NOT NULL,
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (cus_id)
        REFERENCES customers(cus_id)
);
CREATE TABLE order_items (
    ord_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (ord_id, product_id),
    CONSTRAINT fk_oi_order
        FOREIGN KEY (ord_id)
        REFERENCES orders(ord_id),
    CONSTRAINT fk_oi_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);


Insert into customers values(10001,'preetham','preetham@gmail.com','warangal');
Insert into customers values(10002,'Rahul','rahul@gmail.com','Hyderabad');
Insert into customers values(10003,'Anjali','anjali@gmail.com','Vijayawada');
Insert into customers values(10004,'Suresh','suresh@gmail.com','Bangalore');
Insert into customers values(10005,'Priya','priya@gmail.com','Chennai');
Insert into customers values(10006,'Kiran','kiran@gmail.com','Warangal');
Insert into customers values(10007,'Sneha','sneha@gmail.com','Mumbai');
Insert into customers values(10008,'Rama','rama@gmail.com','Vizag');
Insert into customers values(10009,'Srinivas','srinivas@gmail.com','Nalgonda');


Insert into products values(1001,'Phone',50000,2004);
Insert into products values(1002,'Laptop',65000,2022);
Insert into products values(1003,'Tablet',30000,2021);
Insert into products values(1004,'Smart Watch',15000,2023);
Insert into products values(1005,'Headphones',4000,2020);
Insert into products values(1006,'Bluetooth Speaker',3500,2024);
Insert into products values(1007,'LED TV',45000,2022);
Insert into products values(1008,'Washing Machine',450000,2030);


Insert into orders values(100001,10001,'2026-02-06');
Insert into orders values(100008,10001,'2026-02-06');
Insert into orders values(100002,10002,'2020-04-20');
Insert into orders values(100003,10004,'2015-09-13');
Insert into orders values(100004,10003,'1999-11-29');
Insert into orders values(100005,10006,'1880-12-19');
Insert into orders values(100006,10005,'2022-06-28');
Insert into orders values(100007,10007,'2000-01-18');


Insert into order_items values(100001,1001,1);
Insert into order_items values(100002,1002,1);
Insert into order_items values(100003,1003,3);
Insert into order_items values(100004,1004,2);
Insert into order_items values(100005,1005,10);
Insert into order_items values(100006,1006,6);
Insert into order_items values(100007,1007,8);

select * from products;
select * from customers;
select * from orders;
select * from order_items;

select * from customers c join orders o on c.cus_id=o.cus_id; 

select o.ord_id,c.cus_name,c.city from orders o join customers c on o.cus_id=c.cus_id;

select * from orders o join order_items oi on o.ord_id=oi.ord_id join products p on oi.product_id=p.product_id;

select * from orders o join order_items oi on o.ord_id=oi.ord_id join products p on oi.product_id=p.product_id where p.prod_price>35000;

select * from orders o join order_items oi on o.ord_id=oi.ord_id join products p on oi.product_id=p.product_id where prod_name like '%p%';

select * from customers c left join orders o on c.cus_id=o.cus_id where o.ord_id is not null;

select * from customers c left join orders o on c.cus_id=o.cus_id where o.ord_id is NULL;

CREATE TABLE Department(
    dep_id INT PRIMARY KEY,
    dep_name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE Employees(
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(255) NOT NULL,
    emp_email VARCHAR(255) UNIQUE,
    dep_id INT NOT NULL,
    salary DECIMAL(10,2),
    manager_id INT null,
    FOREIGN KEY(dep_id) REFERENCES Department(dep_id),
    FOREIGN KEY(manager_id) REFERENCES Employees(emp_id)
);

Insert into Department values(101,'cse');
Insert into Department values(102,'Ece');
Insert into Department values(103,'It');
Insert into Department values(104,'Eee');
Insert into Department values(105,'Mech');

Insert into Employees values(10001,'preetham','preetham@gmail.com',101,45000.00,null);
Insert into Employees values(10002,'suresh','suresh@gmail.com',101,450000.50,null);
Insert into Employees values(10003,'rishi','rishi@gmail.com',102,8000.00,null);
Insert into Employees values(10004,'vishnu','vishnu@gmail.com',103,10000.00,null);
Insert into Employees values(10001,'dinesh','dinesh@gmail.com',104,5000.00,null);

select * from Department;
select * from Employees;

select * from Employees e join Department d on e.dep_id=d.dep_id ;

select * from Department d left join Employees e on d.dep_id=e.dep_id;

select * from Department d left join Employees e on d.dep_id=e.dep_id where e.emp_id is not null;

select * from products;
select * from order_items;

select * from products p left join order_items oi on p.product_id=oi.product_id where oi.ord_id is null;

select * from products p left join order_items oi on p.product_id=oi.product_id where p.prod_name like '%p%';

select * from orders o right join customers c on c.cus_id=o.cus_id where o.ord_id is null; 

select * from Employees e right join Department d on d.dep_id=e.dep_id;

select p.prod_name,count(*) from products p right join order_items oi on p.product_id=oi.product_id group by p.prod_name;

select * from customers c full outer join orders o on c.cus_id=o.cus_id;
select * from customers c left join orders o on c.cus_id=o.cus_id union select * from customers c right join orders o on c.cus_id=o.cus_id;

select * from customers c inner join orders o on c.cus_id=o.cus_id;
select * from customers c full outer join orders o on c.cus_id=o.cus_id where o.ord_id is null;

select * from employees e full outer join Department d on e.dep_id=d.dep_id;

UPDATE Employees SET manager_id = 10001 WHERE manager_id IS NULL;
Insert into Employees values(10005,'samar','samar@gmail.com',104,45080.00,10002);

select e.emp_id,e.emp_name as employee_name,m.emp_name as manager_name from Employees e join Employees m on e.manager_id=m.emp_id;

select e.emp_id,m.emp_name as manager_name from Employees e join Employees m on e.manager_id=m.emp_id order by e.manager_id;

select distinct e.emp_name as manager_name from Employees e join Employees m on e.emp_id=m.manager_id;

select e.emp_name,m.emp_name from Employees e join Employees m on e.manager_id=m.emp_id;

select * from customers cross join products;

select e1.emp_name as employee1,e2.emp_name as employee2 from employees e1 cross join employees e2 where e1.emp_id<>e2.emp_id;

select * from customers c join orders o on c.cus_id=o.cus_id join order_items oi on o.ord_id=oi.ord_id;

CREATE TABLE Suppliers(
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(255) NOT NULL,
    contact_email VARCHAR(255),
    phone BIGINT,
    country VARCHAR(255)
);

insert into Suppliers values(1,'google','google.com',9182938267,'india');
insert into Suppliers values(2,'amazon','amazon@gmail.com',6281857512,'usa');
insert into Suppliers values(3,'microsoft','microsoft@gmail.com',9345403336,'canada');

select * from products;

ALTER TABLE Products
ADD supplier_id INT;
 
ALTER TABLE Products
ADD FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id);

select * from Suppliers where supplier_id=1;

UPDATE Products SET supplier_id =1 WHERE product_id = 1001;
UPDATE Products SET supplier_id =1 WHERE product_id = 1002;
UPDATE Products SET supplier_id =1 WHERE product_id = 1003;
UPDATE Products SET supplier_id =2 WHERE product_id = 1004;
UPDATE Products SET supplier_id =2 WHERE product_id = 1005;

select * from products p join order_items oi on p.product_id=oi.product_id join Suppliers s on s.supplier_id=p.supplier_id;

select * from customers c join orders o on c.cus_id=o.cus_id join order_items oi on oi.ord_id=o.ord_id join products p on p.product_id=oi.product_id join Suppliers s on s.supplier_id=p.supplier_id;

select c.cus_id,count(*) from customers c join orders o on c.cus_id=o.cus_id group by c.cus_id;

select c.cus_id,sum(oi.quantity*p.prod_price) from customers c join orders o on c.cus_id=o.cus_id join order_items oi on o.ord_id=oi.ord_id join products p on p.product_id=oi.product_id group by c.cus_id;

select * from Department
select * from Employees

select d.dep_id,count(e.emp_id) from Department d left join Employees e on d.dep_id=e.dep_id group by d.dep_id;

select p.product_id,count(oi.product_id) from products p left join order_items oi on p.product_id=oi.product_id group by p.product_id;

select d.dep_id,sum(e.salary) from Department d left join Employees e on d.dep_id=e.dep_id group by d.dep_id;

select c.cus_id,count(o.ord_id)  from customers c left join orders o on c.cus_id=o.cus_id group by c.cus_id having count(o.ord_id)>1;

select d.dep_id,count(e.emp_id) from Department d join Employees e on d.dep_id=e.dep_id group by d.dep_id having count(e.emp_id)>1;

SELECT p.product_id, p.prod_name, COUNT(*) AS times_ordered FROM order_items oi JOIN products p ON oi.product_id = p.product_id GROUP BY p.product_id, p.prod_name HAVING COUNT(*) > 0;

select c.cus_id,sum(p.prod_price*oi.quantity) from customers c join orders o on c.cus_id=o.cus_id join order_items oi on o.ord_id=oi.ord_id join products p on p.product_id=oi.product_id group by(c.cus_id) having sum(p.prod_price*oi.quantity)>10000;

select c.cus_id,count(ord_id) from customers c join orders o on c.cus_id=o.cus_id group by c.cus_id;

select d.dep_id,count(e.emp_id) from Department d left join Employees e on d.dep_id=e.dep_id group by d.dep_id;

select c.city,count(o.ord_id) from customers c join orders o on c.cus_id=o.cus_id group by c.city;

select c.cus_id,c.cus_name,c.email,o.date_ordered,o.ord_id from customers c join orders o on c.cus_id=o.cus_id where o.date_ordered>'2016-09-12';

select e.emp_id,d.dep_id,e.emp_name from Employees e join Department d on e.dep_id=d.dep_id where d.dep_name='cse';

select c.cus_id,c.cus_name,c.city from customers c join orders o on c.cus_id=o.cus_id where c.city='warangal'

select p.product_id,p.prod_name,p.prod_price from orders o join order_items oi on o.ord_id=oi.ord_id join products p on oi.product_id=p.product_id where p.prod_price>15000;

select c.cus_name,c.cus_id from customers c join orders o on c.cus_id=o.cus_id where c.cus_name like 'p%';

select e.emp_name from Employees e join Department d on e.dep_id=d.dep_id where e.emp_name like 'P%';

SELECT p.product_id, p.prod_name, oi.quantity FROM products p JOIN order_items oi ON p.product_id = oi.product_id JOIN orders o ON o.ord_id = oi.ord_id WHERE p.prod_name LIKE '%phone%';

select t.cus_id from (select c.cus_id from customers c join orders o on c.cus_id=o.cus_id )t;
select cus_id from customers where cus_id in (select cus_id from orders);

select cus_id from customers where cus_id not in (select cus_id from orders);

select product_id from products where product_id not in (select product_id from order_items);

select emp_id from Employees where emp_id not in (select emp_id from Department d join Employees e on e.dep_id=d.dep_id);
select emp_id from employees where dep_id not in(select dep_id from Department);

select oi.ord_id,sum(oi.quantity*p.prod_price) as order_total from order_items oi join products p on oi.product_id=p.product_id group by oi.ord_id having 
sum(oi.quantity*p.prod_price)>(select avg(order_total)  from (select sum(oi2.quantity*p2.prod_price)as order_total from products p2 join order_items oi2 on 
p2.product_id=oi2.product_id group by oi2.ord_id)t);

select c.cus_id,sum(oi.quantity*p.prod_price)as order_total from customers c join orders o on c.cus_id=o.cus_id join order_items oi on o.ord_id=oi.ord_id join products p 
on p.product_id=oi.product_id group by c.cus_id having sum(oi.quantity*p.prod_price)>(select avg(order_total) from (select sum(oi2.quantity*p2.prod_price)as order_total from products p2 join 
order_items oi2 on p2.product_id=oi2.product_id group by oi2.ord_id)t);

select e.emp_id,e.emp_name,e.salary from Employees e where e.salary>(select avg(e1.salary) from Employees e1 where e1.dep_id=e.dep_id);

select dep_id,dep_name from Department d where dep_id in (select dep_id from Employees );

alter table customers add status varchar(20);

UPDATE Customers SET status = 'Active';
UPDATE Customers SET status = 'Inactive' WHERE cus_id = 10001;

select * from customers;

select cus_id,status from customers where cus_id not in (select cus_id from customers where status='inactive');

select c.cus_id,c.cus_name from customers c where exists (select 1 from orders o where o.cus_id=c.cus_id);

select e.emp_id,e.emp_name,d.dep_name, case when e.salary>=5000 then'High salary' else 'low salary' end as salaryrange from employees e join department d on e.dep_id=d.dep_id;

