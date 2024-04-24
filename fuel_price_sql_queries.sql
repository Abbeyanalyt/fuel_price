create database nigeria_petrol_price;

use nigeria_petrol_price;

-- Importing the fuel price(april-2023 to jan-2024) data downloaded from nigeria bureau of statistics
create table jan_price_24(
state varchar(255) primary key,
DEC_2023 double not null,
JAN_2024 double not null
);
 
create table dec_price_23(
state varchar(255),
DEC_2023 double not null,
NOV_2023 double not null

);
ALTER TABLE dec_price_23
ADD Foreign key(state) references jan_price_24(state);

create table oct_price_23(
state varchar(255),
SEPT_2023 double not null,
OCT_2023 double not null
);

ALTER TABLE oct_price_23
ADD Foreign key(state) references jan_price_24(state);

CREATE table AUG_23(
state varchar(255),
AUG_2023 double not null
);

ALTER TABLE AUG_23
ADD Foreign key(state) references jan_price_24(state);

create table july_price_23(
state varchar(255),
JUNE_2023 double not null,
JULY_2023 double not null

);

ALTER TABLE july_price_23
ADD Foreign key(state) references jan_price_24(state);

CREATE table MAY_23(
state varchar(255),
MAY_2023 double not null
);

ALTER TABLE MAY_23
ADD Foreign key(state) references jan_price_24(state);

 CREATE table APRIL_23(
state varchar(255),
ITEMLABELS varchar(255),
APRIL_2023 double not null
);

ALTER TABLE APRIL_23
ADD Foreign key(state) references jan_price_24(state);


SELECT * from jan_price_24;
SELECT * from dec_price_23;
SELECT * from oct_price_23;
SELECT * from aug_23;
SELECT * from july_price_23;
SELECT * from may_23;
SELECT * from april_23;

-- Using the join method to retrieve and join the columns needed 
CREATE TABLE nigeria_fuel_price
as
SELECT j.state, ITEMLABELS, APRIL_2023, MAY_2023, JUNE_2023, 
JULY_2023 ,AUG_2023, SEPT_2023, OCT_2023, NOV_2023,
DEC_2023, JAN_2024 from  jan_price_24 j 
join dec_price_23 d
 on j.state = d.state
join oct_price_23 o
on j.state = o.state
join aug_23 a
on j.state = a.state
join july_price_23 ju
on j.state = ju.state
join may_23 m
on j.state = m.state
join april_23 ap
on j.state = ap.state;

select * from nigeria_fuel_price;


create table total_price as
select
state,
(jan_2024 + dec_2023 + nov_2023 + sept_2023 
+ oct_2023 + aug_2023 + june_2023 + july_2023 + may_2023 + april_2023) as total_price
from nigeria_fuel_price
;
-- Calculating for average(overall_price) 
create table average_price
select 
state,
round(total_price/10,2) as average_price
 from total_price
 order by average_price desc;
 
 select * from average_price;
 
 alter table average_price
 add foreign key(state) references nigeria_fuel_price(state);
 
 -- i have just derived the table i needed for my fuel_price_analysis
 create table fuel_price as
 select n.state, itemlabels, april_2023,
 may_2023, june_2023, july_2023, aug_2023,
sept_2023, oct_2023, nov_2023, dec_2023, jan_2024,
 average_price from  nigeria_fuel_price n
 join average_price a
 on  n.state = a.state;
 
 
 select * from fuel_price;

# i transposed my fuel_price table using excel then 
-- importing it back to sql 
create table ngn_fuel_price_transpose(
date date ,
abia double,
abuja double,
adamawa double,
akwa_ibom double,
anambra double,
bauchi double,
bayelsa double,
benue double,
borno double, 
cross_river double, 
delta double,
ebonyi double,
edo double,
ekiti double,
enugu double,
gombe double,
imo double, 
jigawa double,
kaduna double,
kano double,
katsina double,
kebbi double,
kogi double,
kwara double,
lagos double,
niger double,
 ogun double,
 ondo double,
 osun double,
 oyo double, 
 plateau double,
 rivers double, 
 sokoto double,
 taraba double,
 yobe double,
 zamfara double
 );
 
 select * from ngn_fuel_transpose
 ;
 
