create table customer
(
c_cid varchar(5) PRIMARY KEY,
email Varchar(20),
name varchar(20),
phone bigint(10),
refer_id varchar(20)
);

INSERT INTO customer VALUES ('C101', '14YYZ@GMAIL.COM', 'RAM', 9874563210, 'C1');
INSERT INTO customer VALUES ('C102', 'VINAY@GMAIL.COM', 'VINAY', 850697412, 'C1');
INSERT INTO customer VALUES ('C103', 'AMIT@GMAIL.COM', 'AMIT', 8146235897, 'C5');
INSERT INTO customer VALUES ('C104', '12BHUSHAN@GMAIL.COM', 'BHUSHAN', 875210369, 'C3');
INSERT INTO customer VALUES ('C105', 'SANJAY67@GMAIL.COM', 'SANJAY', 4545123698, 'C4');

mysql> select * from customer;
+-------+---------------------+---------+------------+----------+
| c_cid | email               | name    | phone      | refer_id |
+-------+---------------------+---------+------------+----------+
| C101  | 14YYZ@GMAIL.COM     | RAM     | 9874563210 | C1       |
| C102  | VINAY@GMAIL.COM     | VINAY   |  850697412 | C1       |
| C103  | AMIT@GMAIL.COM      | AMIT    | 8146235897 | C5       |
| C104  | 12BHUSHAN@GMAIL.COM | BHUSHAN |  875210369 | C3       |
| C105  | SANJAY67@GMAIL.COM  | SANJAY  | 4545123698 | C4       |
+-------+---------------------+---------+------------+----------+
5 rows in set (0.01 sec)



create table bicyclemodel
(
bmodel_no varchar(5) primary key,
manufacturer varchar(20),
style varchar(10),
c_cid varchar(5),
foreign key (c_cid) references customer(c_cid)
);


INSERT INTO bicyclemodel VALUES('M101', 'HONDA', 'GEAR SHIFT', 'C101');
INSERT INTO bicyclemodel VALUES('M102', 'TATA', 'SIMPLE', 'C101');
INSERT INTO bicyclemodel VALUES('M103', 'TOYOTA', 'GEAR SHIFT', 'C103');
INSERT INTO bicyclemodel VALUES('M104', 'HONDA', 'SIMPLE', 'C105');
INSERT INTO bicyclemodel VALUES('M105', 'MARUTI', 'SIMPLE', 'C102');



mysql> select * from bicyclemodel;
+-----------+--------------+------------+-------+
| bmodel_no | manufacturer | style      | c_cid |
+-----------+--------------+------------+-------+
| M101      | HONDA        | GEAR SHIFT | C101  |
| M102      | TATA         | SIMPLE     | C101  |
| M103      | TOYOTA       | GEAR SHIFT | C103  |
| M104      | HONDA        | SIMPLE     | C105  |
| M105      | MARUTI       | SIMPLE     | C102  |
+-----------+--------------+------------+-------+
5 rows in set (0.00 sec)




create table bicycle
(
b_id varchar(5) primary key,
purchase_date date,
color varchar(10),
b_cid varchar(5),
model_no varchar(10),
foreign key (b_cid) references customer (c_cid),
foreign key (model_no) references bicyclemodel(bmodel_no)
);



INSERT INTO bicycle VALUES('B101', '2003-12-13', 'RED','C102', 'M101');
INSERT INTO bicycle VALUES('B102', '2006-10-13', 'RED','C101', 'M101');
INSERT INTO bicycle VALUES('B103', '2006-02-13', 'BLUE','C103', 'M103');
INSERT INTO bicycle VALUES('B104', '2005-05-13', 'BLACK','C103', 'M104');
INSERT INTO bicycle VALUES('B105', '2004-07-13', 'PURPLE','C105', 'M105');



mysql> select * from bicycle;
+------+---------------+--------+-------+----------+
| b_id | purchase_date | color  | b_cid | model_no |
+------+---------------+--------+-------+----------+
| B101 | 2003-12-13    | RED    | C102  | M101     |
| B102 | 2006-10-13    | RED    | C101  | M101     |
| B103 | 2006-02-13    | BLUE   | C103  | M103     |
| B104 | 2005-05-13    | BLACK  | C103  | M104     |
| B105 | 2004-07-13    | PURPLE | C105  | M105     |
+------+---------------+--------+-------+----------+
5 rows in set (0.00 sec)



create table service
(
bicycle_id varchar(10) primary key,
startdate date,
enddate date,
foreign key (bicycle_id) references bicycle(b_id)
);



INSERT INTO service VALUES('B101', '2005-12-13', '2005-12-13');
INSERT INTO service VALUES('B102', '2006-10-13', '2006-10-13');
INSERT INTO service VALUES('B103', '2006-02-13', '2005-02-25');
INSERT INTO service VALUES('B104', '2005-05-13', '2005-05-20');
INSERT INTO service VALUES('B105', '2004-07-13', '2005-07-28');



mysql> select * from service;
+------------+------------+------------+
| bicycle_id | startdate  | enddate    |
+------------+------------+------------+
| B101       | 2005-12-13 | 2005-12-13 |
| B102       | 2006-10-13 | 2006-10-13 |
| B103       | 2006-02-13 | 2005-02-25 |
| B104       | 2005-05-13 | 2005-05-20 |
| B105       | 2004-07-13 | 2005-07-28 |
+------------+------------+------------+
5 rows in set (0.00 sec)

b) SELECT name from customer, bicyclemodel where manufacturer='HONDA'
And customer.c_cid=bicyclemodel.c_cid;

+--------+
| name   |
+--------+
| RAM    |
| SANJAY |
+--------+
2 rows in set (0.01 sec)

c) select b_id from bicycle, customer
WHERE customer.refer_id='C1' And customer.c_cid=bicycle.b_cid;

+------+
| b_id |
+------+
| B102 |
| B101 |
+------+
2 rows in set (0.02 sec)

d) SELECT distinct manufacturer from bicyclemodel, bicycle
WHERE bicycle.color="RED"
AND bicycle.model_no=bicyclemodel.bmodel_no;

+--------------+
| manufacturer |
+--------------+
| HONDA        |
+--------------+
1 row in set (0.01 sec)

e) select distinct bmodel_no from bicyclemodel, bicycle, service where service.bicycle_id=bicycle.b_id
AND bicyclemodel.bmodel_no=bicycle.model_no;

+-----------+
| bmodel_no |
+-----------+
| M101      |
| M103      |
| M104      |
| M105      |
+-----------+
4 rows in set (0.00 sec)