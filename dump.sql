--
-- PostgreSQL database dump
--

-- Dumped from database version 14.18 (Ubuntu 14.18-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.18 (Ubuntu 14.18-0ubuntu0.22.04.1)

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
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: marco
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.active_storage_attachments OWNER TO marco;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: marco
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_attachments_id_seq OWNER TO marco;

--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marco
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: marco
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying,
    created_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.active_storage_blobs OWNER TO marco;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: marco
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_blobs_id_seq OWNER TO marco;

--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marco
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: marco
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


ALTER TABLE public.active_storage_variant_records OWNER TO marco;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: marco
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.active_storage_variant_records_id_seq OWNER TO marco;

--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marco
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: marco
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO marco;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: marco
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    title character varying NOT NULL,
    content text NOT NULL,
    ferment_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.comments OWNER TO marco;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: marco
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comments_id_seq OWNER TO marco;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marco
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: ferment_recipes; Type: TABLE; Schema: public; Owner: marco
--

CREATE TABLE public.ferment_recipes (
    id bigint NOT NULL,
    name character varying,
    ingredients text,
    instructions text,
    ferment_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ferment_recipes OWNER TO marco;

--
-- Name: ferment_recipes_id_seq; Type: SEQUENCE; Schema: public; Owner: marco
--

CREATE SEQUENCE public.ferment_recipes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ferment_recipes_id_seq OWNER TO marco;

--
-- Name: ferment_recipes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marco
--

ALTER SEQUENCE public.ferment_recipes_id_seq OWNED BY public.ferment_recipes.id;


--
-- Name: ferments; Type: TABLE; Schema: public; Owner: marco
--

CREATE TABLE public.ferments (
    id bigint NOT NULL,
    name character varying,
    description text,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    ingredients text,
    instructions text,
    fermentation_time character varying,
    start_date timestamp(6) without time zone,
    revisar_fermentos integer,
    review_date date
);


ALTER TABLE public.ferments OWNER TO marco;

--
-- Name: ferments_id_seq; Type: SEQUENCE; Schema: public; Owner: marco
--

CREATE SEQUENCE public.ferments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ferments_id_seq OWNER TO marco;

--
-- Name: ferments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marco
--

ALTER SEQUENCE public.ferments_id_seq OWNED BY public.ferments.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: marco
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO marco;

--
-- Name: users; Type: TABLE; Schema: public; Owner: marco
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    first_name character varying,
    last_name character varying,
    avatar character varying
);


ALTER TABLE public.users OWNER TO marco;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: marco
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO marco;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marco
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: ferment_recipes id; Type: DEFAULT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.ferment_recipes ALTER COLUMN id SET DEFAULT nextval('public.ferment_recipes_id_seq'::regclass);


--
-- Name: ferments id; Type: DEFAULT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.ferments ALTER COLUMN id SET DEFAULT nextval('public.ferments_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: active_storage_attachments; Type: TABLE DATA; Schema: public; Owner: marco
--

COPY public.active_storage_attachments (id, name, record_type, record_id, blob_id, created_at) FROM stdin;
241	image	ActiveStorage::VariantRecord	22	241	2025-07-08 12:16:31.930862
242	image	ActiveStorage::VariantRecord	23	242	2025-07-08 12:16:57.16024
243	image	ActiveStorage::VariantRecord	24	243	2025-07-08 12:16:57.447672
244	image	ActiveStorage::VariantRecord	25	244	2025-07-08 12:16:57.494504
245	image	ActiveStorage::VariantRecord	26	245	2025-07-08 12:16:57.50262
246	image	ActiveStorage::VariantRecord	27	246	2025-07-08 12:16:57.622104
247	image	ActiveStorage::VariantRecord	28	247	2025-07-08 12:16:58.815942
248	image	ActiveStorage::VariantRecord	29	248	2025-07-08 12:16:58.826122
249	image	ActiveStorage::VariantRecord	31	249	2025-07-08 12:16:58.969701
250	image	ActiveStorage::VariantRecord	30	250	2025-07-08 12:16:58.980391
251	image	ActiveStorage::VariantRecord	32	251	2025-07-08 12:17:00.032933
254	image	ActiveStorage::VariantRecord	33	254	2025-07-08 12:19:37.310603
255	image	ActiveStorage::VariantRecord	34	255	2025-07-08 12:19:57.116219
256	image	ActiveStorage::VariantRecord	35	256	2025-07-08 12:19:57.125093
259	image	ActiveStorage::VariantRecord	36	259	2025-07-08 12:21:25.900119
260	image	ActiveStorage::VariantRecord	37	260	2025-07-08 12:21:25.937526
130	avatar	User	344	130	2025-02-17 15:19:27.526208
131	avatar	User	345	131	2025-02-17 15:19:28.513466
132	avatar	User	346	132	2025-02-17 15:19:29.602519
133	avatar	User	347	133	2025-02-17 15:19:30.516744
134	avatar	User	348	134	2025-02-17 15:19:31.686854
135	avatar	User	349	135	2025-02-17 15:19:32.569752
136	avatar	User	350	136	2025-02-17 15:19:33.009384
137	avatar	User	351	137	2025-02-17 15:19:34.262731
138	avatar	User	352	138	2025-02-17 15:19:35.249127
139	avatar	User	353	139	2025-02-17 15:19:36.182367
142	photo	User	355	142	2025-03-18 14:25:13.149173
263	image	ActiveStorage::VariantRecord	38	263	2025-07-08 12:22:26.441314
264	image	ActiveStorage::VariantRecord	39	264	2025-07-08 12:22:26.496154
267	image	ActiveStorage::VariantRecord	40	267	2025-07-08 12:25:38.182688
268	image	ActiveStorage::VariantRecord	41	268	2025-07-08 12:25:38.229536
271	image	ActiveStorage::VariantRecord	42	271	2025-07-08 12:29:33.413382
272	image	ActiveStorage::VariantRecord	43	272	2025-07-08 12:29:35.634625
273	image	ActiveStorage::VariantRecord	44	273	2025-07-08 12:29:35.699724
283	image	ActiveStorage::VariantRecord	45	283	2025-07-08 13:08:28.424689
284	photos	Ferment	596	284	2025-07-08 13:14:51.173036
285	photos	Ferment	596	285	2025-07-08 13:15:07.918981
286	photos	Ferment	596	286	2025-07-08 13:15:30.435666
287	photos	Ferment	592	287	2025-07-08 13:33:56.421455
288	photos	Ferment	592	288	2025-07-08 13:34:08.851004
163	photo	User	344	163	2025-03-27 13:36:49.919882
170	image	ActiveStorage::VariantRecord	1	170	2025-07-01 10:14:18.906688
171	image	ActiveStorage::VariantRecord	3	171	2025-07-01 10:49:39.328053
172	image	ActiveStorage::VariantRecord	2	172	2025-07-01 10:49:39.361807
173	image	ActiveStorage::VariantRecord	4	173	2025-07-01 10:49:39.379523
174	image	ActiveStorage::VariantRecord	6	174	2025-07-01 10:49:39.38612
175	image	ActiveStorage::VariantRecord	5	175	2025-07-01 10:49:39.409029
177	image	ActiveStorage::VariantRecord	7	177	2025-07-01 10:53:18.413456
179	image	ActiveStorage::VariantRecord	8	179	2025-07-04 06:54:31.361478
180	image	ActiveStorage::VariantRecord	9	180	2025-07-04 06:59:23.084789
181	image	ActiveStorage::VariantRecord	10	181	2025-07-04 07:01:29.860966
182	image	ActiveStorage::VariantRecord	11	182	2025-07-04 08:04:16.374081
183	image	ActiveStorage::VariantRecord	12	183	2025-07-04 08:14:01.857545
186	image	ActiveStorage::VariantRecord	13	186	2025-07-04 09:59:58.501543
194	photos	Ferment	592	194	2025-07-07 18:58:51.940965
195	image	ActiveStorage::VariantRecord	14	195	2025-07-07 18:59:08.396822
197	image	ActiveStorage::VariantRecord	15	197	2025-07-08 09:00:22.923419
198	photo	User	360	198	2025-07-08 09:58:38.056893
225	image	ActiveStorage::VariantRecord	16	225	2025-07-08 12:15:15.921594
226	image	ActiveStorage::VariantRecord	17	226	2025-07-08 12:15:15.940197
227	image	ActiveStorage::VariantRecord	19	227	2025-07-08 12:15:16.063496
228	image	ActiveStorage::VariantRecord	18	228	2025-07-08 12:15:16.06921
229	image	ActiveStorage::VariantRecord	20	229	2025-07-08 12:15:16.077908
230	image	ActiveStorage::VariantRecord	21	230	2025-07-08 12:15:17.1976
\.


--
-- Data for Name: active_storage_blobs; Type: TABLE DATA; Schema: public; Owner: marco
--

COPY public.active_storage_blobs (id, key, filename, content_type, metadata, service_name, byte_size, checksum, created_at) FROM stdin;
1	wxj7qkrfnq5v2cusmd9rfk6a80s2	foto.png	image/png	{"identified":true,"width":2342,"height":2376,"analyzed":true}	local	1009707	0GpIXB8qyw0cx4BrcjhDOw==	2024-10-24 10:28:50.087588
130	p5og3qlv1qkbtmujtclkaomvr54f	avatar.jpg	image/png	{"identified":true,"width":300,"height":300,"analyzed":true}	local	31572	KWo7Ehxg/zf5cbZsh6TnoQ==	2025-02-17 15:19:27.520773
131	3qrtrse1klzavjad2ppugeq7evsq	avatar.jpg	image/png	{"identified":true,"width":300,"height":300,"analyzed":true}	local	34865	n5RxkD/KlMmGwOFxk6AWXQ==	2025-02-17 15:19:28.511592
132	nchi5do041xb5h3lhi1xctb5zf4y	avatar.jpg	image/png	{"identified":true,"width":300,"height":300,"analyzed":true}	local	38708	PQlR4q0r7ebd24nHkjMupg==	2025-02-17 15:19:29.60021
33	22v8oih4i5p7r98qh1cj7p2ab7wr	tempeh2.jfif	image/jpeg	{"identified":true,"width":225,"height":225,"analyzed":true}	local	9663	6/GcZhNOIXULMgJgcyHpLw==	2024-10-28 11:25:30.056375
133	mgf7ispnasxx844axl3hrks9ojig	avatar.jpg	image/png	{"identified":true,"width":300,"height":300,"analyzed":true}	local	37966	1QBD7roTqi343qpPVDhXRA==	2025-02-17 15:19:30.514674
34	8xmiwcu19v4flz4k863k7uvckxpi	kimchi.jpg	image/jpeg	{"identified":true,"width":612,"height":407,"analyzed":true}	local	39810	+n+OKoWXNEhNwOCWmo+lBg==	2024-10-28 15:33:23.708148
9	w13xorkkb7o7cq6n83utyvu7308z	gorra-poda.jfif	image/jpeg	{"identified":true,"width":225,"height":225,"analyzed":true}	local	3469	YU/a2M6Ml6xNb7jXeynFeg==	2024-10-26 08:22:32.350491
10	7bpkib4zzpgwy955ts1xw6cx30vb	logo.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	269720	VxUGqYJlL2pR4VRU8rLG3w==	2024-10-26 08:22:32.357504
11	kerq3i1oot4cec91j0p2ryvkbyu7	placeholder.jpg	image/jpeg	{"identified":true,"width":612,"height":612,"analyzed":true}	local	7660	XQbHvpt0ersNFAxwbTAGPg==	2024-10-26 08:22:32.366808
12	mr2fg5omkge35tyqk1izkx5koh8z	planta.jpg	image/jpeg	{"identified":true,"width":612,"height":612,"analyzed":true}	local	23536	Nb94O55pi9ylEOaQvasyVg==	2024-10-26 08:22:32.374059
134	rep4j2m2elrt9ts2n213wip0ip95	avatar.jpg	image/png	{"identified":true,"width":300,"height":300,"analyzed":true}	local	34684	MOqrqQbeU91HBtFMtMAn0A==	2025-02-17 15:19:31.68392
135	rls2ni0zxfxz3oq09pxltggyj2de	avatar.jpg	image/png	{"identified":true,"width":300,"height":300,"analyzed":true}	local	33765	9R7fm1RtnD26kXE5hkmqzg==	2025-02-17 15:19:32.567746
15	1wni48iz96jr3s5qq6pteodvrzpw	gorra-poda.jfif	image/jpeg	{"identified":true,"width":225,"height":225,"analyzed":true}	local	3469	YU/a2M6Ml6xNb7jXeynFeg==	2024-10-26 08:57:14.292043
35	lvdxv6ta5z0doh7b459vb0wshowu	hidromiel.jpg	image/jpeg	{"identified":true,"width":330,"height":391,"analyzed":true}	local	32664	GAPS/rJ/ErNnBwlAiHukAQ==	2024-10-28 16:05:01.319471
136	w0lacplbocf5l0xo6ghzf0ridsvd	avatar.jpg	image/png	{"identified":true,"width":300,"height":300,"analyzed":true}	local	37408	1OSTGkwnTbLA9zwtmscY0Q==	2025-02-17 15:19:33.006732
137	62d1rimy5swb1d607kt7ly796rui	avatar.jpg	image/png	{"identified":true,"width":300,"height":300,"analyzed":true}	local	48039	drfoIALdNDXkw80F/3chVg==	2025-02-17 15:19:34.260493
36	cjvwi067svufozbqdsxjy01vtnxh	cerveza.jpg	image/jpeg	{"identified":true,"width":1024,"height":768,"analyzed":true}	local	175297	V8yHBoLGYiQAdXp/maSp5Q==	2024-10-28 16:06:23.487141
138	gkktyrchknisarb7vnjlbgbpzh9s	avatar.jpg	image/png	{"identified":true,"width":300,"height":300,"analyzed":true}	local	31960	dZgZ1UUMPRmpNjuVHCgEeg==	2025-02-17 15:19:35.246192
139	s5an2mjf6rjjze1kvh4ge1gnw2wl	avatar.jpg	image/png	{"identified":true,"width":300,"height":300,"analyzed":true}	local	28176	YKe3CHgtdIImWS/O4ERmzw==	2025-02-17 15:19:36.179844
140	vwtd5w8hrddw7m1kqmx81rddjlup	5819012398214923370.jpg	image/jpeg	{"identified":true}	local	323453	tIkoCrp74rfuRODJ/JLGfA==	2025-03-13 15:57:30.300593
141	ao119du3o05566xwpp93uw4ruifv	5819012398214923370.jpg	image/jpeg	{"identified":true,"width":960,"height":1280,"analyzed":true}	local	323453	tIkoCrp74rfuRODJ/JLGfA==	2025-03-13 16:01:55.789119
38	3nuk60ccfy0psxhjuqlkvdwd4y3u	gorra-poda.jfif	image/jpeg	{"identified":true,"width":225,"height":225,"analyzed":true}	local	3469	YU/a2M6Ml6xNb7jXeynFeg==	2024-10-28 16:08:44.65534
142	k2v5ohl66n6e3rzks9vfslr723oy	profile_picture.jpg	image/jpeg	{"identified":true,"width":853,"height":1280,"analyzed":true}	local	82638	FHntfuFRuylfoJUUQwQgVQ==	2025-03-18 14:25:13.140599
39	v5hjq34a4ozutmcvn4xfqir9h1ez	phone.jpg	image/avif	{"identified":true,"width":2070,"height":1380,"analyzed":true}	local	35500	qXadn4ftv5tLuJftQ44sfA==	2024-10-28 16:08:57.62577
30	ydqehf64zn1umars04sp2c92ka2r	logo.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	269720	VxUGqYJlL2pR4VRU8rLG3w==	2024-10-28 09:21:17.952055
31	y0eykjgrbwipjyfhnr4ux97duoaq	tempeh.jfif	image/jpeg	{"identified":true,"width":276,"height":183,"analyzed":true}	local	8740	xrhtB5hAqjDBubUDxsuHtg==	2024-10-28 10:52:30.649786
32	hyjocov1wzoc0x55reg4ovmzgaei	juli.jfif	image/jpeg	{"identified":true,"width":960,"height":1280,"analyzed":true}	local	151255	n2MBN57snIJ+RpaoY+yL9w==	2024-10-28 11:16:03.301785
40	adzhftvqf38rhauixuxllhs41rnh	juli.jfif	image/jpeg	{"identified":true,"width":960,"height":1280,"analyzed":true}	local	151255	n2MBN57snIJ+RpaoY+yL9w==	2024-10-28 16:09:49.279685
71	i2ffvgdpdqlkp91tqonk3be0cugm	foto.png	image/png	{"identified":true,"width":2342,"height":2376,"analyzed":true}	local	1009707	0GpIXB8qyw0cx4BrcjhDOw==	2024-11-04 15:31:19.27221
72	cfooh7jenbfs0hpoagdt9t6ito8u	tevez.jpg	image/jpeg	{"identified":true,"width":768,"height":543,"analyzed":true}	local	104570	13frG76m2E9fkjHCxV14Yg==	2024-11-05 08:54:15.028524
73	rlvaw6iw7j71jw9jehetucmxlm6a	pasta 2.jfif	image/jpeg	{"identified":true,"width":276,"height":150,"analyzed":true}	local	9648	UEo5hxc7E9ryLm0e/HS+Ag==	2024-11-05 08:55:35.750502
74	e4ekm6v4ejt6azuhlt7nxva1i5e2	pasta1.jfif	image/jpeg	{"identified":true,"width":200,"height":150,"analyzed":true}	local	5489	Nd/1Jes71tqetmJnFoChJA==	2024-11-05 08:55:35.75682
75	3aljdy6t6erwqnt7uaxphjbpsu3f	pasta3.jfif	image/jpeg	{"identified":true,"width":232,"height":130,"analyzed":true}	local	8891	H1IKD84o5zQGEpUl6drQZg==	2024-11-05 15:01:30.800503
77	lfhkp9bkitnby10qigq6lirwikok	planta.jpg	image/jpeg	{"identified":true,"width":612,"height":612,"analyzed":true}	local	23536	Nb94O55pi9ylEOaQvasyVg==	2024-12-20 13:15:24.216748
78	454xbd3xx31npk6fk1k4nljjnwuv	gorra-poda.jfif	image/jpeg	{"identified":true,"width":225,"height":225,"analyzed":true}	local	3469	YU/a2M6Ml6xNb7jXeynFeg==	2025-02-14 08:07:12.725189
79	0l02mf0m49ngatr2fkjdk1bixrow	hidromiel.jpg	image/jpeg	{"identified":true,"width":330,"height":391,"analyzed":true}	local	32664	GAPS/rJ/ErNnBwlAiHukAQ==	2025-02-14 09:31:17.745622
143	0etisirtfl4vabe6w7f8f5dxtm7l	pasta 2.jfif	image/jpeg	{"identified":true,"width":276,"height":150,"analyzed":true}	local	9648	UEo5hxc7E9ryLm0e/HS+Ag==	2025-03-18 16:28:40.782359
144	b9n1nkyjs3xhc7rgp6cydym0m8vy	pasta1.jfif	image/jpeg	{"identified":true,"width":200,"height":150,"analyzed":true}	local	5489	Nd/1Jes71tqetmJnFoChJA==	2025-03-18 16:28:40.806595
145	dm96uuodzhvewwxsje22su9dokgo	tempeh2.jfif	image/jpeg	{"identified":true,"width":225,"height":225,"analyzed":true}	local	9663	6/GcZhNOIXULMgJgcyHpLw==	2025-03-18 16:29:42.354053
148	y5ufylj3ika19rnml0krnjej17yl	tempeh.jfif	image/jpeg	{"identified":true,"width":276,"height":183,"analyzed":true}	local	8740	xrhtB5hAqjDBubUDxsuHtg==	2025-03-18 16:30:01.905353
146	6rtjlmzxcav1wgoxw32l5gi86jqj	placeholder.jpg	image/jpeg	{"identified":true,"width":612,"height":612,"analyzed":true}	local	7660	XQbHvpt0ersNFAxwbTAGPg==	2025-03-18 16:30:01.892495
147	8n5lpgmj316iy9u17udhc8sxtn1i	planta.jpg	image/jpeg	{"identified":true,"width":612,"height":612,"analyzed":true}	local	23536	Nb94O55pi9ylEOaQvasyVg==	2025-03-18 16:30:01.8999
149	xek3uo8bgpl2okq4hxwtwa1bf93a	hidromiel.jpg	image/jpeg	{"identified":true,"width":330,"height":391,"analyzed":true}	local	32664	GAPS/rJ/ErNnBwlAiHukAQ==	2025-03-20 08:36:18.457613
151	utlxq0lsr3r7ujvu5p3tlqg3k1ye	hidromiel.jpg	image/jpeg	{"identified":true,"width":330,"height":391,"analyzed":true}	local	32664	GAPS/rJ/ErNnBwlAiHukAQ==	2025-03-20 10:57:20.813186
150	zomvgmvtz5jcpuvy3nri108l1gvl	1.jpg	image/jpeg	{"identified":true,"width":3000,"height":4000,"analyzed":true}	local	1312574	9e78O6XTa80+MLjsjbNpoA==	2025-03-20 10:57:20.768693
153	pcsquqtmvh0xlkg4dhdddxe2php7	kefir2.jpg	image/jpeg	{"identified":true,"width":900,"height":1073,"analyzed":true}	local	56195	oR5Tv2oZ1kyql7Mx0DDvWg==	2025-03-20 13:08:06.365696
152	lhof5kyz16mf1fyak3iip9voj0ep	kefir1.jpg	image/jpeg	{"identified":true,"width":900,"height":866,"analyzed":true}	local	58578	Pd9VU94XekJQmFs21ix2FA==	2025-03-20 13:08:06.329213
154	u0dn3c10ihpi32rf13rbozhc1kan	kimchi.jpg	image/jpeg	{"identified":true,"width":612,"height":407,"analyzed":true}	local	39810	+n+OKoWXNEhNwOCWmo+lBg==	2025-03-20 13:18:44.939899
156	ebgo4ecjxv06wh3i9nuohokl3118	kefir2.jpg	image/jpeg	{"identified":true,"width":900,"height":1073,"analyzed":true}	local	56195	oR5Tv2oZ1kyql7Mx0DDvWg==	2025-03-21 09:27:45.523164
155	jewwnyqdfpq0d7rta3lvdq85zdgv	kefir1.jpg	image/jpeg	{"identified":true,"width":900,"height":866,"analyzed":true}	local	58578	Pd9VU94XekJQmFs21ix2FA==	2025-03-21 09:27:45.505993
157	hvywak1r8kwwkimfd507a35c7pmo	kefir1.jpg	image/jpeg	{"identified":true,"width":900,"height":866,"analyzed":true}	local	58578	Pd9VU94XekJQmFs21ix2FA==	2025-03-21 10:14:34.870759
158	xigno8r85gjtcsqg63ohyuljnqa8	kefir2.jpg	image/jpeg	{"identified":true,"width":900,"height":1073,"analyzed":true}	local	56195	oR5Tv2oZ1kyql7Mx0DDvWg==	2025-03-21 10:14:34.885754
159	8u6wn9xxamp6nnrfg1hl4izabupe	kefir1.jpg	image/jpeg	{"identified":true,"width":900,"height":866,"analyzed":true}	local	58578	Pd9VU94XekJQmFs21ix2FA==	2025-03-25 09:42:19.096302
160	g7932j70pp24sktea4gb78libry9	kefir1.jpg	image/jpeg	{"identified":true,"width":900,"height":866,"analyzed":true}	local	58578	Pd9VU94XekJQmFs21ix2FA==	2025-03-25 10:07:50.15044
161	cn5h0uf8nykl2jyqapm9zojdhkv4	kefir1.jpg	image/jpeg	{"identified":true,"width":900,"height":866,"analyzed":true}	local	58578	Pd9VU94XekJQmFs21ix2FA==	2025-03-25 10:08:20.716922
162	onjw7rh06z3n38ngof61469ql8ez	kefir1.jpg	image/jpeg	{"identified":true,"width":900,"height":866,"analyzed":true}	local	58578	Pd9VU94XekJQmFs21ix2FA==	2025-03-25 13:56:27.450025
163	gx0w4vsclqunpoae33engntlb9y2	juli.jfif	image/jpeg	{"identified":true,"width":960,"height":1280,"analyzed":true}	local	151255	n2MBN57snIJ+RpaoY+yL9w==	2025-03-27 13:36:49.902405
165	hqu9c3y51bzh5q0r8497176zsmkf	kefir1.jpg	image/jpeg	{"identified":true,"width":900,"height":866,"analyzed":true}	local	58578	Pd9VU94XekJQmFs21ix2FA==	2025-07-01 08:42:50.353309
166	2wbwy6wi6jeuea50724y87fn1xvw	kefir2.jpg	image/jpeg	{"identified":true,"width":900,"height":1073,"analyzed":true}	local	56195	oR5Tv2oZ1kyql7Mx0DDvWg==	2025-07-01 08:42:50.367523
167	039uor7z0xvntyef5e5ajs6b1c4e	kefir1.jpg	image/jpeg	{"identified":true,"width":900,"height":866,"analyzed":true}	local	58578	Pd9VU94XekJQmFs21ix2FA==	2025-07-01 09:25:38.545116
168	d17qbdp2tu8lt2mny6lgl8y0tb5z	kefir2.jpg	image/jpeg	{"identified":true,"width":900,"height":1073,"analyzed":true}	local	56195	oR5Tv2oZ1kyql7Mx0DDvWg==	2025-07-01 09:25:38.566893
169	2eu2dsrzfcngtf0jc7mzsyki33u9	1.jpg	image/jpeg	{"identified":true,"width":3000,"height":4000,"analyzed":true}	local	1312574	9e78O6XTa80+MLjsjbNpoA==	2025-07-01 10:14:14.720971
170	qfoyombakl01m8qdhe3nejjerpkm	1.jpg	image/jpeg	{"identified":true,"width":225,"height":300,"analyzed":true}	local	15276	2u5BM6D1hViFstTwEFBVXw==	2025-07-01 10:14:18.899504
171	zwzqjxj4qupfsjy6iudidzsgwgkq	kefir1.jpg	image/jpeg	{"identified":true,"width":300,"height":289,"analyzed":true}	local	18106	4MHqnV9svPo0pfbPF/6b4g==	2025-07-01 10:49:39.317998
173	yghioiivhawypflwp1robzxxv2g4	kefir1.jpg	image/jpeg	{"identified":true,"width":300,"height":289,"analyzed":true}	local	18106	4MHqnV9svPo0pfbPF/6b4g==	2025-07-01 10:49:39.336035
174	f9qzxgly973i584xjrhoikynsmnt	kefir1.jpg	image/jpeg	{"identified":true,"width":300,"height":289,"analyzed":true}	local	18106	4MHqnV9svPo0pfbPF/6b4g==	2025-07-01 10:49:39.346947
175	yonxv3ejz8klewwksnknrrbtezcw	kefir1.jpg	image/jpeg	{"identified":true,"width":300,"height":289,"analyzed":true}	local	18106	4MHqnV9svPo0pfbPF/6b4g==	2025-07-01 10:49:39.369807
172	7ycuh8i5139jwripa13swm01usoj	kefir1.jpg	image/jpeg	{"identified":true,"width":300,"height":289,"analyzed":true}	local	18106	4MHqnV9svPo0pfbPF/6b4g==	2025-07-01 10:49:39.331884
176	pm1z6xwrthy42myxyiuj28l2nljp	kimchi.jpg	image/jpeg	{"identified":true,"width":612,"height":407,"analyzed":true}	local	39810	+n+OKoWXNEhNwOCWmo+lBg==	2025-07-01 10:53:01.572963
177	g01c2co30w3pxpj1dwnk6v7cvhr5	kimchi.jpg	image/jpeg	{"identified":true,"width":300,"height":200,"analyzed":true}	local	12289	nF0MmWd8LAZxFKR4DmMeEQ==	2025-07-01 10:53:18.406574
179	bizbmc16ivzvi1znxbzypxqb1wp2	kimchi.jpg	image/jpeg	{"identified":true,"width":80,"height":53,"analyzed":true}	local	3313	iBkjTYSfjDV/Y7Is2/lN9w==	2025-07-04 06:54:31.350289
180	ay2zqjx9kw7k0nd5f24nhmb91nyp	kimchi.jpg	image/jpeg	{"identified":true,"width":70,"height":47,"analyzed":true}	local	3117	4Uaxo9LO4vUCR/6IU2EmVw==	2025-07-04 06:59:23.078004
181	234r0yim1zom4xlpv09wgrvwl14p	kimchi.jpg	image/jpeg	{"identified":true,"width":60,"height":40,"analyzed":true}	local	2919	T1VucQS4B3YdPec+33KZNg==	2025-07-04 07:01:29.851411
182	xwil5o39xa1tgpcbmluusjarvu41	kimchi.jpg	image/jpeg	{"identified":true,"width":75,"height":50,"analyzed":true}	local	3245	jBU4lYOC2CWx88I4F2OOXg==	2025-07-04 08:04:16.359008
183	uer6j0hyc9m8rllfgbte7q79xuxx	1.jpg	image/jpeg	{"identified":true,"width":56,"height":75,"analyzed":true}	local	2678	amsb3fDHrRvVO3hfD1M7YA==	2025-07-04 08:14:01.840967
184	d9844za86y0onchrwgzmtqdq28ge	1.jpg	image/jpeg	{"identified":true,"width":3000,"height":4000,"analyzed":true}	local	1312574	9e78O6XTa80+MLjsjbNpoA==	2025-07-04 09:27:33.4697
202	jfhoyafvf19cy96ex452epqo3kdx	pasta 2.jfif	image/jpeg	{"identified":true,"width":276,"height":150,"analyzed":true}	local	9648	UEo5hxc7E9ryLm0e/HS+Ag==	2025-07-08 09:59:41.030451
186	vt0mxzu55l4k989h5wis69j24ea4	1.jpg	image/jpeg	{"identified":true,"width":56,"height":75,"analyzed":true}	local	2678	amsb3fDHrRvVO3hfD1M7YA==	2025-07-04 09:59:58.49612
188	1u0zhzv5lftlalaymq9bs938y50t	tempeh2.jfif	image/jpeg	{"identified":true,"width":225,"height":225,"analyzed":true}	local	9663	6/GcZhNOIXULMgJgcyHpLw==	2025-07-04 10:01:45.371559
187	nzeemowk2gg1elssi8f3lswtmvxe	tempeh.jfif	image/jpeg	{"identified":true,"width":276,"height":183,"analyzed":true}	local	8740	xrhtB5hAqjDBubUDxsuHtg==	2025-07-04 10:01:45.354261
189	bcpegfx8dciwgmvlyryibfemt1my	tempeh.jfif	image/jpeg	{"identified":true,"width":276,"height":183,"analyzed":true}	local	8740	xrhtB5hAqjDBubUDxsuHtg==	2025-07-07 08:51:54.854326
190	5m8fesd6iydpw649wtyd1eq6krhn	tempeh2.jfif	image/jpeg	{"identified":true,"width":225,"height":225,"analyzed":true}	local	9663	6/GcZhNOIXULMgJgcyHpLw==	2025-07-07 08:51:54.875418
200	2l592gus722x3c58694vnncbos8r	kefir2.jpg	image/jpeg	{"identified":true,"width":900,"height":1073,"analyzed":true}	local	56195	oR5Tv2oZ1kyql7Mx0DDvWg==	2025-07-08 09:59:40.999641
193	bl3uavsq2imwujew5d4bhh59h39b	tempeh2.jfif	image/jpeg	{"identified":true,"width":225,"height":225,"analyzed":true}	local	9663	6/GcZhNOIXULMgJgcyHpLw==	2025-07-07 10:03:43.53223
192	2uu39gjjdu19vsmxk12g7ol2fu66	tempeh.jfif	image/jpeg	{"identified":true,"width":276,"height":183,"analyzed":true}	local	8740	xrhtB5hAqjDBubUDxsuHtg==	2025-07-07 10:03:43.515469
194	uktaqdd7oj5i4g4ut9bujfrhvfv8	1.jpg	image/jpeg	{"identified":true,"width":3000,"height":4000,"analyzed":true}	local	1312574	9e78O6XTa80+MLjsjbNpoA==	2025-07-07 18:58:51.923005
195	g01lrm93o89jdmrvyvumtkd5gwtv	1.jpg	image/jpeg	{"identified":true,"width":56,"height":75,"analyzed":true}	local	2678	amsb3fDHrRvVO3hfD1M7YA==	2025-07-07 18:59:08.391254
196	kssq5nt6gskg9t46jzvpbytt0e1r	kimchi.jpg	image/jpeg	{"identified":true,"width":612,"height":407,"analyzed":true}	local	39810	+n+OKoWXNEhNwOCWmo+lBg==	2025-07-08 08:50:21.909064
197	su00owrgjafyp3pnhmk7fr3ti8vq	kimchi.jpg	image/jpeg	{"identified":true,"width":75,"height":50,"analyzed":true}	local	3245	jBU4lYOC2CWx88I4F2OOXg==	2025-07-08 09:00:22.914507
198	ou76otyluzz6httpr2e0enkkg8mf	augusto.jpg	image/jpeg	{"identified":true,"width":225,"height":225,"analyzed":true}	local	7129	06MLAKgO+oG/0s7dab97Jw==	2025-07-08 09:58:38.051229
199	8oiusi4ynk389qyi8bq17fqicqb6	kefir1.jpg	image/jpeg	{"identified":true,"width":900,"height":866,"analyzed":true}	local	58578	Pd9VU94XekJQmFs21ix2FA==	2025-07-08 09:59:40.993559
201	ep2zkhzm5lmqllo11v1y5tfi4fic	kimchi.jpg	image/jpeg	{"identified":true,"width":612,"height":407,"analyzed":true}	local	39810	+n+OKoWXNEhNwOCWmo+lBg==	2025-07-08 09:59:41.010046
203	mdkogw2p96ubxu6p9a6u2068t8jj	pasta3.jfif	image/jpeg	{"identified":true,"width":232,"height":130,"analyzed":true}	local	8891	H1IKD84o5zQGEpUl6drQZg==	2025-07-08 10:14:16.211419
204	mcpd737dsct5qo43ngmlgm3xp9y1	pasta3.jfif	image/jpeg	{"identified":true,"width":232,"height":130,"analyzed":true}	local	8891	H1IKD84o5zQGEpUl6drQZg==	2025-07-08 10:14:16.48881
205	yk1g8of8plmn30oaiyj49781tcf1	pasta1.jfif	image/jpeg	{"identified":true,"width":200,"height":150,"analyzed":true}	local	5489	Nd/1Jes71tqetmJnFoChJA==	2025-07-08 10:14:31.810624
206	utwv1auaus3bn7kpomo9rr47sb44	pasta1.jfif	image/jpeg	{"identified":true,"width":200,"height":150,"analyzed":true}	local	5489	Nd/1Jes71tqetmJnFoChJA==	2025-07-08 10:14:31.870752
207	d0624ls9k4b51cfazaha3ivf29fd	pasta3.jfif	image/jpeg	{"identified":true,"width":232,"height":130,"analyzed":true}	local	8891	H1IKD84o5zQGEpUl6drQZg==	2025-07-08 10:33:50.252812
208	7mm2r8jxjwh344shuhcn9mh9ai8b	pasta3.jfif	image/jpeg	{"identified":true,"width":232,"height":130,"analyzed":true}	local	8891	H1IKD84o5zQGEpUl6drQZg==	2025-07-08 10:33:50.629772
209	9qrvrrb1tmyhikhu8modpj0totp6	pasta 2.jfif	image/jpeg	{"identified":true,"width":276,"height":150,"analyzed":true}	local	9648	UEo5hxc7E9ryLm0e/HS+Ag==	2025-07-08 10:42:10.209453
210	bojwemx69ge7iechpo6y0o258ikp	pasta 2.jfif	image/jpeg	{"identified":true,"width":276,"height":150,"analyzed":true}	local	9648	UEo5hxc7E9ryLm0e/HS+Ag==	2025-07-08 10:42:10.32137
211	yx8d0nqw40deol8dq9g41g8xl8py	kefir1.jpg	image/jpeg	{"identified":true,"width":900,"height":866,"analyzed":true}	local	58578	Pd9VU94XekJQmFs21ix2FA==	2025-07-08 10:44:26.552125
212	m2clpt5hzokt9odods84hyvzphlw	kefir2.jpg	image/jpeg	{"identified":true,"width":900,"height":1073,"analyzed":true}	local	56195	oR5Tv2oZ1kyql7Mx0DDvWg==	2025-07-08 10:44:26.569752
213	w5jv70fu870jskwe2nyg6ih3frn5	kefir2.jpg	image/jpeg	{"identified":true,"width":900,"height":1073,"analyzed":true}	local	56195	oR5Tv2oZ1kyql7Mx0DDvWg==	2025-07-08 10:45:09.579002
214	rag7wd2peztejjj52bsmw42cn4kj	1.jpg	image/jpeg	{"identified":true,"width":3000,"height":4000,"analyzed":true}	local	1312574	9e78O6XTa80+MLjsjbNpoA==	2025-07-08 10:48:10.146121
215	euk399ashnlek7ganz4ctz25elsx	1.jpg	image/jpeg	{"identified":true,"width":3000,"height":4000,"analyzed":true}	local	1312574	9e78O6XTa80+MLjsjbNpoA==	2025-07-08 10:48:33.545985
216	zwdliobh6ts5lxd5vggly08nxj8q	1.jpg	image/jpeg	{"identified":true,"width":3000,"height":4000,"analyzed":true}	local	1312574	9e78O6XTa80+MLjsjbNpoA==	2025-07-08 10:50:41.386259
217	2yllh0alen0l34838uuu3if8mb52	tevez.jpg	image/jpeg	{"identified":true,"width":768,"height":543,"analyzed":true}	local	104570	13frG76m2E9fkjHCxV14Yg==	2025-07-08 10:51:01.170464
218	21d9o34ziyzx5lmvfev8ith3epn2	bikesec-logo2.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1424519	ebIv1nnS4GN8ZVrZmwnbkw==	2025-07-08 10:53:57.823875
222	6aaq72bbj8ryga4bs7f40k9iszrn	bikesec-logo1.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1281235	70wUUTVtv8Qx3VSq9e3vpA==	2025-07-08 12:11:36.077129
221	3qf2l1ql19j1vvia75zzrp75hcba	cerveza.jpg	image/jpeg	{"identified":true,"width":1024,"height":768,"analyzed":true}	local	175297	V8yHBoLGYiQAdXp/maSp5Q==	2025-07-08 12:11:35.658271
219	8lblghbrc9vf7nuczvffg9sdzkde	bikesec-logo1.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1281235	70wUUTVtv8Qx3VSq9e3vpA==	2025-07-08 12:11:35.588617
220	yfmtdxxzhw56aherr57muh5vhjnh	bikesec-logo2.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1424519	ebIv1nnS4GN8ZVrZmwnbkw==	2025-07-08 12:11:35.64567
224	ypch6lci7kg7c5ys9s8068clwbd4	cerveza.jpg	image/jpeg	{"identified":true,"width":1024,"height":768,"analyzed":true}	local	175297	V8yHBoLGYiQAdXp/maSp5Q==	2025-07-08 12:11:36.161995
223	xu2xcxzi8zrnx5g2icgbuqe4h10e	bikesec-logo2.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1424519	ebIv1nnS4GN8ZVrZmwnbkw==	2025-07-08 12:11:36.125506
225	lltmflj4vnuhlpjqr1vqqpc2f2u5	cerveza.jpg	image/jpeg	{"identified":true,"width":100,"height":75,"analyzed":true}	local	6983	AoIpKxjroCyguLQ1Xg7NWA==	2025-07-08 12:15:15.89947
226	e29bkol5u7n3dw5e96uj83905wea	cerveza.jpg	image/jpeg	{"identified":true,"width":100,"height":75,"analyzed":true}	local	6983	AoIpKxjroCyguLQ1Xg7NWA==	2025-07-08 12:15:15.909319
227	69y54wzo18p8f30pkz3qzb75gdrh	bikesec-logo2.png	image/png	{"identified":true,"width":100,"height":100,"analyzed":true}	local	11784	iGc+K5JJZk987aIXGUCPqg==	2025-07-08 12:15:16.037752
228	hjtr6yvps6x3o8iwrt9lg6mxtj8u	bikesec-logo1.png	image/png	{"identified":true,"width":100,"height":100,"analyzed":true}	local	8862	RgPHEQ9nb/1/EV+bvrCJiQ==	2025-07-08 12:15:16.050672
229	usvibicxqld8igfjordlwe4dihi0	bikesec-logo1.png	image/png	{"identified":true,"width":100,"height":100,"analyzed":true}	local	8862	RgPHEQ9nb/1/EV+bvrCJiQ==	2025-07-08 12:15:16.057576
230	xsxgfuj5xf0k1tgtvoylkvd4wd8i	bikesec-logo2.png	image/png	{"identified":true,"width":100,"height":100,"analyzed":true}	local	11784	iGc+K5JJZk987aIXGUCPqg==	2025-07-08 12:15:17.190707
231	xymworou16gfxvoo07doi2m4fimg	bikesec-logo1.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1281235	70wUUTVtv8Qx3VSq9e3vpA==	2025-07-08 12:16:29.515078
235	mjy4ollkvy8zqamviahkiir7h8jx	kimchi.jpg	image/jpeg	{"identified":true,"width":612,"height":407,"analyzed":true}	local	39810	+n+OKoWXNEhNwOCWmo+lBg==	2025-07-08 12:16:29.576142
233	9zne7vco2h0sft3w127fa5f36bc7	kefir1.jpg	image/jpeg	{"identified":true,"width":900,"height":866,"analyzed":true}	local	58578	Pd9VU94XekJQmFs21ix2FA==	2025-07-08 12:16:29.54628
234	0n3t2ee0udb7gp33io5zxgrurxmd	kefir2.jpg	image/jpeg	{"identified":true,"width":900,"height":1073,"analyzed":true}	local	56195	oR5Tv2oZ1kyql7Mx0DDvWg==	2025-07-08 12:16:29.560861
238	8vv3ynmjgfuuygogia21xea6z23o	kefir1.jpg	image/jpeg	{"identified":true,"width":900,"height":866,"analyzed":true}	local	58578	Pd9VU94XekJQmFs21ix2FA==	2025-07-08 12:16:29.770346
236	7u9bue4hf22a1sf39ssqedorj5fa	bikesec-logo1.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1281235	70wUUTVtv8Qx3VSq9e3vpA==	2025-07-08 12:16:29.747657
237	6j4wg33ykmlpzo55box0yvbv0jk1	bikesec-logo2.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1424519	ebIv1nnS4GN8ZVrZmwnbkw==	2025-07-08 12:16:29.759604
232	gh2d9jku61i1wrzhwbqo4s5mfp70	bikesec-logo2.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1424519	ebIv1nnS4GN8ZVrZmwnbkw==	2025-07-08 12:16:29.532059
239	bn9sr9km28wb9rglgc07o852a6bw	kefir2.jpg	image/jpeg	{"identified":true,"width":900,"height":1073,"analyzed":true}	local	56195	oR5Tv2oZ1kyql7Mx0DDvWg==	2025-07-08 12:16:29.778076
240	0jum736jpval3z1l9z1y51klq98z	kimchi.jpg	image/jpeg	{"identified":true,"width":612,"height":407,"analyzed":true}	local	39810	+n+OKoWXNEhNwOCWmo+lBg==	2025-07-08 12:16:29.785939
241	rsfu7f5wneixl2uaxz361lsgdrk6	bikesec-logo1.png	image/png	{"identified":true,"width":75,"height":75,"analyzed":true}	local	4988	QGaxdWi95py0cfIe17DYuA==	2025-07-08 12:16:31.923248
242	esk540bceond5rk0g9l0hh1lkoaj	bikesec-logo1.png	image/png	{"identified":true,"width":100,"height":100,"analyzed":true}	local	8862	RgPHEQ9nb/1/EV+bvrCJiQ==	2025-07-08 12:16:57.152898
243	587gzkd0ooikhcttig6eqjep2e05	kefir1.jpg	image/jpeg	{"identified":true,"width":100,"height":96,"analyzed":true}	local	4459	GunPY2CETlvsZvCKQtDacA==	2025-07-08 12:16:57.408117
245	44qtr5baxurt95fo2np33jgpj9uw	kefir2.jpg	image/jpeg	{"identified":true,"width":84,"height":100,"analyzed":true}	local	4115	cqsfBfIOspVTXWR4whouog==	2025-07-08 12:16:57.473148
244	2sr6vhxkx9grxv4fe4eioa2rubfz	kimchi.jpg	image/jpeg	{"identified":true,"width":100,"height":67,"analyzed":true}	local	3838	0vQfvHsNtGATWLoSS8DyQQ==	2025-07-08 12:16:57.464677
246	asjvtz66t1ffn2a4t9ur87az0hiq	bikesec-logo2.png	image/png	{"identified":true,"width":100,"height":100,"analyzed":true}	local	11784	iGc+K5JJZk987aIXGUCPqg==	2025-07-08 12:16:57.605966
247	8jifa5v98pufm30nz9b2ghhjd7fl	kefir2.jpg	image/jpeg	{"identified":true,"width":84,"height":100,"analyzed":true}	local	4115	cqsfBfIOspVTXWR4whouog==	2025-07-08 12:16:58.791931
248	km2wnc5t2hwicoqbz5oy16omhn8i	bikesec-logo2.png	image/png	{"identified":true,"width":100,"height":100,"analyzed":true}	local	11784	iGc+K5JJZk987aIXGUCPqg==	2025-07-08 12:16:58.802612
249	k4uuqba4oyibvq1lvlyj1lx3sum4	kefir1.jpg	image/jpeg	{"identified":true,"width":100,"height":96,"analyzed":true}	local	4459	GunPY2CETlvsZvCKQtDacA==	2025-07-08 12:16:58.935949
250	njmulvl0t9ymfkdff81dznooostc	kimchi.jpg	image/jpeg	{"identified":true,"width":100,"height":67,"analyzed":true}	local	3838	0vQfvHsNtGATWLoSS8DyQQ==	2025-07-08 12:16:58.947325
251	9mc7jzo2ta03cpqc2i3f9k11e6s3	bikesec-logo1.png	image/png	{"identified":true,"width":100,"height":100,"analyzed":true}	local	8862	RgPHEQ9nb/1/EV+bvrCJiQ==	2025-07-08 12:17:00.025607
252	pt3ljunffhzytcob5kkamwu855at	bikesec-logo1.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1281235	70wUUTVtv8Qx3VSq9e3vpA==	2025-07-08 12:19:36.446402
253	0pzjefsxa8pgfkawstm1jcyab558	bikesec-logo1.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1281235	70wUUTVtv8Qx3VSq9e3vpA==	2025-07-08 12:19:36.567237
254	v9gzd9kdci9fr1yqmzrdr2ycktun	bikesec-logo1.png	image/png	{"identified":true,"width":75,"height":75,"analyzed":true}	local	4988	QGaxdWi95py0cfIe17DYuA==	2025-07-08 12:19:37.303361
256	vo3r8y6yn5o94nf7w7bzepem23dt	bikesec-logo1.png	image/png	{"identified":true,"width":100,"height":100,"analyzed":true}	local	8862	RgPHEQ9nb/1/EV+bvrCJiQ==	2025-07-08 12:19:57.107568
255	6vwbrgy3o9mb51uo02soqiiqd6zf	bikesec-logo1.png	image/png	{"identified":true,"width":100,"height":100,"analyzed":true}	local	8862	RgPHEQ9nb/1/EV+bvrCJiQ==	2025-07-08 12:19:57.097939
257	rnl29dw8pwao31x889aomexl8t33	bikesec-logo1.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1281235	70wUUTVtv8Qx3VSq9e3vpA==	2025-07-08 12:21:24.022341
258	c5mz24v8k1lan79e5ncnqxj1elpr	bikesec-logo2.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1424519	ebIv1nnS4GN8ZVrZmwnbkw==	2025-07-08 12:21:24.042388
259	nhmz5wtihxfhh9crlrwe9t020h9d	bikesec-logo1.png	image/png	{"identified":true,"width":100,"height":100,"analyzed":true}	local	8862	RgPHEQ9nb/1/EV+bvrCJiQ==	2025-07-08 12:21:25.88234
260	9vj9tl8h69lie8dnyimu9d6yvp91	bikesec-logo2.png	image/png	{"identified":true,"width":100,"height":100,"analyzed":true}	local	11784	iGc+K5JJZk987aIXGUCPqg==	2025-07-08 12:21:25.924112
261	tijkks0ep3sc9azo1ahnrfpvhysc	bikesec-logo1.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1281235	70wUUTVtv8Qx3VSq9e3vpA==	2025-07-08 12:22:23.227964
262	1gdlb3pukiuub6u378xbaqfu3a14	bikesec-logo2.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1424519	ebIv1nnS4GN8ZVrZmwnbkw==	2025-07-08 12:22:23.242736
263	hgr6df4yz2hfpj9w7b1ty68d9bkk	bikesec-logo1.png	image/png	{"identified":true,"width":100,"height":100,"analyzed":true}	local	8862	RgPHEQ9nb/1/EV+bvrCJiQ==	2025-07-08 12:22:26.406022
264	dn8h0lgds3w2y2xqptc38l91gbrt	bikesec-logo2.png	image/png	{"identified":true,"width":100,"height":100,"analyzed":true}	local	11784	iGc+K5JJZk987aIXGUCPqg==	2025-07-08 12:22:26.488345
265	nlhqbi8ioa4gff7ve4e5wspca3fu	bikesec-logo1.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1281235	70wUUTVtv8Qx3VSq9e3vpA==	2025-07-08 12:25:34.791879
266	nw8epqe8g9yb9qvtzqyp6x9z0z10	bikesec-logo2.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1424519	ebIv1nnS4GN8ZVrZmwnbkw==	2025-07-08 12:25:34.814652
267	iqis4qwtg1qkjos11ocwmox3p1hi	bikesec-logo1.png	image/png	{"identified":true,"width":100,"height":100,"analyzed":true}	local	8862	RgPHEQ9nb/1/EV+bvrCJiQ==	2025-07-08 12:25:38.167493
268	w34ys6x8pesqj9v36idk8624a5w8	bikesec-logo2.png	image/png	{"identified":true,"width":100,"height":100,"analyzed":true}	local	11784	iGc+K5JJZk987aIXGUCPqg==	2025-07-08 12:25:38.219202
269	vf1jgterwyaq8212efw1885kxyzr	bikesec-logo1.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1281235	70wUUTVtv8Qx3VSq9e3vpA==	2025-07-08 12:29:24.463375
270	4l0mkymdwltjnnlff9y18emn3tz2	bikesec-logo2.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1424519	ebIv1nnS4GN8ZVrZmwnbkw==	2025-07-08 12:29:24.496867
271	nlhd26r6ml0eg7u4ididk9s8s4p7	bikesec-logo1.png	image/png	{"identified":true,"width":75,"height":75,"analyzed":true}	local	4988	QGaxdWi95py0cfIe17DYuA==	2025-07-08 12:29:33.40596
272	zhqhhb37h9ntjgs0ejslyse7nmio	bikesec-logo1.png	image/png	{"identified":true,"width":100,"height":100,"analyzed":true}	local	8862	RgPHEQ9nb/1/EV+bvrCJiQ==	2025-07-08 12:29:35.618019
273	j6ib63lxmpajep4osrdws5o32lfn	bikesec-logo2.png	image/png	{"identified":true,"width":100,"height":100,"analyzed":true}	local	11784	iGc+K5JJZk987aIXGUCPqg==	2025-07-08 12:29:35.689251
275	5jrrr7coos5em1ce5rmofbfiyq7p	pasta1.jfif	image/jpeg	{"identified":true,"width":200,"height":150,"analyzed":true}	local	5489	Nd/1Jes71tqetmJnFoChJA==	2025-07-08 12:31:48.686636
274	sdq9ia4fq9z9oeunzto676joqvsx	pasta 2.jfif	image/jpeg	{"identified":true,"width":276,"height":150,"analyzed":true}	local	9648	UEo5hxc7E9ryLm0e/HS+Ag==	2025-07-08 12:31:48.519619
276	8dfutfj2uxx3781acwr6bzdbf5bc	pasta3.jfif	image/jpeg	{"identified":true,"width":232,"height":130,"analyzed":true}	local	8891	H1IKD84o5zQGEpUl6drQZg==	2025-07-08 12:31:48.707313
278	yoi8moo7caflq9bmnq40ozvx9kcx	bikesec-logo2.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1424519	ebIv1nnS4GN8ZVrZmwnbkw==	2025-07-08 12:53:52.039382
277	808fxjdilfwwqqmfy4aq5ravxqf5	bikesec-logo1.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1281235	70wUUTVtv8Qx3VSq9e3vpA==	2025-07-08 12:53:52.008232
279	wff4cwvwxfrahecgz10uhbsmf4og	bikesec-logo1.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1281235	70wUUTVtv8Qx3VSq9e3vpA==	2025-07-08 13:02:08.440536
280	v2a7dfgatvodnvypn5vbswwrm4bz	bikesec-logo1.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1281235	70wUUTVtv8Qx3VSq9e3vpA==	2025-07-08 13:07:40.809046
281	jrt8ahpyf8rq4ojqb7j6ymblbmqc	bikesec-logo1.png	image/png	{"identified":true,"width":1024,"height":1024,"analyzed":true}	local	1281235	70wUUTVtv8Qx3VSq9e3vpA==	2025-07-08 13:07:53.317212
282	a9iy0rl27t829r4vjixd1stdfy4g	kimchi.jpg	image/jpeg	{"identified":true,"width":612,"height":407,"analyzed":true}	local	39810	+n+OKoWXNEhNwOCWmo+lBg==	2025-07-08 13:08:02.874559
283	ono3pjchgacfwdeaqx5g0tjzb1op	bikesec-logo1.png	image/png	{"identified":true,"width":75,"height":75,"analyzed":true}	local	4988	QGaxdWi95py0cfIe17DYuA==	2025-07-08 13:08:28.416682
284	q7t3g5cnp2m3jy9230nm3vn97v79	pasta3.jfif	image/jpeg	{"identified":true,"width":232,"height":130,"analyzed":true}	local	8891	H1IKD84o5zQGEpUl6drQZg==	2025-07-08 13:14:51.167898
285	piquqg41aofhutjt4nv1nyvzrygk	pasta 2.jfif	image/jpeg	{"identified":true,"width":276,"height":150,"analyzed":true}	local	9648	UEo5hxc7E9ryLm0e/HS+Ag==	2025-07-08 13:15:07.910491
286	hgpgkuqefcl2wdw1isi4sekiughg	pasta1.jfif	image/jpeg	{"identified":true,"width":200,"height":150,"analyzed":true}	local	5489	Nd/1Jes71tqetmJnFoChJA==	2025-07-08 13:15:30.426742
287	t0tz4isawg6hk4imxwl90lceyhfu	planta.jpg	image/jpeg	{"identified":true,"width":612,"height":612,"analyzed":true}	local	23536	Nb94O55pi9ylEOaQvasyVg==	2025-07-08 13:33:56.367183
288	ovq98g3l517cq1w0rut55t89e3l0	gorra-poda.jfif	image/jpeg	{"identified":true,"width":225,"height":225,"analyzed":true}	local	3469	YU/a2M6Ml6xNb7jXeynFeg==	2025-07-08 13:34:08.840053
\.


--
-- Data for Name: active_storage_variant_records; Type: TABLE DATA; Schema: public; Owner: marco
--

COPY public.active_storage_variant_records (id, blob_id, variation_digest) FROM stdin;
1	169	LtoSAYL4ZrQTjS8XJDwiSZvW12s=
3	157	LtoSAYL4ZrQTjS8XJDwiSZvW12s=
2	161	LtoSAYL4ZrQTjS8XJDwiSZvW12s=
4	162	LtoSAYL4ZrQTjS8XJDwiSZvW12s=
5	159	LtoSAYL4ZrQTjS8XJDwiSZvW12s=
6	160	LtoSAYL4ZrQTjS8XJDwiSZvW12s=
7	176	LtoSAYL4ZrQTjS8XJDwiSZvW12s=
8	176	0Lmu9T0kDFUJplmg7S9DaSDDTiw=
9	176	m9uhT0klCXsrtyboYMtqIrNXcGQ=
10	176	RDRMNK2FMUn6E+v3Zc8VEAOEpmA=
11	176	k50UeQWxRYOw8Nhb5igIaa9FQ+8=
12	169	k50UeQWxRYOw8Nhb5igIaa9FQ+8=
13	184	k50UeQWxRYOw8Nhb5igIaa9FQ+8=
14	194	k50UeQWxRYOw8Nhb5igIaa9FQ+8=
15	196	k50UeQWxRYOw8Nhb5igIaa9FQ+8=
16	224	58nLvjR5lLpeOdoWw8+s844W40I=
17	221	58nLvjR5lLpeOdoWw8+s844W40I=
18	222	uyx6Kcit1Aa78Mrn7bVgZ7OZn0Y=
19	220	uyx6Kcit1Aa78Mrn7bVgZ7OZn0Y=
20	219	uyx6Kcit1Aa78Mrn7bVgZ7OZn0Y=
21	223	uyx6Kcit1Aa78Mrn7bVgZ7OZn0Y=
22	231	x3n5Mm+cgu11DYEzJ436gM39kd8=
23	231	uyx6Kcit1Aa78Mrn7bVgZ7OZn0Y=
24	233	58nLvjR5lLpeOdoWw8+s844W40I=
25	235	58nLvjR5lLpeOdoWw8+s844W40I=
26	234	58nLvjR5lLpeOdoWw8+s844W40I=
27	232	uyx6Kcit1Aa78Mrn7bVgZ7OZn0Y=
28	239	58nLvjR5lLpeOdoWw8+s844W40I=
29	237	uyx6Kcit1Aa78Mrn7bVgZ7OZn0Y=
30	240	58nLvjR5lLpeOdoWw8+s844W40I=
31	238	58nLvjR5lLpeOdoWw8+s844W40I=
32	236	uyx6Kcit1Aa78Mrn7bVgZ7OZn0Y=
33	252	x3n5Mm+cgu11DYEzJ436gM39kd8=
34	252	uyx6Kcit1Aa78Mrn7bVgZ7OZn0Y=
35	253	uyx6Kcit1Aa78Mrn7bVgZ7OZn0Y=
36	257	uyx6Kcit1Aa78Mrn7bVgZ7OZn0Y=
37	258	uyx6Kcit1Aa78Mrn7bVgZ7OZn0Y=
38	261	uyx6Kcit1Aa78Mrn7bVgZ7OZn0Y=
39	262	uyx6Kcit1Aa78Mrn7bVgZ7OZn0Y=
40	265	uyx6Kcit1Aa78Mrn7bVgZ7OZn0Y=
41	266	uyx6Kcit1Aa78Mrn7bVgZ7OZn0Y=
42	269	x3n5Mm+cgu11DYEzJ436gM39kd8=
43	269	uyx6Kcit1Aa78Mrn7bVgZ7OZn0Y=
44	270	uyx6Kcit1Aa78Mrn7bVgZ7OZn0Y=
45	280	x3n5Mm+cgu11DYEzJ436gM39kd8=
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: marco
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2024-09-13 11:44:24.323862	2024-09-13 11:44:24.323866
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: marco
--

COPY public.comments (id, title, content, ferment_id, user_id, created_at, updated_at) FROM stdin;
45	Excelente	Me gustaria que me pases fotos de como quedo! Un saludo	592	360	2025-07-08 13:22:35.024823	2025-07-08 13:22:35.024823
\.


--
-- Data for Name: ferment_recipes; Type: TABLE DATA; Schema: public; Owner: marco
--

COPY public.ferment_recipes (id, name, ingredients, instructions, ferment_id, user_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: ferments; Type: TABLE DATA; Schema: public; Owner: marco
--

COPY public.ferments (id, name, description, user_id, created_at, updated_at, ingredients, instructions, fermentation_time, start_date, revisar_fermentos, review_date) FROM stdin;
596	pasta	\N	360	2025-07-08 13:14:51.131699	2025-07-08 13:15:30.706454	pasta, tuco, tomates,cebolla	osnsodnvsodnvosdnvsjnvsjdnvsjnvsjvnsjvnsdjnvsjdnvksdnvsnvbsnbvfsbvdsfbdfbdfb	1	2025-05-20 00:00:00	1	2025-07-07
592	Hidromiel	Bebida alcohólica fermentada de miel.	355	2025-07-07 11:45:43.718048	2025-07-08 13:34:09.103319	Miel, agua, levadura de vino	Mezcla miel y agua, añade levadura, fermenta 3-4 semanas.	3-4 semanas	2025-05-20 00:00:00	3	2025-06-20
62	Kéfir	\N	344	2025-03-24 14:52:19.885348	2025-07-07 13:13:27.498701	Leche, Granos de kéfir	Añade los granos de kéfir a la leche en un frasco. Cubre con un paño y deja fermentar a temperatura ambiente durante 24 horas. Cuela los granos y guarda el kéfir en el refrigerador.	24 horas	2025-07-08 00:00:00	3	2025-07-11
588	Chucrut	Repollo fermentado, ácido y crujiente.	355	2025-07-07 11:45:43.601863	2025-07-07 13:13:27.561741	Repollo, sal marina	Corta el repollo, mezcla con sal, prensa y deja fermentar a temperatura ambiente 2-4 semanas.	2-4 semanas	2025-06-27 00:00:00	3	2025-06-30
589	Kéfir de Agua	Bebida fermentada dulce y burbujeante.	355	2025-07-07 11:45:43.679739	2025-07-07 13:13:27.57945	Granos de kéfir de agua, agua, azúcar, fruta seca	Disuelve azúcar en agua, añade granos y fruta seca, fermenta 24-48 horas.	1-2 días	2025-07-04 00:00:00	3	2025-07-07
591	Yogur Casero	Yogur natural fermentado.	355	2025-07-07 11:45:43.705674	2025-07-07 13:13:27.613333	Leche, cultivo iniciador (yogur natural)	Calienta leche, añade cultivo, fermenta 6-12 horas a 40°C.	6-12 horas	2025-07-06 00:00:00	3	2025-07-09
5	Miso	\N	344	2025-03-24 14:46:11.818403	2025-07-07 13:13:27.483251	Soja, Sal, Koji (hongo Aspergillus oryzae)	Remoja la soja durante la noche y cocínala hasta que esté blanda. Tritura y mezcla con sal y koji. Coloca en un frasco, presionando para eliminar burbujas de aire. Deja fermentar en un lugar fresco durante 6 meses a 2 años.	6 meses a 2 años	2025-07-11 00:00:00	3	2025-07-14
628	Fermento de remolacha	\N	344	2025-03-24 14:52:28.656657	2025-07-07 13:13:27.650872	Remolacha, Sal, Agua	Corta las remolachas en rodajas y colócalas en un frasco. Mezcla agua y sal, vierte sobre las remolachas y deja fermentar a temperatura ambiente durante 1-2 semanas.	1-2 semanas	2025-03-20 00:00:00	3	2025-03-23
6624	Fermento de pimiento	\N	344	2025-03-24 14:52:27.702388	2025-07-07 13:13:27.664483	Pimientos, Sal, Agua	Corta los pimientos en tiras y colócalos en un frasco. Mezcla agua y sal, vierte sobre los pimientos y deja fermentar a temperatura ambiente durante 1-2 semanas.	1-2 semanas	2025-01-15 00:00:00	3	2025-01-18
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: marco
--

COPY public.schema_migrations (version) FROM stdin;
20240913115142
20240913132139
20240913132210
20240913150353
20241024084648
20241104160748
20241220114126
20250217131811
20250318161405
20250318162120
20250325100727
20250707083146
20250707131033
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: marco
--

COPY public.users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, created_at, updated_at, first_name, last_name, avatar) FROM stdin;
360	augustitoau10@gmail.com	$2a$12$pQp95VdxcnQBki9octBQpuIxX64IZJoytuUYerY5/lVkVg0cawxAy	\N	\N	\N	2025-07-08 09:58:37.971704	2025-07-08 09:58:38.667063	Augusto	Audieri	\N
344	julia.caraballo@gmail.com	$2a$12$oT17KfjL/AlUtAoa5KvueO3dyQf0t1J1.6XMPC19LPQW2WeTYQ7em	\N	\N	\N	2025-02-17 15:19:26.904261	2025-03-27 13:38:05.686358	Julia	Caraballo	\N
355	marcoogarbini@gmail.com	$2a$12$YksPJVBfAq329Xvb3bS6we2XksNC9Qp3dXD9vXln/Ctk3G8SLTyU6	e2f4402e4d68cbf6004c9fd6f521f84170cfad044b5175713b828d80a999f03c	2025-07-04 10:26:46.613413	\N	2025-03-18 14:25:13.065754	2025-07-04 10:26:46.61416	Marco	Garbini	\N
\.


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marco
--

SELECT pg_catalog.setval('public.active_storage_attachments_id_seq', 288, true);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marco
--

SELECT pg_catalog.setval('public.active_storage_blobs_id_seq', 288, true);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marco
--

SELECT pg_catalog.setval('public.active_storage_variant_records_id_seq', 45, true);


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marco
--

SELECT pg_catalog.setval('public.comments_id_seq', 45, true);


--
-- Name: ferment_recipes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marco
--

SELECT pg_catalog.setval('public.ferment_recipes_id_seq', 500, true);


--
-- Name: ferments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marco
--

SELECT pg_catalog.setval('public.ferments_id_seq', 596, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marco
--

SELECT pg_catalog.setval('public.users_id_seq', 360, true);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: ferment_recipes ferment_recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.ferment_recipes
    ADD CONSTRAINT ferment_recipes_pkey PRIMARY KEY (id);


--
-- Name: ferments ferments_pkey; Type: CONSTRAINT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.ferments
    ADD CONSTRAINT ferments_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: marco
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: marco
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: marco
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: marco
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_comments_on_ferment_id; Type: INDEX; Schema: public; Owner: marco
--

CREATE INDEX index_comments_on_ferment_id ON public.comments USING btree (ferment_id);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: marco
--

CREATE INDEX index_comments_on_user_id ON public.comments USING btree (user_id);


--
-- Name: index_ferment_recipes_on_ferment_id; Type: INDEX; Schema: public; Owner: marco
--

CREATE INDEX index_ferment_recipes_on_ferment_id ON public.ferment_recipes USING btree (ferment_id);


--
-- Name: index_ferment_recipes_on_user_id; Type: INDEX; Schema: public; Owner: marco
--

CREATE INDEX index_ferment_recipes_on_user_id ON public.ferment_recipes USING btree (user_id);


--
-- Name: index_ferments_on_user_id; Type: INDEX; Schema: public; Owner: marco
--

CREATE INDEX index_ferments_on_user_id ON public.ferments USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: marco
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: marco
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: comments fk_rails_03de2dc08c; Type: FK CONSTRAINT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_rails_03de2dc08c FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: ferment_recipes fk_rails_492c3cdefa; Type: FK CONSTRAINT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.ferment_recipes
    ADD CONSTRAINT fk_rails_492c3cdefa FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: comments fk_rails_553038bd5e; Type: FK CONSTRAINT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT fk_rails_553038bd5e FOREIGN KEY (ferment_id) REFERENCES public.ferments(id);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: ferments fk_rails_aef2e62253; Type: FK CONSTRAINT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.ferments
    ADD CONSTRAINT fk_rails_aef2e62253 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: ferment_recipes fk_rails_f4265871e1; Type: FK CONSTRAINT; Schema: public; Owner: marco
--

ALTER TABLE ONLY public.ferment_recipes
    ADD CONSTRAINT fk_rails_f4265871e1 FOREIGN KEY (ferment_id) REFERENCES public.ferments(id);


--
-- PostgreSQL database dump complete
--

