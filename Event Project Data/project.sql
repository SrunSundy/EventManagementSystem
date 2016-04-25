
CREATE TABLE tbl_user(
	user_id SERIAL PRIMARY KEY,
	user_name VARCHAR(100),
	email VARCHAR(100),
	gender VARCHAR(1),
	birth_date DATE,
	current_address VARCHAR(200),
	create_date TIMESTAMP DEFAULT now(),
	status INT DEFAULT 1
);

INSERT INTO tbl_user(user_name,email,gender,birth_date,current_address)
VALUES('sundy','jamsdfsdfsesundy@gmail.com','M','10-10-1993','PP'),
('sy','jamesundsdfsy@gmail.com','M','10-10-1993','PP'),
('sudy','jameaassundy@gmail.com','M','10-10-1993','PP'),
('ndy','jsdfsamesundy@gmail.com','M','10-10-1993','PP'),
('undy','sundy@gmail.com','M','10-10-1993','PP'),
('sdy','jameundy@gmail.com','M','10-10-1993','PP'),
('ndy','jamsundy@gmail.com','M','10-10-1993','PP');

CREATE TABLE tbl_user_event(
	event_id SERIAL PRIMARY KEY,
	user_id INT REFERENCES tbl_user(user_id),
	event_name VARCHAR(150),
	description VARCHAR(200),
	create_date TIMESTAMP DEFAULT now(),
	status INT DEFAULT 1
);

INSERT INTO tbl_user_event(user_id,event_name,description) 
VALUES(1,'Wedding','This is the best celebration');
INSERT INTO tbl_user_event(user_id,event_name,description) 
VALUES(2,'Small party','This event consist of ka than,party...');


CREATE TABLE tbl_paid_product(
	paid_pro_id SERIAL PRIMARY KEY,
	user_id INT REFERENCES tbl_user(user_id),
	event_id INT REFERENCES tbl_user_event(event_id),
	product_name VARCHAR(150),
	price FLOAT,
	create_date TIMESTAMP DEFAULT now(),
	status INT DEFAULT 1
);


CREATE TABLE tbl_participation(
	participation_id SERIAL PRIMARY KEY,
	user_id INT REFERENCES tbl_user(user_id),
	participation_name VARCHAR(50),
	description VARCHAR(200),
	status INT DEFAULT 1
	

);

CREATE TABLE tbl_part_detail(

	part_detail_id SERIAL PRIMARY KEY,
	participation_id INT REFERENCES tbl_participation(participation_id),
	event_id INT REFERENCES tbl_user_event(event_id),
	khmermoney FLOAT,
	dollarmoney FLOAT,
	havegift BOOLEAN,
	gift_description VARCHAR(200),
	create_date TIMESTAMP  DEFAULT now(),
	last_modify_date TIMESTAMP DEFAULT now(),
	status INT DEFAULT 1
);

ALTER TABLE tbl_user ADD COLUMN last_modify_date TIMESTAMP DEFAULT now();
ALTER TABLE tbl_paid_product ADD COLUMN last_modify_date TIMESTAMP DEFAULT now();
ALTER TABLE tbl_user_event ADD COLUMN last_modify_date TIMESTAMP DEFAULT now();


--my query;

CASE 
		WHEN (SELECT COUNT(*) WHERE participation_name='Narong' and user_id=1) > 0 THEN 
			
			INSERT INTO tbl_part_detail(participation_id,event_id,money,havegift,gift_description)
SELECT (SELECT participation_id FROM tbl_participation WHERE participation_name='Nar' and user_id=1),2,0,false,'yoyo'
WHERE not exists (
    select * from tbl_part_detail where participation_id =( SELECT participation_id FROM tbl_participation WHERE participation_name='Nar' and user_id=1)
 and event_id = 2
);
		ELSE
			INSERT INTO tbl_participation(participation_name,description,user_id)
			VALUES('Narith','bek sloy',1);
			INSERT INTO tbl_part_detail(participation_id,event_id,money,havegift,gift_description)
			VALUES((SELECT participation_id FROM tbl_participation WHERE participation_name='Narith' and user_id=1),2,0,false,'yoyo');
END