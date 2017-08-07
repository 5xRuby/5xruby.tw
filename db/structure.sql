--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = public, pg_catalog;

--
-- Name: attendances_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE attendances_status AS ENUM (
    'new',
    'ordered',
    'checked_in',
    'cancelled'
);


--
-- Name: markup_type; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE markup_type AS ENUM (
    'html',
    'markdown'
);


--
-- Name: orders_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE orders_status AS ENUM (
    'new',
    'ordered',
    'paid',
    'cancelled'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: activities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE activities (
    id integer NOT NULL,
    permalink character varying,
    max_population integer DEFAULT 300,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    course_id integer,
    form_id integer
);


--
-- Name: activities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE activities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE activities_id_seq OWNED BY activities.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: attendances; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE attendances (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    user_id integer,
    sequence_num integer,
    ticket_id integer,
    activity_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    state attendances_status,
    order_id uuid
);


--
-- Name: authors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE authors (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: authors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE authors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE authors_id_seq OWNED BY authors.id;


--
-- Name: camp_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE camp_settings (
    id integer NOT NULL,
    payload json,
    status character varying,
    lang character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: camp_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE camp_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: camp_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE camp_settings_id_seq OWNED BY camp_settings.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    courses_count integer DEFAULT 0 NOT NULL,
    is_highlighted boolean DEFAULT false NOT NULL,
    sort_id integer DEFAULT 0 NOT NULL,
    permalink character varying NOT NULL
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE courses (
    id integer NOT NULL,
    image character varying,
    title character varying NOT NULL,
    summary text,
    description text,
    what_will_learn text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    subtitle character varying,
    category_id integer,
    is_online boolean DEFAULT false NOT NULL,
    permalink character varying NOT NULL,
    note text,
    apply_link character varying,
    iframe_html character varying,
    maximum_attendees integer DEFAULT 30 NOT NULL,
    total_attendees integer DEFAULT 0 NOT NULL,
    minimum_attendees integer DEFAULT 5 NOT NULL,
    suitable_for text,
    payment_note text
);


--
-- Name: courses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE courses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE courses_id_seq OWNED BY courses.id;


--
-- Name: courses_speakers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE courses_speakers (
    course_id integer NOT NULL,
    speaker_id integer NOT NULL
);


--
-- Name: faqs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE faqs (
    id integer NOT NULL,
    question text NOT NULL,
    answer text NOT NULL,
    is_online boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    sort_id integer DEFAULT 0 NOT NULL
);


--
-- Name: faqs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE faqs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: faqs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE faqs_id_seq OWNED BY faqs.id;


--
-- Name: forms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE forms (
    id integer NOT NULL,
    title character varying,
    fields json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: forms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE forms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE forms_id_seq OWNED BY forms.id;


--
-- Name: index_picture_imgs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE index_picture_imgs (
    id integer NOT NULL,
    src character varying,
    lang character varying,
    size character varying,
    index_picture_id integer
);


--
-- Name: index_picture_imgs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE index_picture_imgs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: index_picture_imgs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE index_picture_imgs_id_seq OWNED BY index_picture_imgs.id;


--
-- Name: index_pictures; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE index_pictures (
    id integer NOT NULL,
    alt character varying,
    href character varying
);


--
-- Name: index_pictures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE index_pictures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: index_pictures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE index_pictures_id_seq OWNED BY index_pictures.id;


--
-- Name: interview_questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE interview_questions (
    id integer NOT NULL,
    question text NOT NULL,
    answer text NOT NULL,
    sort_id integer DEFAULT 0 NOT NULL,
    is_online boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: interview_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE interview_questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: interview_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE interview_questions_id_seq OWNED BY interview_questions.id;


--
-- Name: omniauths; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE omniauths (
    id integer NOT NULL,
    provider character varying,
    uid character varying,
    user_id integer,
    payload json,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: omniauths_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE omniauths_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: omniauths_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE omniauths_id_seq OWNED BY omniauths.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE orders (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    form_data json,
    total_price integer,
    order_info text,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    state orders_status
);


--
-- Name: posts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE posts (
    id integer NOT NULL,
    title character varying NOT NULL,
    content text NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    image character varying,
    author_id integer,
    summary text,
    is_online boolean DEFAULT false NOT NULL,
    permalink character varying NOT NULL,
    publish_at timestamp without time zone,
    markup_type markup_type DEFAULT 'html'::markup_type,
    image_width integer,
    image_height integer
);


--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE posts_id_seq OWNED BY posts.id;


--
-- Name: redactor_images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE redactor_images (
    id integer NOT NULL,
    image character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: redactor_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE redactor_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: redactor_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE redactor_images_id_seq OWNED BY redactor_images.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: showcases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE showcases (
    id integer NOT NULL,
    name character varying,
    description text,
    link character varying,
    image character varying,
    is_online boolean DEFAULT false NOT NULL,
    sort_id integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    category integer
);


--
-- Name: showcases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE showcases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: showcases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE showcases_id_seq OWNED BY showcases.id;


--
-- Name: speakers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE speakers (
    id integer NOT NULL,
    avatar character varying,
    name character varying NOT NULL,
    summary text,
    is_online boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    role character varying DEFAULT 'consultant'::character varying NOT NULL,
    title character varying,
    facebook_url character varying,
    twitter_url character varying,
    google_url character varying,
    blog_url character varying,
    sort_id integer DEFAULT 0 NOT NULL
);


--
-- Name: speakers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE speakers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: speakers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE speakers_id_seq OWNED BY speakers.id;


--
-- Name: speakers_videos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE speakers_videos (
    video_id integer NOT NULL,
    speaker_id integer NOT NULL
);


--
-- Name: stages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE stages (
    id integer NOT NULL,
    course_id integer NOT NULL,
    title character varying NOT NULL,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    date date DEFAULT '2014-09-03'::date NOT NULL,
    start_at time without time zone DEFAULT '00:00:00'::time without time zone NOT NULL,
    end_at time without time zone DEFAULT '00:00:00'::time without time zone NOT NULL,
    hours double precision DEFAULT 1.0 NOT NULL
);


--
-- Name: stages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stages_id_seq OWNED BY stages.id;


--
-- Name: taggings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE taggings (
    id integer NOT NULL,
    tag_id integer,
    taggable_type character varying,
    taggable_id integer,
    tagger_type character varying,
    tagger_id integer,
    context character varying(128),
    created_at timestamp without time zone
);


--
-- Name: taggings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE taggings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: taggings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE taggings_id_seq OWNED BY taggings.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tags (
    id integer NOT NULL,
    name character varying,
    taggings_count integer DEFAULT 0
);


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: tickets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tickets (
    id integer NOT NULL,
    activity_id integer,
    start_at timestamp without time zone,
    end_at timestamp without time zone,
    price integer DEFAULT 0,
    need_invitation_code boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    name character varying,
    is_primary boolean DEFAULT false
);


--
-- Name: tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tickets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tickets_id_seq OWNED BY tickets.id;


--
-- Name: translations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE translations (
    id integer NOT NULL,
    translatable_type character varying,
    translatable_id integer,
    "column" character varying,
    locale character varying,
    text text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE translations_id_seq OWNED BY translations.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    username character varying,
    phone character varying
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: videos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE videos (
    id integer NOT NULL,
    title character varying,
    iframe character varying,
    summary character varying,
    description text,
    is_online boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    image character varying
);


--
-- Name: videos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE videos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: videos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE videos_id_seq OWNED BY videos.id;


--
-- Name: activities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY activities ALTER COLUMN id SET DEFAULT nextval('activities_id_seq'::regclass);


--
-- Name: authors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY authors ALTER COLUMN id SET DEFAULT nextval('authors_id_seq'::regclass);


--
-- Name: camp_settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY camp_settings ALTER COLUMN id SET DEFAULT nextval('camp_settings_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: courses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY courses ALTER COLUMN id SET DEFAULT nextval('courses_id_seq'::regclass);


--
-- Name: faqs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY faqs ALTER COLUMN id SET DEFAULT nextval('faqs_id_seq'::regclass);


--
-- Name: forms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY forms ALTER COLUMN id SET DEFAULT nextval('forms_id_seq'::regclass);


--
-- Name: index_picture_imgs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY index_picture_imgs ALTER COLUMN id SET DEFAULT nextval('index_picture_imgs_id_seq'::regclass);


--
-- Name: index_pictures id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY index_pictures ALTER COLUMN id SET DEFAULT nextval('index_pictures_id_seq'::regclass);


--
-- Name: interview_questions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY interview_questions ALTER COLUMN id SET DEFAULT nextval('interview_questions_id_seq'::regclass);


--
-- Name: omniauths id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY omniauths ALTER COLUMN id SET DEFAULT nextval('omniauths_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY posts ALTER COLUMN id SET DEFAULT nextval('posts_id_seq'::regclass);


--
-- Name: redactor_images id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY redactor_images ALTER COLUMN id SET DEFAULT nextval('redactor_images_id_seq'::regclass);


--
-- Name: showcases id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY showcases ALTER COLUMN id SET DEFAULT nextval('showcases_id_seq'::regclass);


--
-- Name: speakers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY speakers ALTER COLUMN id SET DEFAULT nextval('speakers_id_seq'::regclass);


--
-- Name: stages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stages ALTER COLUMN id SET DEFAULT nextval('stages_id_seq'::regclass);


--
-- Name: taggings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY taggings ALTER COLUMN id SET DEFAULT nextval('taggings_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: tickets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tickets ALTER COLUMN id SET DEFAULT nextval('tickets_id_seq'::regclass);


--
-- Name: translations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY translations ALTER COLUMN id SET DEFAULT nextval('translations_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: videos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY videos ALTER COLUMN id SET DEFAULT nextval('videos_id_seq'::regclass);


--
-- Name: activities activities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: authors authors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);


--
-- Name: camp_settings camp_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY camp_settings
    ADD CONSTRAINT camp_settings_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (id);


--
-- Name: faqs faqs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY faqs
    ADD CONSTRAINT faqs_pkey PRIMARY KEY (id);


--
-- Name: forms forms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY forms
    ADD CONSTRAINT forms_pkey PRIMARY KEY (id);


--
-- Name: index_picture_imgs index_picture_imgs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY index_picture_imgs
    ADD CONSTRAINT index_picture_imgs_pkey PRIMARY KEY (id);


--
-- Name: index_pictures index_pictures_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY index_pictures
    ADD CONSTRAINT index_pictures_pkey PRIMARY KEY (id);


--
-- Name: interview_questions interview_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY interview_questions
    ADD CONSTRAINT interview_questions_pkey PRIMARY KEY (id);


--
-- Name: omniauths omniauths_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY omniauths
    ADD CONSTRAINT omniauths_pkey PRIMARY KEY (id);


--
-- Name: orders payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: redactor_images redactor_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY redactor_images
    ADD CONSTRAINT redactor_images_pkey PRIMARY KEY (id);


--
-- Name: attendances registrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY attendances
    ADD CONSTRAINT registrations_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: showcases showcases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY showcases
    ADD CONSTRAINT showcases_pkey PRIMARY KEY (id);


--
-- Name: speakers speakers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY speakers
    ADD CONSTRAINT speakers_pkey PRIMARY KEY (id);


--
-- Name: stages stages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stages
    ADD CONSTRAINT stages_pkey PRIMARY KEY (id);


--
-- Name: taggings taggings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY taggings
    ADD CONSTRAINT taggings_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- Name: translations translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY translations
    ADD CONSTRAINT translations_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: videos videos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY videos
    ADD CONSTRAINT videos_pkey PRIMARY KEY (id);


--
-- Name: index_activities_on_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_activities_on_course_id ON activities USING btree (course_id);


--
-- Name: index_activities_on_form_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_activities_on_form_id ON activities USING btree (form_id);


--
-- Name: index_activities_on_permalink; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_activities_on_permalink ON activities USING btree (permalink);


--
-- Name: index_attendances_on_activity_id_and_sequence_num; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_attendances_on_activity_id_and_sequence_num ON attendances USING btree (activity_id, sequence_num);


--
-- Name: index_categories_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categories_on_name ON categories USING btree (name);


--
-- Name: index_categories_on_permalink; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_categories_on_permalink ON categories USING btree (permalink);


--
-- Name: index_courses_on_category_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_courses_on_category_id ON courses USING btree (category_id);


--
-- Name: index_courses_on_permalink; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_courses_on_permalink ON courses USING btree (permalink);


--
-- Name: index_courses_on_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_courses_on_title ON courses USING btree (title);


--
-- Name: index_courses_speakers_on_course_id_and_speaker_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_courses_speakers_on_course_id_and_speaker_id ON courses_speakers USING btree (course_id, speaker_id);


--
-- Name: index_courses_speakers_on_speaker_id_and_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_courses_speakers_on_speaker_id_and_course_id ON courses_speakers USING btree (speaker_id, course_id);


--
-- Name: index_posts_on_author_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_posts_on_author_id ON posts USING btree (author_id);


--
-- Name: index_posts_on_permalink; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_posts_on_permalink ON posts USING btree (permalink);


--
-- Name: index_speakers_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_speakers_on_name ON speakers USING btree (name);


--
-- Name: index_speakers_videos_on_speaker_id_and_video_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_speakers_videos_on_speaker_id_and_video_id ON speakers_videos USING btree (speaker_id, video_id);


--
-- Name: index_speakers_videos_on_video_id_and_speaker_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_speakers_videos_on_video_id_and_speaker_id ON speakers_videos USING btree (video_id, speaker_id);


--
-- Name: index_stages_on_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stages_on_course_id ON stages USING btree (course_id);


--
-- Name: index_taggings_on_context; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_context ON taggings USING btree (context);


--
-- Name: index_taggings_on_tag_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_tag_id ON taggings USING btree (tag_id);


--
-- Name: index_taggings_on_taggable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_taggable_id ON taggings USING btree (taggable_id);


--
-- Name: index_taggings_on_taggable_id_and_taggable_type_and_context; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_taggable_id_and_taggable_type_and_context ON taggings USING btree (taggable_id, taggable_type, context);


--
-- Name: index_taggings_on_taggable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_taggable_type ON taggings USING btree (taggable_type);


--
-- Name: index_taggings_on_tagger_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_tagger_id ON taggings USING btree (tagger_id);


--
-- Name: index_taggings_on_tagger_id_and_tagger_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_taggings_on_tagger_id_and_tagger_type ON taggings USING btree (tagger_id, tagger_type);


--
-- Name: index_tags_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_tags_on_name ON tags USING btree (name);


--
-- Name: index_translations_on_translatable_type_and_translatable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_translations_on_translatable_type_and_translatable_id ON translations USING btree (translatable_type, translatable_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: taggings_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX taggings_idx ON taggings USING btree (tag_id, taggable_id, taggable_type, context, tagger_id, tagger_type);


--
-- Name: taggings_idy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX taggings_idy ON taggings USING btree (taggable_id, taggable_type, tagger_id, context);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20140505041847'),
('20140505141006'),
('20140509032510'),
('20140509033208'),
('20140509121002'),
('20140509124729'),
('20140509133927'),
('20140510135721'),
('20140510183028'),
('20140511164233'),
('20140512175223'),
('20140513054044'),
('20140515175439'),
('20140515183010'),
('20140517063501'),
('20140517064348'),
('20140517064450'),
('20140517072027'),
('20140518073615'),
('20140518073955'),
('20140518085623'),
('20140518114958'),
('20140518114959'),
('20140518114960'),
('20140519200529'),
('20140520173618'),
('20140522145457'),
('20140524092604'),
('20140524113745'),
('20140524171004'),
('20140524171005'),
('20140524171007'),
('20140527075041'),
('20140528051954'),
('20140601104147'),
('20140822174137'),
('20140902143919'),
('20140902204101'),
('20140902211454'),
('20140902211728'),
('20140902220607'),
('20140903013050'),
('20140903095425'),
('20140903101343'),
('20140903101852'),
('20140904082353'),
('20141008035833'),
('20141009144312'),
('20141009181547'),
('20141012154813'),
('20141023050621'),
('20141024042720'),
('20141031082820'),
('20160104064158'),
('20160203040400'),
('20160203040401'),
('20160203040402'),
('20170214085010'),
('20170215074055'),
('20170215085038'),
('20170215092604'),
('20170215103824'),
('20170216043136'),
('20170216072139'),
('20170216091337'),
('20170217064811'),
('20170221080159'),
('20170221085439'),
('20170301065149'),
('20170308030123'),
('20170317082958'),
('20170317085150'),
('20170317094116'),
('20170323093033'),
('20170323095104'),
('20170323102014'),
('20170324033407'),
('20170328100913'),
('20170330084200'),
('20170331041117'),
('20170405034739'),
('20170405044239'),
('20170406032802'),
('20170406033828');


