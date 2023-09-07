-- Create the database table schema

CREATE SCHEMA crowdfunding;


CREATE TABLE crowdfunding.campaign (
    cf_id integer NOT NULL,
    contact_id integer,
    company_name character varying(60),
    description character varying(100),
    goal double precision,
    pledged double precision,
    outcome character varying(20),
    backers_count integer,
    country character(2),
    currency character(3),
    launch_date date,
    end_date date,
    category_id character varying(7),
    subcategory_id character varying(10)
);


CREATE TABLE crowdfunding.category (
    category_id character varying(7) NOT NULL,
    category character varying(40)
);


CREATE TABLE crowdfunding.contacts (
    contact_id integer NOT NULL,
    first_name character varying(20),
    last_name character varying(20),
    email character varying(60)
);


CREATE TABLE crowdfunding.subcategory (
    subcategory_id character varying(10) NOT NULL,
    subcategory character varying(40)
);


ALTER TABLE ONLY crowdfunding.campaign
    ADD CONSTRAINT pk_campaign PRIMARY KEY (cf_id);

ALTER TABLE ONLY crowdfunding.category
    ADD CONSTRAINT pk_category PRIMARY KEY (category_id);
	
ALTER TABLE ONLY crowdfunding.contacts
    ADD CONSTRAINT pk_contacts PRIMARY KEY (contact_id);

ALTER TABLE ONLY crowdfunding.subcategory
    ADD CONSTRAINT pk_subcategory PRIMARY KEY (subcategory_id);


ALTER TABLE ONLY crowdfunding.campaign
    ADD CONSTRAINT fk_campaign_category_id FOREIGN KEY (category_id) REFERENCES crowdfunding.category(category_id);

ALTER TABLE ONLY crowdfunding.campaign
    ADD CONSTRAINT fk_campaign_contact_id FOREIGN KEY (contact_id) REFERENCES crowdfunding.contacts(contact_id);

ALTER TABLE ONLY crowdfunding.campaign
    ADD CONSTRAINT fk_campaign_subcategory_id FOREIGN KEY (subcategory_id) REFERENCES crowdfunding.subcategory(subcategory_id);


-- Import data into the tables

COPY crowdfunding.contacts FROM '/tmp/Resources/contacts.csv' WITH CSV HEADER;

COPY crowdfunding.category FROM '/tmp/Resources/category.csv' WITH CSV HEADER;

COPY crowdfunding.subcategory FROM '/tmp/Resources/subcategory.csv' WITH CSV HEADER;

COPY crowdfunding.campaign FROM '/tmp/Resources/campaign.csv' WITH CSV HEADER;