--
-- PostgreSQL database dump
--

-- Dumped from database version 11.0 (Debian 11.0-1.pgdg90+2)
-- Dumped by pg_dump version 13.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: mpaa_rating; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.mpaa_rating AS ENUM (
    'G',
    'PG',
    'PG-13',
    'R',
    'NC-17'
);


--
-- Name: year; Type: DOMAIN; Schema: public; Owner: -
--

CREATE DOMAIN public.year AS integer
	CONSTRAINT year_check CHECK (((VALUE >= 1901) AND (VALUE <= 2155)));


--
-- Name: _group_concat(text, text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public._group_concat(text, text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $_$
SELECT CASE
  WHEN $2 IS NULL THEN $1
  WHEN $1 IS NULL THEN $2
  ELSE $1 || ', ' || $2
END
$_$;


--
-- Name: film_in_stock(integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.film_in_stock(p_film_id integer, p_store_id integer, OUT p_film_count integer) RETURNS SETOF integer
    LANGUAGE sql
    AS $_$
     SELECT inventory_id
     FROM inventory
     WHERE film_id = $1
     AND store_id = $2
     AND inventory_in_stock(inventory_id);
$_$;


--
-- Name: film_not_in_stock(integer, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.film_not_in_stock(p_film_id integer, p_store_id integer, OUT p_film_count integer) RETURNS SETOF integer
    LANGUAGE sql
    AS $_$
    SELECT inventory_id
    FROM inventory
    WHERE film_id = $1
    AND store_id = $2
    AND NOT inventory_in_stock(inventory_id);
$_$;


--
-- Name: get_customer_balance(integer, timestamp with time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_customer_balance(p_customer_id integer, p_effective_date timestamp with time zone) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
       --#OK, WE NEED TO CALCULATE THE CURRENT BALANCE GIVEN A CUSTOMER_ID AND A DATE
       --#THAT WE WANT THE BALANCE TO BE EFFECTIVE FOR. THE BALANCE IS:
       --#   1) RENTAL FEES FOR ALL PREVIOUS RENTALS
       --#   2) ONE DOLLAR FOR EVERY DAY THE PREVIOUS RENTALS ARE OVERDUE
       --#   3) IF A FILM IS MORE THAN RENTAL_DURATION * 2 OVERDUE, CHARGE THE REPLACEMENT_COST
       --#   4) SUBTRACT ALL PAYMENTS MADE BEFORE THE DATE SPECIFIED
DECLARE
    v_rentfees DECIMAL(5,2); --#FEES PAID TO RENT THE VIDEOS INITIALLY
    v_overfees INTEGER;      --#LATE FEES FOR PRIOR RENTALS
    v_payments DECIMAL(5,2); --#SUM OF PAYMENTS MADE PREVIOUSLY
BEGIN
    SELECT COALESCE(SUM(film.rental_rate),0) INTO v_rentfees
    FROM film, inventory, rental
    WHERE film.film_id = inventory.film_id
      AND inventory.inventory_id = rental.inventory_id
      AND rental.rental_date <= p_effective_date
      AND rental.customer_id = p_customer_id;

    SELECT COALESCE(SUM(IF((rental.return_date - rental.rental_date) > (film.rental_duration * '1 day'::interval),
        ((rental.return_date - rental.rental_date) - (film.rental_duration * '1 day'::interval)),0)),0) INTO v_overfees
    FROM rental, inventory, film
    WHERE film.film_id = inventory.film_id
      AND inventory.inventory_id = rental.inventory_id
      AND rental.rental_date <= p_effective_date
      AND rental.customer_id = p_customer_id;

    SELECT COALESCE(SUM(payment.amount),0) INTO v_payments
    FROM payment
    WHERE payment.payment_date <= p_effective_date
    AND payment.customer_id = p_customer_id;

    RETURN v_rentfees + v_overfees - v_payments;
END
$$;


--
-- Name: inventory_held_by_customer(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.inventory_held_by_customer(p_inventory_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_customer_id INTEGER;
BEGIN

  SELECT customer_id INTO v_customer_id
  FROM rental
  WHERE return_date IS NULL
  AND inventory_id = p_inventory_id;

  RETURN v_customer_id;
END $$;


--
-- Name: inventory_in_stock(integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.inventory_in_stock(p_inventory_id integer) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_rentals INTEGER;
    v_out     INTEGER;
BEGIN
    -- AN ITEM IS IN-STOCK IF THERE ARE EITHER NO ROWS IN THE rental TABLE
    -- FOR THE ITEM OR ALL ROWS HAVE return_date POPULATED

    SELECT count(*) INTO v_rentals
    FROM rental
    WHERE inventory_id = p_inventory_id;

    IF v_rentals = 0 THEN
      RETURN TRUE;
    END IF;

    SELECT COUNT(rental_id) INTO v_out
    FROM inventory LEFT JOIN rental USING(inventory_id)
    WHERE inventory.inventory_id = p_inventory_id
    AND rental.return_date IS NULL;

    IF v_out > 0 THEN
      RETURN FALSE;
    ELSE
      RETURN TRUE;
    END IF;
END $$;


--
-- Name: last_day(timestamp with time zone); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.last_day(timestamp with time zone) RETURNS date
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
  SELECT CASE
    WHEN EXTRACT(MONTH FROM $1) = 12 THEN
      (((EXTRACT(YEAR FROM $1) + 1) operator(pg_catalog.||) '-01-01')::date - INTERVAL '1 day')::date
    ELSE
      ((EXTRACT(YEAR FROM $1) operator(pg_catalog.||) '-' operator(pg_catalog.||) (EXTRACT(MONTH FROM $1) + 1) operator(pg_catalog.||) '-01')::date - INTERVAL '1 day')::date
    END
$_$;


--
-- Name: last_updated(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.last_updated() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.last_update = CURRENT_TIMESTAMP;
    RETURN NEW;
END $$;


--
-- Name: customer_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.customer_customer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


SET default_tablespace = '';

--
-- Name: customer; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.customer (
    customer_id integer DEFAULT nextval('public.customer_customer_id_seq'::regclass) NOT NULL,
    store_id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    email text,
    address_id integer NOT NULL,
    activebool boolean DEFAULT true NOT NULL,
    create_date date DEFAULT CURRENT_DATE NOT NULL,
    last_update timestamp with time zone DEFAULT now(),
    active integer
);


--
-- Name: rewards_report(integer, numeric); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.rewards_report(min_monthly_purchases integer, min_dollar_amount_purchased numeric) RETURNS SETOF public.customer
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
DECLARE
    last_month_start DATE;
    last_month_end DATE;
rr RECORD;
tmpSQL TEXT;
BEGIN

    /* Some sanity checks... */
    IF min_monthly_purchases = 0 THEN
        RAISE EXCEPTION 'Minimum monthly purchases parameter must be > 0';
    END IF;
    IF min_dollar_amount_purchased = 0.00 THEN
        RAISE EXCEPTION 'Minimum monthly dollar amount purchased parameter must be > $0.00';
    END IF;

    last_month_start := CURRENT_DATE - '3 month'::interval;
    last_month_start := to_date((extract(YEAR FROM last_month_start) || '-' || extract(MONTH FROM last_month_start) || '-01'),'YYYY-MM-DD');
    last_month_end := LAST_DAY(last_month_start);

    /*
    Create a temporary storage area for Customer IDs.
    */
    CREATE TEMPORARY TABLE tmpCustomer (customer_id INTEGER NOT NULL PRIMARY KEY);

    /*
    Find all customers meeting the monthly purchase requirements
    */

    tmpSQL := 'INSERT INTO tmpCustomer (customer_id)
        SELECT p.customer_id
        FROM payment AS p
        WHERE DATE(p.payment_date) BETWEEN '||quote_literal(last_month_start) ||' AND '|| quote_literal(last_month_end) || '
        GROUP BY customer_id
        HAVING SUM(p.amount) > '|| min_dollar_amount_purchased || '
        AND COUNT(customer_id) > ' ||min_monthly_purchases ;

    EXECUTE tmpSQL;

    /*
    Output ALL customer information of matching rewardees.
    Customize output as needed.
    */
    FOR rr IN EXECUTE 'SELECT c.* FROM tmpCustomer AS t INNER JOIN customer AS c ON t.customer_id = c.customer_id' LOOP
        RETURN NEXT rr;
    END LOOP;

    /* Clean up */
    tmpSQL := 'DROP TABLE tmpCustomer';
    EXECUTE tmpSQL;

RETURN;
END
$_$;


--
-- Name: group_concat(text); Type: AGGREGATE; Schema: public; Owner: -
--

CREATE AGGREGATE public.group_concat(text) (
    SFUNC = public._group_concat,
    STYPE = text
);


--
-- Name: actor_actor_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.actor_actor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: actor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.actor (
    actor_id integer DEFAULT nextval('public.actor_actor_id_seq'::regclass) NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: category_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.category_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.category (
    category_id integer DEFAULT nextval('public.category_category_id_seq'::regclass) NOT NULL,
    name text NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: film_film_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.film_film_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: film; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.film (
    film_id integer DEFAULT nextval('public.film_film_id_seq'::regclass) NOT NULL,
    title text NOT NULL,
    description text,
    release_year public.year,
    language_id integer NOT NULL,
    original_language_id integer,
    rental_duration smallint DEFAULT 3 NOT NULL,
    rental_rate numeric(4,2) DEFAULT 4.99 NOT NULL,
    length smallint,
    replacement_cost numeric(5,2) DEFAULT 19.99 NOT NULL,
    rating public.mpaa_rating DEFAULT 'G'::public.mpaa_rating,
    last_update timestamp with time zone DEFAULT now() NOT NULL,
    special_features text[],
    fulltext tsvector NOT NULL
);


--
-- Name: film_actor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.film_actor (
    actor_id integer NOT NULL,
    film_id integer NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: film_category; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.film_category (
    film_id integer NOT NULL,
    category_id integer NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: actor_info; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.actor_info AS
 SELECT a.actor_id,
    a.first_name,
    a.last_name,
    public.group_concat(DISTINCT ((c.name || ': '::text) || ( SELECT public.group_concat(f.title) AS group_concat
           FROM ((public.film f
             JOIN public.film_category fc_1 ON ((f.film_id = fc_1.film_id)))
             JOIN public.film_actor fa_1 ON ((f.film_id = fa_1.film_id)))
          WHERE ((fc_1.category_id = c.category_id) AND (fa_1.actor_id = a.actor_id))
          GROUP BY fa_1.actor_id))) AS film_info
   FROM (((public.actor a
     LEFT JOIN public.film_actor fa ON ((a.actor_id = fa.actor_id)))
     LEFT JOIN public.film_category fc ON ((fa.film_id = fc.film_id)))
     LEFT JOIN public.category c ON ((fc.category_id = c.category_id)))
  GROUP BY a.actor_id, a.first_name, a.last_name;


--
-- Name: address_address_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.address_address_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: address; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.address (
    address_id integer DEFAULT nextval('public.address_address_id_seq'::regclass) NOT NULL,
    address text NOT NULL,
    address2 text,
    district text NOT NULL,
    city_id integer NOT NULL,
    postal_code text,
    phone text NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: city_city_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.city_city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: city; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.city (
    city_id integer DEFAULT nextval('public.city_city_id_seq'::regclass) NOT NULL,
    city text NOT NULL,
    country_id integer NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: country_country_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.country_country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: country; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.country (
    country_id integer DEFAULT nextval('public.country_country_id_seq'::regclass) NOT NULL,
    country text NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: customer_list; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.customer_list AS
 SELECT cu.customer_id AS id,
    ((cu.first_name || ' '::text) || cu.last_name) AS name,
    a.address,
    a.postal_code AS "zip code",
    a.phone,
    city.city,
    country.country,
        CASE
            WHEN cu.activebool THEN 'active'::text
            ELSE ''::text
        END AS notes,
    cu.store_id AS sid
   FROM (((public.customer cu
     JOIN public.address a ON ((cu.address_id = a.address_id)))
     JOIN public.city ON ((a.city_id = city.city_id)))
     JOIN public.country ON ((city.country_id = country.country_id)));


--
-- Name: film_list; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.film_list AS
 SELECT film.film_id AS fid,
    film.title,
    film.description,
    category.name AS category,
    film.rental_rate AS price,
    film.length,
    film.rating,
    public.group_concat(((actor.first_name || ' '::text) || actor.last_name)) AS actors
   FROM ((((public.category
     LEFT JOIN public.film_category ON ((category.category_id = film_category.category_id)))
     LEFT JOIN public.film ON ((film_category.film_id = film.film_id)))
     JOIN public.film_actor ON ((film.film_id = film_actor.film_id)))
     JOIN public.actor ON ((film_actor.actor_id = actor.actor_id)))
  GROUP BY film.film_id, film.title, film.description, category.name, film.rental_rate, film.length, film.rating;


--
-- Name: inventory_inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.inventory_inventory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: inventory; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.inventory (
    inventory_id integer DEFAULT nextval('public.inventory_inventory_id_seq'::regclass) NOT NULL,
    film_id integer NOT NULL,
    store_id integer NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: language_language_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.language_language_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: language; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.language (
    language_id integer DEFAULT nextval('public.language_language_id_seq'::regclass) NOT NULL,
    name character(20) NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: nicer_but_slower_film_list; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.nicer_but_slower_film_list AS
 SELECT film.film_id AS fid,
    film.title,
    film.description,
    category.name AS category,
    film.rental_rate AS price,
    film.length,
    film.rating,
    public.group_concat((((upper("substring"(actor.first_name, 1, 1)) || lower("substring"(actor.first_name, 2))) || upper("substring"(actor.last_name, 1, 1))) || lower("substring"(actor.last_name, 2)))) AS actors
   FROM ((((public.category
     LEFT JOIN public.film_category ON ((category.category_id = film_category.category_id)))
     LEFT JOIN public.film ON ((film_category.film_id = film.film_id)))
     JOIN public.film_actor ON ((film.film_id = film_actor.film_id)))
     JOIN public.actor ON ((film_actor.actor_id = actor.actor_id)))
  GROUP BY film.film_id, film.title, film.description, category.name, film.rental_rate, film.length, film.rating;


--
-- Name: payment_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payment_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment (
    payment_id integer DEFAULT nextval('public.payment_payment_id_seq'::regclass) NOT NULL,
    customer_id integer NOT NULL,
    staff_id integer NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp with time zone NOT NULL
)
PARTITION BY RANGE (payment_date);


--
-- Name: payment_p2020_01; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_p2020_01 (
    payment_id integer DEFAULT nextval('public.payment_payment_id_seq'::regclass) NOT NULL,
    customer_id integer NOT NULL,
    staff_id integer NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp with time zone NOT NULL
);
ALTER TABLE ONLY public.payment ATTACH PARTITION public.payment_p2020_01 FOR VALUES FROM ('2020-01-01 00:00:00+00') TO ('2020-02-01 00:00:00+00');


--
-- Name: payment_p2020_02; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_p2020_02 (
    payment_id integer DEFAULT nextval('public.payment_payment_id_seq'::regclass) NOT NULL,
    customer_id integer NOT NULL,
    staff_id integer NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp with time zone NOT NULL
);
ALTER TABLE ONLY public.payment ATTACH PARTITION public.payment_p2020_02 FOR VALUES FROM ('2020-02-01 00:00:00+00') TO ('2020-03-01 00:00:00+00');


--
-- Name: payment_p2020_03; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_p2020_03 (
    payment_id integer DEFAULT nextval('public.payment_payment_id_seq'::regclass) NOT NULL,
    customer_id integer NOT NULL,
    staff_id integer NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp with time zone NOT NULL
);
ALTER TABLE ONLY public.payment ATTACH PARTITION public.payment_p2020_03 FOR VALUES FROM ('2020-03-01 00:00:00+00') TO ('2020-04-01 00:00:00+00');


--
-- Name: payment_p2020_04; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_p2020_04 (
    payment_id integer DEFAULT nextval('public.payment_payment_id_seq'::regclass) NOT NULL,
    customer_id integer NOT NULL,
    staff_id integer NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp with time zone NOT NULL
);
ALTER TABLE ONLY public.payment ATTACH PARTITION public.payment_p2020_04 FOR VALUES FROM ('2020-04-01 00:00:00+00') TO ('2020-05-01 00:00:00+00');


--
-- Name: payment_p2020_05; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_p2020_05 (
    payment_id integer DEFAULT nextval('public.payment_payment_id_seq'::regclass) NOT NULL,
    customer_id integer NOT NULL,
    staff_id integer NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp with time zone NOT NULL
);
ALTER TABLE ONLY public.payment ATTACH PARTITION public.payment_p2020_05 FOR VALUES FROM ('2020-05-01 00:00:00+00') TO ('2020-06-01 00:00:00+00');


--
-- Name: payment_p2020_06; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_p2020_06 (
    payment_id integer DEFAULT nextval('public.payment_payment_id_seq'::regclass) NOT NULL,
    customer_id integer NOT NULL,
    staff_id integer NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp with time zone NOT NULL
);
ALTER TABLE ONLY public.payment ATTACH PARTITION public.payment_p2020_06 FOR VALUES FROM ('2020-06-01 00:00:00+00') TO ('2020-07-01 00:00:00+00');


--
-- Name: rental_rental_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rental_rental_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rental; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rental (
    rental_id integer DEFAULT nextval('public.rental_rental_id_seq'::regclass) NOT NULL,
    rental_date timestamp with time zone NOT NULL,
    inventory_id integer NOT NULL,
    customer_id integer NOT NULL,
    return_date timestamp with time zone,
    staff_id integer NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: sales_by_film_category; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.sales_by_film_category AS
 SELECT c.name AS category,
    sum(p.amount) AS total_sales
   FROM (((((public.payment p
     JOIN public.rental r ON ((p.rental_id = r.rental_id)))
     JOIN public.inventory i ON ((r.inventory_id = i.inventory_id)))
     JOIN public.film f ON ((i.film_id = f.film_id)))
     JOIN public.film_category fc ON ((f.film_id = fc.film_id)))
     JOIN public.category c ON ((fc.category_id = c.category_id)))
  GROUP BY c.name
  ORDER BY (sum(p.amount)) DESC;


--
-- Name: staff_staff_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.staff_staff_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: staff; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.staff (
    staff_id integer DEFAULT nextval('public.staff_staff_id_seq'::regclass) NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    address_id integer NOT NULL,
    email text,
    store_id integer NOT NULL,
    active boolean DEFAULT true NOT NULL,
    username text NOT NULL,
    password text,
    last_update timestamp with time zone DEFAULT now() NOT NULL,
    picture bytea
);


--
-- Name: store_store_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.store_store_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: store; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.store (
    store_id integer DEFAULT nextval('public.store_store_id_seq'::regclass) NOT NULL,
    manager_staff_id integer NOT NULL,
    address_id integer NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: sales_by_store; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.sales_by_store AS
 SELECT ((c.city || ','::text) || cy.country) AS store,
    ((m.first_name || ' '::text) || m.last_name) AS manager,
    sum(p.amount) AS total_sales
   FROM (((((((public.payment p
     JOIN public.rental r ON ((p.rental_id = r.rental_id)))
     JOIN public.inventory i ON ((r.inventory_id = i.inventory_id)))
     JOIN public.store s ON ((i.store_id = s.store_id)))
     JOIN public.address a ON ((s.address_id = a.address_id)))
     JOIN public.city c ON ((a.city_id = c.city_id)))
     JOIN public.country cy ON ((c.country_id = cy.country_id)))
     JOIN public.staff m ON ((s.manager_staff_id = m.staff_id)))
  GROUP BY cy.country, c.city, s.store_id, m.first_name, m.last_name
  ORDER BY cy.country, c.city;


--
-- Name: staff_list; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.staff_list AS
 SELECT s.staff_id AS id,
    ((s.first_name || ' '::text) || s.last_name) AS name,
    a.address,
    a.postal_code AS "zip code",
    a.phone,
    city.city,
    country.country,
    s.store_id AS sid
   FROM (((public.staff s
     JOIN public.address a ON ((s.address_id = a.address_id)))
     JOIN public.city ON ((a.city_id = city.city_id)))
     JOIN public.country ON ((city.country_id = country.country_id)));


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.category (category_id, name, last_update) FROM stdin;
1	Action	2020-02-15 09:46:27+00
2	Animation	2020-02-15 09:46:27+00
3	Children	2020-02-15 09:46:27+00
4	Classics	2020-02-15 09:46:27+00
5	Comedy	2020-02-15 09:46:27+00
6	Documentary	2020-02-15 09:46:27+00
7	Drama	2020-02-15 09:46:27+00
8	Family	2020-02-15 09:46:27+00
9	Foreign	2020-02-15 09:46:27+00
10	Games	2020-02-15 09:46:27+00
11	Horror	2020-02-15 09:46:27+00
12	Music	2020-02-15 09:46:27+00
13	New	2020-02-15 09:46:27+00
14	Sci-Fi	2020-02-15 09:46:27+00
15	Sports	2020-02-15 09:46:27+00
16	Travel	2020-02-15 09:46:27+00
\.


--
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.city (city_id, city, country_id, last_update) FROM stdin;
1	A Corua (La Corua)	87	2020-02-15 09:45:25+00
2	Abha	82	2020-02-15 09:45:25+00
3	Abu Dhabi	101	2020-02-15 09:45:25+00
4	Acua	60	2020-02-15 09:45:25+00
5	Adana	97	2020-02-15 09:45:25+00
6	Addis Abeba	31	2020-02-15 09:45:25+00
7	Aden	107	2020-02-15 09:45:25+00
8	Adoni	44	2020-02-15 09:45:25+00
9	Ahmadnagar	44	2020-02-15 09:45:25+00
10	Akishima	50	2020-02-15 09:45:25+00
11	Akron	103	2020-02-15 09:45:25+00
12	al-Ayn	101	2020-02-15 09:45:25+00
13	al-Hawiya	82	2020-02-15 09:45:25+00
14	al-Manama	11	2020-02-15 09:45:25+00
15	al-Qadarif	89	2020-02-15 09:45:25+00
16	al-Qatif	82	2020-02-15 09:45:25+00
17	Alessandria	49	2020-02-15 09:45:25+00
18	Allappuzha (Alleppey)	44	2020-02-15 09:45:25+00
19	Allende	60	2020-02-15 09:45:25+00
20	Almirante Brown	6	2020-02-15 09:45:25+00
21	Alvorada	15	2020-02-15 09:45:25+00
22	Ambattur	44	2020-02-15 09:45:25+00
23	Amersfoort	67	2020-02-15 09:45:25+00
24	Amroha	44	2020-02-15 09:45:25+00
25	Angra dos Reis	15	2020-02-15 09:45:25+00
26	Anpolis	15	2020-02-15 09:45:25+00
27	Antofagasta	22	2020-02-15 09:45:25+00
28	Aparecida de Goinia	15	2020-02-15 09:45:25+00
29	Apeldoorn	67	2020-02-15 09:45:25+00
30	Araatuba	15	2020-02-15 09:45:25+00
31	Arak	46	2020-02-15 09:45:25+00
32	Arecibo	77	2020-02-15 09:45:25+00
33	Arlington	103	2020-02-15 09:45:25+00
34	Ashdod	48	2020-02-15 09:45:25+00
35	Ashgabat	98	2020-02-15 09:45:25+00
36	Ashqelon	48	2020-02-15 09:45:25+00
37	Asuncin	73	2020-02-15 09:45:25+00
38	Athenai	39	2020-02-15 09:45:25+00
39	Atinsk	80	2020-02-15 09:45:25+00
40	Atlixco	60	2020-02-15 09:45:25+00
41	Augusta-Richmond County	103	2020-02-15 09:45:25+00
42	Aurora	103	2020-02-15 09:45:25+00
43	Avellaneda	6	2020-02-15 09:45:25+00
44	Bag	15	2020-02-15 09:45:25+00
45	Baha Blanca	6	2020-02-15 09:45:25+00
46	Baicheng	23	2020-02-15 09:45:25+00
47	Baiyin	23	2020-02-15 09:45:25+00
48	Baku	10	2020-02-15 09:45:25+00
49	Balaiha	80	2020-02-15 09:45:25+00
50	Balikesir	97	2020-02-15 09:45:25+00
51	Balurghat	44	2020-02-15 09:45:25+00
52	Bamenda	19	2020-02-15 09:45:25+00
53	Bandar Seri Begawan	16	2020-02-15 09:45:25+00
54	Banjul	37	2020-02-15 09:45:25+00
55	Barcelona	104	2020-02-15 09:45:25+00
56	Basel	91	2020-02-15 09:45:25+00
57	Bat Yam	48	2020-02-15 09:45:25+00
58	Batman	97	2020-02-15 09:45:25+00
59	Batna	2	2020-02-15 09:45:25+00
60	Battambang	18	2020-02-15 09:45:25+00
61	Baybay	75	2020-02-15 09:45:25+00
62	Bayugan	75	2020-02-15 09:45:25+00
63	Bchar	2	2020-02-15 09:45:25+00
64	Beira	63	2020-02-15 09:45:25+00
65	Bellevue	103	2020-02-15 09:45:25+00
66	Belm	15	2020-02-15 09:45:25+00
67	Benguela	4	2020-02-15 09:45:25+00
68	Beni-Mellal	62	2020-02-15 09:45:25+00
69	Benin City	69	2020-02-15 09:45:25+00
70	Bergamo	49	2020-02-15 09:45:25+00
71	Berhampore (Baharampur)	44	2020-02-15 09:45:25+00
72	Bern	91	2020-02-15 09:45:25+00
73	Bhavnagar	44	2020-02-15 09:45:25+00
74	Bhilwara	44	2020-02-15 09:45:25+00
75	Bhimavaram	44	2020-02-15 09:45:25+00
76	Bhopal	44	2020-02-15 09:45:25+00
77	Bhusawal	44	2020-02-15 09:45:25+00
78	Bijapur	44	2020-02-15 09:45:25+00
79	Bilbays	29	2020-02-15 09:45:25+00
80	Binzhou	23	2020-02-15 09:45:25+00
81	Birgunj	66	2020-02-15 09:45:25+00
82	Bislig	75	2020-02-15 09:45:25+00
83	Blumenau	15	2020-02-15 09:45:25+00
84	Boa Vista	15	2020-02-15 09:45:25+00
85	Boksburg	85	2020-02-15 09:45:25+00
86	Botosani	78	2020-02-15 09:45:25+00
87	Botshabelo	85	2020-02-15 09:45:25+00
88	Bradford	102	2020-02-15 09:45:25+00
89	Braslia	15	2020-02-15 09:45:25+00
90	Bratislava	84	2020-02-15 09:45:25+00
91	Brescia	49	2020-02-15 09:45:25+00
92	Brest	34	2020-02-15 09:45:25+00
93	Brindisi	49	2020-02-15 09:45:25+00
94	Brockton	103	2020-02-15 09:45:25+00
95	Bucuresti	78	2020-02-15 09:45:25+00
96	Buenaventura	24	2020-02-15 09:45:25+00
97	Bydgoszcz	76	2020-02-15 09:45:25+00
98	Cabuyao	75	2020-02-15 09:45:25+00
99	Callao	74	2020-02-15 09:45:25+00
100	Cam Ranh	105	2020-02-15 09:45:25+00
101	Cape Coral	103	2020-02-15 09:45:25+00
102	Caracas	104	2020-02-15 09:45:25+00
103	Carmen	60	2020-02-15 09:45:25+00
104	Cavite	75	2020-02-15 09:45:25+00
105	Cayenne	35	2020-02-15 09:45:25+00
106	Celaya	60	2020-02-15 09:45:25+00
107	Chandrapur	44	2020-02-15 09:45:25+00
108	Changhwa	92	2020-02-15 09:45:25+00
109	Changzhou	23	2020-02-15 09:45:25+00
110	Chapra	44	2020-02-15 09:45:25+00
111	Charlotte Amalie	106	2020-02-15 09:45:25+00
112	Chatsworth	85	2020-02-15 09:45:25+00
113	Cheju	86	2020-02-15 09:45:25+00
114	Chiayi	92	2020-02-15 09:45:25+00
115	Chisinau	61	2020-02-15 09:45:25+00
116	Chungho	92	2020-02-15 09:45:25+00
117	Cianjur	45	2020-02-15 09:45:25+00
118	Ciomas	45	2020-02-15 09:45:25+00
119	Ciparay	45	2020-02-15 09:45:25+00
120	Citrus Heights	103	2020-02-15 09:45:25+00
121	Citt del Vaticano	41	2020-02-15 09:45:25+00
122	Ciudad del Este	73	2020-02-15 09:45:25+00
123	Clarksville	103	2020-02-15 09:45:25+00
124	Coacalco de Berriozbal	60	2020-02-15 09:45:25+00
125	Coatzacoalcos	60	2020-02-15 09:45:25+00
126	Compton	103	2020-02-15 09:45:25+00
127	Coquimbo	22	2020-02-15 09:45:25+00
128	Crdoba	6	2020-02-15 09:45:25+00
129	Cuauhtmoc	60	2020-02-15 09:45:25+00
130	Cuautla	60	2020-02-15 09:45:25+00
131	Cuernavaca	60	2020-02-15 09:45:25+00
132	Cuman	104	2020-02-15 09:45:25+00
133	Czestochowa	76	2020-02-15 09:45:25+00
134	Dadu	72	2020-02-15 09:45:25+00
135	Dallas	103	2020-02-15 09:45:25+00
136	Datong	23	2020-02-15 09:45:25+00
137	Daugavpils	54	2020-02-15 09:45:25+00
138	Davao	75	2020-02-15 09:45:25+00
139	Daxian	23	2020-02-15 09:45:25+00
140	Dayton	103	2020-02-15 09:45:25+00
141	Deba Habe	69	2020-02-15 09:45:25+00
142	Denizli	97	2020-02-15 09:45:25+00
143	Dhaka	12	2020-02-15 09:45:25+00
144	Dhule (Dhulia)	44	2020-02-15 09:45:25+00
145	Dongying	23	2020-02-15 09:45:25+00
146	Donostia-San Sebastin	87	2020-02-15 09:45:25+00
147	Dos Quebradas	24	2020-02-15 09:45:25+00
148	Duisburg	38	2020-02-15 09:45:25+00
149	Dundee	102	2020-02-15 09:45:25+00
150	Dzerzinsk	80	2020-02-15 09:45:25+00
151	Ede	67	2020-02-15 09:45:25+00
152	Effon-Alaiye	69	2020-02-15 09:45:25+00
153	El Alto	14	2020-02-15 09:45:25+00
154	El Fuerte	60	2020-02-15 09:45:25+00
155	El Monte	103	2020-02-15 09:45:25+00
156	Elista	80	2020-02-15 09:45:25+00
157	Emeishan	23	2020-02-15 09:45:25+00
158	Emmen	67	2020-02-15 09:45:25+00
159	Enshi	23	2020-02-15 09:45:25+00
160	Erlangen	38	2020-02-15 09:45:25+00
161	Escobar	6	2020-02-15 09:45:25+00
162	Esfahan	46	2020-02-15 09:45:25+00
163	Eskisehir	97	2020-02-15 09:45:25+00
164	Etawah	44	2020-02-15 09:45:25+00
165	Ezeiza	6	2020-02-15 09:45:25+00
166	Ezhou	23	2020-02-15 09:45:25+00
167	Faaa	36	2020-02-15 09:45:25+00
168	Fengshan	92	2020-02-15 09:45:25+00
169	Firozabad	44	2020-02-15 09:45:25+00
170	Florencia	24	2020-02-15 09:45:25+00
171	Fontana	103	2020-02-15 09:45:25+00
172	Fukuyama	50	2020-02-15 09:45:25+00
173	Funafuti	99	2020-02-15 09:45:25+00
174	Fuyu	23	2020-02-15 09:45:25+00
175	Fuzhou	23	2020-02-15 09:45:25+00
176	Gandhinagar	44	2020-02-15 09:45:25+00
177	Garden Grove	103	2020-02-15 09:45:25+00
178	Garland	103	2020-02-15 09:45:25+00
179	Gatineau	20	2020-02-15 09:45:25+00
180	Gaziantep	97	2020-02-15 09:45:25+00
181	Gijn	87	2020-02-15 09:45:25+00
182	Gingoog	75	2020-02-15 09:45:25+00
183	Goinia	15	2020-02-15 09:45:25+00
184	Gorontalo	45	2020-02-15 09:45:25+00
185	Grand Prairie	103	2020-02-15 09:45:25+00
186	Graz	9	2020-02-15 09:45:25+00
187	Greensboro	103	2020-02-15 09:45:25+00
188	Guadalajara	60	2020-02-15 09:45:25+00
189	Guaruj	15	2020-02-15 09:45:25+00
190	guas Lindas de Gois	15	2020-02-15 09:45:25+00
191	Gulbarga	44	2020-02-15 09:45:25+00
192	Hagonoy	75	2020-02-15 09:45:25+00
193	Haining	23	2020-02-15 09:45:25+00
194	Haiphong	105	2020-02-15 09:45:25+00
195	Haldia	44	2020-02-15 09:45:25+00
196	Halifax	20	2020-02-15 09:45:25+00
197	Halisahar	44	2020-02-15 09:45:25+00
198	Halle/Saale	38	2020-02-15 09:45:25+00
199	Hami	23	2020-02-15 09:45:25+00
200	Hamilton	68	2020-02-15 09:45:25+00
201	Hanoi	105	2020-02-15 09:45:25+00
202	Hidalgo	60	2020-02-15 09:45:25+00
203	Higashiosaka	50	2020-02-15 09:45:25+00
204	Hino	50	2020-02-15 09:45:25+00
205	Hiroshima	50	2020-02-15 09:45:25+00
206	Hodeida	107	2020-02-15 09:45:25+00
207	Hohhot	23	2020-02-15 09:45:25+00
208	Hoshiarpur	44	2020-02-15 09:45:25+00
209	Hsichuh	92	2020-02-15 09:45:25+00
210	Huaian	23	2020-02-15 09:45:25+00
211	Hubli-Dharwad	44	2020-02-15 09:45:25+00
212	Huejutla de Reyes	60	2020-02-15 09:45:25+00
213	Huixquilucan	60	2020-02-15 09:45:25+00
214	Hunuco	74	2020-02-15 09:45:25+00
215	Ibirit	15	2020-02-15 09:45:25+00
216	Idfu	29	2020-02-15 09:45:25+00
217	Ife	69	2020-02-15 09:45:25+00
218	Ikerre	69	2020-02-15 09:45:25+00
219	Iligan	75	2020-02-15 09:45:25+00
220	Ilorin	69	2020-02-15 09:45:25+00
221	Imus	75	2020-02-15 09:45:25+00
222	Inegl	97	2020-02-15 09:45:25+00
223	Ipoh	59	2020-02-15 09:45:25+00
224	Isesaki	50	2020-02-15 09:45:25+00
225	Ivanovo	80	2020-02-15 09:45:25+00
226	Iwaki	50	2020-02-15 09:45:25+00
227	Iwakuni	50	2020-02-15 09:45:25+00
228	Iwatsuki	50	2020-02-15 09:45:25+00
229	Izumisano	50	2020-02-15 09:45:25+00
230	Jaffna	88	2020-02-15 09:45:25+00
231	Jaipur	44	2020-02-15 09:45:25+00
232	Jakarta	45	2020-02-15 09:45:25+00
233	Jalib al-Shuyukh	53	2020-02-15 09:45:25+00
234	Jamalpur	12	2020-02-15 09:45:25+00
235	Jaroslavl	80	2020-02-15 09:45:25+00
236	Jastrzebie-Zdrj	76	2020-02-15 09:45:25+00
237	Jedda	82	2020-02-15 09:45:25+00
238	Jelets	80	2020-02-15 09:45:25+00
239	Jhansi	44	2020-02-15 09:45:25+00
240	Jinchang	23	2020-02-15 09:45:25+00
241	Jining	23	2020-02-15 09:45:25+00
242	Jinzhou	23	2020-02-15 09:45:25+00
243	Jodhpur	44	2020-02-15 09:45:25+00
244	Johannesburg	85	2020-02-15 09:45:25+00
245	Joliet	103	2020-02-15 09:45:25+00
246	Jos Azueta	60	2020-02-15 09:45:25+00
247	Juazeiro do Norte	15	2020-02-15 09:45:25+00
248	Juiz de Fora	15	2020-02-15 09:45:25+00
249	Junan	23	2020-02-15 09:45:25+00
250	Jurez	60	2020-02-15 09:45:25+00
251	Kabul	1	2020-02-15 09:45:25+00
252	Kaduna	69	2020-02-15 09:45:25+00
253	Kakamigahara	50	2020-02-15 09:45:25+00
254	Kaliningrad	80	2020-02-15 09:45:25+00
255	Kalisz	76	2020-02-15 09:45:25+00
256	Kamakura	50	2020-02-15 09:45:25+00
257	Kamarhati	44	2020-02-15 09:45:25+00
258	Kamjanets-Podilskyi	100	2020-02-15 09:45:25+00
259	Kamyin	80	2020-02-15 09:45:25+00
260	Kanazawa	50	2020-02-15 09:45:25+00
261	Kanchrapara	44	2020-02-15 09:45:25+00
262	Kansas City	103	2020-02-15 09:45:25+00
263	Karnal	44	2020-02-15 09:45:25+00
264	Katihar	44	2020-02-15 09:45:25+00
265	Kermanshah	46	2020-02-15 09:45:25+00
266	Kilis	97	2020-02-15 09:45:25+00
267	Kimberley	85	2020-02-15 09:45:25+00
268	Kimchon	86	2020-02-15 09:45:25+00
269	Kingstown	81	2020-02-15 09:45:25+00
270	Kirovo-Tepetsk	80	2020-02-15 09:45:25+00
271	Kisumu	52	2020-02-15 09:45:25+00
272	Kitwe	109	2020-02-15 09:45:25+00
273	Klerksdorp	85	2020-02-15 09:45:25+00
274	Kolpino	80	2020-02-15 09:45:25+00
275	Konotop	100	2020-02-15 09:45:25+00
276	Koriyama	50	2020-02-15 09:45:25+00
277	Korla	23	2020-02-15 09:45:25+00
278	Korolev	80	2020-02-15 09:45:25+00
279	Kowloon and New Kowloon	42	2020-02-15 09:45:25+00
280	Kragujevac	108	2020-02-15 09:45:25+00
281	Ktahya	97	2020-02-15 09:45:25+00
282	Kuching	59	2020-02-15 09:45:25+00
283	Kumbakonam	44	2020-02-15 09:45:25+00
284	Kurashiki	50	2020-02-15 09:45:25+00
285	Kurgan	80	2020-02-15 09:45:25+00
286	Kursk	80	2020-02-15 09:45:25+00
287	Kuwana	50	2020-02-15 09:45:25+00
288	La Paz	60	2020-02-15 09:45:25+00
289	La Plata	6	2020-02-15 09:45:25+00
290	La Romana	27	2020-02-15 09:45:25+00
291	Laiwu	23	2020-02-15 09:45:25+00
292	Lancaster	103	2020-02-15 09:45:25+00
293	Laohekou	23	2020-02-15 09:45:25+00
294	Lapu-Lapu	75	2020-02-15 09:45:25+00
295	Laredo	103	2020-02-15 09:45:25+00
296	Lausanne	91	2020-02-15 09:45:25+00
297	Le Mans	34	2020-02-15 09:45:25+00
298	Lengshuijiang	23	2020-02-15 09:45:25+00
299	Leshan	23	2020-02-15 09:45:25+00
300	Lethbridge	20	2020-02-15 09:45:25+00
301	Lhokseumawe	45	2020-02-15 09:45:25+00
302	Liaocheng	23	2020-02-15 09:45:25+00
303	Liepaja	54	2020-02-15 09:45:25+00
304	Lilongwe	58	2020-02-15 09:45:25+00
305	Lima	74	2020-02-15 09:45:25+00
306	Lincoln	103	2020-02-15 09:45:25+00
307	Linz	9	2020-02-15 09:45:25+00
308	Lipetsk	80	2020-02-15 09:45:25+00
309	Livorno	49	2020-02-15 09:45:25+00
310	Ljubertsy	80	2020-02-15 09:45:25+00
311	Loja	28	2020-02-15 09:45:25+00
312	London	102	2020-02-15 09:45:25+00
313	London	20	2020-02-15 09:45:25+00
314	Lublin	76	2020-02-15 09:45:25+00
315	Lubumbashi	25	2020-02-15 09:45:25+00
316	Lungtan	92	2020-02-15 09:45:25+00
317	Luzinia	15	2020-02-15 09:45:25+00
318	Madiun	45	2020-02-15 09:45:25+00
319	Mahajanga	57	2020-02-15 09:45:25+00
320	Maikop	80	2020-02-15 09:45:25+00
321	Malm	90	2020-02-15 09:45:25+00
322	Manchester	103	2020-02-15 09:45:25+00
323	Mandaluyong	75	2020-02-15 09:45:25+00
324	Mandi Bahauddin	72	2020-02-15 09:45:25+00
325	Mannheim	38	2020-02-15 09:45:25+00
326	Maracabo	104	2020-02-15 09:45:25+00
327	Mardan	72	2020-02-15 09:45:25+00
328	Maring	15	2020-02-15 09:45:25+00
329	Masqat	71	2020-02-15 09:45:25+00
330	Matamoros	60	2020-02-15 09:45:25+00
331	Matsue	50	2020-02-15 09:45:25+00
332	Meixian	23	2020-02-15 09:45:25+00
333	Memphis	103	2020-02-15 09:45:25+00
334	Merlo	6	2020-02-15 09:45:25+00
335	Mexicali	60	2020-02-15 09:45:25+00
336	Miraj	44	2020-02-15 09:45:25+00
337	Mit Ghamr	29	2020-02-15 09:45:25+00
338	Miyakonojo	50	2020-02-15 09:45:25+00
339	Mogiljov	13	2020-02-15 09:45:25+00
340	Molodetno	13	2020-02-15 09:45:25+00
341	Monclova	60	2020-02-15 09:45:25+00
342	Monywa	64	2020-02-15 09:45:25+00
343	Moscow	80	2020-02-15 09:45:25+00
344	Mosul	47	2020-02-15 09:45:25+00
345	Mukateve	100	2020-02-15 09:45:25+00
346	Munger (Monghyr)	44	2020-02-15 09:45:25+00
347	Mwanza	93	2020-02-15 09:45:25+00
348	Mwene-Ditu	25	2020-02-15 09:45:25+00
349	Myingyan	64	2020-02-15 09:45:25+00
350	Mysore	44	2020-02-15 09:45:25+00
351	Naala-Porto	63	2020-02-15 09:45:25+00
352	Nabereznyje Telny	80	2020-02-15 09:45:25+00
353	Nador	62	2020-02-15 09:45:25+00
354	Nagaon	44	2020-02-15 09:45:25+00
355	Nagareyama	50	2020-02-15 09:45:25+00
356	Najafabad	46	2020-02-15 09:45:25+00
357	Naju	86	2020-02-15 09:45:25+00
358	Nakhon Sawan	94	2020-02-15 09:45:25+00
359	Nam Dinh	105	2020-02-15 09:45:25+00
360	Namibe	4	2020-02-15 09:45:25+00
361	Nantou	92	2020-02-15 09:45:25+00
362	Nanyang	23	2020-02-15 09:45:25+00
363	NDjamna	21	2020-02-15 09:45:25+00
364	Newcastle	85	2020-02-15 09:45:25+00
365	Nezahualcyotl	60	2020-02-15 09:45:25+00
366	Nha Trang	105	2020-02-15 09:45:25+00
367	Niznekamsk	80	2020-02-15 09:45:25+00
368	Novi Sad	108	2020-02-15 09:45:25+00
369	Novoterkassk	80	2020-02-15 09:45:25+00
370	Nukualofa	95	2020-02-15 09:45:25+00
371	Nuuk	40	2020-02-15 09:45:25+00
372	Nyeri	52	2020-02-15 09:45:25+00
373	Ocumare del Tuy	104	2020-02-15 09:45:25+00
374	Ogbomosho	69	2020-02-15 09:45:25+00
375	Okara	72	2020-02-15 09:45:25+00
376	Okayama	50	2020-02-15 09:45:25+00
377	Okinawa	50	2020-02-15 09:45:25+00
378	Olomouc	26	2020-02-15 09:45:25+00
379	Omdurman	89	2020-02-15 09:45:25+00
380	Omiya	50	2020-02-15 09:45:25+00
381	Ondo	69	2020-02-15 09:45:25+00
382	Onomichi	50	2020-02-15 09:45:25+00
383	Oshawa	20	2020-02-15 09:45:25+00
384	Osmaniye	97	2020-02-15 09:45:25+00
385	ostka	100	2020-02-15 09:45:25+00
386	Otsu	50	2020-02-15 09:45:25+00
387	Oulu	33	2020-02-15 09:45:25+00
388	Ourense (Orense)	87	2020-02-15 09:45:25+00
389	Owo	69	2020-02-15 09:45:25+00
390	Oyo	69	2020-02-15 09:45:25+00
391	Ozamis	75	2020-02-15 09:45:25+00
392	Paarl	85	2020-02-15 09:45:25+00
393	Pachuca de Soto	60	2020-02-15 09:45:25+00
394	Pak Kret	94	2020-02-15 09:45:25+00
395	Palghat (Palakkad)	44	2020-02-15 09:45:25+00
396	Pangkal Pinang	45	2020-02-15 09:45:25+00
397	Papeete	36	2020-02-15 09:45:25+00
398	Parbhani	44	2020-02-15 09:45:25+00
399	Pathankot	44	2020-02-15 09:45:25+00
400	Patiala	44	2020-02-15 09:45:25+00
401	Patras	39	2020-02-15 09:45:25+00
402	Pavlodar	51	2020-02-15 09:45:25+00
403	Pemalang	45	2020-02-15 09:45:25+00
404	Peoria	103	2020-02-15 09:45:25+00
405	Pereira	24	2020-02-15 09:45:25+00
406	Phnom Penh	18	2020-02-15 09:45:25+00
407	Pingxiang	23	2020-02-15 09:45:25+00
408	Pjatigorsk	80	2020-02-15 09:45:25+00
409	Plock	76	2020-02-15 09:45:25+00
410	Po	15	2020-02-15 09:45:25+00
411	Ponce	77	2020-02-15 09:45:25+00
412	Pontianak	45	2020-02-15 09:45:25+00
413	Poos de Caldas	15	2020-02-15 09:45:25+00
414	Portoviejo	28	2020-02-15 09:45:25+00
415	Probolinggo	45	2020-02-15 09:45:25+00
416	Pudukkottai	44	2020-02-15 09:45:25+00
417	Pune	44	2020-02-15 09:45:25+00
418	Purnea (Purnia)	44	2020-02-15 09:45:25+00
419	Purwakarta	45	2020-02-15 09:45:25+00
420	Pyongyang	70	2020-02-15 09:45:25+00
421	Qalyub	29	2020-02-15 09:45:25+00
422	Qinhuangdao	23	2020-02-15 09:45:25+00
423	Qomsheh	46	2020-02-15 09:45:25+00
424	Quilmes	6	2020-02-15 09:45:25+00
425	Rae Bareli	44	2020-02-15 09:45:25+00
426	Rajkot	44	2020-02-15 09:45:25+00
427	Rampur	44	2020-02-15 09:45:25+00
428	Rancagua	22	2020-02-15 09:45:25+00
429	Ranchi	44	2020-02-15 09:45:25+00
430	Richmond Hill	20	2020-02-15 09:45:25+00
431	Rio Claro	15	2020-02-15 09:45:25+00
432	Rizhao	23	2020-02-15 09:45:25+00
433	Roanoke	103	2020-02-15 09:45:25+00
434	Robamba	28	2020-02-15 09:45:25+00
435	Rockford	103	2020-02-15 09:45:25+00
436	Ruse	17	2020-02-15 09:45:25+00
437	Rustenburg	85	2020-02-15 09:45:25+00
438	s-Hertogenbosch	67	2020-02-15 09:45:25+00
439	Saarbrcken	38	2020-02-15 09:45:25+00
440	Sagamihara	50	2020-02-15 09:45:25+00
441	Saint Louis	103	2020-02-15 09:45:25+00
442	Saint-Denis	79	2020-02-15 09:45:25+00
443	Sal	62	2020-02-15 09:45:25+00
444	Salala	71	2020-02-15 09:45:25+00
445	Salamanca	60	2020-02-15 09:45:25+00
446	Salinas	103	2020-02-15 09:45:25+00
447	Salzburg	9	2020-02-15 09:45:25+00
448	Sambhal	44	2020-02-15 09:45:25+00
449	San Bernardino	103	2020-02-15 09:45:25+00
450	San Felipe de Puerto Plata	27	2020-02-15 09:45:25+00
451	San Felipe del Progreso	60	2020-02-15 09:45:25+00
452	San Juan Bautista Tuxtepec	60	2020-02-15 09:45:25+00
453	San Lorenzo	73	2020-02-15 09:45:25+00
454	San Miguel de Tucumn	6	2020-02-15 09:45:25+00
455	Sanaa	107	2020-02-15 09:45:25+00
456	Santa Brbara dOeste	15	2020-02-15 09:45:25+00
457	Santa F	6	2020-02-15 09:45:25+00
458	Santa Rosa	75	2020-02-15 09:45:25+00
459	Santiago de Compostela	87	2020-02-15 09:45:25+00
460	Santiago de los Caballeros	27	2020-02-15 09:45:25+00
461	Santo Andr	15	2020-02-15 09:45:25+00
462	Sanya	23	2020-02-15 09:45:25+00
463	Sasebo	50	2020-02-15 09:45:25+00
464	Satna	44	2020-02-15 09:45:25+00
465	Sawhaj	29	2020-02-15 09:45:25+00
466	Serpuhov	80	2020-02-15 09:45:25+00
467	Shahr-e Kord	46	2020-02-15 09:45:25+00
468	Shanwei	23	2020-02-15 09:45:25+00
469	Shaoguan	23	2020-02-15 09:45:25+00
470	Sharja	101	2020-02-15 09:45:25+00
471	Shenzhen	23	2020-02-15 09:45:25+00
472	Shikarpur	72	2020-02-15 09:45:25+00
473	Shimoga	44	2020-02-15 09:45:25+00
474	Shimonoseki	50	2020-02-15 09:45:25+00
475	Shivapuri	44	2020-02-15 09:45:25+00
476	Shubra al-Khayma	29	2020-02-15 09:45:25+00
477	Siegen	38	2020-02-15 09:45:25+00
478	Siliguri (Shiliguri)	44	2020-02-15 09:45:25+00
479	Simferopol	100	2020-02-15 09:45:25+00
480	Sincelejo	24	2020-02-15 09:45:25+00
481	Sirjan	46	2020-02-15 09:45:25+00
482	Sivas	97	2020-02-15 09:45:25+00
483	Skikda	2	2020-02-15 09:45:25+00
484	Smolensk	80	2020-02-15 09:45:25+00
485	So Bernardo do Campo	15	2020-02-15 09:45:25+00
486	So Leopoldo	15	2020-02-15 09:45:25+00
487	Sogamoso	24	2020-02-15 09:45:25+00
488	Sokoto	69	2020-02-15 09:45:25+00
489	Songkhla	94	2020-02-15 09:45:25+00
490	Sorocaba	15	2020-02-15 09:45:25+00
491	Soshanguve	85	2020-02-15 09:45:25+00
492	Sousse	96	2020-02-15 09:45:25+00
493	South Hill	5	2020-02-15 09:45:25+00
494	Southampton	102	2020-02-15 09:45:25+00
495	Southend-on-Sea	102	2020-02-15 09:45:25+00
496	Southport	102	2020-02-15 09:45:25+00
497	Springs	85	2020-02-15 09:45:25+00
498	Stara Zagora	17	2020-02-15 09:45:25+00
499	Sterling Heights	103	2020-02-15 09:45:25+00
500	Stockport	102	2020-02-15 09:45:25+00
501	Sucre	14	2020-02-15 09:45:25+00
502	Suihua	23	2020-02-15 09:45:25+00
503	Sullana	74	2020-02-15 09:45:25+00
504	Sultanbeyli	97	2020-02-15 09:45:25+00
505	Sumqayit	10	2020-02-15 09:45:25+00
506	Sumy	100	2020-02-15 09:45:25+00
507	Sungai Petani	59	2020-02-15 09:45:25+00
508	Sunnyvale	103	2020-02-15 09:45:25+00
509	Surakarta	45	2020-02-15 09:45:25+00
510	Syktyvkar	80	2020-02-15 09:45:25+00
511	Syrakusa	49	2020-02-15 09:45:25+00
512	Szkesfehrvr	43	2020-02-15 09:45:25+00
513	Tabora	93	2020-02-15 09:45:25+00
514	Tabriz	46	2020-02-15 09:45:25+00
515	Tabuk	82	2020-02-15 09:45:25+00
516	Tafuna	3	2020-02-15 09:45:25+00
517	Taguig	75	2020-02-15 09:45:25+00
518	Taizz	107	2020-02-15 09:45:25+00
519	Talavera	75	2020-02-15 09:45:25+00
520	Tallahassee	103	2020-02-15 09:45:25+00
521	Tama	50	2020-02-15 09:45:25+00
522	Tambaram	44	2020-02-15 09:45:25+00
523	Tanauan	75	2020-02-15 09:45:25+00
524	Tandil	6	2020-02-15 09:45:25+00
525	Tangail	12	2020-02-15 09:45:25+00
526	Tanshui	92	2020-02-15 09:45:25+00
527	Tanza	75	2020-02-15 09:45:25+00
528	Tarlac	75	2020-02-15 09:45:25+00
529	Tarsus	97	2020-02-15 09:45:25+00
530	Tartu	30	2020-02-15 09:45:25+00
531	Teboksary	80	2020-02-15 09:45:25+00
532	Tegal	45	2020-02-15 09:45:25+00
533	Tel Aviv-Jaffa	48	2020-02-15 09:45:25+00
534	Tete	63	2020-02-15 09:45:25+00
535	Tianjin	23	2020-02-15 09:45:25+00
536	Tiefa	23	2020-02-15 09:45:25+00
537	Tieli	23	2020-02-15 09:45:25+00
538	Tokat	97	2020-02-15 09:45:25+00
539	Tonghae	86	2020-02-15 09:45:25+00
540	Tongliao	23	2020-02-15 09:45:25+00
541	Torren	60	2020-02-15 09:45:25+00
542	Touliu	92	2020-02-15 09:45:25+00
543	Toulon	34	2020-02-15 09:45:25+00
544	Toulouse	34	2020-02-15 09:45:25+00
545	Trshavn	32	2020-02-15 09:45:25+00
546	Tsaotun	92	2020-02-15 09:45:25+00
547	Tsuyama	50	2020-02-15 09:45:25+00
548	Tuguegarao	75	2020-02-15 09:45:25+00
549	Tychy	76	2020-02-15 09:45:25+00
550	Udaipur	44	2020-02-15 09:45:25+00
551	Udine	49	2020-02-15 09:45:25+00
552	Ueda	50	2020-02-15 09:45:25+00
553	Uijongbu	86	2020-02-15 09:45:25+00
554	Uluberia	44	2020-02-15 09:45:25+00
555	Urawa	50	2020-02-15 09:45:25+00
556	Uruapan	60	2020-02-15 09:45:25+00
557	Usak	97	2020-02-15 09:45:25+00
558	Usolje-Sibirskoje	80	2020-02-15 09:45:25+00
559	Uttarpara-Kotrung	44	2020-02-15 09:45:25+00
560	Vaduz	55	2020-02-15 09:45:25+00
561	Valencia	104	2020-02-15 09:45:25+00
562	Valle de la Pascua	104	2020-02-15 09:45:25+00
563	Valle de Santiago	60	2020-02-15 09:45:25+00
564	Valparai	44	2020-02-15 09:45:25+00
565	Vancouver	20	2020-02-15 09:45:25+00
566	Varanasi (Benares)	44	2020-02-15 09:45:25+00
567	Vicente Lpez	6	2020-02-15 09:45:25+00
568	Vijayawada	44	2020-02-15 09:45:25+00
569	Vila Velha	15	2020-02-15 09:45:25+00
570	Vilnius	56	2020-02-15 09:45:25+00
571	Vinh	105	2020-02-15 09:45:25+00
572	Vitria de Santo Anto	15	2020-02-15 09:45:25+00
573	Warren	103	2020-02-15 09:45:25+00
574	Weifang	23	2020-02-15 09:45:25+00
575	Witten	38	2020-02-15 09:45:25+00
576	Woodridge	8	2020-02-15 09:45:25+00
577	Wroclaw	76	2020-02-15 09:45:25+00
578	Xiangfan	23	2020-02-15 09:45:25+00
579	Xiangtan	23	2020-02-15 09:45:25+00
580	Xintai	23	2020-02-15 09:45:25+00
581	Xinxiang	23	2020-02-15 09:45:25+00
582	Yamuna Nagar	44	2020-02-15 09:45:25+00
583	Yangor	65	2020-02-15 09:45:25+00
584	Yantai	23	2020-02-15 09:45:25+00
585	Yaound	19	2020-02-15 09:45:25+00
586	Yerevan	7	2020-02-15 09:45:25+00
587	Yinchuan	23	2020-02-15 09:45:25+00
588	Yingkou	23	2020-02-15 09:45:25+00
589	York	102	2020-02-15 09:45:25+00
590	Yuncheng	23	2020-02-15 09:45:25+00
591	Yuzhou	23	2020-02-15 09:45:25+00
592	Zalantun	23	2020-02-15 09:45:25+00
593	Zanzibar	93	2020-02-15 09:45:25+00
594	Zaoyang	23	2020-02-15 09:45:25+00
595	Zapopan	60	2020-02-15 09:45:25+00
596	Zaria	69	2020-02-15 09:45:25+00
597	Zeleznogorsk	80	2020-02-15 09:45:25+00
598	Zhezqazghan	51	2020-02-15 09:45:25+00
599	Zhoushan	23	2020-02-15 09:45:25+00
600	Ziguinchor	83	2020-02-15 09:45:25+00
\.


--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.country (country_id, country, last_update) FROM stdin;
1	Afghanistan	2020-02-15 09:44:00+00
2	Algeria	2020-02-15 09:44:00+00
3	American Samoa	2020-02-15 09:44:00+00
4	Angola	2020-02-15 09:44:00+00
5	Anguilla	2020-02-15 09:44:00+00
6	Argentina	2020-02-15 09:44:00+00
7	Armenia	2020-02-15 09:44:00+00
8	Australia	2020-02-15 09:44:00+00
9	Austria	2020-02-15 09:44:00+00
10	Azerbaijan	2020-02-15 09:44:00+00
11	Bahrain	2020-02-15 09:44:00+00
12	Bangladesh	2020-02-15 09:44:00+00
13	Belarus	2020-02-15 09:44:00+00
14	Bolivia	2020-02-15 09:44:00+00
15	Brazil	2020-02-15 09:44:00+00
16	Brunei	2020-02-15 09:44:00+00
17	Bulgaria	2020-02-15 09:44:00+00
18	Cambodia	2020-02-15 09:44:00+00
19	Cameroon	2020-02-15 09:44:00+00
20	Canada	2020-02-15 09:44:00+00
21	Chad	2020-02-15 09:44:00+00
22	Chile	2020-02-15 09:44:00+00
23	China	2020-02-15 09:44:00+00
24	Colombia	2020-02-15 09:44:00+00
25	Congo, The Democratic Republic of the	2020-02-15 09:44:00+00
26	Czech Republic	2020-02-15 09:44:00+00
27	Dominican Republic	2020-02-15 09:44:00+00
28	Ecuador	2020-02-15 09:44:00+00
29	Egypt	2020-02-15 09:44:00+00
30	Estonia	2020-02-15 09:44:00+00
31	Ethiopia	2020-02-15 09:44:00+00
32	Faroe Islands	2020-02-15 09:44:00+00
33	Finland	2020-02-15 09:44:00+00
34	France	2020-02-15 09:44:00+00
35	French Guiana	2020-02-15 09:44:00+00
36	French Polynesia	2020-02-15 09:44:00+00
37	Gambia	2020-02-15 09:44:00+00
38	Germany	2020-02-15 09:44:00+00
39	Greece	2020-02-15 09:44:00+00
40	Greenland	2020-02-15 09:44:00+00
41	Holy See (Vatican City State)	2020-02-15 09:44:00+00
42	Hong Kong	2020-02-15 09:44:00+00
43	Hungary	2020-02-15 09:44:00+00
44	India	2020-02-15 09:44:00+00
45	Indonesia	2020-02-15 09:44:00+00
46	Iran	2020-02-15 09:44:00+00
47	Iraq	2020-02-15 09:44:00+00
48	Israel	2020-02-15 09:44:00+00
49	Italy	2020-02-15 09:44:00+00
50	Japan	2020-02-15 09:44:00+00
51	Kazakstan	2020-02-15 09:44:00+00
52	Kenya	2020-02-15 09:44:00+00
53	Kuwait	2020-02-15 09:44:00+00
54	Latvia	2020-02-15 09:44:00+00
55	Liechtenstein	2020-02-15 09:44:00+00
56	Lithuania	2020-02-15 09:44:00+00
57	Madagascar	2020-02-15 09:44:00+00
58	Malawi	2020-02-15 09:44:00+00
59	Malaysia	2020-02-15 09:44:00+00
60	Mexico	2020-02-15 09:44:00+00
61	Moldova	2020-02-15 09:44:00+00
62	Morocco	2020-02-15 09:44:00+00
63	Mozambique	2020-02-15 09:44:00+00
64	Myanmar	2020-02-15 09:44:00+00
65	Nauru	2020-02-15 09:44:00+00
66	Nepal	2020-02-15 09:44:00+00
67	Netherlands	2020-02-15 09:44:00+00
68	New Zealand	2020-02-15 09:44:00+00
69	Nigeria	2020-02-15 09:44:00+00
70	North Korea	2020-02-15 09:44:00+00
71	Oman	2020-02-15 09:44:00+00
72	Pakistan	2020-02-15 09:44:00+00
73	Paraguay	2020-02-15 09:44:00+00
74	Peru	2020-02-15 09:44:00+00
75	Philippines	2020-02-15 09:44:00+00
76	Poland	2020-02-15 09:44:00+00
77	Puerto Rico	2020-02-15 09:44:00+00
78	Romania	2020-02-15 09:44:00+00
79	Runion	2020-02-15 09:44:00+00
80	Russian Federation	2020-02-15 09:44:00+00
81	Saint Vincent and the Grenadines	2020-02-15 09:44:00+00
82	Saudi Arabia	2020-02-15 09:44:00+00
83	Senegal	2020-02-15 09:44:00+00
84	Slovakia	2020-02-15 09:44:00+00
85	South Africa	2020-02-15 09:44:00+00
86	South Korea	2020-02-15 09:44:00+00
87	Spain	2020-02-15 09:44:00+00
88	Sri Lanka	2020-02-15 09:44:00+00
89	Sudan	2020-02-15 09:44:00+00
90	Sweden	2020-02-15 09:44:00+00
91	Switzerland	2020-02-15 09:44:00+00
92	Taiwan	2020-02-15 09:44:00+00
93	Tanzania	2020-02-15 09:44:00+00
94	Thailand	2020-02-15 09:44:00+00
95	Tonga	2020-02-15 09:44:00+00
96	Tunisia	2020-02-15 09:44:00+00
97	Turkey	2020-02-15 09:44:00+00
98	Turkmenistan	2020-02-15 09:44:00+00
99	Tuvalu	2020-02-15 09:44:00+00
100	Ukraine	2020-02-15 09:44:00+00
101	United Arab Emirates	2020-02-15 09:44:00+00
102	United Kingdom	2020-02-15 09:44:00+00
103	United States	2020-02-15 09:44:00+00
104	Venezuela	2020-02-15 09:44:00+00
105	Vietnam	2020-02-15 09:44:00+00
106	Virgin Islands, U.S.	2020-02-15 09:44:00+00
107	Yemen	2020-02-15 09:44:00+00
108	Yugoslavia	2020-02-15 09:44:00+00
109	Zambia	2020-02-15 09:44:00+00
\.


--
-- Data for Name: language; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.language (language_id, name, last_update) FROM stdin;
1	English             	2020-02-15 10:02:19+00
2	Italian             	2020-02-15 10:02:19+00
3	Japanese            	2020-02-15 10:02:19+00
4	Mandarin            	2020-02-15 10:02:19+00
5	French              	2020-02-15 10:02:19+00
6	German              	2020-02-15 10:02:19+00
\.


--
-- Name: actor_actor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.actor_actor_id_seq', 200, true);


--
-- Name: address_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.address_address_id_seq', 605, true);


--
-- Name: category_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.category_category_id_seq', 16, true);


--
-- Name: city_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.city_city_id_seq', 600, true);


--
-- Name: country_country_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.country_country_id_seq', 109, true);


--
-- Name: customer_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.customer_customer_id_seq', 599, true);


--
-- Name: film_film_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.film_film_id_seq', 1000, true);


--
-- Name: inventory_inventory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.inventory_inventory_id_seq', 4581, true);


--
-- Name: language_language_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.language_language_id_seq', 6, true);


--
-- Name: payment_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payment_payment_id_seq', 32098, true);


--
-- Name: rental_rental_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rental_rental_id_seq', 16049, true);


--
-- Name: staff_staff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.staff_staff_id_seq', 2, true);


--
-- Name: store_store_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.store_store_id_seq', 2, true);


--
-- Name: actor actor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (actor_id);


--
-- Name: address address_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_pkey PRIMARY KEY (address_id);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);


--
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);


--
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (country_id);


--
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- Name: film_actor film_actor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_actor
    ADD CONSTRAINT film_actor_pkey PRIMARY KEY (actor_id, film_id);


--
-- Name: film_category film_category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_category
    ADD CONSTRAINT film_category_pkey PRIMARY KEY (film_id, category_id);


--
-- Name: film film_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film
    ADD CONSTRAINT film_pkey PRIMARY KEY (film_id);


--
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (inventory_id);


--
-- Name: language language_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.language
    ADD CONSTRAINT language_pkey PRIMARY KEY (language_id);


--
-- Name: rental rental_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rental
    ADD CONSTRAINT rental_pkey PRIMARY KEY (rental_id);


--
-- Name: staff staff_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (staff_id);


--
-- Name: store store_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store
    ADD CONSTRAINT store_pkey PRIMARY KEY (store_id);


--
-- Name: film_fulltext_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX film_fulltext_idx ON public.film USING gist (fulltext);


--
-- Name: idx_actor_last_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_actor_last_name ON public.actor USING btree (last_name);


--
-- Name: idx_fk_address_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_address_id ON public.customer USING btree (address_id);


--
-- Name: idx_fk_city_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_city_id ON public.address USING btree (city_id);


--
-- Name: idx_fk_country_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_country_id ON public.city USING btree (country_id);


--
-- Name: idx_fk_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_customer_id ON ONLY public.payment USING btree (customer_id);


--
-- Name: idx_fk_film_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_film_id ON public.film_actor USING btree (film_id);


--
-- Name: idx_fk_inventory_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_inventory_id ON public.rental USING btree (inventory_id);


--
-- Name: idx_fk_language_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_language_id ON public.film USING btree (language_id);


--
-- Name: idx_fk_original_language_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_original_language_id ON public.film USING btree (original_language_id);


--
-- Name: idx_fk_payment_p2020_01_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_payment_p2020_01_customer_id ON public.payment_p2020_01 USING btree (customer_id);


--
-- Name: idx_fk_staff_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_staff_id ON ONLY public.payment USING btree (staff_id);


--
-- Name: idx_fk_payment_p2020_01_staff_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_payment_p2020_01_staff_id ON public.payment_p2020_01 USING btree (staff_id);


--
-- Name: idx_fk_payment_p2020_02_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_payment_p2020_02_customer_id ON public.payment_p2020_02 USING btree (customer_id);


--
-- Name: idx_fk_payment_p2020_02_staff_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_payment_p2020_02_staff_id ON public.payment_p2020_02 USING btree (staff_id);


--
-- Name: idx_fk_payment_p2020_03_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_payment_p2020_03_customer_id ON public.payment_p2020_03 USING btree (customer_id);


--
-- Name: idx_fk_payment_p2020_03_staff_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_payment_p2020_03_staff_id ON public.payment_p2020_03 USING btree (staff_id);


--
-- Name: idx_fk_payment_p2020_04_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_payment_p2020_04_customer_id ON public.payment_p2020_04 USING btree (customer_id);


--
-- Name: idx_fk_payment_p2020_04_staff_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_payment_p2020_04_staff_id ON public.payment_p2020_04 USING btree (staff_id);


--
-- Name: idx_fk_payment_p2020_05_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_payment_p2020_05_customer_id ON public.payment_p2020_05 USING btree (customer_id);


--
-- Name: idx_fk_payment_p2020_05_staff_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_payment_p2020_05_staff_id ON public.payment_p2020_05 USING btree (staff_id);


--
-- Name: idx_fk_payment_p2020_06_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_payment_p2020_06_customer_id ON public.payment_p2020_06 USING btree (customer_id);


--
-- Name: idx_fk_payment_p2020_06_staff_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_payment_p2020_06_staff_id ON public.payment_p2020_06 USING btree (staff_id);


--
-- Name: idx_fk_store_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fk_store_id ON public.customer USING btree (store_id);


--
-- Name: idx_last_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_last_name ON public.customer USING btree (last_name);


--
-- Name: idx_store_id_film_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_store_id_film_id ON public.inventory USING btree (store_id, film_id);


--
-- Name: idx_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_title ON public.film USING btree (title);


--
-- Name: idx_unq_manager_staff_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_unq_manager_staff_id ON public.store USING btree (manager_staff_id);


--
-- Name: idx_unq_rental_rental_date_inventory_id_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_unq_rental_rental_date_inventory_id_customer_id ON public.rental USING btree (rental_date, inventory_id, customer_id);


--
-- Name: payment_p2020_01_customer_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payment_p2020_01_customer_id_idx ON public.payment_p2020_01 USING btree (customer_id);


--
-- Name: payment_p2020_02_customer_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payment_p2020_02_customer_id_idx ON public.payment_p2020_02 USING btree (customer_id);


--
-- Name: payment_p2020_03_customer_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payment_p2020_03_customer_id_idx ON public.payment_p2020_03 USING btree (customer_id);


--
-- Name: payment_p2020_04_customer_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payment_p2020_04_customer_id_idx ON public.payment_p2020_04 USING btree (customer_id);


--
-- Name: payment_p2020_05_customer_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payment_p2020_05_customer_id_idx ON public.payment_p2020_05 USING btree (customer_id);


--
-- Name: payment_p2020_06_customer_id_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX payment_p2020_06_customer_id_idx ON public.payment_p2020_06 USING btree (customer_id);


--
-- Name: idx_fk_payment_p2020_01_staff_id; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_fk_staff_id ATTACH PARTITION public.idx_fk_payment_p2020_01_staff_id;


--
-- Name: idx_fk_payment_p2020_02_staff_id; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_fk_staff_id ATTACH PARTITION public.idx_fk_payment_p2020_02_staff_id;


--
-- Name: idx_fk_payment_p2020_03_staff_id; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_fk_staff_id ATTACH PARTITION public.idx_fk_payment_p2020_03_staff_id;


--
-- Name: idx_fk_payment_p2020_04_staff_id; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_fk_staff_id ATTACH PARTITION public.idx_fk_payment_p2020_04_staff_id;


--
-- Name: idx_fk_payment_p2020_05_staff_id; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_fk_staff_id ATTACH PARTITION public.idx_fk_payment_p2020_05_staff_id;


--
-- Name: idx_fk_payment_p2020_06_staff_id; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_fk_staff_id ATTACH PARTITION public.idx_fk_payment_p2020_06_staff_id;


--
-- Name: payment_p2020_01_customer_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_fk_customer_id ATTACH PARTITION public.payment_p2020_01_customer_id_idx;


--
-- Name: payment_p2020_02_customer_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_fk_customer_id ATTACH PARTITION public.payment_p2020_02_customer_id_idx;


--
-- Name: payment_p2020_03_customer_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_fk_customer_id ATTACH PARTITION public.payment_p2020_03_customer_id_idx;


--
-- Name: payment_p2020_04_customer_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_fk_customer_id ATTACH PARTITION public.payment_p2020_04_customer_id_idx;


--
-- Name: payment_p2020_05_customer_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_fk_customer_id ATTACH PARTITION public.payment_p2020_05_customer_id_idx;


--
-- Name: payment_p2020_06_customer_id_idx; Type: INDEX ATTACH; Schema: public; Owner: -
--

ALTER INDEX public.idx_fk_customer_id ATTACH PARTITION public.payment_p2020_06_customer_id_idx;


--
-- Name: film film_fulltext_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER film_fulltext_trigger BEFORE INSERT OR UPDATE ON public.film FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger('fulltext', 'pg_catalog.english', 'title', 'description');


--
-- Name: actor last_updated; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.actor FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: address last_updated; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.address FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: category last_updated; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.category FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: city last_updated; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.city FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: country last_updated; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.country FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: customer last_updated; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.customer FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: film last_updated; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.film FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: film_actor last_updated; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.film_actor FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: film_category last_updated; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.film_category FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: inventory last_updated; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.inventory FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: language last_updated; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.language FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: rental last_updated; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.rental FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: staff last_updated; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.staff FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: store last_updated; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER last_updated BEFORE UPDATE ON public.store FOR EACH ROW EXECUTE PROCEDURE public.last_updated();


--
-- Name: address address_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.address
    ADD CONSTRAINT address_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.city(city_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: city city_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.country(country_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: customer customer_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address(address_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: customer customer_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store(store_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: film_actor film_actor_actor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_actor
    ADD CONSTRAINT film_actor_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES public.actor(actor_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: film_actor film_actor_film_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_actor
    ADD CONSTRAINT film_actor_film_id_fkey FOREIGN KEY (film_id) REFERENCES public.film(film_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: film_category film_category_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_category
    ADD CONSTRAINT film_category_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(category_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: film_category film_category_film_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film_category
    ADD CONSTRAINT film_category_film_id_fkey FOREIGN KEY (film_id) REFERENCES public.film(film_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: film film_language_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film
    ADD CONSTRAINT film_language_id_fkey FOREIGN KEY (language_id) REFERENCES public.language(language_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: film film_original_language_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.film
    ADD CONSTRAINT film_original_language_id_fkey FOREIGN KEY (original_language_id) REFERENCES public.language(language_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: inventory inventory_film_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_film_id_fkey FOREIGN KEY (film_id) REFERENCES public.film(film_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: inventory inventory_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store(store_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: payment_p2020_01 payment_p2020_01_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_p2020_01
    ADD CONSTRAINT payment_p2020_01_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);


--
-- Name: payment_p2020_01 payment_p2020_01_rental_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_p2020_01
    ADD CONSTRAINT payment_p2020_01_rental_id_fkey FOREIGN KEY (rental_id) REFERENCES public.rental(rental_id);


--
-- Name: payment_p2020_01 payment_p2020_01_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_p2020_01
    ADD CONSTRAINT payment_p2020_01_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id);


--
-- Name: payment_p2020_02 payment_p2020_02_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_p2020_02
    ADD CONSTRAINT payment_p2020_02_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);


--
-- Name: payment_p2020_02 payment_p2020_02_rental_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_p2020_02
    ADD CONSTRAINT payment_p2020_02_rental_id_fkey FOREIGN KEY (rental_id) REFERENCES public.rental(rental_id);


--
-- Name: payment_p2020_02 payment_p2020_02_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_p2020_02
    ADD CONSTRAINT payment_p2020_02_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id);


--
-- Name: payment_p2020_03 payment_p2020_03_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_p2020_03
    ADD CONSTRAINT payment_p2020_03_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);


--
-- Name: payment_p2020_03 payment_p2020_03_rental_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_p2020_03
    ADD CONSTRAINT payment_p2020_03_rental_id_fkey FOREIGN KEY (rental_id) REFERENCES public.rental(rental_id);


--
-- Name: payment_p2020_03 payment_p2020_03_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_p2020_03
    ADD CONSTRAINT payment_p2020_03_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id);


--
-- Name: payment_p2020_04 payment_p2020_04_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_p2020_04
    ADD CONSTRAINT payment_p2020_04_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);


--
-- Name: payment_p2020_04 payment_p2020_04_rental_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_p2020_04
    ADD CONSTRAINT payment_p2020_04_rental_id_fkey FOREIGN KEY (rental_id) REFERENCES public.rental(rental_id);


--
-- Name: payment_p2020_04 payment_p2020_04_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_p2020_04
    ADD CONSTRAINT payment_p2020_04_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id);


--
-- Name: payment_p2020_05 payment_p2020_05_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_p2020_05
    ADD CONSTRAINT payment_p2020_05_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);


--
-- Name: payment_p2020_05 payment_p2020_05_rental_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_p2020_05
    ADD CONSTRAINT payment_p2020_05_rental_id_fkey FOREIGN KEY (rental_id) REFERENCES public.rental(rental_id);


--
-- Name: payment_p2020_05 payment_p2020_05_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_p2020_05
    ADD CONSTRAINT payment_p2020_05_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id);


--
-- Name: payment_p2020_06 payment_p2020_06_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_p2020_06
    ADD CONSTRAINT payment_p2020_06_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);


--
-- Name: payment_p2020_06 payment_p2020_06_rental_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_p2020_06
    ADD CONSTRAINT payment_p2020_06_rental_id_fkey FOREIGN KEY (rental_id) REFERENCES public.rental(rental_id);


--
-- Name: payment_p2020_06 payment_p2020_06_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_p2020_06
    ADD CONSTRAINT payment_p2020_06_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id);


--
-- Name: rental rental_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rental
    ADD CONSTRAINT rental_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: rental rental_inventory_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rental
    ADD CONSTRAINT rental_inventory_id_fkey FOREIGN KEY (inventory_id) REFERENCES public.inventory(inventory_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: rental rental_staff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rental
    ADD CONSTRAINT rental_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: staff staff_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address(address_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: staff staff_store_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.staff
    ADD CONSTRAINT staff_store_id_fkey FOREIGN KEY (store_id) REFERENCES public.store(store_id);


--
-- Name: store store_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.store
    ADD CONSTRAINT store_address_id_fkey FOREIGN KEY (address_id) REFERENCES public.address(address_id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

