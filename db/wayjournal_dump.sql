--
-- PostgreSQL database dump
--

-- Dumped from database version 11.4 (Debian 11.4-1.pgdg90+1)
-- Dumped by pg_dump version 11.4 (Debian 11.4-1.pgdg90+1)

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
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: data_source; Type: TYPE; Schema: public; Owner: wayjournal
--

CREATE TYPE public.data_source AS ENUM (
    'video',
    'gps',
    'obd'
);


ALTER TYPE public.data_source OWNER TO wayjournal;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: car_brands; Type: TABLE; Schema: public; Owner: wayjournal
--

CREATE TABLE public.car_brands (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.car_brands OWNER TO wayjournal;

--
-- Name: car_brands_id_seq; Type: SEQUENCE; Schema: public; Owner: wayjournal
--

CREATE SEQUENCE public.car_brands_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.car_brands_id_seq OWNER TO wayjournal;

--
-- Name: car_brands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wayjournal
--

ALTER SEQUENCE public.car_brands_id_seq OWNED BY public.car_brands.id;


--
-- Name: car_fuel_types; Type: TABLE; Schema: public; Owner: wayjournal
--

CREATE TABLE public.car_fuel_types (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.car_fuel_types OWNER TO wayjournal;

--
-- Name: car_fuel_types_id_seq; Type: SEQUENCE; Schema: public; Owner: wayjournal
--

CREATE SEQUENCE public.car_fuel_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.car_fuel_types_id_seq OWNER TO wayjournal;

--
-- Name: car_fuel_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wayjournal
--

ALTER SEQUENCE public.car_fuel_types_id_seq OWNED BY public.car_fuel_types.id;


--
-- Name: car_models; Type: TABLE; Schema: public; Owner: wayjournal
--

CREATE TABLE public.car_models (
    id integer NOT NULL,
    brand_id integer,
    name character varying(255)
);


ALTER TABLE public.car_models OWNER TO wayjournal;

--
-- Name: car_models_id_seq; Type: SEQUENCE; Schema: public; Owner: wayjournal
--

CREATE SEQUENCE public.car_models_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.car_models_id_seq OWNER TO wayjournal;

--
-- Name: car_models_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wayjournal
--

ALTER SEQUENCE public.car_models_id_seq OWNED BY public.car_models.id;


--
-- Name: car_modification; Type: TABLE; Schema: public; Owner: wayjournal
--

CREATE TABLE public.car_modification (
    id integer NOT NULL,
    sub_model_id integer,
    name character varying(255)
);


ALTER TABLE public.car_modification OWNER TO wayjournal;

--
-- Name: car_modification_id_seq; Type: SEQUENCE; Schema: public; Owner: wayjournal
--

CREATE SEQUENCE public.car_modification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.car_modification_id_seq OWNER TO wayjournal;

--
-- Name: car_modification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wayjournal
--

ALTER SEQUENCE public.car_modification_id_seq OWNED BY public.car_modification.id;


--
-- Name: car_sub_models; Type: TABLE; Schema: public; Owner: wayjournal
--

CREATE TABLE public.car_sub_models (
    id integer NOT NULL,
    model_id integer,
    name character varying(255)
);


ALTER TABLE public.car_sub_models OWNER TO wayjournal;

--
-- Name: car_sub_models_id_seq; Type: SEQUENCE; Schema: public; Owner: wayjournal
--

CREATE SEQUENCE public.car_sub_models_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.car_sub_models_id_seq OWNER TO wayjournal;

--
-- Name: car_sub_models_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wayjournal
--

ALTER SEQUENCE public.car_sub_models_id_seq OWNED BY public.car_sub_models.id;


--
-- Name: cars; Type: TABLE; Schema: public; Owner: wayjournal
--

CREATE TABLE public.cars (
    uuid uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    brand integer,
    model integer,
    sub_model integer,
    modification integer,
    fuel_type integer,
    government_number character varying(10),
    delete boolean DEFAULT false,
    user_uid uuid NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    avatars json
);


ALTER TABLE public.cars OWNER TO wayjournal;

--
-- Name: device_types; Type: TABLE; Schema: public; Owner: wayjournal
--

CREATE TABLE public.device_types (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.device_types OWNER TO wayjournal;

--
-- Name: device_types_id_seq; Type: SEQUENCE; Schema: public; Owner: wayjournal
--

CREATE SEQUENCE public.device_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.device_types_id_seq OWNER TO wayjournal;

--
-- Name: device_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wayjournal
--

ALTER SEQUENCE public.device_types_id_seq OWNED BY public.device_types.id;


--
-- Name: devices; Type: TABLE; Schema: public; Owner: wayjournal
--

CREATE TABLE public.devices (
    uuid uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    term_id character varying(500) NOT NULL,
    type integer NOT NULL,
    car_uid uuid NOT NULL,
    available_data_source public.data_source[],
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    extra_data json,
    delete boolean DEFAULT false
);


ALTER TABLE public.devices OWNER TO wayjournal;

--
-- Name: drivers; Type: TABLE; Schema: public; Owner: wayjournal
--

CREATE TABLE public.drivers (
    uuid uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    avatar_url character varying(255),
    company uuid NOT NULL
);


ALTER TABLE public.drivers OWNER TO wayjournal;

--
-- Name: drivers_history; Type: TABLE; Schema: public; Owner: wayjournal
--

CREATE TABLE public.drivers_history (
    uuid uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    driver_uid uuid NOT NULL,
    car_uid uuid NOT NULL,
    start_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    finish_at timestamp with time zone
);


ALTER TABLE public.drivers_history OWNER TO wayjournal;

--
-- Name: enabled_data_source; Type: TABLE; Schema: public; Owner: wayjournal
--

CREATE TABLE public.enabled_data_source (
    car_uid uuid NOT NULL,
    device_uid uuid NOT NULL,
    enabled public.data_source NOT NULL
);


ALTER TABLE public.enabled_data_source OWNER TO wayjournal;

--
-- Name: event_types; Type: TABLE; Schema: public; Owner: wayjournal
--

CREATE TABLE public.event_types (
    id integer NOT NULL,
    name character varying(255),
    level integer DEFAULT 0,
    description character varying(255)
);


ALTER TABLE public.event_types OWNER TO wayjournal;

--
-- Name: event_types_id_seq; Type: SEQUENCE; Schema: public; Owner: wayjournal
--

CREATE SEQUENCE public.event_types_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_types_id_seq OWNER TO wayjournal;

--
-- Name: event_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wayjournal
--

ALTER SEQUENCE public.event_types_id_seq OWNED BY public.event_types.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: wayjournal
--

CREATE TABLE public.events (
    uuid uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_uid uuid NOT NULL,
    car_uid uuid NOT NULL,
    device_uid uuid NOT NULL,
    event_time timestamp with time zone NOT NULL,
    type_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.events OWNER TO wayjournal;

--
-- Name: gps; Type: TABLE; Schema: public; Owner: wayjournal
--

CREATE TABLE public.gps (
    uuid uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_uid uuid NOT NULL,
    car_uid uuid NOT NULL,
    device_uid uuid NOT NULL,
    lat double precision NOT NULL,
    lon double precision NOT NULL,
    altitude double precision,
    direction double precision,
    accuracy double precision,
    speed double precision,
    gps_time timestamp with time zone NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.gps OWNER TO wayjournal;

--
-- Name: knex_migrations; Type: TABLE; Schema: public; Owner: wayjournal
--

CREATE TABLE public.knex_migrations (
    id integer NOT NULL,
    name character varying(255),
    batch integer,
    migration_time timestamp with time zone
);


ALTER TABLE public.knex_migrations OWNER TO wayjournal;

--
-- Name: knex_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: wayjournal
--

CREATE SEQUENCE public.knex_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.knex_migrations_id_seq OWNER TO wayjournal;

--
-- Name: knex_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wayjournal
--

ALTER SEQUENCE public.knex_migrations_id_seq OWNED BY public.knex_migrations.id;


--
-- Name: knex_migrations_lock; Type: TABLE; Schema: public; Owner: wayjournal
--

CREATE TABLE public.knex_migrations_lock (
    is_locked integer
);


ALTER TABLE public.knex_migrations_lock OWNER TO wayjournal;

--
-- Name: users; Type: TABLE; Schema: public; Owner: wayjournal
--

CREATE TABLE public.users (
    uuid uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    email character varying(510) NOT NULL,
    name character varying(300),
    password character varying(300),
    phone bigint,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    avatars json
);


ALTER TABLE public.users OWNER TO wayjournal;

--
-- Name: car_brands id; Type: DEFAULT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.car_brands ALTER COLUMN id SET DEFAULT nextval('public.car_brands_id_seq'::regclass);


--
-- Name: car_fuel_types id; Type: DEFAULT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.car_fuel_types ALTER COLUMN id SET DEFAULT nextval('public.car_fuel_types_id_seq'::regclass);


--
-- Name: car_models id; Type: DEFAULT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.car_models ALTER COLUMN id SET DEFAULT nextval('public.car_models_id_seq'::regclass);


--
-- Name: car_modification id; Type: DEFAULT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.car_modification ALTER COLUMN id SET DEFAULT nextval('public.car_modification_id_seq'::regclass);


--
-- Name: car_sub_models id; Type: DEFAULT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.car_sub_models ALTER COLUMN id SET DEFAULT nextval('public.car_sub_models_id_seq'::regclass);


--
-- Name: device_types id; Type: DEFAULT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.device_types ALTER COLUMN id SET DEFAULT nextval('public.device_types_id_seq'::regclass);


--
-- Name: event_types id; Type: DEFAULT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.event_types ALTER COLUMN id SET DEFAULT nextval('public.event_types_id_seq'::regclass);


--
-- Name: knex_migrations id; Type: DEFAULT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.knex_migrations ALTER COLUMN id SET DEFAULT nextval('public.knex_migrations_id_seq'::regclass);


--
-- Data for Name: car_brands; Type: TABLE DATA; Schema: public; Owner: wayjournal
--

COPY public.car_brands (id, name) FROM stdin;
1	Oka
\.


--
-- Data for Name: car_fuel_types; Type: TABLE DATA; Schema: public; Owner: wayjournal
--

COPY public.car_fuel_types (id, name) FROM stdin;
1	Samogon
\.


--
-- Data for Name: car_models; Type: TABLE DATA; Schema: public; Owner: wayjournal
--

COPY public.car_models (id, brand_id, name) FROM stdin;
1	1	1975
\.


--
-- Data for Name: car_modification; Type: TABLE DATA; Schema: public; Owner: wayjournal
--

COPY public.car_modification (id, sub_model_id, name) FROM stdin;
1	1	Fuel reorgonize
\.


--
-- Data for Name: car_sub_models; Type: TABLE DATA; Schema: public; Owner: wayjournal
--

COPY public.car_sub_models (id, model_id, name) FROM stdin;
1	1	Vasilich edition
\.


--
-- Data for Name: cars; Type: TABLE DATA; Schema: public; Owner: wayjournal
--

COPY public.cars (uuid, brand, model, sub_model, modification, fuel_type, government_number, delete, user_uid, created_at, updated_at, avatars) FROM stdin;
eac51452-5510-4699-a3f8-d4099c3ab0ca	1	1	1	1	1	abc234	f	55d15a32-6227-4faf-b9fa-928d3b5fcd48	2019-07-01 18:10:32.920703+00	2019-07-01 18:10:32.920703+00	\N
1f1d90d8-5188-4c45-be9a-3ce8178d8acf	1	1	1	1	1	abc234	f	55d15a32-6227-4faf-b9fa-928d3b5fcd48	2019-07-01 18:13:31.187114+00	2019-07-01 18:13:31.187114+00	\N
d8f96d92-fb2f-415b-a86f-586506b8a422	1	1	1	1	1	121212	f	55d15a32-6227-4faf-b9fa-928d3b5fcd48	2019-07-02 16:51:15.501862+00	2019-07-02 16:51:15.501862+00	\N
5ebb7e68-2181-4faf-a2f2-f5ba15e7e1d2	1	1	1	1	1	121212	f	55d15a32-6227-4faf-b9fa-928d3b5fcd48	2019-07-02 17:31:25.229488+00	2019-07-02 17:31:25.229488+00	\N
931ff8b5-0e07-43be-8303-26bdb8b61b9c	1	1	1	1	1	121212	f	55d15a32-6227-4faf-b9fa-928d3b5fcd48	2019-07-02 19:17:49.676188+00	2019-07-02 19:17:49.676188+00	\N
c2c9bce3-de6b-4432-b613-e66c76e76f25	1	1	1	1	1	dddddd	f	55d15a32-6227-4faf-b9fa-928d3b5fcd48	2019-07-02 19:17:54.333348+00	2019-07-02 19:17:54.333348+00	\N
\.


--
-- Data for Name: device_types; Type: TABLE DATA; Schema: public; Owner: wayjournal
--

COPY public.device_types (id, name) FROM stdin;
1	Petrovich
2	MagicSystem
3	MobileDevice
4	Obd
\.


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: wayjournal
--

COPY public.devices (uuid, term_id, type, car_uid, available_data_source, created_at, updated_at, extra_data, delete) FROM stdin;
df37cb43-6175-49e9-a8f4-41c3336dffcc	string term id	1	eac51452-5510-4699-a3f8-d4099c3ab0ca	{gps,video}	2019-07-01 19:00:35.274477+00	2019-07-01 19:00:35.274477+00	\N	f
\.


--
-- Data for Name: drivers; Type: TABLE DATA; Schema: public; Owner: wayjournal
--

COPY public.drivers (uuid, name, avatar_url, company) FROM stdin;
\.


--
-- Data for Name: drivers_history; Type: TABLE DATA; Schema: public; Owner: wayjournal
--

COPY public.drivers_history (uuid, driver_uid, car_uid, start_at, finish_at) FROM stdin;
\.


--
-- Data for Name: enabled_data_source; Type: TABLE DATA; Schema: public; Owner: wayjournal
--

COPY public.enabled_data_source (car_uid, device_uid, enabled) FROM stdin;
\.


--
-- Data for Name: event_types; Type: TABLE DATA; Schema: public; Owner: wayjournal
--

COPY public.event_types (id, name, level, description) FROM stdin;
1	TrackStart	0	Track start
2	TrackStop	0	Track stop
\.


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: wayjournal
--

COPY public.events (uuid, user_uid, car_uid, device_uid, event_time, type_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: gps; Type: TABLE DATA; Schema: public; Owner: wayjournal
--

COPY public.gps (uuid, user_uid, car_uid, device_uid, lat, lon, altitude, direction, accuracy, speed, gps_time, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: knex_migrations; Type: TABLE DATA; Schema: public; Owner: wayjournal
--

COPY public.knex_migrations (id, name, batch, migration_time) FROM stdin;
1	20161225120159-create_extension.js	1	2019-07-01 16:25:15.633+00
2	20161226114927-table_car_brands.js	1	2019-07-01 16:25:15.729+00
3	20161226114939-table_car_models.js	1	2019-07-01 16:25:15.852+00
4	20161226114945-table_car_sub_models.js	1	2019-07-01 16:25:15.927+00
5	20161226114956-table_car_modification.js	1	2019-07-01 16:25:16.014+00
6	20161226115006-table_car_fuel_types.js	1	2019-07-01 16:25:16.071+00
7	20161227103841-table_users.js	1	2019-07-01 16:25:16.149+00
8	20161227105206-table_cars.js	1	2019-07-01 16:25:16.505+00
9	20161227110403-table_device_types.js	1	2019-07-01 16:25:16.557+00
10	20161227110526-enum_data_sources.js	1	2019-07-01 16:25:16.617+00
11	20161227110647-table_devices.js	1	2019-07-01 16:25:16.756+00
12	20161227113509-table_enabled_data_source.js	1	2019-07-01 16:25:16.846+00
13	20170109110039-table_drivers.js	1	2019-07-01 16:25:16.931+00
14	20170109110307-table_drivers_history.js	1	2019-07-01 16:25:17.034+00
15	20170111150043-test_dump.sql	1	2019-07-01 16:25:17.134+00
16	20170116104545-alter_table_users.js	1	2019-07-01 16:25:17.146+00
17	20170116115834-alter_table_cars.js	1	2019-07-01 16:25:17.192+00
18	20170123174232-table_event_types.js	1	2019-07-01 16:25:17.229+00
19	20170124173619-table_gps.js	1	2019-07-01 16:25:17.332+00
20	20170124174200-table_events.js	1	2019-07-01 16:25:17.699+00
21	20170212101928-data_event_type.sql	1	2019-07-01 16:25:17.722+00
22	20170216124110-alter_table_devices.js	1	2019-07-01 16:25:17.75+00
23	20170216125445-test_dump_2.sql	1	2019-07-01 16:25:17.773+00
24	20170217140225-alter_table_event_types.js	1	2019-07-01 16:25:17.815+00
25	20170217150339-test_dump_3.sql	1	2019-07-01 16:25:17.851+00
26	20170222102649-test_dump_4.sql	1	2019-07-01 16:25:17.879+00
27	20170315114904-alter_table_devices.js	1	2019-07-01 16:25:17.917+00
\.


--
-- Data for Name: knex_migrations_lock; Type: TABLE DATA; Schema: public; Owner: wayjournal
--

COPY public.knex_migrations_lock (is_locked) FROM stdin;
0
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: wayjournal
--

COPY public.users (uuid, email, name, password, phone, created_at, updated_at, avatars) FROM stdin;
55d15a32-6227-4faf-b9fa-928d3b5fcd48	b-b-q@ya.ru	\N	8d6229153add62945b60693ee020fca3c09dab67	\N	2019-07-01 16:43:54.057131+00	2019-07-01 16:43:54.057131+00	\N
ec7124b4-7ad9-45eb-9e6e-89dbd21fc080	test@ya.ru	\N	8d6229153add62945b60693ee020fca3c09dab67	\N	2019-07-26 16:16:43.787085+00	2019-07-26 16:16:43.787085+00	\N
\.


--
-- Name: car_brands_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wayjournal
--

SELECT pg_catalog.setval('public.car_brands_id_seq', 1, false);


--
-- Name: car_fuel_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wayjournal
--

SELECT pg_catalog.setval('public.car_fuel_types_id_seq', 1, false);


--
-- Name: car_models_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wayjournal
--

SELECT pg_catalog.setval('public.car_models_id_seq', 1, false);


--
-- Name: car_modification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wayjournal
--

SELECT pg_catalog.setval('public.car_modification_id_seq', 1, false);


--
-- Name: car_sub_models_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wayjournal
--

SELECT pg_catalog.setval('public.car_sub_models_id_seq', 1, false);


--
-- Name: device_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wayjournal
--

SELECT pg_catalog.setval('public.device_types_id_seq', 1, false);


--
-- Name: event_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wayjournal
--

SELECT pg_catalog.setval('public.event_types_id_seq', 1, false);


--
-- Name: knex_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: wayjournal
--

SELECT pg_catalog.setval('public.knex_migrations_id_seq', 27, true);


--
-- Name: car_brands car_brands_pkey; Type: CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.car_brands
    ADD CONSTRAINT car_brands_pkey PRIMARY KEY (id);


--
-- Name: car_fuel_types car_fuel_types_pkey; Type: CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.car_fuel_types
    ADD CONSTRAINT car_fuel_types_pkey PRIMARY KEY (id);


--
-- Name: car_models car_models_pkey; Type: CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.car_models
    ADD CONSTRAINT car_models_pkey PRIMARY KEY (id);


--
-- Name: car_modification car_modification_pkey; Type: CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.car_modification
    ADD CONSTRAINT car_modification_pkey PRIMARY KEY (id);


--
-- Name: car_sub_models car_sub_models_pkey; Type: CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.car_sub_models
    ADD CONSTRAINT car_sub_models_pkey PRIMARY KEY (id);


--
-- Name: cars cars_pkey; Type: CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_pkey PRIMARY KEY (uuid);


--
-- Name: device_types device_types_pkey; Type: CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.device_types
    ADD CONSTRAINT device_types_pkey PRIMARY KEY (id);


--
-- Name: devices devices_pkey; Type: CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_pkey PRIMARY KEY (uuid);


--
-- Name: drivers_history drivers_history_pkey; Type: CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.drivers_history
    ADD CONSTRAINT drivers_history_pkey PRIMARY KEY (uuid);


--
-- Name: drivers drivers_pkey; Type: CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.drivers
    ADD CONSTRAINT drivers_pkey PRIMARY KEY (uuid);


--
-- Name: enabled_data_source enabled_data_source_pkey; Type: CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.enabled_data_source
    ADD CONSTRAINT enabled_data_source_pkey PRIMARY KEY (car_uid, enabled);


--
-- Name: event_types event_types_pkey; Type: CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.event_types
    ADD CONSTRAINT event_types_pkey PRIMARY KEY (id);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (uuid);


--
-- Name: gps gps_pkey; Type: CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.gps
    ADD CONSTRAINT gps_pkey PRIMARY KEY (uuid);


--
-- Name: knex_migrations knex_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.knex_migrations
    ADD CONSTRAINT knex_migrations_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (uuid);


--
-- Name: car_models car_models_brand_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.car_models
    ADD CONSTRAINT car_models_brand_id_foreign FOREIGN KEY (brand_id) REFERENCES public.car_brands(id);


--
-- Name: car_modification car_modification_sub_model_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.car_modification
    ADD CONSTRAINT car_modification_sub_model_id_foreign FOREIGN KEY (sub_model_id) REFERENCES public.car_sub_models(id);


--
-- Name: car_sub_models car_sub_models_model_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.car_sub_models
    ADD CONSTRAINT car_sub_models_model_id_foreign FOREIGN KEY (model_id) REFERENCES public.car_models(id);


--
-- Name: cars cars_brand_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_brand_foreign FOREIGN KEY (brand) REFERENCES public.car_brands(id);


--
-- Name: cars cars_fuel_type_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_fuel_type_foreign FOREIGN KEY (fuel_type) REFERENCES public.car_fuel_types(id);


--
-- Name: cars cars_model_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_model_foreign FOREIGN KEY (model) REFERENCES public.car_models(id);


--
-- Name: cars cars_modification_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_modification_foreign FOREIGN KEY (modification) REFERENCES public.car_modification(id);


--
-- Name: cars cars_sub_model_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_sub_model_foreign FOREIGN KEY (sub_model) REFERENCES public.car_sub_models(id);


--
-- Name: cars cars_user_uid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_user_uid_foreign FOREIGN KEY (user_uid) REFERENCES public.users(uuid);


--
-- Name: devices devices_car_uid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_car_uid_foreign FOREIGN KEY (car_uid) REFERENCES public.cars(uuid);


--
-- Name: devices devices_type_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_type_foreign FOREIGN KEY (type) REFERENCES public.device_types(id);


--
-- Name: drivers drivers_company_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.drivers
    ADD CONSTRAINT drivers_company_foreign FOREIGN KEY (company) REFERENCES public.users(uuid);


--
-- Name: drivers_history drivers_history_car_uid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.drivers_history
    ADD CONSTRAINT drivers_history_car_uid_foreign FOREIGN KEY (car_uid) REFERENCES public.cars(uuid);


--
-- Name: drivers_history drivers_history_driver_uid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.drivers_history
    ADD CONSTRAINT drivers_history_driver_uid_foreign FOREIGN KEY (driver_uid) REFERENCES public.drivers(uuid);


--
-- Name: enabled_data_source enabled_data_source_car_uid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.enabled_data_source
    ADD CONSTRAINT enabled_data_source_car_uid_foreign FOREIGN KEY (car_uid) REFERENCES public.cars(uuid);


--
-- Name: enabled_data_source enabled_data_source_device_uid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.enabled_data_source
    ADD CONSTRAINT enabled_data_source_device_uid_foreign FOREIGN KEY (device_uid) REFERENCES public.devices(uuid);


--
-- Name: events events_car_uid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_car_uid_foreign FOREIGN KEY (car_uid) REFERENCES public.cars(uuid);


--
-- Name: events events_device_uid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_device_uid_foreign FOREIGN KEY (device_uid) REFERENCES public.devices(uuid);


--
-- Name: events events_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_type_id_foreign FOREIGN KEY (type_id) REFERENCES public.event_types(id);


--
-- Name: events events_user_uid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_user_uid_foreign FOREIGN KEY (user_uid) REFERENCES public.users(uuid);


--
-- Name: gps gps_car_uid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.gps
    ADD CONSTRAINT gps_car_uid_foreign FOREIGN KEY (car_uid) REFERENCES public.cars(uuid);


--
-- Name: gps gps_device_uid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.gps
    ADD CONSTRAINT gps_device_uid_foreign FOREIGN KEY (device_uid) REFERENCES public.devices(uuid);


--
-- Name: gps gps_user_uid_foreign; Type: FK CONSTRAINT; Schema: public; Owner: wayjournal
--

ALTER TABLE ONLY public.gps
    ADD CONSTRAINT gps_user_uid_foreign FOREIGN KEY (user_uid) REFERENCES public.users(uuid);


--
-- PostgreSQL database dump complete
--

