COMMENT ON SCHEMA public IS 'standard public schema';

-- DROP SEQUENCE public.film_id_seq;

CREATE SEQUENCE public.film_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.hall_id_seq;

CREATE SEQUENCE public.hall_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.screening_id_seq;

CREATE SEQUENCE public.screening_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.tickets_id_screening_seq;

CREATE SEQUENCE public.tickets_id_screening_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- public.film definition

-- Drop table

-- DROP TABLE film;

CREATE TABLE film (
	id serial4 NOT NULL,
	"name" varchar NOT NULL,
	description text NULL,
	CONSTRAINT film_pk PRIMARY KEY (id)
);


-- public.hall definition

-- Drop table

-- DROP TABLE hall;

CREATE TABLE hall (
	id serial4 NOT NULL,
	"name" varchar(100) NOT NULL,
	CONSTRAINT hall_pk PRIMARY KEY (id)
);


-- public.hall_row definition

-- Drop table

-- DROP TABLE hall_row;

CREATE TABLE hall_row (
	hall_id int4 NOT NULL,
	"number" int2 NOT NULL,
	capacity int2 NOT NULL
);


-- public.screening definition

-- Drop table

-- DROP TABLE screening;

CREATE TABLE screening (
	id serial4 NOT NULL,
	hall_id int4 NOT NULL,
	film_id int4 NOT NULL,
	"time" timestamp NULL,
	CONSTRAINT screening_pk PRIMARY KEY (id)
);


-- public.tickets definition

-- Drop table

-- DROP TABLE tickets;

CREATE TABLE tickets (
	id_screening serial4 NOT NULL,
	"row" int2 NOT NULL,
	seat int2 NOT NULL,
	"cost" int4 NOT NULL,
	CONSTRAINT tickets_pk PRIMARY KEY (id_screening, "row", seat)
);


-- public.certainhall source

CREATE OR REPLACE VIEW public.certainhall
AS SELECT hall.name AS "Зал",
    screening."time" AS "Начало"
   FROM screening
     JOIN hall ON hall.id = screening.hall_id
  WHERE screening.hall_id = 2;


-- public.filmafter11 source

CREATE OR REPLACE VIEW public.filmafter11
AS SELECT film.name AS "Название",
    screening."time" AS "Начало"
   FROM screening
     JOIN film ON film.id = screening.film_id
  WHERE screening."time" > '2024-01-01 11:40:00'::timestamp without time zone;


-- public.hall_three_row_tow source

CREATE OR REPLACE VIEW public.hall_three_row_tow
AS SELECT hall.name AS "Номер зала",
    hall_row.number AS "Номер ряда",
    hall_row.capacity AS "Количество мест"
   FROM hall_row
     JOIN hall ON hall.id = hall_row.hall_id
  WHERE hall.name::text = 'Зал 3'::text AND hall_row.number = 2;


-- public.certainfilm source

CREATE OR REPLACE VIEW public.certainfilm
AS SELECT film.name AS "Название",
    screening."time" AS "Начало"
   FROM screening
     JOIN film ON film.id = screening.film_id
  WHERE screening.film_id = 7;
 
 
 INSERT INTO public.film (id,"name",description) VALUES
	 (1,'Форсаж 1','Боевик, триллер'),
	 (2,'Веном 3','Боевик, ужасы'),
	 (3,'Ужасающий 3','Ужасы'),
	 (4,'Переводчик','Боевик, триллер'),
	 (5,'Драйв','Драма'),
	 (6,'Ужасающий 2','Ужасы'),
	 (7,'Ужасающий 1','Ужасы');
INSERT INTO public.hall (id,"name") VALUES
	 (1,'Зал 1'),
	 (2,'Зал 2'),
	 (3,'Зал 3'),
	 (4,'Зал 4'),
	 (7,'Зал 7'),
	 (5,'Зал 5'),
	 (6,'Зал 6');
INSERT INTO public.hall_row (hall_id,"number",capacity) VALUES
	 (1,1,6),
	 (2,6,12),
	 (3,2,8),
	 (4,3,7),
	 (6,4,8),
	 (7,2,5),
	 (5,2,8);
INSERT INTO public.screening (id,hall_id,film_id,"time") VALUES
	 (4,4,4,'2024-02-06 10:30:00'),
	 (2,2,1,'2024-02-01 11:40:00'),
	 (5,5,2,'2024-02-09 20:40:00'),
	 (1,1,3,'2024-02-01 11:40:00'),
	 (6,6,5,'2024-02-06 10:30:00'),
	 (7,7,6,'2023-12-07 11:40:00'),
	 (3,3,7,'2023-12-08 10:40:00');
INSERT INTO public.tickets (id_screening,"row",seat,"cost") VALUES
	 (1,5,12,450),
	 (2,4,9,350),
	 (3,6,8,400),
	 (4,8,4,300),
	 (5,2,10,500),
	 (6,7,3,400),
	 (7,4,2,500);
