Create Database Shelter;

CREATE TABLE animals (
   animalid serial primary key,
   animalname varchar(30) not null check (length(animalname)>=3),
   animalage int not null check (animalage>=0 AND animalage <40),
   animalmonth int not null check (animalmonth >=1 AND animalmonth < 12),
   weight int not null check (weight >=0.1 And weight <= 105 ),
   description varchar(255),
   animaltype varchar(3) not null check (animaltype in('cat','dog')),
   gender varchar(6) not null check (gender in ('female','male')),
   admission_date date not null
);

CREATE TABLE breed (
   breedid serial primary key,
   breedtype VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE animalsxbreed (
   animalxbreedid serial primary key,
   breedid INT,
   animalid INT,   
   FOREIGN KEY (breedid) REFERENCES breed(breedid),
   FOREIGN KEY (animalid) REFERENCES animals(animalid)
);

CREATE TABLE pet_pen(
   pet_penid serial primary key,
   pen_number int unique not null,
   pen_status varchar(6) not null check (pen_status in ('free','busy','repair')),
   pen_size varchar(6) not null check (pen_size in ('big','small','medium')),
   pen_clean date not null,
   Pracownik_Odpowiedzialny varchar(255)
);

CREATE TABLE animalsxpet_pen (
   animalxpet_penid serial primary key,
   pet_penid INT,
   animalid INT,   
   FOREIGN KEY (pet_penid) REFERENCES pet_pen(pet_penid),
   FOREIGN KEY (animalid) REFERENCES animals(animalid)
);

CREATE TABLE employees(
   employeesid serial primary key,
   firstname varchar(27) not null check (length(firstname)>=2),
   lastname varchar(54) not null check (length(lastname)>=2),
   workstation varchar(24) not null check (workstation in ('boss','administrative','medical','keeper')),
   city varchar(125) not null check (length(city)>=2),
   address varchar(255) not null check (length(address)>2),
   zipcode varchar(6) not null,
   phone varchar(20) not null,
   email varchar (100),
   salary decimal(6,2) not null,
   employmentdate date not null
);

CREATE TABLE animalsxemployees (
   animalsxemployeeid serial primary key,
   employeesid INT,
   animalid INT,   
   FOREIGN KEY (employeesid) REFERENCES employees(employeesid),
   FOREIGN KEY (animalid) REFERENCES animals(animalid)
);



CREATE TABLE veterinarycares(
  veterinarycareid serial primary key,
  firstname varchar(27) not null check (length(firstname)>=2),
  lastname varchar(54) not null check (length(lastname)>=2),
  vetlocation varchar(255) not null check (length(vetlocation)>=5),
  vetvisitdate date not null,
  next_vetvisitdate date not null check(next_vetvisitdate > vetvisitdate),
  treatmentdetail TEXT NOT NULL CHECK (LENGTH(treatmentdetail) <= 2500),
  payment_status varchar(30) not null check (payment_status IN ('paid','unpaid'))
);

CREATE TABLE vaccinations(
  vaccinationid serial primary key,
  vaccine_type varchar(100) not null,
  vaccination_date date not null,
  next_vaccination_date date not null check(next_vaccination_date > vaccination_date)
);

CREATE TABLE animalsxveterinarycaresxvaccinations (
  animalsxveterinary_careid serial primary key,
  veterinarycareid INT,
  vaccinationsid INT,
  animalid INT,
  FOREIGN KEY (veterinarycareid) REFERENCES veterinarycares(veterinarycareid),
  FOREIGN KEY (vaccinationsid) REFERENCES vaccinations(vaccinationsid),
  FOREIGN KEY (animalid) REFERENCES animals(animalid)
);



CREATE TABLE medications(
 medicationid serial primary key,
 medication_name varchar(50) not null check (length(medication_name)>=3),
 dosage NUMERIC(6, 2) NOT NULL CHECK (dosage >= 0.1),
 frequency varchar(30) not null check (length(frequency)>=5),
 frequencydate date not null,
 availabilit varchar(30) not null check (availabilit in ('vailable','unvailable'))
);

CREATE TABLE animalsxmedications (
 animalsxmedicationid serial primary key,
 medicationid INT,
 animalid INT,
 FOREIGN KEY (medicationid) REFERENCES medications(medicationid),
 FOREIGN KEY (animalid) REFERENCES animals(animalid)
);

CREATE TABLE dietary(
 dietid serial primary key ,
 foodtype varchar(34) not null check (foodtype in('wet', 'dry', 'semi-moist', 'freegmo', 'freesugar', 
'nowheat', 'noflavourings', 'freepreservatives')) ,
 quantity NUMERIC(6, 2) NOT NULL CHECK (quantity >= 1),
 allergy varchar(40) not null check (allergy in ('have','nohave')),
 allergietype varchar(128), 
 special_requirements TEXT NOT NULL CHECK (LENGTH(special_requirements) <= 1500)
);

CREATE TABLE animalsxdietary (
 animalsxdietarid serial primary key,
 dietid INT,
 animalid INT,
 FOREIGN KEY (dietid) REFERENCES dietary(dietid),
 FOREIGN KEY (animalid) REFERENCES animals(animalid)
);


CREATE TABLE adoptions(
 adoptionsid serial primary key ,
 adoptiondate date not null,
 adoptionstatus VARCHAR(50) not null check (adoptionstatus IN ('inprocess','cancelled','completed')),
 comments varchar(125),
 date_return date NULL,
 reason_of_return varchar(125) NULL,
 adoptionconditions varchar(125) NULL
);

CREATE TABLE customers(
 customerid serial primary key , 
 firstname varchar(27) not null check (length(firstname)>=2), 	
 lastname varchar(54) not null check (length(lastname)>=2),
 dataofbirth DATE,
 CHECK (CURRENT_DATE - dataOfBirth >= 18),
 city varchar(125) not null check (length(city)>=2), 
 address varchar(255) not null check (length(address)>2),
 zipcode varchar(6) not null,
 phone varchar(20) not null,
 email varchar (100) null,
 historyinteraction TEXT NOT NULL CHECK (LENGTH(historyinteraction) <= 2500) 
);

CREATE TABLE animalsxadoptionsxcustomers (
 animalsxadoptionsxcustomersid serial primary key ,
 adoptionsid INT,
 customerid INT,
 animalid INT,	
 FOREIGN KEY (adoptionsid) REFERENCES adoptions(adoptionsid),
 FOREIGN KEY (customerid) REFERENCES customers(customerid),
 FOREIGN KEY (animalid) REFERENCES animals(animalid)
);

CREATE TABLE fees (
 fee serial primary key  ,
 feedescription VARCHAR(110),
 amount DECIMAL(8, 2),
 feedate date,
 feestatus VARCHAR(50) not null check (feestatus IN ('inprocess','cancelled','completed')),
 description varchar(130) 
);



