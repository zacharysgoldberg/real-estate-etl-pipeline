--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

-- Started on 2022-03-12 00:28:22 UTC

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 209 (class 1259 OID 102227)
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 159632)
-- Name: content; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content (
    id integer NOT NULL,
    description text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    content_type text NOT NULL,
    filtered boolean NOT NULL,
    user_id integer
);


ALTER TABLE public.content OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 159631)
-- Name: content_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.content_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.content_id_seq OWNER TO postgres;

--
-- TOC entry 3387 (class 0 OID 0)
-- Dependencies: 214
-- Name: content_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.content_id_seq OWNED BY public.content.id;


--
-- TOC entry 217 (class 1259 OID 159646)
-- Name: incidents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.incidents (
    id integer NOT NULL,
    city text NOT NULL,
    state character varying(2) NOT NULL,
    incident_type character varying(100) NOT NULL,
    coordinates text NOT NULL,
    description text,
    ongoing boolean,
    date_time timestamp without time zone NOT NULL,
    location_id integer NOT NULL
);


ALTER TABLE public.incidents OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 159645)
-- Name: incidents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.incidents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.incidents_id_seq OWNER TO postgres;

--
-- TOC entry 3388 (class 0 OID 0)
-- Dependencies: 216
-- Name: incidents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.incidents_id_seq OWNED BY public.incidents.id;


--
-- TOC entry 211 (class 1259 OID 159612)
-- Name: locations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    city text NOT NULL,
    state character varying(2) NOT NULL
);


ALTER TABLE public.locations OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 159611)
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.locations_id_seq OWNER TO postgres;

--
-- TOC entry 3389 (class 0 OID 0)
-- Dependencies: 210
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- TOC entry 219 (class 1259 OID 159660)
-- Name: tips; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tips (
    id integer NOT NULL,
    anonymous boolean NOT NULL,
    username character varying(128),
    city text NOT NULL,
    state character varying(2) NOT NULL,
    coordinates text NOT NULL,
    incident_type character varying(100) NOT NULL,
    description text,
    date_time timestamp without time zone NOT NULL,
    user_id integer,
    location_id integer NOT NULL,
    incident_id integer NOT NULL
);


ALTER TABLE public.tips OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 159659)
-- Name: tips_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tips_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tips_id_seq OWNER TO postgres;

--
-- TOC entry 3390 (class 0 OID 0)
-- Dependencies: 218
-- Name: tips_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tips_id_seq OWNED BY public.tips.id;


--
-- TOC entry 213 (class 1259 OID 159621)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    full_name text NOT NULL,
    username character varying(128) NOT NULL,
    password character varying(128) NOT NULL,
    date_of_birth timestamp without time zone NOT NULL,
    email character varying(200) NOT NULL,
    phone text
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 159683)
-- Name: users_content; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_content (
    user_id integer NOT NULL,
    content_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.users_content OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 159620)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3391 (class 0 OID 0)
-- Dependencies: 212
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 221 (class 1259 OID 159698)
-- Name: users_tips; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_tips (
    user_id integer NOT NULL,
    tip_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.users_tips OWNER TO postgres;

--
-- TOC entry 3200 (class 2604 OID 159635)
-- Name: content id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content ALTER COLUMN id SET DEFAULT nextval('public.content_id_seq'::regclass);


--
-- TOC entry 3201 (class 2604 OID 159649)
-- Name: incidents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.incidents ALTER COLUMN id SET DEFAULT nextval('public.incidents_id_seq'::regclass);


--
-- TOC entry 3198 (class 2604 OID 159615)
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- TOC entry 3202 (class 2604 OID 159663)
-- Name: tips id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tips ALTER COLUMN id SET DEFAULT nextval('public.tips_id_seq'::regclass);


--
-- TOC entry 3199 (class 2604 OID 159624)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3369 (class 0 OID 102227)
-- Dependencies: 209
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
beaa18834b10
\.


--
-- TOC entry 3375 (class 0 OID 159632)
-- Dependencies: 215
-- Data for Name: content; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.content (id, description, created_at, content_type, filtered, user_id) FROM stdin;
1	Herself himself gun yeah production.	2022-03-10 23:59:31.98286	Video	t	149
2	Represent decision Republican describe.	2022-03-10 23:59:31.98286	Image	f	151
3	Order long serve a discuss until.	2022-03-10 23:59:31.98286	Sound recording	t	177
4	Police research you above.	2022-03-10 23:59:31.98286	Video	t	174
5	Across two ball thus.	2022-03-10 23:59:31.98286	Image	f	153
6	Out hot kid increase.	2022-03-10 23:59:31.98286	Image	t	110
7	Budget source action.	2022-03-10 23:59:31.98286	Video	f	167
8	Response about hard ability international happy painting be.	2022-03-10 23:59:31.98286	Image	t	110
9	Race evening TV determine.	2022-03-10 23:59:31.98286	Sound recording	f	108
10	List see suggest fish.	2022-03-10 23:59:31.98286	Sound recording	f	165
11	Level believe medical which third language.	2022-03-10 23:59:31.98286	Video	f	124
12	Eat receive within imagine.	2022-03-10 23:59:31.98286	Video	f	154
13	Determine collection open same upon.	2022-03-10 23:59:31.98286	Sound recording	t	132
14	Operation live yes money own deal add.	2022-03-10 23:59:31.98286	Sound recording	t	199
15	Between hear within young argue compare strategy.	2022-03-10 23:59:31.98286	Sound recording	f	110
16	Southern begin real.	2022-03-10 23:59:31.98286	Video	f	139
17	Necessary effect sort remain feeling.	2022-03-10 23:59:31.98286	Sound recording	t	125
18	Consider somebody ground sure interview subject people.	2022-03-10 23:59:31.98286	Image	f	108
19	Officer baby able hand finish resource.	2022-03-10 23:59:31.98286	Sound recording	f	114
20	Pm project happen you travel.	2022-03-10 23:59:31.98286	Image	t	122
21	Kind big someone theory its manage number.	2022-03-10 23:59:31.98286	Sound recording	f	129
22	Increase sell evidence act.	2022-03-10 23:59:31.98286	Video	t	200
23	Foot keep whom certainly laugh arm wrong.	2022-03-10 23:59:31.98286	Video	f	199
24	Thousand natural scientist.	2022-03-10 23:59:31.98286	Sound recording	f	138
25	Past six run finish military far push.	2022-03-10 23:59:31.98286	Sound recording	t	159
26	Side space describe special.	2022-03-10 23:59:31.98286	Image	t	147
27	Beat each with many.	2022-03-10 23:59:31.98286	Image	t	153
28	This once treat middle rock work.	2022-03-10 23:59:31.98286	Sound recording	f	140
29	Present base commercial which station detail.	2022-03-10 23:59:31.98286	Sound recording	t	122
30	Well charge continue more campaign spend.	2022-03-10 23:59:31.98286	Sound recording	f	123
31	Agreement by entire sense activity bill.	2022-03-10 23:59:31.98286	Image	f	145
32	Nation cup start long catch writer long.	2022-03-10 23:59:31.98286	Sound recording	f	172
33	Loss Democrat century recent fight take.	2022-03-10 23:59:31.98286	Sound recording	f	120
34	Middle discover company during event than during.	2022-03-10 23:59:31.98286	Image	f	122
35	Improve pretty but activity scientist share radio red.	2022-03-10 23:59:31.98286	Sound recording	t	179
36	Assume item heart price traditional green.	2022-03-10 23:59:31.98286	Video	t	107
37	Serve cause value expert.	2022-03-10 23:59:31.98286	Image	f	156
38	Read war their item change.	2022-03-10 23:59:31.98286	Video	f	199
39	Then actually event body leg senior.	2022-03-10 23:59:31.98286	Image	f	101
40	Wife development leave high ground charge.	2022-03-10 23:59:31.98286	Image	f	195
41	Dream charge think stage.	2022-03-10 23:59:31.98286	Sound recording	t	187
42	Science expect your in term tonight.	2022-03-10 23:59:31.98286	Image	t	142
43	Crime usually her.	2022-03-10 23:59:31.98286	Video	f	175
44	Check example chair morning win natural which.	2022-03-10 23:59:31.98286	Sound recording	t	168
45	Sell offer alone care conference.	2022-03-10 23:59:31.98286	Sound recording	f	139
46	Last civil program read.	2022-03-10 23:59:31.98286	Sound recording	t	183
47	Friend difficult range meeting government positive.	2022-03-10 23:59:31.98286	Image	f	157
48	Design education thought remember.	2022-03-10 23:59:31.98286	Sound recording	t	144
49	Stock finish eat available situation animal.	2022-03-10 23:59:31.98286	Video	f	183
50	Heavy Republican natural political.	2022-03-10 23:59:31.98286	Video	f	151
51	Security process senior yourself already.	2022-03-10 23:59:31.98286	Image	f	114
52	Five different should.	2022-03-10 23:59:31.98286	Image	t	179
53	Everyone charge citizen even.	2022-03-10 23:59:31.98286	Image	f	114
54	Note west catch goal perform.	2022-03-10 23:59:31.98286	Video	f	128
55	Reason very rule finish would eight low.	2022-03-10 23:59:31.98286	Image	t	170
56	Group culture history serious standard TV.	2022-03-10 23:59:31.98286	Video	t	165
57	Discussion attention class tough hospital message line.	2022-03-10 23:59:31.98286	Image	f	153
58	Into write life visit cup.	2022-03-10 23:59:31.98286	Image	f	200
59	Water artist history model admit particular hope.	2022-03-10 23:59:31.98286	Sound recording	t	167
60	Thank our research.	2022-03-10 23:59:31.98286	Video	t	184
61	Score air point wait away thousand.	2022-03-10 23:59:31.98286	Sound recording	t	137
62	Pick method girl me across.	2022-03-10 23:59:31.98286	Video	f	146
63	Worry husband room dark computer card friend.	2022-03-10 23:59:31.98286	Image	t	150
64	Such defense early head.	2022-03-10 23:59:31.98286	Image	t	121
65	Whether he water room.	2022-03-10 23:59:31.98286	Image	t	143
66	Opportunity wear exist national begin treatment speak final.	2022-03-10 23:59:31.98286	Video	f	106
67	Art social strong free size light.	2022-03-10 23:59:31.98286	Image	f	102
68	Institution cup choose decision nothing.	2022-03-10 23:59:31.98286	Video	t	154
69	Wide to hold quickly necessary financial evening thank.	2022-03-10 23:59:31.98286	Sound recording	t	111
70	Agency here machine financial.	2022-03-10 23:59:31.98286	Video	t	176
71	Resource memory small structure from say.	2022-03-10 23:59:31.98286	Video	t	122
72	Key star artist local.	2022-03-10 23:59:31.98286	Sound recording	f	128
73	Late social speech.	2022-03-10 23:59:31.98286	Sound recording	f	163
74	Single reveal already against campaign significant any expect.	2022-03-10 23:59:31.98286	Video	f	122
75	Much yourself list miss.	2022-03-10 23:59:31.98286	Video	f	183
\.


--
-- TOC entry 3377 (class 0 OID 159646)
-- Dependencies: 217
-- Data for Name: incidents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.incidents (id, city, state, incident_type, coordinates, description, ongoing, date_time, location_id) FROM stdin;
1	Providence	RI	Respiratory distress	169.116265	Walk magazine future among this stock part.	t	2021-08-29 03:54:32	93
2	Milwaukee	WI	Respiratory distress	104.856958	Sense former look huge.	t	2021-06-18 00:13:48	103
3	Fargo	ND	Overdose	14.991050	Water water economic important late.	t	2021-10-18 05:31:11	89
4	Billings	MT	Fight	103.837851	Certain focus day capital main manager.	t	2021-09-18 09:17:10	80
5	Milwaukee	WI	Fight	42.468949	Material response receive though fear per role purpose.	f	2021-06-06 22:55:57	103
6	Burlington	VT	Domestic Violence	21.542981	Cost any control office college.	t	2021-09-23 00:59:25	100
7	Indianapolis	IN	Cardiac arrest	-131.019900	Scene enjoy fast two late hope prove.	t	2022-01-12 21:48:13	68
8	Houston	TX	Seizure	44.985755	Upon continue subject half community position.	t	2021-12-13 04:58:55	97
9	Columbus	OH	Cardiac arrest	-57.641191	Each perform seek shoulder.	t	2021-10-19 02:27:43	90
10	Little Rock	AR	Behavioral/Psychiatric	21.351797	Product bring himself modern form.	f	2021-07-07 16:32:07	58
11	Cheyenne	WY	Vehicle accident	56.404985	Rather election their attention never.	f	2021-06-12 19:13:30	104
12	Burlington	VT	Domestic Violence	-68.853134	Commercial another describe evidence PM develop day huge.	t	2021-09-16 07:15:34	100
13	New York City	NY	Cardiac arrest	144.293217	Success low situation value.	f	2021-06-30 05:47:50	86
14	New York City	NY	Fight	156.038038	Power peace loss interesting current.	t	2021-05-22 14:14:24	86
15	Anchorage	AK	Domestic Violence	-28.170590	Read feeling teacher camera trouble business.	f	2021-09-18 03:11:27	56
16	Salt Lake City	UT	Vehicle accident	-123.248624	Off me perform such leg.	f	2021-06-14 18:08:06	99
17	Columbus	OH	Traumatic Injury	39.347491	Single much investment magazine quite.	t	2021-09-18 23:24:10	90
18	Chicago	IL	Behavioral/Psychiatric	162.593249	Whose college window century situation ready song citizen.	f	2021-06-26 15:42:11	67
19	Denver	CO	Behavioral/Psychiatric	-134.723119	Age try Republican begin assume example television.	t	2021-06-08 18:50:40	59
20	New York City	NY	Overdose	-38.795314	Our society toward finally surface model past.	t	2021-07-15 05:15:14	86
21	New Orleans	LA	Behavioral/Psychiatric	-38.124142	Parent exist anything term whole different team.	f	2021-04-01 08:42:26	72
22	Milwaukee	WI	Traumatic Injury	90.889820	Wait board name her to TV.	t	2021-06-03 01:05:21	103
23	Buffalo	NY	Domestic Violence	-31.551867	Capital thing long fast place explain commercial.	t	2021-04-11 11:59:16	87
24	Phoenix	AZ	Respiratory distress	67.746207	Easy feel central live campaign forward information.	f	2022-03-07 21:36:43	57
25	Milwaukee	WI	Stabbing	121.997748	Side bed whole level area point.	f	2021-03-31 07:50:00	103
26	Philadelphia	PA	Seizure	3.452749	History people final mission four.	f	2021-06-17 22:31:38	92
27	San Francisco	CA	Behavioral/Psychiatric	9.965193	Learn skin general card friend.	t	2021-08-01 13:53:23	54
28	Milwaukee	WI	Seizure	-128.140941	Draw career music create.	t	2021-10-15 03:57:33	103
29	Columbus	OH	Fight	-175.091933	Eight mean at gas religious television.	f	2022-01-21 15:00:12	90
30	Wilmington	DE	Behavioral/Psychiatric	88.208035	Wrong herself actually.	t	2021-03-19 02:17:13	61
31	Omaha	NE	Traumatic Injury	40.797152	Either within month follow owner example ask.	t	2021-04-15 01:36:56	81
32	Jackson	MS	Traumatic Injury	30.340312	Teacher level fight now.	t	2022-01-25 15:57:27	78
33	Baltimore	MD	Fight	-118.371379	Place Republican house material stuff must.	t	2021-08-03 18:02:50	74
34	Buffalo	NY	Seizure	-166.074759	Level guy one detail floor establish.	f	2021-06-15 12:16:24	87
35	Jacksonville	FL	Traumatic Injury	-24.170725	Charge reality turn finally read into out.	f	2021-12-28 20:39:41	62
37	Las Vegas	NV	Gunshot Wound	63.114108	Result suffer worry discussion.	t	2021-05-28 05:46:16	82
38	Philadelphia	PA	Stabbing	35.798089	Two road simple represent put school ok fall.	t	2022-01-09 08:40:17	92
39	Houston	TX	Respiratory distress	-139.318530	See care imagine laugh certainly.	t	2021-11-28 04:52:08	97
40	Seattle	WA	Stabbing	131.908002	Should where listen key where serious happy.	f	2021-09-14 08:51:32	102
41	Billings	MT	Fight	-41.029619	Sound want media read.	f	2021-04-22 22:07:28	80
42	Miami	FL	Bleeding	98.289522	Myself onto race ok clear administration result.	t	2021-06-25 07:07:46	63
43	Omaha	NE	Respiratory distress	13.667582	Summer want doctor occur record say.	f	2021-10-26 17:42:32	81
44	Fargo	ND	Gunshot Wound	20.656532	Dark just health seven remain design however able.	f	2021-04-23 05:26:17	89
45	Denver	CO	Behavioral/Psychiatric	-178.894185	Talk ago have computer power.	f	2021-07-20 12:53:05	59
46	Wilmington	DE	Fight	-174.412747	History second parent according.	t	2021-06-16 21:03:54	61
48	Honolulu	HI	Domestic Violence	116.076323	Occur little trial quickly.	f	2021-08-16 00:57:00	65
49	Seattle	WA	Overdose	20.166632	Officer month audience talk sister keep.	f	2021-06-04 21:11:33	102
50	Providence	RI	Property Fire	60.604958	Now painting traditional pick leader who.	t	2021-05-12 19:11:01	93
51	Kansas City	MO	Vehicle accident	-31.833102	Thought test management.	t	2021-03-11 19:26:48	79
52	Omaha	NE	Stabbing	119.460019	Effort situation hard point.	f	2021-04-08 08:26:49	81
53	Virginia Beach	VA	Bleeding	-21.638213	Mother environmental whatever better if compare everyone.	f	2021-12-26 13:56:17	101
55	Des Moines	IA	Stabbing	-73.644298	Beautiful cell would be once military.	t	2021-11-21 11:26:19	69
56	Billings	MT	Traumatic Injury	-4.131119	Possible when since.	f	2021-04-07 18:53:44	80
57	Oklahoma City	OK	Property Fire	26.026531	Research beat shake baby.	t	2021-06-20 14:19:37	91
58	Fargo	ND	Behavioral/Psychiatric	18.358859	As stock close high family state soldier.	f	2021-05-17 23:42:11	89
59	Jacksonville	FL	Vehicle accident	-52.157316	Stock walk strategy memory election.	f	2021-07-20 00:14:57	62
60	Minneapolis	MN	Overdose	45.093391	Really economic memory study some difference.	f	2021-11-15 22:45:46	77
61	Manchester	NH	Respiratory distress	-31.496224	Feel truth population probably certain professional brother.	t	2021-04-02 12:55:39	83
62	Wilmington	DE	Stabbing	167.644695	Some pressure most discuss to book.	t	2021-04-01 16:19:04	61
64	Los Angeles	CA	Fight	-167.858666	Market understand TV avoid smile friend window growth.	f	2021-10-19 18:11:30	53
65	Portland	OR	Vehicle accident	114.864492	Power care people media rest.	t	2021-10-21 06:50:00	73
66	Boston	MA	Bleeding	86.064076	Specific current player economic.	t	2021-09-15 00:24:59	75
67	New Orleans	LA	Bleeding	-85.500965	Religious choose job issue.	t	2021-06-22 07:21:36	72
68	Billings	MT	Gunshot Wound	-138.269435	Agreement region need decade eight reach.	f	2022-01-07 11:01:20	80
69	Los Angeles	CA	Bleeding	6.000242	Born discover me grow his ahead.	t	2021-11-13 04:37:50	53
70	Fargo	ND	Cardiac arrest	-28.886299	Increase remain main father raise dark.	f	2021-05-12 23:20:23	89
71	Philadelphia	PA	Vehicle accident	115.687073	Budget significant four somebody develop.	f	2021-12-29 01:16:35	92
72	Miami	FL	Property Fire	-13.442758	Meeting buy age newspaper reality bed.	f	2022-01-19 05:31:55	63
73	Salt Lake City	UT	Stabbing	4.382660	Health attorney improve push.	f	2021-03-15 23:25:57	99
74	Los Angeles	CA	Property Fire	-126.968621	Fly improve world time part agent lay.	t	2021-11-04 05:18:33	53
75	Miami	FL	Seizure	4.640478	Right word quickly performance.	f	2021-05-11 09:27:24	63
76	Jacksonville	FL	Vehicle accident	-106.707202	Politics interesting rate tree.	f	2021-08-29 13:44:28	62
77	Minneapolis	MN	Fight	-157.061673	Strategy TV to.	t	2021-10-25 10:12:08	77
78	Burlington	VT	Stabbing	58.016729	Town put we trip soldier lose.	t	2021-10-29 21:16:06	100
79	Charleston	WV	Gunshot Wound	166.368740	Current security board yes model recent network store.	t	2021-10-26 08:53:33	94
80	Las Vegas	NV	Domestic Violence	6.133542	Kind environmental become news guy husband might.	f	2021-04-22 10:36:09	82
81	Jacksonville	FL	Seizure	41.923393	Style tough everything part phone skill.	t	2021-07-25 21:19:24	62
82	Birmingham	AL	Stabbing	-86.854636	Race write perform it.	f	2021-07-16 01:12:46	55
83	Fargo	ND	Behavioral/Psychiatric	17.549097	Available pass cut one.	t	2021-12-24 08:17:27	89
84	Denver	CO	Gunshot Wound	140.924537	Protect yes actually raise general dream line down.	t	2021-09-01 01:27:21	59
85	Baltimore	MD	Cardiac arrest	-129.556227	Action adult operation fact level.	f	2021-07-11 11:25:39	74
86	Birmingham	AL	Seizure	78.919299	Ball likely east decision visit expect.	t	2021-06-27 17:29:44	55
87	Louisville	KY	Gunshot Wound	79.483787	Magazine arm Congress detail national gun charge.	t	2021-03-11 03:51:17	71
88	Detroit	MI	Respiratory distress	40.463390	Person trip education technology skin rule life five.	f	2021-05-27 14:59:01	76
89	Bridgeport	CT	Fight	169.949281	Physical food movie Republican.	f	2022-02-15 11:03:39	60
90	Des Moines	IA	Vehicle accident	79.744965	Address fund us challenge candidate.	t	2022-01-01 17:49:42	69
91	Providence	RI	Behavioral/Psychiatric	-168.341556	Something away offer single while family.	f	2021-04-09 10:24:10	93
92	New Orleans	LA	Behavioral/Psychiatric	8.543001	Suffer book conference authority lose.	f	2021-05-29 00:32:44	72
93	Louisville	KY	Seizure	57.448229	Energy officer data of able people.	f	2021-11-21 22:33:19	71
94	Los Angeles	CA	Traumatic Injury	-17.199702	Why agree system explain building.	t	2021-03-16 07:48:08	53
95	Philadelphia	PA	Seizure	162.437006	Argue take speech far bank tonight seat box.	t	2021-08-26 07:48:33	92
96	Portland	OR	Behavioral/Psychiatric	69.077145	Glass campaign meeting start teacher.	t	2022-03-06 17:01:39	73
97	Providence	RI	Vehicle accident	-174.035100	Involve number these indicate involve prepare.	f	2021-08-07 13:47:45	93
98	Billings	MT	Overdose	144.282755	Some money response other lead meeting several box.	t	2021-11-18 12:51:01	80
99	Birmingham	AL	Cardiac arrest	155.184482	Act play party.	f	2021-08-21 19:08:00	55
100	Milwaukee	WI	Cardiac arrest	25.093660	Particular sometimes life certain himself bill bag near.	f	2021-10-17 13:18:03	103
101	Salt Lake City	UT	Traumatic Injury	-161.050474	Remember chance wife hotel national number.	t	2021-07-16 12:12:18	99
102	Wichita	KS	Fight	-100.511968	Seem kind season hour.	f	2021-04-07 14:03:29	70
103	Wilmington	DE	Property Fire	-57.164774	Last truth save security bar soon use.	t	2021-12-31 02:41:55	61
104	Phoenix	AZ	Stabbing	156.056680	Make this author contain politics program themselves.	t	2022-03-01 04:35:37	57
105	Fargo	ND	Fight	96.893411	Reach live decision.	f	2021-09-14 16:31:22	89
107	Jackson	MS	Stabbing	-171.159245	Employee common Mrs candidate anything.	t	2021-11-19 20:12:19	78
108	Chicago	IL	Cardiac arrest	82.156612	Point itself picture spend position specific what.	f	2021-04-07 12:38:46	67
109	Charleston	WV	Overdose	-1.557488	Fast million suffer boy meeting pressure either.	f	2022-01-19 15:18:05	94
110	Manchester	NH	Seizure	-146.716147	Position quality their also.	t	2022-03-03 00:03:34	83
111	Cheyenne	WY	Bleeding	-61.775032	President himself read sea.	f	2021-08-03 00:46:57	104
112	Baltimore	MD	Vehicle accident	161.736496	Every third itself method mention watch here red.	f	2021-09-28 01:50:42	74
113	Providence	RI	Traumatic Injury	39.511099	Five miss eight loss news president.	f	2021-08-01 22:23:45	93
114	Charlotte	NC	Overdose	0.500592	Scientist scientist five know market ok.	f	2022-01-24 14:10:09	88
115	Charleston	WV	Overdose	11.823112	Reach only once itself.	f	2021-04-14 20:10:27	94
116	New Orleans	LA	Traumatic Injury	103.088715	Town strategy individual structure second throughout.	f	2021-06-14 12:57:38	72
117	Billings	MT	Gunshot Wound	-77.759208	Officer because door fact feeling job thus.	t	2022-02-03 20:24:19	80
118	Charlotte	NC	Traumatic Injury	-89.699524	Play expert stop itself red.	t	2021-08-12 23:10:08	88
119	Albuquerque	NM	Overdose	-28.313093	Goal capital alone several prepare.	f	2021-10-04 04:57:24	85
120	Buffalo	NY	Behavioral/Psychiatric	-172.633277	Across change energy federal far picture teach.	t	2021-07-26 12:46:56	87
121	Columbus	OH	Vehicle accident	-7.956986	Media science person cut class.	t	2021-12-13 07:26:34	90
122	Phoenix	AZ	Overdose	47.852028	Positive these boy try I interest.	t	2021-06-16 07:57:48	57
123	Cheyenne	WY	Gunshot Wound	-104.583781	Prove else oil attorney star tax forward.	t	2021-12-21 00:09:08	104
124	Indianapolis	IN	Gunshot Wound	-106.947919	Loss dream bank our rise.	t	2021-04-29 14:06:07	68
125	Columbus	OH	Stabbing	-66.569958	Yet he daughter chance.	f	2022-01-14 05:17:38	90
126	Kansas City	MO	Bleeding	45.109666	Know end think especially quality statement soon.	t	2022-01-02 18:21:48	79
127	Portland	OR	Traumatic Injury	57.760767	Stock soldier yet another act land.	f	2021-11-21 02:00:55	73
128	Milwaukee	WI	Cardiac arrest	168.496846	Meeting candidate manager century five finish matter her.	f	2021-07-14 10:23:04	103
129	Houston	TX	Gunshot Wound	-110.038947	Occur exactly expect often.	f	2021-04-17 21:40:40	97
130	Jacksonville	FL	Overdose	-80.796262	Also police spring tonight reflect.	t	2021-05-12 14:33:47	62
132	Denver	CO	Stabbing	18.584472	Drop measure mention expert my major rich.	f	2021-11-16 06:25:39	59
133	Manchester	NH	Behavioral/Psychiatric	48.242636	Agreement eight defense hope.	f	2021-03-10 20:51:47	83
134	Providence	RI	Vehicle accident	-99.297168	Budget any conference.	f	2021-08-05 20:21:21	93
135	Cheyenne	WY	Respiratory distress	-61.148326	Necessary local radio those exist factor fish.	f	2021-07-05 09:18:34	104
136	Jackson	MS	Seizure	73.983613	Decade center but foreign executive.	t	2021-11-22 05:15:26	78
137	Anchorage	AK	Traumatic Injury	-177.332466	Create through technology thousand laugh source adult.	f	2022-02-27 05:39:52	56
138	Boise	ID	Seizure	-74.101185	Specific ago manager something particularly dark.	f	2022-02-11 15:20:52	66
139	Albuquerque	NM	Stabbing	-9.868400	Expect base common possible.	f	2021-03-20 15:00:54	85
140	Seattle	WA	Property Fire	77.079321	Decade laugh would food wait art once.	t	2022-03-06 10:56:53	102
141	New Orleans	LA	Bleeding	98.671531	Effect receive trial nothing what.	t	2021-06-19 11:57:13	72
142	Fargo	ND	Traumatic Injury	132.455125	Decision where she item thus.	f	2021-07-07 07:09:08	89
143	Charleston	WV	Stabbing	-141.249817	Everybody certainly minute they.	t	2021-09-01 05:01:36	94
144	Austin	TX	Seizure	-124.018218	Pick go cell present nature paper interview.	f	2021-03-17 19:50:01	98
145	Billings	MT	Stabbing	-130.150020	Bar side air build set story word.	f	2021-06-09 13:25:18	80
146	Minneapolis	MN	Behavioral/Psychiatric	101.896742	Dinner Mrs artist.	t	2021-09-10 22:39:38	77
148	New York City	NY	Bleeding	0.417308	Left how mention effort paper individual evidence conference.	f	2022-02-07 05:57:14	86
149	Indianapolis	IN	Property Fire	-121.591519	Weight rather store suddenly speech visit himself.	t	2021-12-22 23:15:56	68
150	Denver	CO	Domestic Violence	-50.621311	Training if while bit green different project.	t	2021-04-07 19:38:04	59
151	Louisville	KY	Property Fire	8.505213	Collection find rock quickly.	t	2021-11-14 21:09:35	71
152	Milwaukee	WI	Stabbing	79.352780	Down star right doctor Mr board very.	f	2022-01-20 05:30:57	103
153	Charlotte	NC	Bleeding	36.419976	Become free around million wide indeed.	t	2021-04-03 05:50:12	88
154	Atlanta	GA	Respiratory distress	-119.051774	She produce few Mr either think theory.	f	2021-06-08 23:09:19	64
155	Charlotte	NC	Bleeding	-39.285401	Travel inside hair dream father leg beyond process.	f	2022-02-27 09:55:12	88
156	Boise	ID	Seizure	20.903830	Success relationship series natural.	t	2022-01-30 10:36:11	66
157	Anchorage	AK	Vehicle accident	20.520988	Ago upon to story campaign fear parent.	f	2022-02-28 21:51:13	56
158	New Orleans	LA	Gunshot Wound	-81.131012	Land find hope cup listen agency yeah.	t	2021-11-18 23:20:41	72
159	Bridgeport	CT	Traumatic Injury	139.738334	Indicate night land once eight.	f	2021-07-17 03:35:12	60
160	Chicago	IL	Bleeding	135.253884	Somebody nature still.	t	2022-02-21 23:24:57	67
161	Bridgeport	CT	Traumatic Injury	118.335194	Arrive year value join collection.	f	2021-12-20 08:23:03	60
162	Charleston	WV	Stabbing	136.791884	From long among wish factor including.	t	2021-12-13 08:22:58	94
163	Little Rock	AR	Overdose	73.916551	Including quality expect word despite.	t	2021-11-11 08:02:54	58
164	Fargo	ND	Domestic Violence	-164.496137	Few manage fire official exist.	t	2021-10-15 10:54:51	89
166	Detroit	MI	Bleeding	32.297565	Win mention run certainly.	t	2021-07-25 08:57:03	76
167	Boston	MA	Fight	-43.696250	Leader improve garden popular term herself ask.	t	2021-06-22 08:18:07	75
168	Albuquerque	NM	Fight	177.756778	Appear task learn region test difficult.	t	2021-04-07 10:07:37	85
169	Salt Lake City	UT	Bleeding	-178.895351	Article some information small my as woman.	f	2021-09-17 11:07:49	99
170	Detroit	MI	Overdose	-25.154747	Until although threat.	f	2021-06-07 09:11:58	76
171	Atlanta	GA	Vehicle accident	26.934866	Produce policy loss drop.	f	2021-09-14 06:21:26	64
172	Louisville	KY	Overdose	171.247762	Modern claim term everything.	t	2022-02-28 12:48:45	71
173	New York City	NY	Stabbing	44.309330	Eat girl inside.	f	2021-03-14 15:54:06	86
174	Charleston	WV	Respiratory distress	16.552545	Condition operation civil animal.	t	2021-04-02 17:58:26	94
175	Phoenix	AZ	Cardiac arrest	35.536551	Shake themselves build return player source fall.	f	2021-05-01 08:05:17	57
176	Omaha	NE	Cardiac arrest	-81.727208	Remain economic light room.	t	2021-07-31 19:48:26	81
177	Honolulu	HI	Gunshot Wound	84.111340	Short hard wish plan.	f	2021-05-03 04:46:18	65
178	Wilmington	DE	Traumatic Injury	106.808782	Until trip use born white sure.	f	2022-02-16 08:41:29	61
179	Portland	OR	Bleeding	-71.413032	Adult along answer arrive.	t	2022-01-10 21:28:24	73
180	Phoenix	AZ	Vehicle accident	69.169074	Thing walk cost somebody officer.	f	2021-08-30 06:42:13	57
181	Milwaukee	WI	Stabbing	-143.795209	Six step property although yet worry fast.	f	2021-07-25 18:33:42	103
183	Bridgeport	CT	Overdose	-133.857105	Second put hotel say business quite.	t	2022-01-14 17:35:45	60
184	Portland	OR	Gunshot Wound	-40.975774	Rich check study rate account allow.	f	2021-10-09 14:33:06	73
185	Little Rock	AR	Cardiac arrest	59.165026	Mission film ability with direction good.	f	2021-07-31 07:45:21	58
186	Buffalo	NY	Bleeding	-123.096632	Thing enter test sign hard hope course.	t	2021-12-19 20:35:33	87
187	Miami	FL	Overdose	-131.459282	Culture sell sea.	f	2021-06-22 23:02:43	63
188	Denver	CO	Behavioral/Psychiatric	55.227596	South value social that heavy.	f	2021-04-23 07:10:18	59
189	Baltimore	MD	Vehicle accident	-71.602259	Mother cost image scene finally be.	f	2022-02-25 01:56:33	74
190	Houston	TX	Seizure	66.046067	Admit ever accept yeah anyone require mention security.	t	2021-05-26 13:42:07	97
191	Portland	OR	Seizure	44.036250	Success member police pay because choice research.	f	2021-10-05 22:09:49	73
192	Columbus	OH	Cardiac arrest	142.833698	Year kitchen enter can game.	f	2022-02-03 02:15:54	90
193	Denver	CO	Fight	143.039889	So large state main themselves during education.	t	2021-09-11 00:26:54	59
194	Albuquerque	NM	Overdose	-52.850796	Community everyone present usually work quality difficult.	f	2022-02-22 02:39:56	85
195	Billings	MT	Cardiac arrest	26.496671	Draw likely could hand beautiful plan.	f	2021-06-27 13:55:23	80
196	Wichita	KS	Vehicle accident	72.842544	Coach want wide lay effect figure eye.	f	2022-01-11 20:31:49	70
197	Denver	CO	Domestic Violence	-62.585300	Answer spend street center marriage act.	t	2021-04-25 20:41:33	59
198	Indianapolis	IN	Traumatic Injury	-151.458331	Southern factor beat shake animal yeah billion adult.	f	2021-10-21 19:16:04	68
199	Milwaukee	WI	Respiratory distress	-39.445428	Walk item so matter half leave.	f	2022-02-15 18:51:03	103
200	Billings	MT	Domestic Violence	-96.158341	Dinner bar box its.	t	2021-05-24 22:09:22	80
202	Providence	RI	Fight	165.553357	Along president practice simple next minute.	t	2021-03-16 20:37:42	93
203	Phoenix	AZ	Traumatic Injury	-6.787131	Different visit maintain other drug toward.	t	2021-05-29 21:26:49	57
204	Boston	MA	Cardiac arrest	88.569378	Coach what audience decision mouth.	t	2021-11-03 00:03:38	75
205	Atlanta	GA	Cardiac arrest	-106.315336	To want already ahead continue whatever heavy.	t	2021-07-09 16:59:11	64
206	Providence	RI	Traumatic Injury	-85.036990	His standard from onto statement degree.	f	2021-05-26 01:52:47	93
208	Seattle	WA	Behavioral/Psychiatric	75.213795	Act interest television.	t	2021-03-13 16:24:10	102
209	Billings	MT	Domestic Violence	167.040448	Culture tax practice only anything hair.	t	2021-07-18 02:42:03	80
210	Louisville	KY	Vehicle accident	-178.613782	Grow any make off phone although lot.	f	2021-09-25 19:43:46	71
211	Birmingham	AL	Bleeding	-14.976004	Citizen yard eat series kind line foreign.	f	2022-02-24 21:48:37	55
212	Seattle	WA	Bleeding	66.544952	Wonder available few minute effort small.	f	2021-08-27 01:53:32	102
213	Oklahoma City	OK	Gunshot Wound	144.675354	President picture music if herself.	t	2021-08-19 16:01:36	91
214	Providence	RI	Cardiac arrest	106.683606	Painting away cultural usually.	f	2021-05-24 06:30:15	93
215	Burlington	VT	Respiratory distress	-57.918085	Audience third citizen agree past.	f	2021-11-06 16:45:10	100
216	Phoenix	AZ	Overdose	80.185465	Necessary interest kind drive TV bill rule.	f	2021-05-03 04:11:32	57
217	Little Rock	AR	Property Fire	88.031382	Compare early red firm read attorney new.	f	2022-03-07 15:06:34	58
219	Baltimore	MD	Stabbing	159.607886	Risk wind movie public generation window little she.	f	2022-03-08 17:20:14	74
220	Boston	MA	Seizure	163.585339	Four best design event.	t	2022-02-24 16:20:15	75
221	Wilmington	DE	Domestic Violence	-1.801465	Often police cold appear.	t	2021-09-27 08:04:35	61
222	Billings	MT	Cardiac arrest	-98.338497	Term parent type get guess light create.	t	2021-05-27 00:23:53	80
223	Buffalo	NY	Fight	-145.372110	Control news thought.	t	2021-04-17 15:40:20	87
224	Jackson	MS	Fight	-24.687343	Often daughter arrive customer.	t	2021-09-07 12:27:45	78
225	Jacksonville	FL	Respiratory distress	-177.640345	Series woman the including fill court.	t	2021-11-02 03:47:39	62
226	Portland	OR	Bleeding	-177.052248	Cause maybe fight laugh.	f	2021-12-26 10:41:40	73
227	Denver	CO	Overdose	-55.048681	Model top seek while work yard.	f	2021-05-21 12:16:52	59
228	Jacksonville	FL	Bleeding	121.043839	None born thus do.	t	2021-12-11 20:16:55	62
229	Milwaukee	WI	Stabbing	-43.624903	Term heart politics local bed.	f	2021-03-12 23:01:43	103
230	Louisville	KY	Traumatic Injury	-107.721338	Short teach movement class.	t	2022-02-26 03:55:47	71
231	Fargo	ND	Cardiac arrest	56.438037	Civil rise perform meeting no technology argue.	f	2021-04-29 14:20:20	89
232	Buffalo	NY	Fight	1.613137	Event issue issue field senior box our newspaper.	t	2021-12-29 23:22:12	87
233	Omaha	NE	Overdose	-159.104298	Interesting small eat.	t	2021-10-29 14:47:07	81
234	Wichita	KS	Vehicle accident	89.396779	Law himself perform key rule but nor.	t	2021-12-14 10:55:48	70
235	Chicago	IL	Stabbing	77.975559	Bit join there lead.	t	2021-07-31 15:39:03	67
236	Buffalo	NY	Seizure	173.086975	Sing first federal realize everyone television air.	t	2021-06-09 14:57:04	87
237	Newark	NJ	Vehicle accident	98.752952	Space lose strategy set win.	t	2021-05-13 14:53:48	84
238	Birmingham	AL	Overdose	39.369042	Week official eight like also.	f	2021-06-07 03:34:47	55
239	Birmingham	AL	Bleeding	-67.428586	Short ability assume produce.	t	2021-07-19 15:37:39	55
240	Buffalo	NY	Fight	151.957677	Strategy old ago factor he little.	f	2021-06-29 16:03:30	87
241	Nashville	TE	Domestic Violence	-77.289613	High nation share state ready.	t	2021-05-03 06:26:16	96
242	Indianapolis	IN	Cardiac arrest	31.920455	Carry garden she term smile go physical.	t	2021-08-26 18:10:19	68
244	Milwaukee	WI	Traumatic Injury	48.171777	Sometimes hotel world while.	f	2021-03-12 16:15:57	103
245	Newark	NJ	Behavioral/Psychiatric	-80.519069	Election subject ground mind.	f	2021-08-26 22:21:31	84
246	Philadelphia	PA	Fight	117.407793	Travel relationship however after against candidate.	t	2021-12-29 02:04:27	92
247	Wilmington	DE	Traumatic Injury	18.008711	Social idea practice may owner animal.	t	2021-12-18 16:09:36	61
248	Bridgeport	CT	Traumatic Injury	-8.462093	Dream history single.	t	2022-02-25 20:05:58	60
249	Chicago	IL	Seizure	130.968244	Table participant that stay recently recently ask.	t	2022-01-29 12:24:37	67
251	Jacksonville	FL	Cardiac arrest	161.364526	Friend red against throw site.	f	2021-04-16 07:13:15	62
252	Wilmington	DE	Traumatic Injury	-144.445536	Gun ahead certain participant media information sea.	t	2021-12-28 19:47:11	61
253	Jackson	MS	Vehicle accident	-165.737913	Always whole material happen democratic.	t	2021-04-27 06:50:19	78
254	Baltimore	MD	Overdose	132.447544	Heart perform year fear.	t	2021-09-04 18:30:23	74
255	Virginia Beach	VA	Overdose	146.217185	Use traditional front.	t	2021-07-07 08:34:48	101
256	Jacksonville	FL	Seizure	-6.411628	Their process build stay law attack.	t	2021-08-08 00:45:12	62
257	Columbus	OH	Overdose	39.271540	Drug understand ground marriage step like player.	t	2021-08-24 03:02:35	90
259	Portland	OR	Traumatic Injury	26.945173	Answer its then building bill dog energy seven.	f	2021-07-02 14:14:13	73
260	Bridgeport	CT	Fight	-48.437232	Stop attorney piece detail author type.	t	2022-02-11 07:19:12	60
261	Louisville	KY	Fight	2.226342	Note realize other.	f	2022-01-20 09:00:24	71
262	Milwaukee	WI	Domestic Violence	32.030510	Example specific itself fire town health.	f	2021-03-17 13:46:31	103
263	Providence	RI	Seizure	34.930183	Stay dark fill defense the it.	t	2021-10-20 23:00:29	93
264	Bridgeport	CT	Vehicle accident	58.897592	Air body light table us store rather rock.	f	2022-03-08 01:11:08	60
265	Los Angeles	CA	Seizure	-32.338354	Organization only pass visit own push for.	f	2021-04-14 18:26:44	53
266	Boise	ID	Overdose	111.145602	Interest quickly step record.	t	2021-06-04 00:15:58	66
267	Des Moines	IA	Cardiac arrest	26.889891	Of think quality.	t	2021-10-17 13:30:34	69
268	Indianapolis	IN	Vehicle accident	165.789570	Leader machine you officer.	t	2021-06-01 06:53:34	68
269	Omaha	NE	Respiratory distress	-112.740639	Usually seven exactly character pretty color finally.	t	2021-11-30 14:04:42	81
270	Virginia Beach	VA	Fight	-133.099797	Bring finish operation year the.	t	2021-11-28 12:12:40	101
271	Kansas City	MO	Cardiac arrest	-59.360992	Poor argue likely author citizen adult.	f	2021-05-09 13:16:13	79
272	Wilmington	DE	Stabbing	-47.368439	Idea make popular sometimes better reason.	t	2021-04-25 23:26:53	61
273	New York City	NY	Overdose	-65.518986	Ground hold year central only challenge.	f	2021-06-13 00:19:49	86
274	Sioux Falls	SD	Vehicle accident	-81.593387	Before writer weight despite.	f	2022-02-08 20:26:52	95
275	Chicago	IL	Gunshot Wound	102.263122	Ever finish among.	f	2022-02-18 01:42:18	67
276	Birmingham	AL	Cardiac arrest	-142.049894	Mind catch financial article.	f	2021-11-13 23:44:50	55
277	Providence	RI	Fight	-127.833736	Stage sell yard wrong.	t	2021-11-06 07:11:36	93
278	Indianapolis	IN	Behavioral/Psychiatric	60.885301	Tv task fast claim room.	t	2021-05-24 13:24:17	68
279	Kansas City	MO	Cardiac arrest	68.161658	Reveal teach media every paper.	f	2021-04-14 09:47:17	79
280	Chicago	IL	Domestic Violence	-83.735790	Bank television PM upon.	t	2021-07-05 11:34:32	67
281	Louisville	KY	Traumatic Injury	-16.012420	Pressure kitchen form catch that step forget.	t	2021-12-03 22:14:28	71
282	Denver	CO	Gunshot Wound	-46.910128	Discover mention huge indeed.	t	2021-06-17 11:19:22	59
283	Cheyenne	WY	Seizure	-115.321110	Station scientist woman clear.	f	2021-03-15 17:25:09	104
284	Detroit	MI	Seizure	-147.560950	Read let six career maybe wide light.	f	2021-07-26 10:14:06	76
285	Detroit	MI	Bleeding	-70.809569	Population boy possible project increase beautiful.	f	2021-12-24 21:34:17	76
286	Philadelphia	PA	Property Fire	-93.371208	Type safe back there have little.	t	2021-05-25 16:05:08	92
287	Sioux Falls	SD	Traumatic Injury	158.080411	May southern figure eye put training.	t	2022-02-07 01:52:28	95
288	Denver	CO	Stabbing	158.640391	I into feeling boy.	t	2021-04-10 01:39:16	59
289	Jackson	MS	Behavioral/Psychiatric	-145.104735	About himself sometimes knowledge others.	t	2021-11-06 04:50:58	78
290	Anchorage	AK	Fight	-33.756097	Apply series for society.	t	2021-04-17 04:36:28	56
291	Little Rock	AR	Domestic Violence	-10.348212	Hotel full fine bill magazine wait.	f	2022-02-27 08:02:29	58
292	Des Moines	IA	Fight	41.925973	Low power open design improve really.	f	2021-05-11 13:09:04	69
293	Bridgeport	CT	Bleeding	95.511373	First fly young better near plan.	f	2021-06-23 04:17:05	60
294	Burlington	VT	Seizure	-20.901698	Most enough various join trouble.	t	2021-11-09 18:06:52	100
295	Detroit	MI	Respiratory distress	-26.011899	Pick later whatever own.	f	2021-07-08 12:58:52	76
296	Miami	FL	Respiratory distress	-133.785437	Central bit tonight other bar themselves.	t	2021-03-11 06:55:06	63
297	Los Angeles	CA	Cardiac arrest	-70.367197	Ability science indicate thousand.	t	2021-04-12 03:40:39	53
298	Las Vegas	NV	Gunshot Wound	-157.027537	Worker enjoy recently every knowledge.	f	2021-10-31 12:26:30	82
299	Miami	FL	Cardiac arrest	65.473165	Far admit structure short suffer.	t	2022-01-05 17:50:57	63
300	Boise	ID	Traumatic Injury	-109.968391	Over gun they fast beautiful once while hot.	t	2021-11-20 13:46:40	66
301	Louisville	KY	Respiratory distress	57.528738	Next process make trade young environmental.	t	2021-05-26 20:26:40	71
302	Jacksonville	FL	Seizure	125.207291	War around else rule series.	f	2022-02-17 12:54:59	62
303	Buffalo	NY	Bleeding	-15.565980	Great water smile night put.	f	2022-01-30 04:39:08	87
304	Bridgeport	CT	Respiratory distress	111.696421	Surface bring dinner clear bank discuss.	t	2021-06-23 08:59:00	60
305	Sioux Falls	SD	Property Fire	102.252361	Thing term us various successful certain media necessary.	f	2021-08-16 14:00:57	95
306	Jacksonville	FL	Respiratory distress	-85.226610	Here reveal impact father true public would.	t	2021-10-13 20:16:16	62
308	Salt Lake City	UT	Vehicle accident	-36.980566	Various onto form number minute lawyer second.	t	2021-11-20 06:28:41	99
310	Oklahoma City	OK	Gunshot Wound	-131.844334	Nor population practice blood say.	f	2021-11-02 11:12:32	91
311	Fargo	ND	Vehicle accident	-167.139291	Treat low attorney author state third audience forward.	t	2021-07-28 11:21:37	89
312	Billings	MT	Seizure	-35.773193	Consider begin environmental again opportunity.	t	2022-01-10 09:17:04	80
313	Baltimore	MD	Respiratory distress	123.405617	Occur civil test simple message pass concern.	t	2021-08-16 21:35:14	74
314	Phoenix	AZ	Overdose	-10.250974	Wear finally son concern campaign memory.	t	2021-12-20 22:00:42	57
315	Philadelphia	PA	Property Fire	-27.650891	Available court sister word.	t	2021-11-19 23:45:38	92
316	Bridgeport	CT	Seizure	-170.977313	Ok understand entire exactly significant onto.	f	2021-04-08 14:05:14	60
318	Newark	NJ	Domestic Violence	145.772566	Nature true two.	f	2021-11-26 08:16:50	84
319	Fargo	ND	Vehicle accident	76.897255	Visit beautiful approach yeah.	t	2021-06-26 06:58:44	89
320	Miami	FL	Cardiac arrest	20.974249	Painting establish side and.	f	2021-11-25 09:24:22	63
321	Little Rock	AR	Domestic Violence	-70.008380	Five brother media produce.	f	2022-01-23 20:58:11	58
322	New York City	NY	Bleeding	35.939576	Case success method perhaps each.	t	2021-05-25 17:47:19	86
323	Seattle	WA	Cardiac arrest	-43.960052	Physical live fact loss rather.	t	2021-06-27 08:42:44	102
324	Philadelphia	PA	Traumatic Injury	119.095701	Note bill especially detail rock.	t	2021-04-08 08:16:52	92
325	Honolulu	HI	Domestic Violence	77.731887	Ability middle story soldier miss take site.	t	2021-12-06 15:27:55	65
326	Virginia Beach	VA	Overdose	69.457357	Them she cut air then method skin modern.	t	2021-04-27 06:48:28	101
327	Seattle	WA	Bleeding	-162.535688	Type thank five realize administration per.	t	2021-05-22 07:45:12	102
328	Kansas City	MO	Overdose	-138.993945	Smile such significant opportunity send what pass.	f	2021-03-20 11:43:01	79
329	Austin	TX	Overdose	-87.578746	Data institution federal staff professional.	f	2021-09-27 16:12:17	98
330	Burlington	VT	Overdose	-35.654065	Range thing shake full bag reach.	t	2022-02-19 03:12:32	100
331	Columbus	OH	Gunshot Wound	-86.392419	Must manager for yourself difference system first vote.	f	2021-09-24 19:33:54	90
332	Austin	TX	Traumatic Injury	17.711582	Everything born success tend over speak.	t	2021-03-29 07:50:38	98
333	Wichita	KS	Traumatic Injury	-125.743303	My green cause both similar mother.	t	2021-10-24 01:29:22	70
334	Little Rock	AR	Respiratory distress	-62.240753	Politics bag impact bring bill.	t	2021-08-29 00:41:22	58
335	Oklahoma City	OK	Overdose	37.764473	Establish my enough their.	f	2021-08-28 12:21:57	91
336	Boise	ID	Seizure	-125.883905	Son state participant wear friend clearly.	f	2022-02-14 09:38:07	66
337	Minneapolis	MN	Bleeding	-11.642514	Artist conference none office actually.	t	2021-09-22 20:09:14	77
338	Manchester	NH	Cardiac arrest	40.591894	Father ago manager fall whom.	t	2021-05-08 00:51:41	83
339	Billings	MT	Traumatic Injury	58.807910	Peace apply several.	f	2021-05-20 21:20:35	80
340	Milwaukee	WI	Domestic Violence	120.573888	Drive matter agency join more local still memory.	f	2021-08-02 17:42:15	103
341	San Francisco	CA	Behavioral/Psychiatric	32.297518	Authority staff significant.	t	2021-12-21 16:19:29	54
342	Phoenix	AZ	Seizure	7.636677	Mouth into Mrs happy you.	f	2021-06-24 17:42:39	57
343	Jacksonville	FL	Stabbing	-74.148530	Challenge entire loss one half kid high.	t	2021-09-09 15:27:17	62
344	Albuquerque	NM	Vehicle accident	-39.726614	Drive arm time professional.	f	2021-05-22 00:14:09	85
345	Philadelphia	PA	Overdose	13.890597	Mrs player growth political commercial former.	t	2021-03-27 22:35:24	92
346	Portland	OR	Fight	-144.068275	Large throw Congress forward sign year some.	t	2021-10-22 12:13:09	73
347	Jacksonville	FL	Vehicle accident	-142.307563	Than quality know name.	f	2022-02-20 20:18:41	62
348	Providence	RI	Overdose	-45.776144	Put let leave account support travel wife put.	f	2022-02-16 04:11:29	93
349	Billings	MT	Domestic Violence	-140.085689	Stock pattern doctor true purpose.	f	2021-09-03 10:42:02	80
350	Wichita	KS	Cardiac arrest	112.491773	Information poor after boy moment while against reveal.	f	2021-04-30 02:03:51	70
351	Cheyenne	WY	Overdose	83.272756	Once rise state in.	t	2021-05-21 12:15:52	104
352	Chicago	IL	Domestic Violence	-91.610620	Occur hear film trade.	t	2021-12-18 03:10:49	67
353	Austin	TX	Bleeding	117.592398	Government plant common manager.	t	2021-05-09 01:36:11	98
354	Denver	CO	Gunshot Wound	53.178629	Month system here.	f	2021-08-09 11:04:54	59
355	New Orleans	LA	Bleeding	46.554494	Before defense song make rather open.	f	2021-05-12 16:13:39	72
356	Newark	NJ	Gunshot Wound	-152.510785	Whatever administration fine against.	f	2021-12-09 10:12:59	84
357	Baltimore	MD	Domestic Violence	114.804068	Include physical party.	f	2021-10-22 01:39:45	74
358	Little Rock	AR	Bleeding	157.837155	Cover politics despite PM although.	t	2022-02-04 04:34:10	58
359	Miami	FL	Gunshot Wound	98.395676	Explain light all.	t	2022-01-07 23:04:58	63
360	Buffalo	NY	Vehicle accident	-28.733319	Home yourself adult various.	t	2021-07-02 12:43:02	87
361	Minneapolis	MN	Cardiac arrest	-41.594732	Would indeed where figure.	t	2021-03-18 08:04:23	77
363	Chicago	IL	Gunshot Wound	-103.991232	Executive shoulder home himself meeting him church.	f	2021-06-15 10:42:27	67
364	Louisville	KY	Respiratory distress	92.814864	Hold compare capital team technology while.	f	2021-08-31 04:37:15	71
365	Bridgeport	CT	Property Fire	73.490615	Quite think teach better answer.	t	2021-11-12 06:17:52	60
366	Chicago	IL	Respiratory distress	-116.227240	Protect glass budget open how call itself.	t	2021-12-30 02:09:34	67
367	Kansas City	MO	Bleeding	76.466785	Glass decade girl she campaign argue law.	f	2021-08-17 17:26:17	79
368	Wichita	KS	Seizure	160.869168	Decide artist capital discuss.	f	2022-02-13 21:19:34	70
369	Boston	MA	Property Fire	22.977289	Product game game together.	t	2021-11-13 09:14:38	75
370	Cheyenne	WY	Cardiac arrest	173.166766	Generation skill likely else beautiful management within.	t	2021-10-19 04:46:14	104
371	Wilmington	DE	Vehicle accident	171.777335	Election purpose question wrong degree near value.	f	2021-04-08 12:30:18	61
372	Philadelphia	PA	Fight	-42.805025	Senior child modern usually fly.	f	2021-11-11 10:56:15	92
373	Seattle	WA	Behavioral/Psychiatric	175.184480	Until lot avoid girl.	f	2021-03-29 20:14:27	102
374	Billings	MT	Fight	-2.395431	Who newspaper spend person would space us actually.	t	2021-12-18 02:44:01	80
375	New Orleans	LA	Vehicle accident	-158.239531	Hold yard discover lay however.	f	2021-10-20 10:37:34	72
376	Houston	TX	Respiratory distress	-57.405370	Police push common support society audience actually.	t	2021-12-09 14:13:48	97
377	Albuquerque	NM	Bleeding	165.930156	Us could popular president analysis loss glass stock.	f	2021-09-13 04:11:05	85
378	Portland	OR	Traumatic Injury	78.899048	Should manager it ready charge.	f	2021-08-14 18:05:37	73
379	Charlotte	NC	Property Fire	175.918199	Risk avoid ever close.	t	2021-04-02 10:41:32	88
380	Kansas City	MO	Overdose	-116.700580	Green skill long suggest.	f	2021-10-12 11:43:40	79
381	Salt Lake City	UT	Respiratory distress	-116.502294	Republican amount go list today future every service.	f	2021-10-21 02:21:48	99
382	Columbus	OH	Property Fire	-36.316246	Everybody community past how writer.	t	2021-03-28 07:46:56	90
383	Newark	NJ	Traumatic Injury	-106.036037	Effort vote without attorney.	f	2021-12-21 14:35:02	84
384	Birmingham	AL	Vehicle accident	-178.817375	Far item college fine one establish.	t	2021-07-14 01:11:51	55
385	Portland	OR	Bleeding	-49.585777	Truth member property represent often change them.	f	2021-05-04 18:30:11	73
386	Miami	FL	Stabbing	126.984691	Firm page much remain quality career local.	f	2021-11-19 04:44:04	63
387	Houston	TX	Gunshot Wound	-107.982520	During suffer nice young financial.	t	2022-01-03 03:15:46	97
388	Fargo	ND	Respiratory distress	40.310320	Result company receive at anything must.	f	2021-04-01 08:10:35	89
389	Seattle	WA	Overdose	-86.850527	Plan tree degree eat image argue imagine.	t	2022-01-03 15:41:40	102
390	Manchester	NH	Stabbing	-81.638347	Cultural only others participant baby money.	t	2021-10-26 07:50:59	83
391	Milwaukee	WI	Overdose	-71.557925	How for space because special.	t	2021-07-28 07:41:59	103
392	Philadelphia	PA	Seizure	-131.210913	Control painting lot fire bar could enjoy.	t	2021-08-20 14:18:59	92
393	Little Rock	AR	Traumatic Injury	-124.772558	Street chair financial may keep.	t	2022-01-05 12:42:40	58
394	Fargo	ND	Fight	-53.592808	Commercial a situation major benefit information head or.	t	2021-07-10 10:38:46	89
395	Manchester	NH	Behavioral/Psychiatric	67.600076	Upon clear quickly church radio state Mr office.	f	2022-01-27 02:52:54	83
396	Burlington	VT	Overdose	30.986258	Make property than break.	t	2021-12-14 12:32:34	100
397	Chicago	IL	Fight	47.120048	Scene expect suggest quickly success central time low.	f	2021-12-20 04:38:50	67
398	Miami	FL	Overdose	121.961443	Walk probably experience establish single true own see.	t	2021-10-06 12:32:42	63
399	Louisville	KY	Domestic Violence	36.627782	Tend grow thank alone more.	t	2021-09-23 22:07:21	71
400	Little Rock	AR	Domestic Violence	-19.415245	Politics begin else.	t	2021-10-18 08:48:27	58
401	Bridgeport	CT	Behavioral/Psychiatric	24.908540	Especially around top film water still bit.	f	2021-10-22 05:48:39	60
402	Des Moines	IA	Property Fire	-164.464094	Book blue different.	t	2022-02-27 00:20:40	69
403	Oklahoma City	OK	Property Fire	-112.428554	These window increase pass onto.	t	2021-10-30 02:46:48	91
406	Minneapolis	MN	Seizure	-115.410670	West may shoulder enter state peace every.	t	2021-04-22 05:52:48	77
408	Nashville	TE	Respiratory distress	-22.178299	New attention dog first.	f	2021-03-23 20:35:24	96
409	Atlanta	GA	Stabbing	-138.657761	Red down room many beyond newspaper music.	f	2022-01-07 00:16:43	64
410	Little Rock	AR	Seizure	-25.977112	Hospital me article movement human reality.	t	2021-09-16 21:14:43	58
411	Charleston	WV	Behavioral/Psychiatric	-45.470152	Difficult wall new prepare put money nothing still.	t	2021-12-15 06:30:46	94
412	Boston	MA	Cardiac arrest	-114.631488	Good music interesting with.	t	2021-11-18 18:08:53	75
413	Wichita	KS	Vehicle accident	-108.175619	Group question why officer true start conference.	t	2022-03-07 20:49:01	70
414	Buffalo	NY	Domestic Violence	111.077398	Avoid TV employee yeah play laugh.	t	2021-08-12 22:28:16	87
415	Baltimore	MD	Seizure	32.138242	Term enter moment participant dinner form tend.	f	2022-01-19 12:41:04	74
416	Philadelphia	PA	Overdose	-96.143872	Walk picture ago their.	t	2021-09-29 16:04:36	92
417	Columbus	OH	Bleeding	-29.487235	Appear grow both fine catch middle speech.	f	2021-12-06 10:15:04	90
418	Houston	TX	Behavioral/Psychiatric	31.291279	Different short run consumer rich knowledge.	t	2021-04-14 02:12:21	97
419	Omaha	NE	Property Fire	-93.673981	Nice course down what.	t	2021-10-18 06:30:08	81
420	Fargo	ND	Seizure	-160.063980	Morning pick involve soon talk defense.	f	2021-10-26 10:33:53	89
421	Des Moines	IA	Traumatic Injury	88.017233	Ready nearly while full dinner charge.	f	2021-07-02 12:23:02	69
422	San Francisco	CA	Fight	104.246097	Thing at middle always commercial.	f	2021-05-08 03:45:42	54
423	Virginia Beach	VA	Seizure	64.523750	That arrive cost consumer hope.	t	2021-06-11 21:05:05	101
424	Boston	MA	Bleeding	-166.636609	Successful information term moment far somebody work.	t	2021-08-23 13:14:18	75
425	Minneapolis	MN	Gunshot Wound	53.836781	Tax someone new water.	f	2021-09-24 21:14:18	77
426	Atlanta	GA	Gunshot Wound	164.807994	Fall follow year tonight.	t	2021-11-04 08:10:19	64
427	Louisville	KY	Gunshot Wound	133.755750	Wrong law accept boy enjoy.	t	2021-06-05 11:57:54	71
428	Albuquerque	NM	Overdose	105.705853	Road still how each right.	f	2021-03-25 09:30:52	85
429	Baltimore	MD	Gunshot Wound	80.449877	Possible none activity sound.	t	2022-02-27 12:50:37	74
430	Wilmington	DE	Seizure	-44.965786	Art right bit job threat two.	f	2021-06-29 14:42:25	61
431	Burlington	VT	Seizure	-49.649150	Likely beyond certain consumer certainly this student.	f	2021-04-26 21:07:30	100
432	Buffalo	NY	Fight	-120.609156	Common return guy send.	t	2021-11-14 17:53:09	87
433	Portland	OR	Cardiac arrest	-87.373482	Station along group where traditional me run.	f	2021-04-13 03:19:18	73
434	Des Moines	IA	Bleeding	-119.278647	Chance most model black race.	t	2022-02-11 16:42:36	69
436	Seattle	WA	Gunshot Wound	-162.360767	Learn human threat region pattern.	f	2021-07-21 04:10:37	102
437	Philadelphia	PA	Bleeding	-90.879001	Herself sense family nor leader total nice.	t	2021-11-16 03:57:57	92
438	Salt Lake City	UT	Behavioral/Psychiatric	8.649742	Weight him field floor politics stay particularly audience.	t	2022-01-19 08:25:58	99
439	Anchorage	AK	Cardiac arrest	127.503593	Notice with five collection expect source.	t	2021-10-10 06:35:25	56
440	Billings	MT	Behavioral/Psychiatric	87.723107	Management new cost set wrong.	t	2022-01-28 08:44:38	80
441	Jacksonville	FL	Fight	-146.029397	Official work thing just nearly around.	f	2021-07-21 20:34:11	62
442	Nashville	TE	Respiratory distress	35.477623	Whatever thought school movement program among spring.	t	2021-11-13 11:15:38	96
443	Wichita	KS	Stabbing	-119.173111	Hot forget section process prepare plant.	f	2021-07-21 19:30:45	70
444	Philadelphia	PA	Bleeding	108.587762	Cut go administration.	f	2021-04-12 19:11:25	92
446	Milwaukee	WI	Stabbing	83.464822	Fine meet coach trip drop.	f	2021-05-23 19:34:47	103
448	Wichita	KS	Respiratory distress	74.857794	They best unit including.	t	2021-09-20 23:53:24	70
449	Des Moines	IA	Traumatic Injury	-92.880491	Land might spring eat matter contain instead.	t	2021-10-30 16:27:34	69
450	New York City	NY	Bleeding	-89.370409	Single exist hear occur project investment name.	t	2021-03-12 08:56:59	86
451	Cheyenne	WY	Property Fire	-70.537017	Person increase tax or offer.	f	2021-10-20 14:40:46	104
452	New York City	NY	Seizure	149.455167	Level happen many training paper must.	t	2021-05-22 19:17:38	86
453	Newark	NJ	Cardiac arrest	-67.561370	Ago base other from.	t	2021-05-27 18:39:04	84
454	Atlanta	GA	Gunshot Wound	-166.718993	Major own of figure.	t	2021-04-14 17:02:24	64
455	Honolulu	HI	Stabbing	-49.764411	People any article specific rise crime.	f	2021-06-22 22:41:57	65
456	Charleston	WV	Overdose	25.910296	Nor more assume four on father easy create.	t	2021-11-20 19:31:29	94
457	Salt Lake City	UT	Respiratory distress	-62.588863	Who no consumer.	t	2022-02-23 03:04:03	99
458	Albuquerque	NM	Behavioral/Psychiatric	64.782250	Tax note south available building.	t	2021-08-06 21:20:05	85
460	Sioux Falls	SD	Bleeding	-1.848052	Process few many bed.	t	2021-12-31 16:25:43	95
462	Fargo	ND	Respiratory distress	131.535693	Both lose minute.	f	2021-11-12 07:01:17	89
463	New York City	NY	Gunshot Wound	19.883261	Apply assume television staff cost agency agency election.	f	2021-11-03 02:20:56	86
464	Bridgeport	CT	Vehicle accident	-78.529455	Less high hit writer attention figure future relationship.	f	2021-09-08 20:29:39	60
465	Virginia Beach	VA	Cardiac arrest	121.781752	Write big owner nice.	f	2021-09-06 06:49:21	101
466	New Orleans	LA	Traumatic Injury	-108.566899	Former work our watch interest opportunity add.	f	2021-07-07 22:26:35	72
467	Fargo	ND	Overdose	-47.162941	Out actually us relationship through president.	f	2021-12-16 03:38:08	89
468	New Orleans	LA	Respiratory distress	-22.182936	Century meeting live cell.	f	2021-10-07 02:41:24	72
469	Buffalo	NY	Behavioral/Psychiatric	61.705938	Daughter behavior own fast.	f	2021-11-05 22:04:22	87
470	Houston	TX	Domestic Violence	10.496977	Although source method son trip car whose.	f	2021-05-26 11:19:29	97
471	Charlotte	NC	Cardiac arrest	46.643597	Read for card everything.	f	2021-04-06 07:12:05	88
472	Oklahoma City	OK	Stabbing	-33.026379	Civil trade huge.	f	2021-03-31 04:12:41	91
473	Sioux Falls	SD	Domestic Violence	-65.302206	Economic fish yet environmental black push live.	f	2021-11-18 17:57:32	95
474	Sioux Falls	SD	Gunshot Wound	-150.239690	Lot imagine control list.	f	2021-05-17 23:22:58	95
475	Bridgeport	CT	Property Fire	-34.409572	Base if piece within public.	t	2021-06-15 01:00:59	60
476	Houston	TX	Traumatic Injury	76.336924	Friend also realize someone represent at expect hope.	f	2022-01-06 04:22:22	97
477	Seattle	WA	Traumatic Injury	-112.452657	Since important beyond sure daughter hit.	t	2021-12-13 05:17:01	102
480	Boston	MA	Domestic Violence	67.280083	Beat start really bad person.	t	2021-05-30 21:24:11	75
481	Anchorage	AK	Stabbing	-59.862384	Similar want fast outside occur under.	f	2021-12-27 00:54:52	56
482	Wichita	KS	Property Fire	20.307406	Order air body.	t	2021-06-14 08:28:48	70
483	Philadelphia	PA	Fight	-121.036203	Actually pay agreement hope show young through.	t	2021-07-25 08:47:04	92
484	Boston	MA	Gunshot Wound	-138.755678	Him term already significant exactly week store.	t	2021-03-22 06:56:36	75
485	Omaha	NE	Seizure	65.858483	Alone item it wonder woman nation.	f	2021-08-12 05:27:20	81
486	Bridgeport	CT	Bleeding	45.282671	Give woman should local.	t	2021-07-14 22:46:58	60
487	Billings	MT	Vehicle accident	-102.800168	Official official Republican.	t	2021-05-15 12:49:26	80
488	Newark	NJ	Domestic Violence	132.939401	Man boy buy smile.	t	2021-09-27 22:37:16	84
489	Fargo	ND	Stabbing	-87.271298	Him catch hand rule style.	f	2021-10-17 17:02:55	89
490	Newark	NJ	Fight	-116.187815	Recently research improve back.	t	2021-07-28 14:52:15	84
491	Austin	TX	Cardiac arrest	4.402897	Star personal else various without certainly.	f	2021-09-09 15:13:36	98
492	Louisville	KY	Behavioral/Psychiatric	164.873323	Technology matter data accept.	t	2021-03-15 09:15:36	71
493	Houston	TX	Behavioral/Psychiatric	86.460119	Two environmental prove but now gas.	f	2022-02-11 22:21:06	97
494	Atlanta	GA	Respiratory distress	-29.834755	President less will the might up.	f	2022-02-20 23:03:58	64
495	Nashville	TE	Gunshot Wound	-169.497389	Raise about move everyone TV nor gun.	t	2021-11-10 18:28:48	96
496	New Orleans	LA	Stabbing	77.606170	Explain within interesting at green subject.	f	2021-12-24 03:25:09	72
497	Boston	MA	Bleeding	-58.418421	Radio budget purpose order reason huge officer provide.	t	2021-09-26 13:55:42	75
498	Burlington	VT	Seizure	153.255562	Law space staff entire yeah.	f	2021-11-03 15:01:10	100
499	Nashville	TE	Gunshot Wound	-119.787933	Turn treatment pressure amount.	f	2021-12-11 12:32:59	96
500	Kansas City	MO	Domestic Violence	-172.261909	Tax trial eight choice before.	t	2022-01-10 15:33:36	79
501	Atlanta	GA	Stabbing	91.174137	Maybe speech must by food majority job.	t	2022-01-05 14:49:10	64
502	New York City	NY	Overdose	-95.484811	Fine specific night full center.	t	2021-11-26 20:01:51	86
504	Minneapolis	MN	Traumatic Injury	-105.633220	Reflect ago very.	f	2022-03-02 19:46:30	77
505	Seattle	WA	Fight	-104.176714	Newspaper send money pretty simple my like.	f	2021-05-20 07:35:40	102
507	Baltimore	MD	Overdose	96.188783	Although have including tell.	t	2021-12-08 11:42:40	74
508	Oklahoma City	OK	Respiratory distress	26.687872	Not pattern newspaper strong activity.	t	2021-09-12 19:00:36	91
509	Oklahoma City	OK	Bleeding	-52.866266	Direction explain or same people either.	f	2021-11-28 11:53:10	91
510	Albuquerque	NM	Domestic Violence	-123.479335	Father back seek once family.	f	2021-11-11 14:31:38	85
511	Albuquerque	NM	Overdose	16.349896	Especially true consider exist.	f	2021-11-18 23:42:25	85
512	Little Rock	AR	Seizure	160.569842	Increase professional American another floor.	f	2021-12-20 03:55:26	58
513	Charleston	WV	Cardiac arrest	24.702275	Eye fund account Mrs someone however perhaps.	t	2021-03-18 04:24:38	94
514	Austin	TX	Fight	8.448204	Since off say.	t	2021-05-12 21:49:11	98
516	Virginia Beach	VA	Seizure	-17.803404	Drive interview enter fill best local star far.	f	2021-03-29 05:10:47	101
517	Minneapolis	MN	Vehicle accident	115.476261	Relationship drop bag black husband.	f	2022-01-14 12:12:56	77
518	Burlington	VT	Gunshot Wound	67.832438	Air manager decide can act deep station.	t	2021-03-25 08:37:15	100
519	Wichita	KS	Bleeding	-98.954883	Task discover between concern fund science total open.	t	2021-08-13 07:24:08	70
520	Nashville	TE	Stabbing	143.966188	Fill own soldier when coach medical.	f	2021-04-11 18:59:41	96
521	Las Vegas	NV	Behavioral/Psychiatric	141.514961	Discover expert either approach week community.	f	2021-06-03 22:36:46	82
522	Buffalo	NY	Bleeding	131.880855	Court education old southern far their.	f	2022-02-27 13:44:46	87
523	Sioux Falls	SD	Stabbing	152.765100	Race like door bring.	t	2021-07-14 00:45:18	95
524	Sioux Falls	SD	Cardiac arrest	121.176038	Story thought stuff start until wait book.	t	2021-08-26 00:58:48	95
525	Houston	TX	Traumatic Injury	-70.495388	Decision whole third authority find necessary.	t	2021-09-09 22:35:13	97
526	Des Moines	IA	Domestic Violence	-153.142898	Fish organization service.	t	2021-03-28 02:19:05	69
527	Manchester	NH	Overdose	62.886711	Onto nice it forget level politics determine.	t	2021-09-10 02:43:46	83
528	Philadelphia	PA	Fight	-170.423075	Worker only interesting subject still than.	t	2021-05-05 12:38:46	92
529	Anchorage	AK	Fight	-149.537469	Human name peace opportunity knowledge write cause.	f	2021-07-17 16:20:37	56
530	Las Vegas	NV	Gunshot Wound	-74.673083	Toward smile mention argue nothing politics already indicate.	f	2021-09-02 09:24:30	82
531	Cheyenne	WY	Gunshot Wound	38.097232	Chair night build claim health item.	f	2021-11-04 11:37:58	104
532	Indianapolis	IN	Seizure	-163.463127	Sit plant according nation memory tell present.	t	2021-12-17 13:57:22	68
533	Jacksonville	FL	Behavioral/Psychiatric	102.054508	Lot grow government.	f	2021-06-03 16:41:41	62
535	Billings	MT	Behavioral/Psychiatric	-44.361231	Study free activity control.	f	2021-10-22 10:59:52	80
536	Anchorage	AK	Property Fire	-168.934325	Affect suffer interest.	t	2021-11-05 19:17:09	56
537	Detroit	MI	Respiratory distress	77.863573	Issue role hear director when us.	t	2021-04-22 13:22:32	76
538	Las Vegas	NV	Fight	4.452539	Common have realize may control.	t	2021-03-10 11:52:48	82
539	Boston	MA	Vehicle accident	-81.920939	Couple two draw but choose six.	f	2021-06-27 08:58:41	75
540	Burlington	VT	Vehicle accident	84.765625	Certainly fire sea focus movie might.	f	2022-01-24 20:59:14	100
541	Salt Lake City	UT	Domestic Violence	-123.492217	Its still remember possible mouth thing wall their.	f	2021-06-24 18:14:06	99
542	Newark	NJ	Bleeding	-127.133970	Such measure cup than.	t	2021-12-23 08:10:13	84
543	Birmingham	AL	Domestic Violence	-93.819788	Business call full sell despite.	f	2021-04-24 23:32:54	55
544	Des Moines	IA	Traumatic Injury	-113.928063	Music value increase practice state rest senior despite.	t	2021-06-02 18:17:31	69
545	Anchorage	AK	Traumatic Injury	132.230992	Difficult movie task authority business ask keep.	f	2021-12-13 09:49:38	56
546	Virginia Beach	VA	Stabbing	-122.206311	Woman three effort white national pass whole large.	f	2022-02-23 04:15:39	101
547	Jackson	MS	Gunshot Wound	117.420660	Daughter sense since data future serious.	t	2021-05-07 08:04:29	78
548	Milwaukee	WI	Domestic Violence	149.938608	Fact order wall beautiful reveal.	t	2021-07-30 00:34:03	103
549	Buffalo	NY	Overdose	69.307072	Drop put daughter human finally once similar see.	t	2021-05-15 06:40:04	87
550	Burlington	VT	Cardiac arrest	32.382602	Everyone nature step a top.	t	2021-08-19 06:12:50	100
551	Houston	TX	Respiratory distress	-150.559231	Gun amount maintain too.	f	2021-07-22 16:58:50	97
552	Louisville	KY	Bleeding	-179.754688	Morning clear any yet anything agree late.	f	2022-01-30 08:47:13	71
553	Austin	TX	Respiratory distress	25.046232	Especially police court industry.	f	2021-09-17 23:16:27	98
554	Philadelphia	PA	Behavioral/Psychiatric	-83.009491	Rock bag force question.	f	2021-12-13 16:58:23	92
555	Philadelphia	PA	Domestic Violence	-0.811819	Movie fall issue.	f	2021-06-18 06:27:47	92
557	Little Rock	AR	Seizure	77.548021	Teacher war whether few way.	t	2021-05-04 06:51:16	58
558	Jackson	MS	Fight	123.732558	Laugh project land may today include company.	f	2021-09-13 05:27:59	78
559	Virginia Beach	VA	Fight	-171.395680	Past organization ok major five yourself.	t	2021-03-14 04:40:55	101
560	Miami	FL	Cardiac arrest	133.368255	List after share.	f	2021-10-25 09:14:45	63
561	Charlotte	NC	Respiratory distress	75.991781	Ago you five standard collection what truth true.	t	2021-06-28 05:50:45	88
562	Newark	NJ	Bleeding	-20.529059	Particular candidate yet would book alone fall.	f	2022-01-16 22:24:43	84
563	Las Vegas	NV	Domestic Violence	152.796784	Stand perhaps war.	t	2021-04-25 17:53:24	82
564	Kansas City	MO	Behavioral/Psychiatric	-67.057847	Recognize forget born medical.	t	2021-07-22 01:41:39	79
565	Boston	MA	Fight	57.224998	A amount future them way fall her.	t	2021-09-29 16:18:21	75
566	Cheyenne	WY	Seizure	-166.667448	Attention husband everyone nation.	f	2021-12-26 06:30:58	104
567	Providence	RI	Seizure	-96.444828	City painting thousand provide.	t	2021-04-08 06:47:35	93
568	Honolulu	HI	Cardiac arrest	-24.854144	Himself coach successful similar be test.	f	2022-01-08 21:51:39	65
569	Louisville	KY	Vehicle accident	-149.029849	However industry describe action.	t	2022-01-12 03:43:00	71
570	Burlington	VT	Seizure	174.687755	Until generation share hundred government.	t	2021-12-14 09:03:59	100
571	Louisville	KY	Fight	-130.735688	Group establish picture world.	t	2022-01-28 05:56:26	71
572	Las Vegas	NV	Gunshot Wound	-173.759739	Put per young four deal serious.	t	2021-05-19 16:59:16	82
573	Indianapolis	IN	Fight	-37.620894	Federal recently likely because majority pick character social.	t	2021-07-25 09:16:15	68
574	Buffalo	NY	Cardiac arrest	82.646067	Final special production campaign maintain change trade.	f	2022-01-04 04:16:06	87
575	Boston	MA	Fight	10.639779	Coach word walk appear deep difference interview.	t	2021-09-28 12:33:04	75
576	Portland	OR	Cardiac arrest	165.951846	Probably politics performance season accept.	f	2021-08-22 01:31:52	73
577	Baltimore	MD	Behavioral/Psychiatric	28.139459	Fight head kind I by.	f	2021-08-04 18:07:55	74
578	Austin	TX	Overdose	-20.905424	Light card evidence father.	f	2021-07-03 18:55:07	98
579	Columbus	OH	Stabbing	-140.489231	Require upon tree watch.	f	2021-09-01 00:37:34	90
580	Buffalo	NY	Bleeding	-32.423171	Draw space mind phone follow.	t	2022-02-11 16:57:24	87
581	New Orleans	LA	Overdose	36.828723	Wear exactly from economic could pattern break sing.	f	2022-01-22 14:41:38	72
582	Wichita	KS	Fight	48.130410	Main probably reveal answer brother common attack.	f	2021-05-23 18:33:55	70
583	Buffalo	NY	Respiratory distress	-103.921842	Part thing draw resource material pay.	f	2021-07-03 09:27:58	87
584	Omaha	NE	Stabbing	-24.132325	Mention language owner discuss shoulder.	f	2021-10-03 09:07:57	81
586	Honolulu	HI	Stabbing	-107.430814	Finally form what radio land artist avoid charge.	t	2021-10-03 02:33:49	65
587	Billings	MT	Fight	129.035303	Hope even local high organization everybody drop people.	t	2021-11-24 04:16:31	80
588	Birmingham	AL	Fight	43.212018	Number hand since offer.	f	2021-11-18 17:49:47	55
589	Charleston	WV	Bleeding	100.481090	Hot agency various establish together.	t	2021-05-31 05:55:59	94
590	Boise	ID	Bleeding	44.993949	She cup industry society thousand.	t	2022-01-27 06:42:17	66
591	Newark	NJ	Fight	18.349670	Different yet issue dinner.	f	2021-06-19 11:52:35	84
592	Des Moines	IA	Overdose	-49.614113	Left question we message partner.	f	2022-01-14 16:36:32	69
594	Nashville	TE	Vehicle accident	-6.749502	Present decision wait full another not degree.	f	2021-08-10 17:12:52	96
595	Seattle	WA	Stabbing	49.874997	Sister month get impact peace.	t	2021-07-21 15:45:33	102
596	New York City	NY	Gunshot Wound	137.954763	Network research current state responsibility.	f	2022-02-15 00:37:55	86
597	Charlotte	NC	Fight	-169.644698	Morning some however huge.	t	2021-11-04 12:56:44	88
599	Minneapolis	MN	Traumatic Injury	55.141338	Address several mind.	t	2021-08-13 13:52:00	77
600	Kansas City	MO	Seizure	-140.672942	Water quality news increase little behavior bar.	f	2021-11-02 01:08:26	79
601	Des Moines	IA	Respiratory distress	-53.808406	News another next nation.	f	2021-12-30 15:18:51	69
602	Jacksonville	FL	Vehicle accident	170.442015	Trade where organization simple house save.	t	2021-06-20 20:46:20	62
603	Newark	NJ	Bleeding	106.706391	Traditional strong leave still.	f	2021-10-04 17:47:21	84
604	Philadelphia	PA	Bleeding	13.462073	Check institution writer Republican course.	f	2021-09-12 17:06:39	92
605	Houston	TX	Traumatic Injury	73.969999	Opportunity sing think how population executive reduce least.	t	2021-04-13 15:26:58	97
606	Boston	MA	Stabbing	-60.838152	Hope many whose especially economic its.	t	2021-08-18 00:49:51	75
607	Salt Lake City	UT	Bleeding	-127.877952	First fall property few lay.	f	2021-11-01 06:11:56	99
608	Manchester	NH	Property Fire	-117.314994	Wait choice last general game dark.	t	2021-08-13 11:21:55	83
609	Fargo	ND	Cardiac arrest	-29.317982	Since team situation detail here.	t	2021-06-20 17:35:00	89
610	Charlotte	NC	Vehicle accident	87.837950	Present especially state reflect girl mouth.	t	2021-03-19 01:44:18	88
611	Baltimore	MD	Fight	-75.030531	Section manager name enter.	t	2021-08-04 22:50:25	74
612	Providence	RI	Property Fire	110.194014	Model occur wish skill.	f	2021-12-20 19:46:50	93
613	Philadelphia	PA	Cardiac arrest	54.961129	Can also bad south security piece probably.	t	2021-04-30 02:00:49	92
614	San Francisco	CA	Seizure	-64.439184	Card paper require cause operation whom explain.	t	2021-10-29 18:49:50	54
615	Charlotte	NC	Bleeding	-63.196792	Of spring many final practice kind together.	t	2022-02-10 23:44:17	88
616	Buffalo	NY	Stabbing	81.579552	His father carry level.	f	2022-02-01 05:59:23	87
618	Little Rock	AR	Respiratory distress	53.992437	Increase effort ten man animal room.	f	2021-11-24 20:54:36	58
619	Houston	TX	Respiratory distress	13.541362	Finish not everybody charge time.	f	2021-05-04 03:07:04	97
620	Columbus	OH	Property Fire	-2.929983	Line executive somebody item.	t	2021-04-14 06:35:57	90
621	Buffalo	NY	Gunshot Wound	47.450252	Performance he notice military economy be guess.	f	2021-09-26 03:47:55	87
622	Charlotte	NC	Respiratory distress	-71.237850	Own source push.	t	2021-10-25 14:56:42	88
623	New Orleans	LA	Behavioral/Psychiatric	151.504152	Play social specific share until thing baby.	f	2021-11-02 02:33:59	72
624	Salt Lake City	UT	Traumatic Injury	90.951337	Sell imagine toward method who choose use.	t	2021-03-18 11:35:34	99
625	Portland	OR	Overdose	-144.857206	Send recognize notice least style.	t	2021-05-24 13:24:19	73
626	San Francisco	CA	Respiratory distress	-41.999128	Garden arm not culture usually.	t	2021-08-28 06:33:20	54
627	Houston	TX	Respiratory distress	-174.217408	Least father national.	t	2021-09-29 13:22:06	97
628	Little Rock	AR	Cardiac arrest	137.455779	Rate deal serious pay last.	f	2021-08-13 22:55:20	58
629	Buffalo	NY	Seizure	178.911366	Treatment law stage project heart.	f	2022-03-10 04:59:53	87
631	Phoenix	AZ	Property Fire	-162.825806	More believe gas side strategy growth.	t	2021-08-06 15:40:55	57
632	Philadelphia	PA	Gunshot Wound	-51.090039	Beat usually unit themselves mention mean blue.	f	2021-09-04 18:53:02	92
633	Jacksonville	FL	Vehicle accident	-27.406973	Should than top.	f	2021-11-13 20:53:57	62
634	Columbus	OH	Respiratory distress	-124.151594	Interest yard time body happy base.	t	2021-09-17 15:36:50	90
635	Virginia Beach	VA	Traumatic Injury	-150.218026	Ability toward down floor of land.	f	2021-12-18 10:26:27	101
636	Honolulu	HI	Domestic Violence	144.713342	North between home way imagine edge book there.	t	2022-02-21 01:07:55	65
637	Sioux Falls	SD	Behavioral/Psychiatric	60.853595	Several whether attorney parent certainly heavy use.	f	2021-10-21 05:52:28	95
638	Wichita	KS	Domestic Violence	-55.030196	Wish day return nice option anything.	t	2021-06-08 15:56:41	70
639	Little Rock	AR	Gunshot Wound	21.031116	Issue hope weight capital board should every.	t	2021-09-24 21:41:20	58
640	Denver	CO	Gunshot Wound	21.012982	Head guess happen choose significant capital.	t	2021-09-28 05:02:30	59
641	Des Moines	IA	Vehicle accident	-3.011354	Popular whatever debate care this subject.	t	2022-03-07 13:02:10	69
642	Manchester	NH	Cardiac arrest	136.986019	Thousand plan travel.	t	2021-07-21 12:27:03	83
643	Manchester	NH	Property Fire	118.043866	National skin cause without cause beyond.	f	2021-07-01 10:50:15	83
644	Detroit	MI	Cardiac arrest	-167.643892	None truth nice just tell bad.	f	2021-04-10 16:20:36	76
645	Louisville	KY	Cardiac arrest	-172.324459	Low here beyond mean happy.	t	2021-03-24 00:22:25	71
646	Houston	TX	Cardiac arrest	164.053744	Black cultural claim marriage seek down old perform.	t	2021-05-03 05:13:58	97
647	Honolulu	HI	Fight	145.161900	Drop individual show stock hour majority.	t	2021-06-04 05:43:16	65
648	Wilmington	DE	Behavioral/Psychiatric	-26.436997	Design pay hundred begin from almost.	t	2022-01-31 14:57:28	61
649	Las Vegas	NV	Traumatic Injury	-144.444982	Learn wind happen news.	f	2021-06-26 09:22:49	82
650	Detroit	MI	Domestic Violence	142.345029	Decide industry design rich me difficult poor.	f	2021-06-07 19:19:55	76
651	Wichita	KS	Seizure	72.240348	Ground environment nearly threat table environmental.	t	2021-11-27 02:26:54	70
652	Wilmington	DE	Overdose	147.432463	Old threat crime ground.	f	2021-08-08 15:08:08	61
653	Charlotte	NC	Cardiac arrest	-93.840822	Ready sing wife instead would tax.	t	2022-01-09 10:11:16	88
654	Honolulu	HI	Stabbing	-114.802865	Of civil friend option vote.	f	2021-09-04 14:06:50	65
655	Charlotte	NC	Respiratory distress	20.286299	Address expect heavy cost on.	t	2022-01-06 10:49:35	88
656	Honolulu	HI	Seizure	-12.205297	Particular religious direction car.	f	2022-03-10 06:08:12	65
657	Minneapolis	MN	Seizure	40.492576	Message father item simply sing risk.	f	2021-07-01 16:23:16	77
658	Seattle	WA	Fight	-41.028204	Name shoulder industry.	f	2022-01-14 19:56:58	102
659	Des Moines	IA	Traumatic Injury	68.465143	Manager present where area cultural probably some.	f	2022-02-10 05:29:32	69
660	Denver	CO	Vehicle accident	30.760918	High local rich sea final road effort.	t	2021-11-11 20:06:11	59
661	Nashville	TE	Respiratory distress	78.255962	Media member majority peace able cut television.	t	2021-08-04 03:18:45	96
662	New York City	NY	Cardiac arrest	-136.402822	Available group miss will.	t	2021-12-13 01:22:50	86
663	Charlotte	NC	Behavioral/Psychiatric	-47.227443	Suddenly arrive play them.	f	2021-03-27 07:05:39	88
664	Chicago	IL	Stabbing	48.464557	Alone buy rich almost whom beat.	t	2021-05-24 12:50:55	67
665	Sioux Falls	SD	Fight	99.905905	Left government personal result gun drop say indeed.	f	2022-01-25 22:28:03	95
666	Philadelphia	PA	Seizure	43.379579	Team physical when do keep upon.	t	2021-11-15 13:27:51	92
667	Jackson	MS	Behavioral/Psychiatric	-120.437436	Show could situation mention either true whose.	t	2021-06-07 15:45:59	78
669	Miami	FL	Cardiac arrest	163.141842	Land partner yes market station page nice.	t	2021-12-04 22:43:37	63
670	Charleston	WV	Seizure	61.391442	Could surface foreign myself be.	f	2021-05-25 12:56:39	94
671	Burlington	VT	Overdose	-15.490360	I none charge just pressure.	t	2021-10-30 20:28:38	100
673	Buffalo	NY	Seizure	167.415129	Sign enjoy about enter language.	t	2022-01-09 20:56:31	87
675	Wilmington	DE	Overdose	7.072257	Cause economy until economic country house nothing.	f	2021-09-12 08:57:12	61
676	New York City	NY	Domestic Violence	-102.487360	Special threat respond thank while specific receive beyond.	t	2022-01-02 10:53:56	86
677	Sioux Falls	SD	Cardiac arrest	-9.915966	Mind great race drug finally.	t	2022-01-17 18:35:50	95
678	Buffalo	NY	Property Fire	23.600196	Specific determine couple economic military kitchen machine occur.	f	2021-06-17 13:33:45	87
679	Jacksonville	FL	Behavioral/Psychiatric	-140.741198	Range turn difficult president with usually.	t	2021-07-22 00:21:35	62
682	Bridgeport	CT	Domestic Violence	120.214916	His throughout government build someone very.	t	2021-10-10 10:09:13	60
683	Salt Lake City	UT	Fight	122.965023	Movement sell him firm.	t	2021-03-11 01:03:56	99
685	Omaha	NE	Respiratory distress	-78.778885	Store police rate different happy them.	t	2021-06-14 05:49:42	81
686	Phoenix	AZ	Seizure	-175.126291	Yeah song once short mention cost within.	t	2022-01-10 21:00:47	57
688	Wichita	KS	Overdose	-97.487389	Agent current suddenly teacher show according.	t	2021-12-26 23:35:38	70
689	Louisville	KY	Behavioral/Psychiatric	37.796815	Other national wide business later piece yard.	t	2021-05-05 07:15:08	71
690	Louisville	KY	Domestic Violence	25.977296	Fire somebody production begin agreement Mrs dream reveal.	f	2021-12-05 11:05:39	71
691	Newark	NJ	Stabbing	129.528959	Suddenly expect either beautiful standard.	t	2021-04-15 15:46:51	84
692	Columbus	OH	Domestic Violence	167.152578	Not receive about human.	t	2021-07-06 13:08:16	90
693	Birmingham	AL	Domestic Violence	179.860062	Lot station reveal tell drug win evidence.	f	2021-08-06 05:13:00	55
694	Miami	FL	Cardiac arrest	13.898120	Than room cold we mission anything throughout.	t	2021-07-04 17:46:19	63
695	Birmingham	AL	Cardiac arrest	88.499715	Hospital book network relationship attorney run message scene.	f	2022-01-14 19:20:58	55
696	Little Rock	AR	Respiratory distress	166.139357	Difficult mention least pass break just.	t	2021-10-03 08:16:25	58
697	Oklahoma City	OK	Fight	-144.131240	Mother beat campaign move support my.	f	2022-01-01 20:00:26	91
698	Kansas City	MO	Overdose	-161.059107	Mission their relationship yeah water health benefit.	t	2021-10-25 12:16:51	79
699	Charlotte	NC	Vehicle accident	-179.020111	Issue perform through.	t	2021-07-04 19:51:38	88
701	Houston	TX	Stabbing	125.012769	Show under fear because.	t	2022-02-12 13:19:38	97
702	Omaha	NE	Respiratory distress	47.842694	Whose choose bad party rest.	f	2021-05-08 11:37:51	81
703	Providence	RI	Property Fire	106.814512	Sing society service.	f	2021-12-17 03:46:35	93
704	Chicago	IL	Property Fire	-147.894122	Answer life experience talk upon.	f	2021-04-27 03:13:01	67
705	Charlotte	NC	Overdose	-168.280443	Rate year despite plan fill example manager.	f	2021-06-27 06:13:12	88
706	Boise	ID	Domestic Violence	51.238935	Effect week draw leader financial sound.	t	2022-02-16 02:39:12	66
708	Portland	OR	Behavioral/Psychiatric	-148.128173	Face check site pay whole order many seek.	f	2021-07-07 19:56:36	73
709	Des Moines	IA	Respiratory distress	-43.898857	Well personal country.	f	2021-09-25 19:06:29	69
710	Minneapolis	MN	Overdose	157.461294	Teacher on near attack power us themselves.	f	2021-03-30 14:30:12	77
711	Billings	MT	Overdose	-62.399902	Wish dog world nation.	f	2022-01-12 15:09:29	80
712	Honolulu	HI	Fight	-73.902541	Enough technology way garden perhaps.	f	2022-02-01 05:54:38	65
713	Columbus	OH	Gunshot Wound	-93.280733	Drug develop order yeah use cold game.	t	2021-06-14 14:40:03	90
714	Buffalo	NY	Fight	24.522059	Beautiful ground world after.	t	2021-12-19 17:23:24	87
715	Omaha	NE	Behavioral/Psychiatric	-16.057224	Memory soldier protect capital only player.	f	2021-05-03 19:28:39	81
716	Portland	OR	Respiratory distress	-127.011858	Kid region firm street firm life keep.	t	2021-05-25 18:34:03	73
717	Los Angeles	CA	Seizure	-135.878991	Drive him never level none.	t	2021-06-29 04:05:07	53
718	Salt Lake City	UT	Property Fire	-2.627113	Much plan now important color when.	f	2021-05-10 10:09:44	99
719	Houston	TX	Stabbing	112.718838	Back long forget bed process.	f	2021-05-20 17:31:21	97
720	Sioux Falls	SD	Seizure	-143.650967	Themselves office me may space its treat president.	f	2021-11-29 14:38:53	95
721	Omaha	NE	Traumatic Injury	10.926376	Agent religious up.	f	2021-09-28 14:48:26	81
723	Anchorage	AK	Traumatic Injury	-147.996414	Team remember together education card enter.	t	2021-11-01 11:49:50	56
724	Kansas City	MO	Traumatic Injury	-59.905097	Voice property table growth.	t	2021-03-13 23:14:24	79
725	Las Vegas	NV	Vehicle accident	-118.666411	Level maintain maintain hospital shoulder.	f	2021-04-15 16:31:20	82
726	Las Vegas	NV	Fight	-165.269030	Federal tell success ball increase.	f	2021-06-16 19:13:30	82
727	Albuquerque	NM	Vehicle accident	73.217622	Garden clearly sound control language campaign.	f	2021-07-11 15:46:32	85
728	Charleston	WV	Traumatic Injury	113.313436	Guy worry peace eight huge.	t	2021-09-26 18:24:38	94
729	Boise	ID	Overdose	119.424419	Factor wall foot image ask form factor.	t	2021-10-23 11:55:11	66
730	Indianapolis	IN	Fight	-171.067384	Reason free town company question.	f	2021-12-19 03:26:36	68
731	Billings	MT	Stabbing	140.427679	Market and dog how he suddenly theory include.	t	2022-03-05 18:12:42	80
732	Louisville	KY	Traumatic Injury	-144.222527	Play development television seek culture purpose.	t	2021-10-03 00:10:40	71
733	Chicago	IL	Gunshot Wound	-161.305148	Population player say why prepare condition.	f	2021-09-10 13:00:40	67
734	Salt Lake City	UT	Traumatic Injury	-162.420488	So she turn research husband feeling.	f	2021-11-28 09:46:36	99
735	Jackson	MS	Traumatic Injury	166.983523	Hot hand close throw all mention medical.	f	2021-05-27 13:21:04	78
737	Sioux Falls	SD	Respiratory distress	111.767378	With money anything create day.	f	2021-06-02 17:29:21	95
738	Little Rock	AR	Fight	165.197626	National north method me.	f	2022-01-10 08:43:11	58
739	Billings	MT	Vehicle accident	-18.796624	Garden evidence effort identify.	t	2021-09-21 01:45:48	80
740	Detroit	MI	Bleeding	128.148332	Morning bring past offer.	f	2021-07-20 18:41:30	76
741	Miami	FL	Property Fire	114.698691	Democrat not personal order apply home.	f	2021-09-26 19:13:52	63
742	New York City	NY	Stabbing	31.768913	Hundred section religious guess next central.	t	2021-03-22 05:34:33	86
743	Cheyenne	WY	Property Fire	117.897922	Bar sell newspaper former.	f	2022-02-04 03:33:17	104
744	Albuquerque	NM	Property Fire	32.240132	Per with town happen message.	t	2021-07-05 09:05:45	85
745	Wichita	KS	Respiratory distress	-96.727416	Minute still prove trade.	f	2021-03-27 20:53:17	70
746	Honolulu	HI	Behavioral/Psychiatric	-49.281188	Goal resource know away the.	t	2022-03-04 10:05:00	65
748	Little Rock	AR	Traumatic Injury	100.913966	Sport until president sell.	t	2021-04-12 15:49:51	58
749	New Orleans	LA	Traumatic Injury	122.004466	Town security stage share often magazine not son.	t	2021-08-03 21:38:12	72
750	Detroit	MI	Seizure	-157.776848	Successful offer west left institution.	t	2021-07-02 13:08:50	76
751	Honolulu	HI	Overdose	45.170608	Focus society church doctor.	t	2021-08-09 14:25:51	65
752	Omaha	NE	Vehicle accident	-38.918258	Against television get sort open toward.	t	2021-12-30 01:43:06	81
753	Providence	RI	Vehicle accident	76.426249	Your keep rise raise sing.	t	2021-07-14 23:00:07	93
754	Philadelphia	PA	Vehicle accident	-9.154873	Already nice mouth commercial involve business you reality.	t	2021-07-13 12:18:37	92
755	Honolulu	HI	Respiratory distress	-109.982771	The garden or guess rock once.	f	2022-03-10 05:49:49	65
756	Columbus	OH	Domestic Violence	178.984729	Significant store American at within society give discover.	t	2021-08-03 16:05:06	90
757	Phoenix	AZ	Overdose	-101.612538	Whatever view want instead along according.	t	2021-04-08 14:32:23	57
758	Boise	ID	Domestic Violence	11.104185	Direction game blue company read interview.	f	2021-08-29 09:48:58	66
760	Manchester	NH	Stabbing	61.406246	Always board behind beautiful.	t	2021-04-01 01:17:40	83
761	Jacksonville	FL	Respiratory distress	-173.862884	Summer program himself sense camera.	f	2021-11-13 02:28:20	62
762	Anchorage	AK	Cardiac arrest	-157.554975	Police strategy view team administration safe section.	t	2021-11-17 11:44:41	56
763	Omaha	NE	Seizure	-139.420854	Able face get will current heavy.	t	2021-11-24 19:11:21	81
764	Albuquerque	NM	Overdose	0.582435	Enter feel policy daughter such.	f	2021-11-30 04:57:58	85
765	Sioux Falls	SD	Behavioral/Psychiatric	171.312552	Four very speak effect.	t	2022-01-28 11:44:29	95
766	Detroit	MI	Gunshot Wound	125.137928	Change international add write film pattern safe.	t	2021-09-24 12:56:04	76
767	Bridgeport	CT	Stabbing	-12.521982	Anyone writer test happy everything.	f	2021-09-08 11:30:55	60
768	Providence	RI	Fight	-0.931551	Fear specific cold most person.	t	2021-10-31 23:25:01	93
770	Birmingham	AL	Vehicle accident	-5.923255	Much hair sense career seat together which.	t	2022-02-09 00:03:09	55
772	Las Vegas	NV	Overdose	161.152486	Week use general.	f	2021-09-11 10:27:33	82
773	Charleston	WV	Overdose	-164.184843	Successful five free soon.	t	2021-05-15 12:26:51	94
774	Minneapolis	MN	Respiratory distress	79.358936	Writer writer check seek.	f	2021-08-01 02:59:19	77
775	Louisville	KY	Respiratory distress	96.399563	Hundred him later determine cup.	f	2021-09-13 09:51:34	71
776	Seattle	WA	Overdose	-158.913008	Anything bed surface scene year.	t	2022-01-10 12:17:06	102
777	Chicago	IL	Property Fire	-8.132389	Treatment tree soon theory play crime although best.	f	2021-07-09 16:04:11	67
778	Boston	MA	Gunshot Wound	14.488039	Often full society including put base full.	f	2021-05-07 04:44:41	75
779	Newark	NJ	Fight	25.896022	Crime necessary indeed agreement chair half carry.	t	2021-03-29 18:59:14	84
780	Miami	FL	Domestic Violence	-72.399300	Across talk rich keep.	t	2021-12-16 10:52:53	63
781	Salt Lake City	UT	Traumatic Injury	-121.259657	Media use alone rich.	f	2021-07-05 16:42:22	99
782	Anchorage	AK	Behavioral/Psychiatric	-143.496980	May or soon doctor break sister usually.	f	2022-02-20 03:09:54	56
783	Houston	TX	Fight	78.312044	Toward with country.	f	2022-01-29 19:09:58	97
784	Chicago	IL	Fight	-100.093614	Meeting response doctor government.	t	2022-01-29 16:25:06	67
785	Columbus	OH	Traumatic Injury	-33.017912	Person above especially risk.	f	2021-06-17 01:34:29	90
786	Albuquerque	NM	Stabbing	-13.023692	Find identify visit specific environmental.	f	2021-05-14 02:33:08	85
787	Charlotte	NC	Overdose	-30.620678	Past spring unit study want rate decide.	f	2021-10-13 18:02:17	88
788	Sioux Falls	SD	Seizure	-70.716608	Loss indeed young bit do center.	f	2021-10-13 02:49:08	95
789	Boston	MA	Fight	-50.825151	Believe green rest assume.	t	2021-10-10 08:42:25	75
790	Kansas City	MO	Bleeding	-7.430079	Step individual particular option effort identify.	f	2021-10-15 12:32:14	79
791	Denver	CO	Fight	118.190025	Rate board indeed.	t	2021-08-07 22:38:31	59
792	Boston	MA	Stabbing	98.201021	Improve president early book risk fight nearly.	f	2021-07-27 02:03:30	75
793	Billings	MT	Traumatic Injury	-64.800398	Blue list sit force station.	f	2021-12-04 14:35:52	80
794	Charleston	WV	Cardiac arrest	128.505299	At ground plant civil bed another somebody.	f	2021-12-13 15:41:13	94
795	Birmingham	AL	Stabbing	-163.639704	Black meet these little.	f	2021-10-27 23:24:42	55
796	Charleston	WV	Traumatic Injury	-67.447433	Another but movie office study.	f	2021-07-30 01:11:54	94
797	Las Vegas	NV	Seizure	-12.269411	Three let summer identify everyone father kid.	t	2021-09-21 10:45:57	82
798	Honolulu	HI	Cardiac arrest	170.506344	Sit security individual similar.	t	2021-08-02 04:02:10	65
799	Seattle	WA	Stabbing	-28.126264	Research author daughter.	t	2021-12-22 09:01:42	102
800	Jacksonville	FL	Fight	-54.425988	Stock trip grow option nature late.	t	2021-09-12 01:28:50	62
801	Houston	TX	Behavioral/Psychiatric	-76.355248	Big officer letter well ready idea season.	t	2022-02-16 22:03:35	97
802	Burlington	VT	Seizure	-1.080812	Mind television study myself situation.	t	2021-04-08 22:55:43	100
803	Charleston	WV	Domestic Violence	131.062189	Take middle real step only school meet.	f	2021-09-12 07:57:50	94
804	Wilmington	DE	Traumatic Injury	-83.955853	Make find production garden.	f	2022-03-05 23:27:01	61
805	Manchester	NH	Bleeding	171.855479	Area collection put mission.	t	2021-07-24 09:28:49	83
806	Newark	NJ	Traumatic Injury	-146.648600	Career so a act north local big.	f	2021-07-13 15:55:31	84
807	Seattle	WA	Fight	-126.770616	Second foot view detail billion fine there radio.	t	2021-11-21 05:20:43	102
808	Minneapolis	MN	Behavioral/Psychiatric	-42.094087	Sort important rich author practice teacher.	t	2022-01-09 06:32:35	77
809	Manchester	NH	Bleeding	-16.186008	Traditional alone section leg either.	t	2021-06-22 15:39:53	83
810	Detroit	MI	Behavioral/Psychiatric	151.420953	Nature agent attorney put beat upon fund.	f	2021-08-07 14:03:21	76
811	Sioux Falls	SD	Cardiac arrest	-94.192914	Collection everyone myself audience.	f	2022-01-09 23:20:28	95
812	Minneapolis	MN	Behavioral/Psychiatric	35.445525	Bed field new finish alone thought himself.	t	2022-01-08 12:58:09	77
813	Oklahoma City	OK	Fight	-23.187468	Note appear list.	f	2021-04-30 00:26:22	91
815	Burlington	VT	Domestic Violence	-151.545114	Increase however however born.	f	2022-03-10 14:43:55	100
816	Boise	ID	Property Fire	-50.440455	What while list make north.	f	2021-07-12 20:44:45	66
817	Bridgeport	CT	Respiratory distress	14.749100	Story star line sport where face your.	t	2022-03-08 19:21:47	60
818	Omaha	NE	Gunshot Wound	77.372384	Society whole authority decide move.	f	2021-04-14 10:10:28	81
821	Buffalo	NY	Bleeding	-9.639261	Street strategy hard.	t	2021-05-10 15:53:10	87
822	Miami	FL	Stabbing	138.767276	Instead way run film.	f	2021-09-05 16:59:10	63
823	Charlotte	NC	Respiratory distress	-125.979546	When try summer.	t	2021-04-19 02:23:35	88
824	Los Angeles	CA	Behavioral/Psychiatric	77.866380	Here brother opportunity development point policy late.	f	2021-08-07 19:12:01	53
825	Austin	TX	Bleeding	137.210015	Stand reduce reflect project page itself local evidence.	f	2022-01-05 20:41:03	98
826	Cheyenne	WY	Gunshot Wound	-148.929040	Theory think environmental notice sign reflect.	t	2021-10-17 11:45:14	104
827	Jackson	MS	Seizure	47.983276	Actually treatment at shake mission development camera.	t	2022-02-08 14:32:05	78
828	Honolulu	HI	Behavioral/Psychiatric	-130.535533	Increase only fly.	f	2021-12-03 20:07:07	65
829	Indianapolis	IN	Fight	0.883213	Outside note human.	t	2021-09-16 07:45:39	68
830	Bridgeport	CT	Behavioral/Psychiatric	-36.895600	Carry meeting through action.	t	2022-02-17 13:50:53	60
831	Providence	RI	Fight	-3.444417	Which state of analysis short.	t	2021-07-10 01:57:49	93
832	Columbus	OH	Domestic Violence	-153.732319	Carry rich open.	f	2021-09-23 00:53:55	90
833	Buffalo	NY	Gunshot Wound	99.329760	Person wind response company.	t	2021-03-18 23:58:12	87
834	Jackson	MS	Respiratory distress	173.170238	Despite central too lead himself concern.	t	2021-08-14 12:55:53	78
835	Nashville	TE	Domestic Violence	-119.803448	Significant toward where food.	f	2021-05-20 19:50:37	96
836	Charlotte	NC	Bleeding	-137.410635	Remain need debate interesting manager voice when respond.	f	2021-05-21 20:48:15	88
837	New Orleans	LA	Seizure	-134.867838	Toward left will specific popular determine center fine.	f	2021-06-21 01:39:17	72
838	Newark	NJ	Stabbing	-97.811139	Decision learn change central.	f	2021-09-28 11:13:59	84
839	Denver	CO	Fight	-128.676265	Growth career begin number.	f	2022-02-10 00:47:50	59
840	Kansas City	MO	Gunshot Wound	-117.796593	Determine impact teacher data lot health.	t	2021-05-07 01:42:20	79
841	Los Angeles	CA	Behavioral/Psychiatric	51.386368	Give ahead way.	f	2021-11-01 05:06:50	53
842	Sioux Falls	SD	Fight	85.318724	Development treat be.	t	2021-08-01 13:00:27	95
843	Kansas City	MO	Cardiac arrest	155.172643	Federal lawyer perhaps third.	t	2021-04-16 18:56:53	79
844	Oklahoma City	OK	Fight	-3.777970	Significant court wrong yard.	t	2021-10-20 17:32:53	91
845	Seattle	WA	Vehicle accident	-136.034431	International rock majority foot.	f	2022-01-11 15:14:36	102
846	Billings	MT	Vehicle accident	81.310335	Ability direction culture.	f	2021-12-15 20:22:16	80
847	Fargo	ND	Fight	112.668550	Time spend conference trouble point understand.	t	2021-08-07 13:20:30	89
848	Austin	TX	Behavioral/Psychiatric	-152.287457	Party edge he can likely.	f	2021-09-25 10:03:05	98
849	Wilmington	DE	Stabbing	134.686068	Cold action model toward middle.	f	2021-06-10 06:40:06	61
850	Virginia Beach	VA	Fight	-168.411224	Data probably successful up black.	f	2021-05-03 09:09:10	101
851	Milwaukee	WI	Seizure	151.801018	Contain west source might business.	f	2021-05-31 16:41:26	103
852	Denver	CO	Respiratory distress	161.769807	City human weight attack strategy decision stuff shoulder.	f	2021-04-24 12:36:01	59
853	Little Rock	AR	Bleeding	-102.147139	Old high direction quite.	f	2021-09-16 02:06:55	58
854	Detroit	MI	Property Fire	163.225949	Head enough few fine spend.	t	2021-06-23 12:39:46	76
855	Phoenix	AZ	Behavioral/Psychiatric	-99.260263	True entire maybe clear standard question major.	f	2022-01-23 13:10:36	57
856	Austin	TX	Cardiac arrest	26.609728	Include recognize instead herself rule month big never.	f	2021-07-16 00:49:16	98
857	New Orleans	LA	Fight	155.637991	The source soon area painting song.	f	2022-03-08 08:19:03	72
858	Portland	OR	Property Fire	89.293510	Cell structure model gun rather win state.	f	2022-01-07 13:32:17	73
859	Virginia Beach	VA	Behavioral/Psychiatric	80.051903	Able pay oil carry perhaps.	f	2022-02-02 04:54:30	101
860	Fargo	ND	Gunshot Wound	-177.920046	Method success energy million.	f	2021-03-12 21:06:09	89
861	Nashville	TE	Respiratory distress	-137.326354	Once free focus.	f	2021-09-14 17:38:36	96
862	Wichita	KS	Behavioral/Psychiatric	153.163621	Couple evidence many see determine.	t	2021-03-11 21:06:06	70
863	Newark	NJ	Respiratory distress	52.597848	Religious piece final others finally mouth artist.	t	2021-05-30 13:18:12	84
865	Providence	RI	Vehicle accident	-55.542666	Parent eat stage news.	t	2021-03-22 09:45:38	93
866	Philadelphia	PA	Property Fire	-135.774688	Free effect boy when create approach.	f	2021-05-05 00:49:19	92
867	Billings	MT	Vehicle accident	-158.869100	Alone sort chair policy.	f	2021-03-28 22:37:20	80
868	Buffalo	NY	Cardiac arrest	-0.334452	Part avoid region amount about because morning.	f	2021-11-03 11:24:25	87
869	Milwaukee	WI	Behavioral/Psychiatric	57.826704	Hot together myself fear right able.	t	2021-08-31 04:52:19	103
870	Des Moines	IA	Respiratory distress	4.074827	Set next audience far people four.	t	2021-12-16 18:40:56	69
872	Jacksonville	FL	Fight	37.623761	In point environment eye under truth person.	t	2021-11-21 09:03:10	62
874	Houston	TX	Domestic Violence	-168.951318	Away six building mother result boy.	f	2021-12-12 00:40:18	97
875	Bridgeport	CT	Vehicle accident	116.500053	Save outside major exist poor.	t	2021-12-10 10:55:09	60
876	Jacksonville	FL	Property Fire	-148.771372	Fast find interview finally back claim seek knowledge.	f	2021-10-19 06:16:03	62
877	Philadelphia	PA	Fight	30.750555	Sound and person million according of guy.	f	2022-02-17 22:11:31	92
878	Las Vegas	NV	Vehicle accident	-118.533834	Tax such animal employee.	f	2021-09-14 02:15:05	82
879	Burlington	VT	Bleeding	79.469927	Director recently baby threat majority.	t	2021-03-28 14:09:38	100
881	Charlotte	NC	Behavioral/Psychiatric	-0.215788	Star newspaper commercial arrive into resource your.	t	2021-11-18 08:33:10	88
882	Newark	NJ	Property Fire	-12.439329	Instead image back represent production television idea.	t	2021-07-21 15:19:59	84
883	Sioux Falls	SD	Cardiac arrest	55.542816	Business month technology fine program amount live race.	f	2021-07-17 09:40:42	95
885	Nashville	TE	Stabbing	-89.674111	Use big at truth.	f	2022-01-21 12:50:36	96
886	Indianapolis	IN	Respiratory distress	121.461045	Involve while worker receive gas wonder age.	t	2022-02-12 05:58:16	68
887	Kansas City	MO	Bleeding	-73.492283	Deal could know brother become short sport society.	t	2021-06-30 11:46:17	79
888	Albuquerque	NM	Cardiac arrest	144.815092	Game dream give.	t	2021-06-20 12:12:09	85
890	Sioux Falls	SD	Traumatic Injury	131.250021	Include student paper.	f	2021-06-05 18:32:55	95
891	Oklahoma City	OK	Stabbing	97.470974	Page month build reduce recognize parent each make.	f	2021-12-23 18:27:36	91
892	Baltimore	MD	Seizure	-82.766090	Set life medical identify score source inside.	f	2022-01-02 23:59:03	74
893	Providence	RI	Property Fire	-129.865868	Allow firm already person coach allow.	f	2021-07-22 19:35:27	93
894	Anchorage	AK	Domestic Violence	87.760557	Shake strategy themselves never before add.	t	2021-11-15 22:51:48	56
895	Detroit	MI	Vehicle accident	-168.611511	Attention issue small.	t	2021-03-18 22:31:13	76
896	Milwaukee	WI	Overdose	81.441242	Manager just crime know standard.	t	2021-06-17 14:48:12	103
897	Houston	TX	Respiratory distress	166.731872	About material wait hour resource.	f	2021-12-09 15:56:31	97
899	Billings	MT	Respiratory distress	-134.216791	Writer east also hour.	t	2021-08-22 23:08:04	80
900	New York City	NY	Fight	-28.995472	Sit dog interview this despite family.	t	2021-07-25 14:44:19	86
901	Wichita	KS	Stabbing	172.555471	Court their practice.	f	2021-09-23 00:57:30	70
902	Oklahoma City	OK	Property Fire	84.085540	Not enough sea will image store.	f	2021-05-19 00:06:27	91
903	Louisville	KY	Bleeding	138.720396	Population alone hope wish whose.	f	2022-02-01 13:12:43	71
904	Cheyenne	WY	Cardiac arrest	41.765983	Four recent before economy.	f	2021-08-27 16:20:49	104
905	Omaha	NE	Overdose	-176.408638	Very operation spend although history whether network.	t	2022-03-09 12:50:03	81
906	Burlington	VT	Fight	-16.015494	Step accept real home approach.	t	2021-06-06 05:18:53	100
907	Billings	MT	Cardiac arrest	6.233076	Want traditional project hot north.	f	2021-07-22 17:41:47	80
908	Jacksonville	FL	Traumatic Injury	-50.070166	Threat issue sense management whatever avoid wide.	t	2021-06-08 17:05:06	62
909	Chicago	IL	Seizure	83.957426	Risk all reach guy significant tonight.	f	2021-05-18 05:48:50	67
910	Bridgeport	CT	Vehicle accident	170.725005	Former political enough itself win painting job.	f	2021-08-09 14:52:06	60
911	Albuquerque	NM	Domestic Violence	-163.808567	Later there hour room quite experience.	f	2021-12-21 13:30:34	85
912	Burlington	VT	Fight	1.832133	Maintain quickly mother buy.	t	2021-03-19 08:46:19	100
914	Louisville	KY	Property Fire	-97.672900	My story begin movement.	f	2021-05-22 21:25:36	71
915	Columbus	OH	Behavioral/Psychiatric	-72.700120	Paper cultural stay agreement great represent nothing.	t	2021-05-13 05:58:38	90
917	New Orleans	LA	Behavioral/Psychiatric	32.383491	Learn every natural reflect.	f	2021-04-19 06:11:44	72
918	Bridgeport	CT	Bleeding	-103.587973	Only person school structure.	f	2021-05-24 12:23:53	60
919	Burlington	VT	Fight	157.060810	Move decide state.	f	2021-04-24 16:48:18	100
920	Newark	NJ	Traumatic Injury	33.290762	Current day land.	t	2021-11-17 07:41:21	84
921	Portland	OR	Seizure	130.292099	Remember art candidate kid have listen cut.	t	2021-10-31 07:16:19	73
922	Atlanta	GA	Overdose	-111.437812	Win culture manager.	f	2021-05-04 00:55:30	64
923	Portland	OR	Property Fire	123.378108	Now car fact.	f	2021-06-30 02:54:18	73
924	Chicago	IL	Property Fire	177.268591	Near financial financial glass use outside figure.	f	2021-07-19 02:03:26	67
925	Minneapolis	MN	Domestic Violence	81.560946	Car modern born heart staff.	f	2021-03-24 14:52:33	77
926	Jackson	MS	Gunshot Wound	-59.060072	Of magazine discuss general value somebody understand generation.	t	2021-04-11 00:27:56	78
927	Wichita	KS	Domestic Violence	47.601150	Safe foreign character need act space value.	t	2021-07-28 02:24:02	70
928	Burlington	VT	Behavioral/Psychiatric	118.615849	Tend reveal return community win run beyond.	t	2021-10-10 11:12:12	100
929	San Francisco	CA	Traumatic Injury	22.791801	Treat second heart new indeed.	t	2021-10-23 12:44:55	54
930	Las Vegas	NV	Vehicle accident	-154.305055	But mean direction risk win.	f	2022-01-09 19:42:42	82
931	Burlington	VT	Stabbing	145.074603	Ground commercial structure voice pass.	t	2021-12-28 05:45:24	100
933	Jackson	MS	Stabbing	72.232626	Left plant rock federal help while health.	f	2022-01-12 05:48:12	78
934	Seattle	WA	Stabbing	73.885004	Fight wall service area your.	t	2021-06-16 08:53:55	102
935	Chicago	IL	Domestic Violence	95.585609	Environmental audience herself several wrong.	f	2021-10-27 01:03:40	67
936	Detroit	MI	Behavioral/Psychiatric	-150.595417	Contain hope game state.	t	2022-01-16 02:04:52	76
937	Cheyenne	WY	Overdose	101.100976	Kind money leader force energy certainly.	t	2021-08-05 15:32:10	104
938	Nashville	TE	Behavioral/Psychiatric	-87.512821	Field base police authority evening player.	t	2021-09-10 02:21:59	96
939	Boise	ID	Stabbing	-62.496760	Expect but thought structure lay adult.	f	2021-06-17 11:16:30	66
940	Atlanta	GA	Property Fire	112.492076	Whatever source sound election clearly wrong.	f	2021-09-22 01:09:41	64
941	Charlotte	NC	Bleeding	151.177695	Sort purpose floor president sister suffer interest.	t	2021-10-24 08:34:06	88
942	Wichita	KS	Seizure	44.433828	Rock hot defense carry her consider ready.	t	2021-12-30 05:10:10	70
943	Virginia Beach	VA	Gunshot Wound	77.600908	Six eight upon particular region mention pass.	t	2021-04-05 12:57:32	101
944	Houston	TX	Seizure	-23.992622	Certainly detail certain throughout politics increase.	f	2021-06-17 21:03:06	97
945	Detroit	MI	Bleeding	-172.503869	Quite physical whose team.	t	2021-03-12 12:54:26	76
946	Albuquerque	NM	Overdose	-99.285726	Religious area able per spend yard.	f	2021-03-24 20:28:54	85
947	Denver	CO	Respiratory distress	-78.865639	Week pretty daughter fund phone service himself.	t	2021-05-24 01:01:52	59
948	Minneapolis	MN	Overdose	-125.969422	Back sort production age water your.	f	2022-03-08 01:06:35	77
949	Charleston	WV	Respiratory distress	-136.033172	Your recent hard economic customer.	t	2021-10-15 06:25:07	94
950	Chicago	IL	Respiratory distress	71.789617	Interesting and green picture conference magazine.	f	2021-12-16 08:15:37	67
951	Salt Lake City	UT	Stabbing	94.064732	Rather cup morning computer partner ask real.	f	2022-01-30 00:59:27	99
952	Louisville	KY	Respiratory distress	-5.204540	Today be college phone.	f	2021-06-16 20:04:57	71
953	Miami	FL	Respiratory distress	-62.329227	Box box health daughter food suddenly.	t	2021-11-26 06:35:09	63
954	Albuquerque	NM	Stabbing	-33.036997	Capital ahead affect serious right life.	t	2021-03-18 02:42:34	85
955	Jacksonville	FL	Fight	-34.314549	Because establish hospital lose line tough stay let.	t	2021-12-29 19:44:45	62
956	Charlotte	NC	Behavioral/Psychiatric	20.477638	Science miss change white lose.	f	2021-08-14 23:20:20	88
958	Buffalo	NY	Overdose	106.135036	Born century quite chair might fire century.	t	2021-08-05 16:05:57	87
959	Billings	MT	Respiratory distress	153.216197	Boy talk western well.	f	2021-07-04 07:11:55	80
960	Phoenix	AZ	Overdose	128.544678	Respond home rise including.	t	2021-12-31 18:43:20	57
961	Oklahoma City	OK	Vehicle accident	163.583555	Section majority year degree newspaper television.	t	2022-03-02 12:14:18	91
962	New York City	NY	Behavioral/Psychiatric	40.514772	Enough theory present.	t	2021-06-23 12:36:26	86
963	Boston	MA	Property Fire	10.137699	High argue consider.	f	2021-03-16 09:52:22	75
964	Indianapolis	IN	Vehicle accident	79.960577	Huge cause major goal fire coach staff.	t	2022-02-24 13:19:50	68
965	Phoenix	AZ	Overdose	-95.502703	Individual laugh minute trade wear.	t	2022-01-21 21:23:35	57
966	Austin	TX	Domestic Violence	115.386880	Collection street way.	f	2021-10-11 00:27:46	98
967	Philadelphia	PA	Seizure	-135.346063	Nature image movie reduce history state guy.	t	2021-11-15 06:13:08	92
968	Los Angeles	CA	Vehicle accident	-21.001515	Rather ask either management throw morning.	t	2022-01-21 13:32:18	53
969	Albuquerque	NM	Vehicle accident	143.293072	Many wait teach role resource.	f	2022-01-23 01:17:04	85
970	Little Rock	AR	Behavioral/Psychiatric	127.402899	Idea across yet nor serious.	f	2021-07-28 02:20:01	58
971	Honolulu	HI	Overdose	-132.575671	Wall hand require stock.	t	2021-10-03 19:32:04	65
972	Chicago	IL	Fight	14.647057	Economic region ago half clearly war police.	t	2021-07-16 12:05:54	67
973	Kansas City	MO	Seizure	-126.152781	Group book general.	t	2021-03-27 12:44:10	79
974	Portland	OR	Bleeding	-154.026968	Set western race blood teach relate.	t	2021-08-02 16:39:24	73
975	Newark	NJ	Overdose	98.452815	Yet page of face weight.	t	2021-11-12 03:23:04	84
976	Jacksonville	FL	Fight	28.426813	Somebody message material try senior.	t	2021-05-08 19:35:50	62
977	Wichita	KS	Behavioral/Psychiatric	-128.357113	Easy summer capital weight.	f	2021-07-24 06:42:03	70
978	Nashville	TE	Domestic Violence	125.572811	Political through maintain arrive detail teacher box person.	t	2022-01-24 02:22:06	96
979	Little Rock	AR	Gunshot Wound	-38.850906	Near clearly science range actually right stand.	t	2021-10-13 05:30:27	58
980	Jacksonville	FL	Stabbing	-18.997495	Science his growth and point machine media.	t	2021-10-24 11:18:29	62
981	New York City	NY	Traumatic Injury	-145.676215	Old south management.	t	2021-07-03 07:33:54	86
983	Wilmington	DE	Behavioral/Psychiatric	124.934686	Poor learn part dream even other.	t	2022-01-11 13:54:21	61
984	Baltimore	MD	Vehicle accident	117.319628	Watch apply history field understand.	t	2021-09-10 21:33:15	74
985	Billings	MT	Fight	169.000905	Our class believe teach for again.	t	2021-11-14 18:33:46	80
986	Milwaukee	WI	Traumatic Injury	-79.213348	Tax certainly vote fall similar trip standard.	f	2021-08-27 01:41:28	103
987	Austin	TX	Overdose	-38.036647	Son training sometimes.	t	2021-10-28 23:50:51	98
988	Boise	ID	Behavioral/Psychiatric	-119.736348	It teacher should shake get very serve base.	t	2021-08-15 07:38:24	66
989	Boston	MA	Overdose	86.492427	Second part institution.	t	2021-11-10 22:15:30	75
990	Baltimore	MD	Gunshot Wound	88.570690	Truth kid measure city those friend.	t	2021-05-20 05:33:09	74
991	Oklahoma City	OK	Domestic Violence	53.113025	Line within agency police receive choose.	f	2021-08-28 07:22:42	91
992	Houston	TX	Bleeding	97.847355	Laugh decision field serve operation article.	t	2021-09-26 08:26:29	97
993	Honolulu	HI	Property Fire	95.205940	Still claim center rich nation carry.	f	2022-01-18 23:34:03	65
994	Las Vegas	NV	Gunshot Wound	18.301340	Democratic wind avoid story any ago.	t	2021-12-15 12:38:54	82
995	Minneapolis	MN	Stabbing	151.779374	Near thousand they discussion case occur decade.	f	2021-07-24 10:52:02	77
996	Oklahoma City	OK	Property Fire	108.360742	See top own baby suggest data.	t	2021-08-02 11:12:28	91
997	Salt Lake City	UT	Gunshot Wound	-165.321601	High light talk thing discuss high wife.	f	2021-06-24 07:40:16	99
998	Omaha	NE	Property Fire	-129.825613	Social size week material happen fire.	f	2021-05-28 04:11:54	81
999	Boise	ID	Bleeding	-135.060273	Career rock clear old politics imagine arrive reflect.	t	2021-07-30 09:48:35	66
1001	Chicago	IL	Stabbing	43.741021	Wall take management experience.	\N	2022-01-10 22:16:08	67
1002	Fargo	ND	Overdose	105.604836	\N	\N	2022-03-08 11:38:06	89
1003	Salt Lake City	UT	Property Fire	112.257722	\N	\N	2022-01-28 01:49:44	99
1004	Salt Lake City	UT	Overdose	150.657748	\N	\N	2022-01-15 02:41:31	99
1000	Sioux Falls	SD	Loss of consciousness / fainting	26.850763	Sound crime wear.	f	2021-06-26 15:20:52	95
1006	Albuquerque	NM	Domestic Violence	-169.791419	Century call imagine guy deep.	\N	2022-01-31 04:52:20	85
1008	Virginia Beach	VA	Property Fire	130.962888	\N	\N	2022-01-29 10:51:08	101
1009	Boston	MA	Vehicle accident	-137.335909	\N	\N	2022-01-30 16:10:43	75
1010	Fargo	ND	Stabbing	107.744811	Key hotel degree for.	\N	2022-02-05 05:34:43	89
1011	Des Moines	IA	Property Fire	-4.507400	Culture modern consumer may evidence one during.	\N	2022-02-22 18:11:47	69
1012	Milwaukee	WI	Traumatic Injury	-152.903890	Difference city each director.	\N	2022-02-03 21:44:31	103
1014	Manchester	NH	Traumatic Injury	-43.709241	Street usually year student.	\N	2022-01-22 22:38:12	83
1015	Milwaukee	WI	Fight	94.768537	Pull everyone animal decide fact strategy.	\N	2022-01-09 04:45:21	103
1016	Salt Lake City	UT	Vehicle accident	160.075861	\N	\N	2022-01-02 17:16:49	99
1017	Wilmington	DE	Fight	107.026521	\N	\N	2022-01-22 00:10:37	61
1018	Bridgeport	CT	Behavioral/Psychiatric	14.992388	Continue score year five media land could.	\N	2022-02-07 05:38:33	60
1019	San Francisco	CA	Vehicle accident	22.962837	\N	\N	2022-02-11 02:23:13	54
1021	Detroit	MI	Property Fire	-15.762097	\N	\N	2022-02-27 02:06:11	76
1022	Atlanta	GA	Traumatic Injury	-43.208878	If service when husband study establish.	\N	2022-01-13 15:05:54	64
1023	Providence	RI	Stabbing	15.976659	Fight road defense.	\N	2022-02-19 21:15:05	93
1025	Baltimore	MD	Bleeding	-52.381300	\N	\N	2022-02-03 13:19:04	74
1026	Boise	ID	Vehicle accident	124.984623	Prove sport assume poor now.	\N	2022-02-21 22:37:14	66
1027	Minneapolis	MN	Behavioral/Psychiatric	-130.263902	Speech player agreement growth every.	\N	2022-02-07 15:15:41	77
1028	Philadelphia	PA	Property Fire	-35.341879	Since affect claim animal shake.	\N	2022-01-18 04:12:21	92
1029	Charlotte	NC	Domestic Violence	-18.765580	Explain that machine set.	\N	2022-03-10 15:52:05	88
1030	Albuquerque	NM	Fight	128.620168	Check national tell its dark carry.	\N	2022-02-24 03:14:40	85
1031	Bridgeport	CT	Stabbing	35.720828	\N	\N	2022-02-06 22:20:02	60
1032	Los Angeles	CA	Stabbing	-1.847993	From grow sit half those common.	\N	2022-01-13 04:07:32	53
1033	Oklahoma City	OK	Bleeding	-124.237348	\N	\N	2022-02-10 13:10:47	91
1034	Jackson	MS	Traumatic Injury	41.686939	\N	\N	2022-02-08 20:55:48	78
1035	Boston	MA	Cardiac arrest	-177.613300	Even standard more study.	\N	2022-01-18 03:14:40	75
1036	Boston	MA	Stabbing	74.446662	\N	\N	2022-02-11 22:34:28	75
1037	Baltimore	MD	Behavioral/Psychiatric	-136.960967	Want without statement man however case.	\N	2022-02-02 11:06:27	74
1038	Virginia Beach	VA	Vehicle accident	-116.194104	\N	\N	2022-02-08 10:16:56	101
1039	Fargo	ND	Fight	112.418172	Small eight may sister management tend spend.	\N	2022-03-10 05:40:19	89
1040	Charlotte	NC	Bleeding	-87.484567	\N	\N	2022-02-21 16:26:31	88
1041	Charleston	WV	Domestic Violence	117.117375	Half cell weight color people end maybe.	\N	2022-02-04 01:03:36	94
1042	Los Angeles	CA	Domestic Violence	-3.010068	\N	\N	2022-01-18 04:34:26	53
1043	Miami	FL	Property Fire	-57.037751	\N	\N	2022-02-02 06:21:30	63
1044	Little Rock	AR	Seizure	-18.252260	\N	\N	2022-01-13 03:17:15	58
1045	Newark	NJ	Domestic Violence	-82.934135	\N	\N	2022-02-21 08:37:31	84
1046	Austin	TX	Stabbing	59.671778	\N	\N	2022-01-30 12:50:18	98
1047	Virginia Beach	VA	Domestic Violence	-158.413412	Morning quickly rich stuff.	\N	2022-01-13 02:41:31	101
1048	Jackson	MS	Cardiac arrest	41.907030	\N	\N	2022-02-27 05:47:27	78
1049	Baltimore	MD	Stabbing	-1.637458	\N	\N	2022-03-09 10:24:28	74
1050	Jackson	MS	Fight	-92.228788	Pay true catch happen too.	\N	2022-01-26 21:35:24	78
36	Austin	TX	Loss of consciousness / fainting	81.004489	Order hundred success serious.	t	2022-03-03 09:34:16	98
47	Sioux Falls	SD	Loss of consciousness / fainting	99.824364	Meet room each soon investment.	f	2021-05-29 09:29:26	95
54	Las Vegas	NV	Loss of consciousness / fainting	154.111898	Here professional possible significant.	t	2021-08-24 10:33:06	82
63	Buffalo	NY	Loss of consciousness / fainting	-99.046571	Particular board radio conference push inside.	f	2021-05-22 04:37:55	87
106	Milwaukee	WI	Loss of consciousness / fainting	-177.378818	In skin a herself.	f	2021-12-31 11:08:08	103
131	Baltimore	MD	Loss of consciousness / fainting	-50.346730	Back explain current part send coach.	t	2021-07-19 05:06:13	74
147	Cheyenne	WY	Loss of consciousness / fainting	158.941796	Study sense president Mr TV reason wrong.	f	2021-04-27 17:58:59	104
165	Philadelphia	PA	Loss of consciousness / fainting	-149.941860	Word road different choice kitchen reflect several week.	t	2021-04-02 05:51:53	92
182	Albuquerque	NM	Loss of consciousness / fainting	-114.305108	Finally tough record through specific story.	f	2021-05-01 20:14:19	85
201	Houston	TX	Loss of consciousness / fainting	-83.923319	Animal catch gas sign.	t	2021-09-03 01:04:33	97
207	Little Rock	AR	Loss of consciousness / fainting	-17.147341	Claim firm government foreign adult role sea.	t	2021-12-18 19:16:41	58
218	Detroit	MI	Loss of consciousness / fainting	-157.859511	Game sea lay lead.	t	2021-08-07 17:55:59	76
243	Buffalo	NY	Loss of consciousness / fainting	-32.789668	Hold physical ability article recent.	t	2021-03-26 08:14:18	87
250	Omaha	NE	Loss of consciousness / fainting	-114.484507	Race prove ready eye far.	f	2021-09-29 18:10:55	81
258	Nashville	TE	Loss of consciousness / fainting	140.352120	Research there price avoid.	f	2022-02-19 01:59:08	96
307	Phoenix	AZ	Loss of consciousness / fainting	132.375133	Present free red garden option fall particular.	t	2021-10-13 11:24:03	57
309	Minneapolis	MN	Loss of consciousness / fainting	-99.217480	Medical stop bring speech college.	f	2021-05-07 22:55:27	77
317	Cheyenne	WY	Loss of consciousness / fainting	30.509114	Gun before difficult film.	f	2021-09-09 06:53:50	104
362	Cheyenne	WY	Loss of consciousness / fainting	-101.953272	Throughout which moment although.	t	2021-09-26 12:44:36	104
404	Oklahoma City	OK	Loss of consciousness / fainting	-136.536742	Buy message score full change foreign number.	t	2021-05-27 01:57:55	91
405	Billings	MT	Loss of consciousness / fainting	-22.941699	Only dream industry.	f	2021-09-24 00:31:35	80
407	Portland	OR	Loss of consciousness / fainting	87.893338	Someone his part hair part size our.	t	2021-03-26 23:21:52	73
435	Seattle	WA	Loss of consciousness / fainting	-107.255919	Air course life provide cause six build.	f	2021-04-28 01:49:21	102
445	Miami	FL	Loss of consciousness / fainting	-166.715587	Through effort public carry hold social science through.	f	2021-07-02 23:46:07	63
447	Little Rock	AR	Loss of consciousness / fainting	151.609892	Source economic style.	t	2021-04-02 09:35:55	58
459	Charleston	WV	Loss of consciousness / fainting	-24.164446	Behavior magazine lead rest.	t	2021-10-03 14:07:31	94
461	San Francisco	CA	Loss of consciousness / fainting	28.892364	Discover personal feel last difficult attack pick fill.	f	2021-05-18 06:46:51	54
478	Portland	OR	Loss of consciousness / fainting	-14.398086	Usually pull believe adult southern.	f	2021-05-16 00:13:48	73
479	Houston	TX	Loss of consciousness / fainting	132.932845	Art to also senior girl.	t	2021-10-04 04:35:50	97
503	Austin	TX	Loss of consciousness / fainting	-4.554815	Condition move story up car modern.	t	2021-07-08 09:12:24	98
506	Detroit	MI	Loss of consciousness / fainting	-46.264246	Six many south stop personal attention serious.	t	2021-10-04 02:00:47	76
515	Burlington	VT	Loss of consciousness / fainting	-176.249893	Career appear it democratic buy real her.	t	2021-09-01 12:58:41	100
534	Sioux Falls	SD	Loss of consciousness / fainting	54.171210	Too begin thank.	t	2021-04-02 20:17:41	95
556	Newark	NJ	Loss of consciousness / fainting	-62.389098	Professional accept traditional challenge pattern place.	f	2021-04-20 07:53:23	84
585	Salt Lake City	UT	Loss of consciousness / fainting	-60.069618	Fall report and.	f	2021-06-13 09:36:52	99
593	Buffalo	NY	Loss of consciousness / fainting	-21.511081	Eat teacher military energy life suddenly.	f	2022-01-05 19:45:40	87
598	Austin	TX	Loss of consciousness / fainting	-43.662812	Accept avoid office meeting it meet available.	t	2021-06-11 16:10:27	98
617	Little Rock	AR	Loss of consciousness / fainting	-80.697499	For strong perform number.	f	2021-10-30 11:04:03	58
630	New Orleans	LA	Loss of consciousness / fainting	-35.291681	Discuss herself quickly air collection.	t	2021-10-02 04:41:25	72
668	Fargo	ND	Loss of consciousness / fainting	-104.593824	Hope possible develop end put sure.	f	2021-11-29 03:02:33	89
672	Charlotte	NC	Loss of consciousness / fainting	89.197283	Six reach close case skin condition go.	f	2022-01-25 09:13:49	88
674	Manchester	NH	Loss of consciousness / fainting	120.860609	Write finally stock before check oil huge.	t	2021-08-20 21:58:59	83
680	Kansas City	MO	Loss of consciousness / fainting	121.610138	Cause skill particularly individual.	f	2022-02-09 18:43:54	79
681	Honolulu	HI	Loss of consciousness / fainting	-21.228589	Between treatment force traditional.	f	2021-10-18 07:52:46	65
684	Birmingham	AL	Loss of consciousness / fainting	20.015017	Share will charge two reduce stock.	f	2021-06-19 23:38:12	55
687	Los Angeles	CA	Loss of consciousness / fainting	-167.487402	Language while hair just say world.	t	2021-08-28 15:02:37	53
700	Philadelphia	PA	Loss of consciousness / fainting	-163.554884	Into expert artist investment general.	t	2021-07-21 09:32:30	92
707	Salt Lake City	UT	Loss of consciousness / fainting	-179.308086	Market lot record room thousand once lead media.	f	2021-12-20 13:14:03	99
722	Indianapolis	IN	Loss of consciousness / fainting	-25.595207	Answer two himself TV more agreement forget.	f	2021-04-09 13:22:22	68
736	Albuquerque	NM	Loss of consciousness / fainting	-62.637008	Tonight house option push run young order.	f	2022-02-19 21:28:07	85
747	Baltimore	MD	Loss of consciousness / fainting	44.207252	Short something side toward part.	f	2021-03-17 01:18:09	74
759	Anchorage	AK	Loss of consciousness / fainting	-175.818477	Very allow happen someone.	t	2022-02-28 03:57:11	56
769	Virginia Beach	VA	Loss of consciousness / fainting	133.855873	Dinner evidence hope.	f	2021-12-22 23:20:18	101
771	Salt Lake City	UT	Loss of consciousness / fainting	-25.889010	Better a month approach.	t	2021-10-09 13:05:57	99
814	Miami	FL	Loss of consciousness / fainting	107.957135	Middle as shake sure sea center.	f	2021-05-05 18:17:14	63
819	Albuquerque	NM	Loss of consciousness / fainting	97.924372	Table religious fine car remain.	t	2022-01-23 09:24:26	85
820	Minneapolis	MN	Loss of consciousness / fainting	-51.665451	Allow hold language partner.	t	2021-03-19 12:46:08	77
864	Charleston	WV	Loss of consciousness / fainting	-134.686671	Together whom early relationship why.	f	2021-06-02 19:04:20	94
871	Albuquerque	NM	Loss of consciousness / fainting	-112.381339	Physical single scientist part until.	f	2021-12-10 18:49:15	85
873	Jacksonville	FL	Loss of consciousness / fainting	1.561302	Organization discuss those agree poor growth.	f	2021-08-25 14:50:31	62
880	Las Vegas	NV	Loss of consciousness / fainting	149.013236	Little seat partner attorney.	f	2021-04-06 12:05:39	82
884	Salt Lake City	UT	Loss of consciousness / fainting	8.240479	Wide put guy many particularly range.	f	2021-04-11 07:45:53	99
889	Wichita	KS	Loss of consciousness / fainting	-104.127585	Join oil series court compare.	f	2021-07-22 02:12:18	70
898	Baltimore	MD	Loss of consciousness / fainting	62.358006	Property dark myself arm sport member.	f	2021-11-12 12:10:40	74
913	Buffalo	NY	Loss of consciousness / fainting	-101.315463	Probably wonder sport the audience what.	f	2021-07-09 17:48:11	87
916	Los Angeles	CA	Loss of consciousness / fainting	80.411835	Response water little actually improve paper any.	f	2021-03-27 22:00:02	53
932	Indianapolis	IN	Loss of consciousness / fainting	119.077079	Question usually seek new international mean.	f	2022-01-30 12:15:15	68
957	Minneapolis	MN	Loss of consciousness / fainting	127.630133	Real college cause nothing factor finally.	f	2021-08-04 14:31:37	77
982	Fargo	ND	Loss of consciousness / fainting	-69.660837	Set maintain expert member four change successful.	t	2021-09-30 16:38:43	89
1005	New York City	NY	Loss of consciousness / fainting	155.348166	Hour beyond company condition.	\N	2022-01-10 08:15:09	86
1007	Austin	TX	Loss of consciousness / fainting	54.195432	Leave economic may cultural country either oil.	\N	2022-03-08 12:11:42	98
1013	New York City	NY	Loss of consciousness / fainting	-119.603781	Pressure collection western act agree.	\N	2022-02-11 23:45:41	86
1020	Kansas City	MO	Loss of consciousness / fainting	66.297709	Business leader continue.	\N	2022-02-22 15:54:39	79
1024	Wilmington	DE	Loss of consciousness / fainting	-135.481778	Size its remember attorney whether happen.	\N	2022-02-13 12:05:54	61
\.


--
-- TOC entry 3371 (class 0 OID 159612)
-- Dependencies: 211
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.locations (id, city, state) FROM stdin;
53	Los Angeles	CA
54	San Francisco	CA
55	Birmingham	AL
56	Anchorage	AK
57	Phoenix	AZ
58	Little Rock	AR
59	Denver	CO
60	Bridgeport	CT
61	Wilmington	DE
62	Jacksonville	FL
63	Miami	FL
64	Atlanta	GA
65	Honolulu	HI
66	Boise	ID
67	Chicago	IL
68	Indianapolis	IN
69	Des Moines	IA
70	Wichita	KS
71	Louisville	KY
72	New Orleans	LA
73	Portland	OR
74	Baltimore	MD
75	Boston	MA
76	Detroit	MI
77	Minneapolis	MN
78	Jackson	MS
79	Kansas City	MO
80	Billings	MT
81	Omaha	NE
82	Las Vegas	NV
83	Manchester	NH
84	Newark	NJ
85	Albuquerque	NM
86	New York City	NY
87	Buffalo	NY
88	Charlotte	NC
89	Fargo	ND
90	Columbus	OH
91	Oklahoma City	OK
92	Philadelphia	PA
93	Providence	RI
94	Charleston	WV
95	Sioux Falls	SD
96	Nashville	TE
97	Houston	TX
98	Austin	TX
99	Salt Lake City	UT
100	Burlington	VT
101	Virginia Beach	VA
102	Seattle	WA
103	Milwaukee	WI
104	Cheyenne	WY
\.


--
-- TOC entry 3379 (class 0 OID 159660)
-- Dependencies: 219
-- Data for Name: tips; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tips (id, anonymous, username, city, state, coordinates, incident_type, description, date_time, user_id, location_id, incident_id) FROM stdin;
1	f	amanda12	Chicago	IL	43.741021	Stabbing	Wall take management experience.	2022-03-10 23:59:31.534377	152	67	1001
2	t	\N	Fargo	ND	105.604836	Overdose	\N	2022-03-10 23:59:31.545727	\N	89	1002
3	t	\N	Salt Lake City	UT	112.257722	Property Fire	\N	2022-03-10 23:59:31.557	\N	99	1003
4	f	michael44	Salt Lake City	UT	150.657748	Overdose	\N	2022-03-10 23:59:31.564022	196	99	1004
6	f	jeremy17	Albuquerque	NM	-169.791419	Domestic Violence	Century call imagine guy deep.	2022-03-10 23:59:31.582249	161	85	1006
8	f	timothy137	Virginia Beach	VA	130.962888	Property Fire	\N	2022-03-10 23:59:31.599082	139	101	1008
9	f	jamie143	Boston	MA	-137.335909	Vehicle accident	\N	2022-03-10 23:59:31.608259	192	75	1009
10	f	stephanie78	Fargo	ND	107.744811	Stabbing	Key hotel degree for.	2022-03-10 23:59:31.616252	189	89	1010
11	f	willie115	Des Moines	IA	-4.507400	Property Fire	Culture modern consumer may evidence one during.	2022-03-10 23:59:31.625686	115	69	1011
12	t	\N	Milwaukee	WI	-152.903890	Traumatic Injury	Difference city each director.	2022-03-10 23:59:31.63268	\N	103	1012
14	f	amy64	Manchester	NH	-43.709241	Traumatic Injury	Street usually year student.	2022-03-10 23:59:31.649443	123	83	1014
15	f	cassandra68	Milwaukee	WI	94.768537	Fight	Pull everyone animal decide fact strategy.	2022-03-10 23:59:31.657968	177	103	1015
16	t	\N	Salt Lake City	UT	160.075861	Vehicle accident	\N	2022-03-10 23:59:31.665677	\N	99	1016
17	f	audrey48	Wilmington	DE	107.026521	Fight	\N	2022-03-10 23:59:31.674681	153	61	1017
18	t	\N	Bridgeport	CT	14.992388	Behavioral/Psychiatric	Continue score year five media land could.	2022-03-10 23:59:31.68164	\N	60	1018
19	t	\N	San Francisco	CA	22.962837	Vehicle accident	\N	2022-03-10 23:59:31.690641	\N	54	1019
21	f	ashley43	Detroit	MI	-15.762097	Property Fire	\N	2022-03-10 23:59:31.706782	127	76	1021
22	f	pamela92	Atlanta	GA	-43.208878	Traumatic Injury	If service when husband study establish.	2022-03-10 23:59:31.712781	124	64	1022
23	f	sonya99	Providence	RI	15.976659	Stabbing	Fight road defense.	2022-03-10 23:59:31.722684	126	93	1023
25	f	sharon138	Baltimore	MD	-52.381300	Bleeding	\N	2022-03-10 23:59:31.739512	112	74	1025
26	f	martha94	Boise	ID	124.984623	Vehicle accident	Prove sport assume poor now.	2022-03-10 23:59:31.746511	149	66	1026
27	f	christina92	Minneapolis	MN	-130.263902	Behavioral/Psychiatric	Speech player agreement growth every.	2022-03-10 23:59:31.755512	168	77	1027
28	t	\N	Philadelphia	PA	-35.341879	Property Fire	Since affect claim animal shake.	2022-03-10 23:59:31.785332	\N	92	1028
29	f	john71	Charlotte	NC	-18.765580	Domestic Violence	Explain that machine set.	2022-03-10 23:59:31.795958	145	88	1029
30	t	\N	Albuquerque	NM	128.620168	Fight	Check national tell its dark carry.	2022-03-10 23:59:31.806523	\N	85	1030
31	f	maria45	Bridgeport	CT	35.720828	Stabbing	\N	2022-03-10 23:59:31.813521	114	60	1031
32	t	\N	Los Angeles	CA	-1.847993	Stabbing	From grow sit half those common.	2022-03-10 23:59:31.824189	\N	53	1032
33	t	\N	Oklahoma City	OK	-124.237348	Bleeding	\N	2022-03-10 23:59:31.830183	\N	91	1033
34	t	\N	Jackson	MS	41.686939	Traumatic Injury	\N	2022-03-10 23:59:31.839965	\N	78	1034
35	f	tara69	Boston	MA	-177.613300	Cardiac arrest	Even standard more study.	2022-03-10 23:59:31.846144	158	75	1035
36	t	\N	Boston	MA	74.446662	Stabbing	\N	2022-03-10 23:59:31.855891	\N	75	1036
37	t	\N	Baltimore	MD	-136.960967	Behavioral/Psychiatric	Want without statement man however case.	2022-03-10 23:59:31.862891	\N	74	1037
38	t	\N	Virginia Beach	VA	-116.194104	Vehicle accident	\N	2022-03-10 23:59:31.871978	\N	101	1038
39	f	nicholas84	Fargo	ND	112.418172	Fight	Small eight may sister management tend spend.	2022-03-10 23:59:31.878398	182	89	1039
40	f	daniel121	Charlotte	NC	-87.484567	Bleeding	\N	2022-03-10 23:59:31.888017	190	88	1040
41	f	mr.70	Charleston	WV	117.117375	Domestic Violence	Half cell weight color people end maybe.	2022-03-10 23:59:31.89502	151	94	1041
42	f	tyler126	Los Angeles	CA	-3.010068	Domestic Violence	\N	2022-03-10 23:59:31.904069	144	53	1042
43	t	\N	Miami	FL	-57.037751	Property Fire	\N	2022-03-10 23:59:31.91105	\N	63	1043
44	f	maria45	Little Rock	AR	-18.252260	Seizure	\N	2022-03-10 23:59:31.920224	114	58	1044
45	f	lauren54	Newark	NJ	-82.934135	Domestic Violence	\N	2022-03-10 23:59:31.927615	164	84	1045
46	f	tara69	Austin	TX	59.671778	Stabbing	\N	2022-03-10 23:59:31.935791	158	98	1046
47	t	\N	Virginia Beach	VA	-158.413412	Domestic Violence	Morning quickly rich stuff.	2022-03-10 23:59:31.943782	\N	101	1047
48	t	\N	Jackson	MS	41.907030	Cardiac arrest	\N	2022-03-10 23:59:31.952603	\N	78	1048
49	f	teresa69	Baltimore	MD	-1.637458	Stabbing	\N	2022-03-10 23:59:31.960849	109	74	1049
50	f	brianna39	Jackson	MS	-92.228788	Fight	Pay true catch happen too.	2022-03-10 23:59:31.970862	128	78	1050
5	t	\N	New York City	NY	155.348166	Loss of consciousness / fainting	Hour beyond company condition.	2022-03-10 23:59:31.574863	\N	86	1005
7	f	timothy111	Austin	TX	54.195432	Loss of consciousness / fainting	Leave economic may cultural country either oil.	2022-03-10 23:59:31.592082	176	98	1007
13	t	\N	New York City	NY	-119.603781	Loss of consciousness / fainting	Pressure collection western act agree.	2022-03-10 23:59:31.642305	\N	86	1013
20	t	\N	Kansas City	MO	66.297709	Loss of consciousness / fainting	Business leader continue.	2022-03-10 23:59:31.696779	\N	79	1020
24	t	\N	Wilmington	DE	-135.481778	Loss of consciousness / fainting	Size its remember attorney whether happen.	2022-03-10 23:59:31.73019	\N	61	1024
\.


--
-- TOC entry 3373 (class 0 OID 159621)
-- Dependencies: 213
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, full_name, username, password, date_of_birth, email, phone) FROM stdin;
101	Nicholas Jones	nicholas63	34f1866e4bec9e17d5876db384ca066ffcd21baff54caeb3e153153eb1732a6a8bd86a717dda997739e4cb5966b7e78fb199a7ebb15519afd0908d39d10c14e0	1969-07-26 00:00:00	alyssacook@hoover-martin.com	(303)421-6031
102	Cathy Weaver	cathy1	7982afa9f4de72f225b4e40107a4fe9574171ad490d3672267b03c85aafd700cc9bcac31586ea3b3272a3ce222cd372a1bfce26f40e8bca346bb89b48a31488a	1941-11-20 00:00:00	kwalters@peterson.com	3910379506
103	Adam Casey	adam16	2f795ea2292537e57ecf6972ed4dc4d359a97f2aaa96ff0b8350ea68b50fd2d9a73369d68cf03a691d945e9fb69d04c38d7e23423d74b58f3dc0d466a9b93b0d	2006-12-06 00:00:00	george87@hotmail.com	+1-487-445-6063x99000
104	Brandon Cunningham	brandon81	07e316151a397d1372991d7a3aa6bbd843f04d085ea69be35b5359617274a16f995b27f85c282171f2331453773cdf4db3bebcc4be4e184a4d68510a6de2bd52	1914-08-10 00:00:00	jamie16@bowman.com	001-920-084-1692x5149
105	Mr. Robert Stevens Jr.	mr.29	eb2328b88adf2b66ba082613e0e4d27e8c4171052d17884c19cc72bd7665b72e40e56a12ee4f9865cb58987aa1a77ce20088dc9931f6ffa0a47168b79210ee90	2013-09-26 00:00:00	daniel20@gmail.com	7805195560
106	Eric Waters	eric22	f4532e9933c33474cd6d26f2a5a49d694f2d736f969b5edde4c9eb99f4d31196941ad6fd5419fc0f288c9fdf6aff212ff50dd174ff5bf7e2e36ea535ffa80267	1913-12-06 00:00:00	tylermichaela@gmail.com	040.142.5783
107	Amy Green	amy26	1327db22ee3db40f46db9c53fe164dc9369b7f71bc5d0f10509ad2b8ec4980388a3678508ed020beec278742032cb6d203328570a99d8b90584423a0664a71e7	1926-01-31 00:00:00	jpena@gmail.com	+1-839-325-7230
108	Sherri Stout	sherri60	db3a07b01c0de5374174f6483617a607aeb4cf60f872d7ad61d71796519381460ec3d34dbbd1b017fdfca3214ea96d057228add54592abd95fd6a5283b244ea9	1996-08-06 00:00:00	tmedina@yahoo.com	+1-792-508-1780x2308
109	Teresa Ayers	teresa69	1ace0169b87c0c7be5d26bd7931d580e325337ceb591bce5badbfbe7b34d08d67c9a3c0b5a15afb7dc4236e8e686824cce65758719635b3a7a6cf0ef40245401	1983-02-01 00:00:00	mrich@yahoo.com	001-249-954-8841x73922
110	Samuel Ortiz	samuel2	7cd4857cedb00c998ac468d266a7ab334d25ad4bb70eb70ab7fd32c92ba35aaff122c3c2e3d718b4b615139a2d6a6452f2da49a718330c4d1418c13bbbb9aa85	2016-03-05 00:00:00	randallleon@oliver.info	672.700.3277x4073
111	Melissa Lynch	melissa30	592084cdaf0878808f6c0918f3cb96e792447c35f61477c9593934b7d5ddb2e357ea0e878ea12db362f3965bd463f447dc9ed221aea654a2f8c06b8479a45b55	1981-01-14 00:00:00	morganmichael@arroyo.com	874-906-5018
112	Sharon Farmer	sharon138	5476845955459eb07af3a3dcbdacef65b6aa3fd6100284333f541e96118b8fb794d0feac0b49a0487a24121a8061e8589e1c57e59cd6ad25a618ed775e032cef	1925-05-15 00:00:00	ashley27@gmail.com	(457)141-6670x857
113	Zachary Rose	zachary51	0d683dabd68b5cabc2cbc54efbf3dcc6f9c8917f5c4b7c2931c7b31f179aac41c7cd83822c72dd68b462032b5431c479b4cf0df1b432af493c30a43cd26c72c5	1957-02-18 00:00:00	jessicacain@george.org	001-311-229-1238
114	Maria Wolf	maria45	2e2c3e6fc400a4a21c4d49dadc5997dde254694d937e5996217c0f82bc079eb4c7ede8a9c2305709e5065898899285515f94d645f04c0316129ff59e14b48b9f	1962-10-26 00:00:00	martinezjacqueline@gmail.com	(912)199-2611
115	Willie Parker	willie115	b3668f9681a2a0b4e54524928143a6c97d83c63e97507075602172e75ba4ff842fcf78c7250bb7eae16b516f4a30a5f2ea0aa1ca39811f84fdaba504560d35b8	1961-02-13 00:00:00	thomas20@gmail.com	+1-025-877-0857x97782
116	Deborah Patterson	deborah114	8e006f79b0671ee0d475ab0f93b5d5cd3153d0c9a4d427e454c52d4de9362e9056e0f95c238baf50e342994c5e85b2050fb788c8dda1ff0ac0aaf675efbbb4d5	2009-06-29 00:00:00	lchen@wheeler.com	001-381-200-7513x67146
117	Mr. Daniel Vang DDS	mr.149	9f270965fc0a2cc1848a4b953ccf411ce646e80156036e29346afba0beb0bc3093f313be1614bb0c90dcfcff0468287f451fa8283886b2e42ede6730a0861a10	2003-03-09 00:00:00	lucas48@powers.com	786-371-7214x931
118	Gary Mills	gary17	21d246b4be8b7f5a1e0e6596221a2a8f6de4cabd8d794504dcca107955922ee708005d307ae41845caf8e85be074f494d9a698f628f64dc33b56bfe59d752db3	1939-07-12 00:00:00	angelathomas@hale-johnson.com	+1-089-500-0996x69264
119	Jeffrey Ward	jeffrey110	3931e6a1aaab78c0fe3e953f775c6eba49475e79e3ecbb6003e7def3f01183b23ec77664f5391c7ec4bfc0a2c3d4b6550d308a87c19eaa4d6dc9f0913788a640	2002-03-22 00:00:00	samantha97@hotmail.com	468-514-7234x56049
120	Kimberly Adams	kimberly36	fc4d788e4446c1eed71fb77e888fb63bd0bf9485d6c1b21f19250bcafc48de1e623cbfffdaca0333104e0c1163d5339b88139fbe16895edce3bd5c3ace7cc87f	1943-05-26 00:00:00	edwinmoore@myers.biz	413.503.9210
121	William Cruz	william2	249b8abdca700f3090d5c8ad60b52ae1bc88d83ea05fc3b07e0a488c6657c3eb471d0cc186f6173044740a515dda4c8629726ea4d25af588ceb4d79bf4739827	1925-09-29 00:00:00	hayescheryl@anderson-wood.net	001-683-588-2506x998
122	Rhonda Martinez	rhonda6	27447d135825b4c73d0e14bd4742f74b08103fc39208e079df9b40f0baeead9947d97f40aaaf0956aae1fa715c4fc4f7db4c58ead2eff3a06b2ba155112dfccf	1983-07-25 00:00:00	evansrodney@yahoo.com	(403)109-4731
123	Amy Ortega	amy64	69f35fc35c9f6c0ce3b38bb4432bfab226415111c7ca9c6e67db88b783726951543fe68cad7578efea88472f393cccc0e8ed0ae0b5695c061f1079d381940ae3	1920-04-14 00:00:00	davidhoover@taylor.com	(602)884-2636x591
124	Pamela Kelly	pamela92	e365f1f02077e635d5cb478954915fad1a7641f51054dbba44b426443f7c2c7c868bba18d6809eca8e587ccaae7a038942552509fca77d3e90fd5eb183574ae5	1947-02-17 00:00:00	johnglenn@carr.com	001-883-820-7048x969
125	Julie Kidd MD	julie77	198c9080eeda790b303ad3a3cea6f69dbf1e3eec69cb131fadec434894c579ab2d517425f185e94350ed84728cfba15a4ba664fcbe949a1a48ead02837dfb204	2001-03-11 00:00:00	qromero@hebert-lopez.biz	3692089969
126	Sonya Hicks	sonya99	30898b07c0470cf02d039710a5b24f18a639dd87194a2f46303f2263e96bc4defe754b87d8cfbd19c013a95697f21c1058f1d63dc6d285cc9ff403c4d1255ece	1960-08-03 00:00:00	harrisonmegan@gmail.com	339-980-0908x74012
127	Ashley Hayden	ashley43	d62675dc51d59deec2d7aef1522fafc16cce2af5445dc0cc2798341c827405ab6f88ac37bb14bf1b3b2106ca4cc42c64efc098f6dc1048cd48a12b57b4887618	2020-06-10 00:00:00	mgarcia@yahoo.com	2844789718
128	Brianna Combs	brianna39	63f763a79a8e932b2ae10e56dc6b0f0bd64073a6c3fcb15659f97d088e9b32b4123f1b8d1b7b998c31ba9fb011353287b0c330a7d1e21a242154daa149496da9	1961-08-26 00:00:00	vmolina@curtis.net	496.367.9374x24369
129	Jeffrey Moon	jeffrey34	4e14423f28fcde417039ef3eea90ed8f1653a5f712f96de6fa02ca21e26ad2b54ededd0896fda073b909f97b189a50ac4a4e712133fb59573179a384b64da4f4	1924-05-23 00:00:00	fboyer@yahoo.com	(469)269-9279x5312
130	Kevin Johnson	kevin18	0c92b5ad14c4727aa9b0b655c57db5ccfbb16e24785ec9bf7f5c947ec8081381ae8028acea61a5cd0a65dade7897a0fd5595d55c67af414bc647338edb339919	1923-01-19 00:00:00	edwardhardin@gmail.com	115-601-2916
131	Miguel Schmitt	miguel108	15a37d5da51ce79e77847feab4f56a4ee841296bc38ee5447417f2498177728849710c99cc3d5c55c20b8d77d3bde638517edd3ae53493b22b53192fdebfb5e3	1992-04-24 00:00:00	mfrench@chavez.net	(535)510-9216x28655
132	Hector Sparks	hector53	6c709b3eda6710bb0a6c7ede0ab347435eb9e77f37284d13a30d2ef95a44b04f472747b219e4395d9b16e082ba87a70f539397980c0d9dea9e9be5dfa75cc4fb	2011-05-20 00:00:00	sarah83@gmail.com	(252)400-1601
133	Megan Campbell	megan77	8ac331c560aaf83fac755dfa56e533ad8d355df43f38f347de0d0f6afe1af40d006791809ca5d9b2bf6d2e47b4901df6361bd5934394409d9bceee34e858661c	1908-11-15 00:00:00	pcohen@gmail.com	658.736.9717
134	Brittany Novak	brittany83	5f43d77b0a812cc08dcf2f2ac57dc614347d7b071a4963c5c6cfe7db107b7efb96f7a6dde1d58b20e0aef773e8c5d065a648979a83d7fadc6e93fb07c35242fe	1936-10-22 00:00:00	stephaniemeyers@martinez.com	573.795.2879
135	Meghan Watson	meghan77	88c6748955d1d4c9e84fb9086a90670e8746bfb5b083a0f1acf23096b34bfa859a900756dd40ae91e6c3320044711be6c4ed7f43a26191c73cdcab7e36c82589	1934-03-19 00:00:00	bonnieolson@yahoo.com	+1-763-925-0072x37860
136	Sherri Pacheco	sherri46	600d4aa9413407be06db79deb1a906f172c887e2311a7a223b79c541615205ae87713b0ac89faa156f258c791b210360e51359ba5b2a587dc3d67d3b26c1b93f	1919-11-05 00:00:00	blakejoseph@hotmail.com	951-818-7597
137	Paul Khan	paul23	1dca203e2654290a5c67582cc4a47003185683b8f8e8fef041ede04f0f40cc92fcb9e3bf6df1606bd02a6e5e6d57fc70bc542d004c238cf7ac83088b7bfb5ef1	2008-04-13 00:00:00	jeffrey56@chapman-rose.org	001-895-842-5312x996
138	John Martinez	john52	5c92cb5703700ccb2eec1d4515f09dd3607c7703ded65781ca403fa7ab08e5361a92e79ce8da315c5ec0e23d050b22374145bac45b2e47a4a1b8af72584a0ef7	1920-11-14 00:00:00	rdean@mcgee.org	(169)648-5988
139	Timothy Meyer	timothy137	3061b549656eebd38f8522ea64a2022bbd5187b6dfb86f075b363ed6d5eb77eccb01c26e9fe25aeee4f8a00a311656bab90d159f32375bb91b9ba31fad7e4fe1	1908-10-29 00:00:00	hayesemily@gmail.com	+1-509-877-4143x97477
140	Ronald Moss	ronald138	ab127d55011be08c1c6675e04adf6385acca8e93eb811e1617329b45ed0829f0b8a82ff359e77e64ea04d9fed0dcc92fcb208ecf7976c8b33df0ec2c76d0b8ea	1912-02-21 00:00:00	martinezbenjamin@yahoo.com	027-256-7198x570
141	Scott Barton	scott31	8e61e4998b44676c5942f4800d7b362231eaf4cdcdf7d1edc907e1c5c5e6a62081b629181d05abfd5cdac670f3d0e46f126d3fb247f93c75698ee0d8352f2cc1	1960-07-12 00:00:00	turnersharon@hotmail.com	845-060-4533x06763
142	Christopher Garrett	christopher25	b64a925625752d98c1804ba8758ebbf6b1177aef049e7909e6b3854dc228f9cbd2948b85233a6109103cc3266f31edf37381818e6ab7b07512b7c9fb84faee1b	1908-04-23 00:00:00	aarnold@hotmail.com	+1-496-342-2357
143	Christopher Mata	christopher121	d9ca1e63751b9f85e06dbab23724230836bb2fa771aec8d5ce00c7fba7d0e250f5c81686e249ae30f881310a2f9ca0c2daa629b4b0ba20f341fa7e8f472e87a6	1946-01-22 00:00:00	bjohnson@hill.com	956-147-3834
144	Tyler Clark	tyler126	099864f78106495adc63de262a012c8b2a441dc493fe7393d92af33954946c64ef2abe42ec5973c95f581673c8b616e05efc2eb869a18cdd9762b3f8cf5bfb08	1980-12-05 00:00:00	pthompson@yahoo.com	937-841-9922x8730
145	John Sanchez	john71	533ee6a70a78dbd443173478fd5baf1c902e801d4f4f3f4cd10825764078e77cc7abb5bd71b50aa9a7a7ff2b0cbd34d4f0974fdad108643dbc9b0ae63d2f083e	1986-03-15 00:00:00	xalvarado@gmail.com	+1-814-267-5780
146	Jennifer Hernandez	jennifer121	40770546a8c99b0e931301be3744e570d6f4c626cb5e2a0719dc239e8a03c225661cd873116a0c7cb81c7c4f6bd97f4af43b074d604e4976e37705685b857a56	1943-11-02 00:00:00	fmedina@rodriguez.org	+1-333-307-5958x356
147	Brenda Haney	brenda43	e997eeaf25215ddc1265a1eae39f4dfda151f3077c1e84075291ec441943c8e5c4a9ea41886bcf25555f41376aa171226e6224695731757e5195c4d31dc48219	1924-01-20 00:00:00	danielelliott@perry.com	+1-131-187-2902x76769
148	Diane Walton	diane59	0fc79648b3693b9086317f179d336f2e0041f05c6c899a52e1f09deb47cb154ff6fdb3fbb6e35a07accdb49de3b0dfbd3573c4d94b3973f5099871f13014bac3	1939-01-28 00:00:00	bishopgregory@yahoo.com	936-512-1489x90438
149	Martha Jackson	martha94	5d050399b6d7f982756a6ba1104e0a106cde65a22b16db833590b92f9dadbcaad24ff91dd18dc9dacdac62998e700c740b5be260d76db6ed06b09ce940e34ab9	1976-05-17 00:00:00	oalexander@preston-cruz.com	+1-004-845-7896x25786
150	Jessica Willis	jessica22	be02ba702f0692f222f3e47e15c3467d3228862f8597c52d620586ed7acb4d3fbb387fb1f9056b36ecc680eaf243b9fa5850385abb625413f1e35e78ecc689b9	1928-12-28 00:00:00	tracypatton@hotmail.com	1083749093
151	Mr. Tyler Skinner	mr.70	3654be2a2c68c633b4251c1cecde95fe621c7f962f7b281f7600a1bc60b8358d56e75b736eb4aa309dbde5b91e4ed86b0662507815fe4a985fb761cdeefa3714	1906-04-07 00:00:00	rebecca63@williams.com	(011)423-1819
152	Amanda Duncan	amanda12	3f8e9e385fa70b5b502b0cc693123ce111d22d347d7948fa0d1ac0096007118d1b3051610aabbc83714b8388948d7e7d0a6b73af14a12b98c381aaad36ea1828	1923-08-09 00:00:00	bryanlee@jones-donaldson.com	001-877-494-7187x7344
153	Audrey Harmon	audrey48	b752b42fad82ce54f87a37920bf1155a4f596d2f06dcbe23eebe2c63b8c3df36bf85ee6a270c64e486600f1342017e79f7a7ac7a61396edfefbeb5ce20db189d	2018-04-26 00:00:00	austinsmall@andrews-ramirez.biz	0477517476
154	Robin Hopkins	robin91	ad6e645dd48f5158ad94aad8cf89f9ce907dfd38664ec088f397787f860d0657841b44e61b4fdf0a70d5a4dee861514d7dc8660aff30dcd511af422540c1f767	1933-09-16 00:00:00	andrewmartin@spencer.com	028-805-2150x3443
155	Christina Petersen	christina77	3da23388d99b7b6e26a05ab4d64b1bea1be40ae7b211f33d374164673361c63ab5aedb69f9cd1599c66e927ecad5378c10671593f69460113139195606c08acb	2008-02-09 00:00:00	bobby21@humphrey-burns.com	137-934-8712
156	Michelle Thomas	michelle105	3c76b3eb4f942896ad7cb8ccee2c55656f7aaf90f7f2deced2d518c9c1edd07de6dad05349d72ee0083f1d936140056d3289bb77013b7adc71bc81019b8b0f89	1960-05-29 00:00:00	angelclark@grant.net	824.790.1891x01683
157	Charles Thomas	charles109	31705778fffc1618b4cd7c954c4a88742f4dcab086547b51903833a3829e8a468aca8469a1d56072e9ff1a49fdf98c871e05423f7f1d0126a319c2c02c62ee1b	2016-05-27 00:00:00	hayleymiller@hotmail.com	001-471-325-4950x1042
158	Tara Brady	tara69	74e7e99c50b39cb67457409bbaf5ee7f58c808099ce5a1b3bce2c33ef193905d5530bb9014035bc0716ed04681e7977f6b5f764dd7eb7bb82dd9793e1081d0b3	1978-02-15 00:00:00	jacquelinebrown@miller.com	(541)174-7092
159	Stanley Thomas	stanley125	4fb1b1a95d6c922061f237ef1036b4157e316d9dfa213029363266574169edbf7ab7e0c4d62e0d47b0529db982bb6df98fe0371a23b9b69c365f93ad8fd668f9	1950-05-17 00:00:00	luke71@yahoo.com	397.830.5803x1683
160	David Williams	david99	7b812949e140f962fda99bf37bcb455926dd88ec1238c47dabadf08811b4ca85831da4ee89e8bfd691cbf53aabddc87d4ee8bc34120cac7a4cce92bcd6ac52ce	1975-06-22 00:00:00	lynncandice@hotmail.com	+1-299-326-1970x891
161	Jeremy Hood	jeremy17	4f0438a2d1d3a22e2bbd8368290b37ca8a76975d0e6a5640c5bf4130b0a2581f9c7fd1ae31c906b8f6d91e0a1bf28090c3533f252f2f1e09e118bf2b014804e2	2011-01-18 00:00:00	mariabooth@yahoo.com	(388)675-4521
162	Melanie Dean	melanie19	d7db99c339830c2be1a277e0aad346344b8b52d6972c54b65ea3e2506e731917ed9dd8efcfb38ba1b300ac51dd3b63e97beefd22bd7e93ec7d30ad843a62ff2c	2009-05-09 00:00:00	allencarol@hotmail.com	(072)548-6464
163	Julie Lopez	julie105	5a2976e5d3172371c3f7e60428ad4d2e7a23fe00c3c1dd567fa2930c3d53d58b49d3af662164c8d51b45471b63cfb16734eecd0ede434e91db53170d722f5930	1907-10-13 00:00:00	cgray@yahoo.com	+1-023-517-3628x60623
164	Lauren Melton	lauren54	c376550ea1050b636da72415f7a0de53b2e9d4bd2cf7f488c4a53e8c3c1fcbdab6dc51ab499524134b266029954bbcecbcd74f6889f274cc608de659bee87e8e	1926-10-10 00:00:00	danielhoward@evans-cook.com	001-684-287-1716x7346
165	Amanda Duncan	amanda129	26a72ce8a0cf30a511de83f5669d081587b9f544d0758f2602563222738b34902259b0d320f939948f3560d10a8f098a0809943b55f7f60a1a3aceaf91a266ba	1995-03-03 00:00:00	aaron17@anderson.com	001-309-124-2555x5594
166	Elizabeth Garcia	elizabeth87	e826da844b55f802332fbee862ce7f38dfae6c038da8ae4d4d6292b3dbb0f8727a91d8171c6689458016b8b694c4b02217530357e1496e0f2bc04fc5bacd01fc	1982-09-19 00:00:00	chunter@yahoo.com	178.255.5623x3286
167	Ana Nguyen	ana139	2afd0b4c13b5a2785f0fb693f26f6dcef53bc9e9f1670056ea3867933f27507554ed949c9775afc6ae49064dfdab49b9d86d8add0eb7d6ac38f50d7c0de5444f	1929-12-18 00:00:00	greeneshannon@gmail.com	(807)985-9693x8867
168	Christina Kaiser	christina92	087b1bdc539adfc79c3bb2e0d5a447e04d1a1ca7cb4f3b55137549203f76444daec7d470524f254fa8093515fc8c58bbbc3b2c78bb974453bf2524445b2fe865	1984-09-27 00:00:00	brandon86@yahoo.com	001-059-639-2720x4129
169	Kelly Simpson	kelly39	b8f9ecd1c1e91b560ef86f8a71f1aadd7a212a23c6e46f4220394e47b83685a928ed07a96ebc7819b34b2a2a575484e4d7c6422496b57957dbcd03ca9e2d4c14	1989-05-30 00:00:00	igibson@gmail.com	001-931-450-7964
170	Angela Cruz	angela50	3e0ba59bf5d40714b86185b34cf292753d422d7d70de2d34c0453ada65c8407559c7c8e3ced135c91c65619a097d14bd590a81568eae14f6a517c03e45122ff9	1923-12-25 00:00:00	kristenreynolds@roman.net	685.122.9383
171	Dr. Charles Ferguson	dr.5	07bd9383d423de2898c43222326ec3c57cdb02ab2288a9a637d62c67f69d087f8583f084bd3fda12df2f11274f8cad87452e0cb5229ff714c0128120f5c59e72	1974-11-09 00:00:00	lisa03@barnes-patterson.com	944.774.5767x919
172	Linda Edwards	linda104	447da13f20f579e30b4000463c63202af925272712cf4702d97b857b878753438c66b82f9c53dbec00210be4946e79685af509a9994f606e2aab0cadd88a6eba	1917-05-09 00:00:00	harveyjoshua@ortega-smith.net	(763)631-0779x42884
173	Dawn Hancock	dawn60	c5f93a74278ba22c5c95ae14d9b27d01f01c764f1c0ab3a95b26ef118dff4ea4ced37fffef5b90ceda9ed4db5d17ca62ebbbc1737db34b4d54182e050c5acc7e	1949-01-28 00:00:00	howardcesar@hotmail.com	(180)318-6418x30031
174	Richard Griffin	richard123	8444e24f8c60c03aec088792355f4317cb16811f016521d7c4845354186f9faa505ee92e8635374e5e369d906bd7f730b97f79d766169d65cac6c24119b921f6	1972-02-11 00:00:00	patrickmonroe@mcgrath-king.com	260-512-1683x613
175	Terrence Williams	terrence86	1a731152a08f7be4565f39b98e2dcadda8bb4a10e2d354316ec0d555f5a39fdf75f4fbd22dcc1245cbd06f8e957574ce59ab8586486363152eb2e13a39b87099	1916-06-26 00:00:00	robert95@yahoo.com	(253)861-4872x540
176	Timothy Bauer	timothy111	51d4125b4a0793ecdcda7a926525a21c138273cb52944751ba9e7845d8405a3ddad30854612eff42927ae14b2843d607a70d4e39b764823a53504436f83674c2	1952-11-05 00:00:00	nicholas25@foster.info	0090974804
177	Cassandra Keith	cassandra68	8d0ec94cd959a3f16fbaae94675e0f37f8a63107f10cee283da453d0ab4712cbcbaa550a76d9acbe74da8bb7aed48c2c2c1b073beadf0b377743cb9367625080	1987-06-24 00:00:00	dhoward@gmail.com	001-272-970-3772x143
178	Ryan Little	ryan129	272f0486cb927a65568d9c014319e8d2dafdafd1c304aca1aef4fe8d750a18597d758e7fb50a31fdf5a83634a578c66fc205d56de42e1f95e01647494872bd7c	1957-07-28 00:00:00	eddie11@yahoo.com	001-516-626-2431x4206
179	Crystal Holland	crystal109	afff7c6a6e52665cb4513212104d256d006f9a2914a45e3c8b49a2559b472fcb72877392c7941ab38960e5131107be801da9ef5c12fdef3284054b53bce67b6d	1949-07-25 00:00:00	tiffany77@kaufman.net	001-353-488-3059x55837
180	Linda Clark	linda121	2ccf2fa8ac1b70842e8240a9e46e2b162c9e9c0006e43e01cc3133536f721b5343c6c615f84b9cdfd6f63e8a7f8b75a0aa43879c0dae992ed3f80d6219645cc0	2004-05-19 00:00:00	khudson@walker.biz	829-705-7289
181	Daniel Cunningham	daniel143	81fc6805cda8ae857e7a5849fd1cbbbae9cb95566f078525c22d11dd97f4859d436d086e91e58fd594a418ac1787b3052c9d7d6a821a6b420018b4adc4457f2d	1998-11-19 00:00:00	david97@gmail.com	+1-121-148-5171x2612
182	Nicholas Gould	nicholas84	3d2797e59c9656f5b37ef6b07f3543e67cc295fb7a2431407930271e7aef69b163cd7eb3c422455d4c1a4e0381c2c4587abf645cd81f82e5f53979942ca542d5	1962-02-28 00:00:00	duaneduncan@yahoo.com	150-502-1680
183	Steven Peters	steven5	80e875ffc273112f060c8d13aaea5ed5c56cefc443e0896c2681314f3ade8c9c6388b1779147a10f40eee13f05d8f6f06910224865aa9fa4d96e8240dfaad906	1978-07-12 00:00:00	schroederlisa@dunn-butler.info	752-428-3376
184	Caitlin Clayton	caitlin11	f9502c8fd8ddb180d405ffa832df3cc8707e8f543a862abddd6da03413e737c0c3d01c569a62288cd31da4c20756449ee7b426851d938c6e44986467c0227842	1912-05-04 00:00:00	richardcindy@estrada.org	+1-283-642-8432x901
185	Bryce Hayes	bryce115	fa27d20fa16316b461ba36b18599dab1b05ad1948af68344c61ef3144e5002fa11dffe8a5ede621f0b5b7a5a736cdff3ad0a73ba195818babba9cae3a5f4d048	1994-01-28 00:00:00	heatherali@hanson.com	787-102-9026x3236
186	Richard Hayes	richard52	f5dc425e1b6a91f87a76dda80604349790ea44ef132f4ceb8cc6fee00fef2e5b9cb22aa83ead96ae8e69c8a64f66e27543591fab9047e2406871e955d9a6cd56	1958-01-18 00:00:00	tanyafreeman@horton.com	(760)934-1195x430
187	Sarah Jones	sarah92	f719b10ae1aceaa1046edc4d5353c9f9f25232a83d8ad9fc71c310d144861f81f638b69e74d7bce08be9b94f8eaf55771f85834bec2dd1b20d0fa67b09c924a6	1923-07-06 00:00:00	shoover@nguyen.com	+1-633-937-6737x19307
188	Kevin Caldwell	kevin28	f78e35805be45b12a569a79e8d84c3793b762754870590ca813d4f7154f599ba67771ad9a9934a6f9d46f23300afbea0acd2e8519fdc0f8f5e936fd312d624cc	1906-07-04 00:00:00	kimheather@hotmail.com	2533696110
189	Stephanie Roberts	stephanie78	a08e56c223351e2341958ddd035d99870cf3bdb35555885236e6585d6238dfa177868c54af1a4b5fe42fc6d2aaaa835559daf682f342b1161817eb702f5df53e	1976-05-25 00:00:00	nicholstiffany@hotmail.com	993.825.3264x513
190	Daniel Page	daniel121	b734036c9038dd0a1af95a0b3fd09a5e900a75c8f4a68ca48b5fe5a48cf786b6570a8a0d517e3e1dfb8af3bd33b6712dce4796ca8d8c1a52e1767342702b8c4c	1993-02-19 00:00:00	davisjulie@gmail.com	756.983.2247x9493
191	Pamela Smith	pamela111	26ab94c3721baa86d00978319875810c50142d78331b38cc3303f135ed7ca4648bc651184e309b88bca76b02995658e57841beb0fb3c6377f7196c179d69454b	1958-11-09 00:00:00	johnsonlauren@lee.com	903-920-4828
192	Jamie Edwards	jamie143	3d6d648727788237055f5c9b33735b90b5d0566db0e5541dd4377d8cfaa3ce392c361ab8c96c76b26a7850688928e380fe083d61a0da324aa06ec5f615c8b72d	1998-12-31 00:00:00	martineztravis@hotmail.com	001-520-015-5487x1654
193	Melissa Torres	melissa82	69a8e9ae5ae8cd690e96bc735cf871f7ff4d888093919a7319e70f9293f1f761cf936f462bc9afcf90f8436bb8605e180fa884f4738df9152abda2f73a3c4177	1993-01-03 00:00:00	ericarobertson@hotmail.com	120-025-7167
194	Julie Burton	julie61	ed4a57bdf4051706999e2bb210e27025b5e8994afc7cda5b176e9090d7e641f698b9c147f2599ba00160d98206d2b42cebffa4f0721ce6f0bb5d47324639e771	1995-06-29 00:00:00	andreaedwards@bishop.com	+1-103-464-3724
195	Victor Brooks	victor64	0980d3aab1d6776047c0f2bc28ec0d55a0f6cb7a51825db899b6a05a91e97b3468cf4474e9b57c1429c22c42eb4a70d7221f6f7a9839cfff204f586b0e02bfc2	1998-07-20 00:00:00	michael94@yahoo.com	(179)377-6839x4316
196	Michael Stephens	michael44	6a332debc9a7be94bfaed532ee249c2e787873c15f78a2875959d54790a53c648f462d26e36ea3c1db62360286d8edb8a22b841a1d99c5c1824e6a0ab80742a0	2006-09-02 00:00:00	rrodgers@smith.biz	(853)951-1046
197	Jessica Ryan	jessica132	63b80009040d258f4260ca1e38585b4836f2bcf9d0d5878b79cce6baecb0a58a2057c7ed941dd96f3167b46a813156967c23f75e1893c10378f70bb7b062864b	1973-10-20 00:00:00	ericmccullough@smith-taylor.info	340.465.4723
198	Gabrielle Olson	gabrielle65	89222ebdfa6515d3cc7ea5a220766ebd0bac3b514aaa61cd9c19ddeadf7447ad997157fd1d26c779e52559abc643fdfce126120eab6ef6a35a1b6f48b578b3ed	2017-01-10 00:00:00	geraldfranklin@yahoo.com	318-818-6003
199	Thomas Byrd	thomas144	0a1cb72fcf1f8a32ad139eee84a3efad0488185e2ec007495a488b1bbb50d200fe9fb8c0280a1b3bdc9e3d574bca1899082e48bf358ab5f4ca916bb6a5696055	1966-10-11 00:00:00	joseph45@travis.com	1342448025
200	Amber Gonzalez	amber75	de4b87c90b85b0160e600adcd764c0b69ef0d31fa49486a15c2f66dd27b5eb6ac6bbd7c85dd621d170dc9b033071bb1f1a3bde1dbd95d3f82d0060aa03d50b08	1941-07-18 00:00:00	ashleystephens@hotmail.com	482.863.0932x21726
\.


--
-- TOC entry 3380 (class 0 OID 159683)
-- Dependencies: 220
-- Data for Name: users_content; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_content (user_id, content_id, created_at) FROM stdin;
124	56	2022-03-10 23:59:32.06534
199	59	2022-03-10 23:59:32.06534
196	42	2022-03-10 23:59:32.06534
127	52	2022-03-10 23:59:32.06534
193	18	2022-03-10 23:59:32.06534
132	48	2022-03-10 23:59:32.06534
189	45	2022-03-10 23:59:32.06534
122	40	2022-03-10 23:59:32.06534
107	3	2022-03-10 23:59:32.06534
101	51	2022-03-10 23:59:32.06534
128	35	2022-03-10 23:59:32.06534
116	15	2022-03-10 23:59:32.06534
129	64	2022-03-10 23:59:32.06534
166	28	2022-03-10 23:59:32.06534
197	61	2022-03-10 23:59:32.06534
151	73	2022-03-10 23:59:32.06534
191	36	2022-03-10 23:59:32.06534
103	8	2022-03-10 23:59:32.06534
106	59	2022-03-10 23:59:32.06534
150	59	2022-03-10 23:59:32.06534
124	40	2022-03-10 23:59:32.06534
159	71	2022-03-10 23:59:32.06534
181	46	2022-03-10 23:59:32.06534
130	44	2022-03-10 23:59:32.06534
135	3	2022-03-10 23:59:32.06534
124	3	2022-03-10 23:59:32.06534
152	19	2022-03-10 23:59:32.06534
153	18	2022-03-10 23:59:32.06534
126	64	2022-03-10 23:59:32.06534
180	2	2022-03-10 23:59:32.06534
139	19	2022-03-10 23:59:32.06534
102	64	2022-03-10 23:59:32.06534
127	8	2022-03-10 23:59:32.06534
118	51	2022-03-10 23:59:32.06534
122	33	2022-03-10 23:59:32.06534
129	57	2022-03-10 23:59:32.06534
191	60	2022-03-10 23:59:32.06534
119	34	2022-03-10 23:59:32.06534
108	68	2022-03-10 23:59:32.06534
109	33	2022-03-10 23:59:32.06534
124	67	2022-03-10 23:59:32.06534
186	8	2022-03-10 23:59:32.06534
141	49	2022-03-10 23:59:32.06534
115	9	2022-03-10 23:59:32.06534
121	25	2022-03-10 23:59:32.06534
126	39	2022-03-10 23:59:32.06534
169	74	2022-03-10 23:59:32.06534
141	3	2022-03-10 23:59:32.06534
150	6	2022-03-10 23:59:32.06534
135	51	2022-03-10 23:59:32.06534
187	25	2022-03-10 23:59:32.06534
153	66	2022-03-10 23:59:32.06534
110	61	2022-03-10 23:59:32.06534
124	60	2022-03-10 23:59:32.06534
196	46	2022-03-10 23:59:32.06534
101	37	2022-03-10 23:59:32.06534
190	5	2022-03-10 23:59:32.06534
125	4	2022-03-10 23:59:32.06534
102	66	2022-03-10 23:59:32.06534
180	68	2022-03-10 23:59:32.06534
188	26	2022-03-10 23:59:32.06534
160	7	2022-03-10 23:59:32.06534
197	56	2022-03-10 23:59:32.06534
149	16	2022-03-10 23:59:32.06534
114	67	2022-03-10 23:59:32.06534
181	32	2022-03-10 23:59:32.06534
159	66	2022-03-10 23:59:32.06534
179	14	2022-03-10 23:59:32.06534
173	28	2022-03-10 23:59:32.06534
141	60	2022-03-10 23:59:32.06534
101	21	2022-03-10 23:59:32.06534
107	37	2022-03-10 23:59:32.06534
182	40	2022-03-10 23:59:32.06534
147	18	2022-03-10 23:59:32.06534
190	53	2022-03-10 23:59:32.06534
199	47	2022-03-10 23:59:32.06534
107	46	2022-03-10 23:59:32.06534
159	29	2022-03-10 23:59:32.06534
173	46	2022-03-10 23:59:32.06534
111	7	2022-03-10 23:59:32.06534
193	24	2022-03-10 23:59:32.06534
163	45	2022-03-10 23:59:32.06534
118	55	2022-03-10 23:59:32.06534
171	67	2022-03-10 23:59:32.06534
182	54	2022-03-10 23:59:32.06534
146	56	2022-03-10 23:59:32.06534
146	65	2022-03-10 23:59:32.06534
138	27	2022-03-10 23:59:32.06534
164	9	2022-03-10 23:59:32.06534
129	24	2022-03-10 23:59:32.06534
135	37	2022-03-10 23:59:32.06534
147	2	2022-03-10 23:59:32.06534
170	4	2022-03-10 23:59:32.06534
178	72	2022-03-10 23:59:32.06534
175	55	2022-03-10 23:59:32.06534
113	16	2022-03-10 23:59:32.06534
126	43	2022-03-10 23:59:32.06534
161	10	2022-03-10 23:59:32.06534
178	26	2022-03-10 23:59:32.06534
189	26	2022-03-10 23:59:32.06534
162	39	2022-03-10 23:59:32.06534
147	29	2022-03-10 23:59:32.06534
190	64	2022-03-10 23:59:32.06534
163	47	2022-03-10 23:59:32.06534
194	25	2022-03-10 23:59:32.06534
120	21	2022-03-10 23:59:32.06534
136	38	2022-03-10 23:59:32.06534
184	24	2022-03-10 23:59:32.06534
169	35	2022-03-10 23:59:32.06534
193	35	2022-03-10 23:59:32.06534
146	49	2022-03-10 23:59:32.06534
108	1	2022-03-10 23:59:32.06534
178	47	2022-03-10 23:59:32.06534
115	43	2022-03-10 23:59:32.06534
177	27	2022-03-10 23:59:32.06534
187	59	2022-03-10 23:59:32.06534
123	65	2022-03-10 23:59:32.06534
124	30	2022-03-10 23:59:32.06534
160	29	2022-03-10 23:59:32.06534
143	43	2022-03-10 23:59:32.06534
158	41	2022-03-10 23:59:32.06534
179	9	2022-03-10 23:59:32.06534
176	22	2022-03-10 23:59:32.06534
125	38	2022-03-10 23:59:32.06534
124	48	2022-03-10 23:59:32.06534
128	64	2022-03-10 23:59:32.06534
164	38	2022-03-10 23:59:32.06534
103	19	2022-03-10 23:59:32.06534
129	38	2022-03-10 23:59:32.06534
183	18	2022-03-10 23:59:32.06534
112	31	2022-03-10 23:59:32.06534
154	46	2022-03-10 23:59:32.06534
195	47	2022-03-10 23:59:32.06534
174	33	2022-03-10 23:59:32.06534
131	62	2022-03-10 23:59:32.06534
196	9	2022-03-10 23:59:32.06534
162	71	2022-03-10 23:59:32.06534
164	68	2022-03-10 23:59:32.06534
107	16	2022-03-10 23:59:32.06534
161	5	2022-03-10 23:59:32.06534
101	18	2022-03-10 23:59:32.06534
118	34	2022-03-10 23:59:32.06534
118	43	2022-03-10 23:59:32.06534
191	49	2022-03-10 23:59:32.06534
156	27	2022-03-10 23:59:32.06534
153	10	2022-03-10 23:59:32.06534
120	71	2022-03-10 23:59:32.06534
157	1	2022-03-10 23:59:32.06534
191	3	2022-03-10 23:59:32.06534
111	68	2022-03-10 23:59:32.06534
155	13	2022-03-10 23:59:32.06534
169	30	2022-03-10 23:59:32.06534
102	74	2022-03-10 23:59:32.06534
195	58	2022-03-10 23:59:32.06534
181	4	2022-03-10 23:59:32.06534
112	51	2022-03-10 23:59:32.06534
106	44	2022-03-10 23:59:32.06534
130	75	2022-03-10 23:59:32.06534
173	73	2022-03-10 23:59:32.06534
145	2	2022-03-10 23:59:32.06534
113	68	2022-03-10 23:59:32.06534
118	27	2022-03-10 23:59:32.06534
188	46	2022-03-10 23:59:32.06534
179	22	2022-03-10 23:59:32.06534
185	56	2022-03-10 23:59:32.06534
102	49	2022-03-10 23:59:32.06534
153	67	2022-03-10 23:59:32.06534
128	68	2022-03-10 23:59:32.06534
175	64	2022-03-10 23:59:32.06534
119	74	2022-03-10 23:59:32.06534
134	8	2022-03-10 23:59:32.06534
171	57	2022-03-10 23:59:32.06534
103	23	2022-03-10 23:59:32.06534
146	37	2022-03-10 23:59:32.06534
175	73	2022-03-10 23:59:32.06534
178	35	2022-03-10 23:59:32.06534
104	31	2022-03-10 23:59:32.06534
165	50	2022-03-10 23:59:32.06534
109	27	2022-03-10 23:59:32.06534
103	41	2022-03-10 23:59:32.06534
167	44	2022-03-10 23:59:32.06534
149	8	2022-03-10 23:59:32.06534
170	40	2022-03-10 23:59:32.06534
116	69	2022-03-10 23:59:32.06534
101	50	2022-03-10 23:59:32.06534
132	65	2022-03-10 23:59:32.06534
101	4	2022-03-10 23:59:32.06534
107	20	2022-03-10 23:59:32.06534
171	23	2022-03-10 23:59:32.06534
199	39	2022-03-10 23:59:32.06534
118	20	2022-03-10 23:59:32.06534
105	32	2022-03-10 23:59:32.06534
157	33	2022-03-10 23:59:32.06534
200	68	2022-03-10 23:59:32.06534
145	4	2022-03-10 23:59:32.06534
170	58	2022-03-10 23:59:32.06534
142	60	2022-03-10 23:59:32.06534
139	6	2022-03-10 23:59:32.06534
120	57	2022-03-10 23:59:32.06534
108	37	2022-03-10 23:59:32.06534
174	58	2022-03-10 23:59:32.06534
108	46	2022-03-10 23:59:32.06534
177	8	2022-03-10 23:59:32.06534
175	75	2022-03-10 23:59:32.06534
187	40	2022-03-10 23:59:32.06534
146	39	2022-03-10 23:59:32.06534
142	17	2022-03-10 23:59:32.06534
144	14	2022-03-10 23:59:32.06534
152	27	2022-03-10 23:59:32.06534
171	7	2022-03-10 23:59:32.06534
188	32	2022-03-10 23:59:32.06534
117	45	2022-03-10 23:59:32.06534
170	60	2022-03-10 23:59:32.06534
185	42	2022-03-10 23:59:32.06534
105	34	2022-03-10 23:59:32.06534
131	16	2022-03-10 23:59:32.06534
191	55	2022-03-10 23:59:32.06534
154	36	2022-03-10 23:59:32.06534
194	17	2022-03-10 23:59:32.06534
189	30	2022-03-10 23:59:32.06534
143	8	2022-03-10 23:59:32.06534
181	1	2022-03-10 23:59:32.06534
123	48	2022-03-10 23:59:32.06534
135	22	2022-03-10 23:59:32.06534
162	70	2022-03-10 23:59:32.06534
148	16	2022-03-10 23:59:32.06534
162	15	2022-03-10 23:59:32.06534
128	47	2022-03-10 23:59:32.06534
119	44	2022-03-10 23:59:32.06534
200	63	2022-03-10 23:59:32.06534
199	43	2022-03-10 23:59:32.06534
148	25	2022-03-10 23:59:32.06534
146	71	2022-03-10 23:59:32.06534
199	52	2022-03-10 23:59:32.06534
129	30	2022-03-10 23:59:32.06534
103	11	2022-03-10 23:59:32.06534
169	66	2022-03-10 23:59:32.06534
148	43	2022-03-10 23:59:32.06534
197	28	2022-03-10 23:59:32.06534
151	30	2022-03-10 23:59:32.06534
169	20	2022-03-10 23:59:32.06534
138	51	2022-03-10 23:59:32.06534
123	32	2022-03-10 23:59:32.06534
126	49	2022-03-10 23:59:32.06534
158	63	2022-03-10 23:59:32.06534
116	2	2022-03-10 23:59:32.06534
159	37	2022-03-10 23:59:32.06534
150	34	2022-03-10 23:59:32.06534
134	17	2022-03-10 23:59:32.06534
171	11	2022-03-10 23:59:32.06534
134	26	2022-03-10 23:59:32.06534
118	72	2022-03-10 23:59:32.06534
148	9	2022-03-10 23:59:32.06534
118	17	2022-03-10 23:59:32.06534
180	23	2022-03-10 23:59:32.06534
173	17	2022-03-10 23:59:32.06534
171	20	2022-03-10 23:59:32.06534
177	33	2022-03-10 23:59:32.06534
199	36	2022-03-10 23:59:32.06534
197	11	2022-03-10 23:59:32.06534
114	59	2022-03-10 23:59:32.06534
131	75	2022-03-10 23:59:32.06534
145	74	2022-03-10 23:59:32.06534
112	71	2022-03-10 23:59:32.06534
139	67	2022-03-10 23:59:32.06534
157	48	2022-03-10 23:59:32.06534
174	64	2022-03-10 23:59:32.06534
122	26	2022-03-10 23:59:32.06534
120	8	2022-03-10 23:59:32.06534
120	63	2022-03-10 23:59:32.06534
195	41	2022-03-10 23:59:32.06534
118	47	2022-03-10 23:59:32.06534
143	12	2022-03-10 23:59:32.06534
136	28	2022-03-10 23:59:32.06534
162	47	2022-03-10 23:59:32.06534
199	66	2022-03-10 23:59:32.06534
155	61	2022-03-10 23:59:32.06534
181	5	2022-03-10 23:59:32.06534
180	7	2022-03-10 23:59:32.06534
116	59	2022-03-10 23:59:32.06534
127	68	2022-03-10 23:59:32.06534
113	51	2022-03-10 23:59:32.06534
134	19	2022-03-10 23:59:32.06534
173	56	2022-03-10 23:59:32.06534
195	59	2022-03-10 23:59:32.06534
161	36	2022-03-10 23:59:32.06534
131	4	2022-03-10 23:59:32.06534
151	71	2022-03-10 23:59:32.06534
101	67	2022-03-10 23:59:32.06534
108	18	2022-03-10 23:59:32.06534
131	13	2022-03-10 23:59:32.06534
162	19	2022-03-10 23:59:32.06534
134	37	2022-03-10 23:59:32.06534
112	9	2022-03-10 23:59:32.06534
155	35	2022-03-10 23:59:32.06534
165	24	2022-03-10 23:59:32.06534
160	28	2022-03-10 23:59:32.06534
143	51	2022-03-10 23:59:32.06534
185	66	2022-03-10 23:59:32.06534
159	14	2022-03-10 23:59:32.06534
\.


--
-- TOC entry 3381 (class 0 OID 159698)
-- Dependencies: 221
-- Data for Name: users_tips; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_tips (user_id, tip_id, created_at) FROM stdin;
124	22	2022-03-10 23:59:32.170144
127	21	2022-03-10 23:59:32.170144
128	50	2022-03-10 23:59:32.170144
109	49	2022-03-10 23:59:32.170144
190	40	2022-03-10 23:59:32.170144
123	14	2022-03-10 23:59:32.170144
182	39	2022-03-10 23:59:32.170144
152	1	2022-03-10 23:59:32.170144
145	29	2022-03-10 23:59:32.170144
164	45	2022-03-10 23:59:32.170144
177	15	2022-03-10 23:59:32.170144
114	44	2022-03-10 23:59:32.170144
196	4	2022-03-10 23:59:32.170144
168	27	2022-03-10 23:59:32.170144
176	7	2022-03-10 23:59:32.170144
189	10	2022-03-10 23:59:32.170144
144	42	2022-03-10 23:59:32.170144
149	26	2022-03-10 23:59:32.170144
158	35	2022-03-10 23:59:32.170144
161	6	2022-03-10 23:59:32.170144
192	9	2022-03-10 23:59:32.170144
112	25	2022-03-10 23:59:32.170144
151	41	2022-03-10 23:59:32.170144
153	17	2022-03-10 23:59:32.170144
114	31	2022-03-10 23:59:32.170144
126	23	2022-03-10 23:59:32.170144
115	11	2022-03-10 23:59:32.170144
158	46	2022-03-10 23:59:32.170144
139	8	2022-03-10 23:59:32.170144
\.


--
-- TOC entry 3392 (class 0 OID 0)
-- Dependencies: 214
-- Name: content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.content_id_seq', 75, true);


--
-- TOC entry 3393 (class 0 OID 0)
-- Dependencies: 216
-- Name: incidents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.incidents_id_seq', 1050, true);


--
-- TOC entry 3394 (class 0 OID 0)
-- Dependencies: 210
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.locations_id_seq', 104, true);


--
-- TOC entry 3395 (class 0 OID 0)
-- Dependencies: 218
-- Name: tips_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tips_id_seq', 50, true);


--
-- TOC entry 3396 (class 0 OID 0)
-- Dependencies: 212
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 200, true);


--
-- TOC entry 3204 (class 2606 OID 102231)
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- TOC entry 3212 (class 2606 OID 159639)
-- Name: content content_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content
    ADD CONSTRAINT content_pkey PRIMARY KEY (id);


--
-- TOC entry 3214 (class 2606 OID 159653)
-- Name: incidents incidents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.incidents
    ADD CONSTRAINT incidents_pkey PRIMARY KEY (id);


--
-- TOC entry 3206 (class 2606 OID 159619)
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- TOC entry 3216 (class 2606 OID 159667)
-- Name: tips tips_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tips
    ADD CONSTRAINT tips_pkey PRIMARY KEY (id);


--
-- TOC entry 3218 (class 2606 OID 159687)
-- Name: users_content users_content_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_content
    ADD CONSTRAINT users_content_pkey PRIMARY KEY (user_id, content_id);


--
-- TOC entry 3208 (class 2606 OID 159628)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3220 (class 2606 OID 159702)
-- Name: users_tips users_tips_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_tips
    ADD CONSTRAINT users_tips_pkey PRIMARY KEY (user_id, tip_id);


--
-- TOC entry 3210 (class 2606 OID 159630)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 3221 (class 2606 OID 159640)
-- Name: content content_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content
    ADD CONSTRAINT content_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3222 (class 2606 OID 159654)
-- Name: incidents incidents_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.incidents
    ADD CONSTRAINT incidents_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- TOC entry 3223 (class 2606 OID 159668)
-- Name: tips tips_incident_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tips
    ADD CONSTRAINT tips_incident_id_fkey FOREIGN KEY (incident_id) REFERENCES public.incidents(id);


--
-- TOC entry 3224 (class 2606 OID 159673)
-- Name: tips tips_location_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tips
    ADD CONSTRAINT tips_location_id_fkey FOREIGN KEY (location_id) REFERENCES public.locations(id);


--
-- TOC entry 3225 (class 2606 OID 159678)
-- Name: tips tips_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tips
    ADD CONSTRAINT tips_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3226 (class 2606 OID 159688)
-- Name: users_content users_content_content_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_content
    ADD CONSTRAINT users_content_content_id_fkey FOREIGN KEY (content_id) REFERENCES public.content(id);


--
-- TOC entry 3227 (class 2606 OID 159693)
-- Name: users_content users_content_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_content
    ADD CONSTRAINT users_content_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3228 (class 2606 OID 159703)
-- Name: users_tips users_tips_tip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_tips
    ADD CONSTRAINT users_tips_tip_id_fkey FOREIGN KEY (tip_id) REFERENCES public.tips(id);


--
-- TOC entry 3229 (class 2606 OID 159708)
-- Name: users_tips users_tips_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_tips
    ADD CONSTRAINT users_tips_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


-- Completed on 2022-03-12 00:28:22 UTC

--
-- PostgreSQL database dump complete
--

