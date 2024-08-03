--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: world_type; Type: TYPE; Schema: public; Owner: freecodecamp
--

CREATE TYPE public.world_type AS ENUM (
    'Moon',
    'Planet'
);


ALTER TYPE public.world_type OWNER TO freecodecamp;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    type character varying(20),
    constellation character varying(50),
    mass_in_m_solar real,
    num_stars real,
    description text,
    name character varying(50) NOT NULL,
    diameter_in_ly integer,
    is_fictional boolean
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(50) NOT NULL,
    planet_id integer,
    description text,
    is_fictional boolean,
    has_known_life boolean
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(50) NOT NULL,
    mass_in_kg real,
    diameter_in_km integer,
    description text,
    has_known_life boolean,
    avg_orbital_speed_in_km_s numeric(6,2),
    star_id integer,
    is_fictional boolean
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: species; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.species (
    species_id integer NOT NULL,
    name character varying(50) NOT NULL,
    planet_id integer,
    is_fictional boolean,
    is_intelligent boolean
);


ALTER TABLE public.species OWNER TO freecodecamp;

--
-- Name: species_species_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.species_species_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.species_species_id_seq OWNER TO freecodecamp;

--
-- Name: species_species_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.species_species_id_seq OWNED BY public.species.species_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(50) NOT NULL,
    mass_in_m_solar real,
    diameter_in_km real,
    luminosity_in_watts real,
    galaxy_id integer,
    description text,
    is_fictional boolean
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_id_seq OWNER TO freecodecamp;

--
-- Name: star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_id_seq OWNED BY public.star.star_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_id_seq'::regclass);


--
-- Name: species species_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.species ALTER COLUMN species_id SET DEFAULT nextval('public.species_species_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'SBbc', 'Sagittarius', 1.54e+12, 2.5e+11, 'The second largest galaxy in the Local Group. Home to the Solar System and the only known life in the universe.', 'Milky Way', 87400, false);
INSERT INTO public.galaxy VALUES (2, 'SA(s)b', 'Andromeda', 1.5e+12, 1e+12, 'The largest galaxy in the Local Group, and the closest to the Milky Way.', 'Andromeda Galaxy', 152000, false);
INSERT INTO public.galaxy VALUES (3, 'SA(s)cd', 'Triangulum', 5e+10, 4e+10, 'The third largest galaxy in the Local Group, and its only unbarred spiral galaxy.', 'Triangulum Galaxy', 60000, false);
INSERT INTO public.galaxy VALUES (4, 'Irr/SB(s)m', 'Dorado', 1e+10, 2e+10, 'The only Magellanic spiral galaxy in the Local Group.', 'Large Magellanic Cloud', 32200, false);
INSERT INTO public.galaxy VALUES (5, 'SB(s)m pec', 'Tucana', 7e+09, 3e+09, 'An irregular dwarf galaxy in the Local Group. One of the most distant objects visible to the naked eye.', 'Small Magellanic Cloud', 18900, false);
INSERT INTO public.galaxy VALUES (6, 'E2', 'Andromeda', 3e+09, 4e+08, 'A dwarf satellite of the Andromeda Galaxy.', 'Messier 32', 6500, false);
INSERT INTO public.galaxy VALUES (7, 'S', NULL, NULL, 4e+11, 'The setting of the Star Wars franchise.', 'The Galaxy', 120000, true);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (19, 'Guermessa', 12, NULL, true, false);
INSERT INTO public.moon VALUES (20, 'Ghomrassen', 12, NULL, true, false);
INSERT INTO public.moon VALUES (21, 'Chenini', 12, NULL, true, false);
INSERT INTO public.moon VALUES (2, 'Phobos', 4, 'The larger of Mars'' two moons. Named after the Greek god of fear and panic.', false, false);
INSERT INTO public.moon VALUES (3, 'Deimos', 4, 'The smaller of Mars'' two moons. Named after the Greek god of dread.', false, false);
INSERT INTO public.moon VALUES (4, 'Io', 5, 'One of the four Galilean moons of Jupiter. The most geologically active object in the Solar System, with over 400 active volcanoes.', false, false);
INSERT INTO public.moon VALUES (5, 'Europa', 5, 'One of the four Galilean moons. Has an icy surface, which covers a water ocean.', false, false);
INSERT INTO public.moon VALUES (6, 'Ganymede', 5, 'One of the Galilean moons. The only moon in the Solar System with a substantial magnetic field.', false, false);
INSERT INTO public.moon VALUES (7, 'Callisto', 5, 'One of the Galilean moons. About the size of the planet Mercury, and completely covered with impact craters.', false, false);
INSERT INTO public.moon VALUES (8, 'Titan', 6, 'Saturn''s largest moon. The only object in space (except Earth) with clear evidence of bodies of liquid on its surface.', false, false);
INSERT INTO public.moon VALUES (9, 'Pandora', 6, 'A moon of Saturn. Not to be confused with the fictional planet Pandora of the Avatar franchise.', false, false);
INSERT INTO public.moon VALUES (1, 'Luna', 3, 'Earth''s only natural satellite. Has a tidally locked orbit, such that the same portion of its surface is always visible from Earth.', false, false);
INSERT INTO public.moon VALUES (10, 'Rhea', 6, 'Saturn''s second-largest moon. Composed of roughly three-quarters ice.', false, false);
INSERT INTO public.moon VALUES (11, 'Titania', 7, 'Uranus''s largest moon.', false, false);
INSERT INTO public.moon VALUES (12, 'Oberon', 7, 'Uranus''s second-largest moon.', false, false);
INSERT INTO public.moon VALUES (13, 'Triton', 8, 'Neptune''s largest moon. The only large moon in the Solar System with a retrograde orbit.', false, false);
INSERT INTO public.moon VALUES (14, 'Nereid', 8, 'The third-largest moon of Neptune. Has the most eccentric orbit of all known moons in the Solar System.', false, false);
INSERT INTO public.moon VALUES (15, 'Charon', 9, 'The largest moon of Pluto. Quite a massive moon compared to its parent body - so much so that the gravitational center of the Plutonian system lies outside Pluto.', false, false);
INSERT INTO public.moon VALUES (16, 'Umbriel', 7, 'The third-largest moon of Uranus. Aptly named, as its surface is the darkest of the Uranian moons.', false, false);
INSERT INTO public.moon VALUES (17, 'Krelln', 11, 'The larger of the two Arrakian moons. Tidally locked with its parent body.', true, false);
INSERT INTO public.moon VALUES (18, 'Arvon', 11, 'The smaller of the Arrakian moons.', true, false);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (3, 'Earth', 5.972e+24, 12742, 'The third planet from the Sun. The origin planet of the author of this database.', true, 29.78, 1, false);
INSERT INTO public.planet VALUES (4, 'Mars', 6.417e+23, 6779, 'The fourth planet from the Sun. Famously very red, due to the abundance of iron oxide on its surface.', false, 24.07, 1, false);
INSERT INTO public.planet VALUES (5, 'Jupiter', 1.8982e+27, 142980, 'The fifth planet from the Sun, and the innermost of the Solar System''s so-called Gas Giants. Has a giant storm on its surface known as the Great Red Spot, which is 23,000km long.', false, 13.07, 1, false);
INSERT INTO public.planet VALUES (6, 'Saturn', 5.683e+26, 120540, 'The sixth planet from the Sun. Famous for its prominent rings of orbital debris.', false, 9.68, 1, false);
INSERT INTO public.planet VALUES (7, 'Uranus', 8.681e+25, 50724, 'The seventh planet from the Sun. Its name originates in Roman mythology, but is also homophonic to a description of an unfortunate part of human anatomy in English.', false, 6.80, 1, false);
INSERT INTO public.planet VALUES (8, 'Neptune', 1.024e+26, 49528, 'The eighth and farthest planet from the Sun, and the densest of the Gas Giants.', false, 5.43, 1, false);
INSERT INTO public.planet VALUES (9, 'Pluto', 1.3025e+22, 2377, 'A dwarf planet that orbits the Sun in the Kuiper belt. Not techincally a planet, though it used to be classified as such, and many have an emtional attachment to this classification.', false, 4.74, 1, false);
INSERT INTO public.planet VALUES (11, 'Arrakis', NULL, NULL, 'The original source of Spice Melange, and the center of Muad''Dib''s Imperium.', true, NULL, 3, true);
INSERT INTO public.planet VALUES (13, 'Vulcan', NULL, NULL, 'The homeworld of the alien species of the same name. Apparently very hot.', true, NULL, 6, true);
INSERT INTO public.planet VALUES (12, 'Tatooine', NULL, 10465, 'A sparsely populated desert world. The birthplace of Anakin and Luke Skywalker. Orbits a binary star system, which this database schema can''t really account for.', true, NULL, 4, true);
INSERT INTO public.planet VALUES (1, 'Mercury', 3.301e+23, 4879, 'The smallest and innermost planet in the Solar System. Named after the Roman god of swiftness, due to the speed at which it moves across Earth''s night sky.', false, 47.36, 1, false);
INSERT INTO public.planet VALUES (2, 'Venus', 4.8675e+24, 12104, 'The second planet from the Sun. Has the densest atmosphere of the Solar System''s four terrestrial planets.', false, 35.02, 1, false);


--
-- Data for Name: species; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.species VALUES (1, 'Homo sapiens', 3, false, true);
INSERT INTO public.species VALUES (2, 'Vulcan', 13, true, true);
INSERT INTO public.species VALUES (3, 'Shai-Hulud', 11, true, false);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Sun', 1, 1.391e+06, 3.828e+26, 1, 'The star at the center of the Solar System. It is associated with its own unit of measurement, the Solar mass (M_sun, M_solar)', false);
INSERT INTO public.star VALUES (3, 'Canopus', 9.81, 1.02e+08, 4.096e+30, 1, 'The second-brightest star in the Earth''s night sky. Much hotter and more massive than the Sun.', false);
INSERT INTO public.star VALUES (4, 'Tatoo I', NULL, NULL, NULL, 7, 'One half of the Tatoo binary star system.', true);
INSERT INTO public.star VALUES (5, 'Tatoo II', NULL, NULL, NULL, 7, 'One half of the Tatoo binary star system.', true);
INSERT INTO public.star VALUES (6, '40 Eridani A', 0.78, 1.119e+06, 1.531e+26, 1, 'Part of 40 Eridani triple star system. Located approximately 16.3ly from the Sun.', false);
INSERT INTO public.star VALUES (7, 'Sirius A', 2.063, 2.381e+06, 9.723e+27, 1, 'The larger star in the Sirius binary star system. Sirius is the brightest "star" in Earth''s night sky.', false);


--
-- Name: galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_id_seq', 7, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 21, true);


--
-- Name: planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_id_seq', 13, true);


--
-- Name: species_species_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.species_species_id_seq', 3, true);


--
-- Name: star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_id_seq', 7, true);


--
-- Name: galaxy galaxy_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_name_key UNIQUE (name);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_name_key UNIQUE (name);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_name_key UNIQUE (name);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: species species_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.species
    ADD CONSTRAINT species_name_key UNIQUE (name);


--
-- Name: species species_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.species
    ADD CONSTRAINT species_pkey PRIMARY KEY (species_id);


--
-- Name: star star_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_name_key UNIQUE (name);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: species species_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.species
    ADD CONSTRAINT species_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

