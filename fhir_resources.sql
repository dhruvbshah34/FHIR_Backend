--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13
-- Dumped by pg_dump version 17.5

-- Started on 2025-07-17 19:19:48

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 24577)
-- Name: fhir_resources; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA fhir_resources;


ALTER SCHEMA fhir_resources OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 252 (class 1259 OID 24863)
-- Name: api_call_analytics; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.api_call_analytics (
    id integer NOT NULL,
    endpoint_id integer,
    called_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    http_method character varying(10),
    full_url character varying(1000),
    query_parameters jsonb,
    request_headers jsonb,
    request_body_size integer,
    response_time_ms integer,
    http_status_code integer,
    response_size_bytes integer,
    response_headers jsonb,
    resource_count integer,
    bundle_type character varying(50),
    has_next_page boolean,
    error_category character varying(100),
    error_message text,
    retry_count integer DEFAULT 0,
    dns_lookup_time_ms integer,
    tcp_connect_time_ms integer,
    tls_handshake_time_ms integer,
    first_byte_time_ms integer,
    user_agent character varying(255),
    client_ip inet,
    session_id character varying(255)
);


ALTER TABLE fhir_resources.api_call_analytics OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 24862)
-- Name: api_call_analytics_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.api_call_analytics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.api_call_analytics_id_seq OWNER TO postgres;

--
-- TOC entry 3636 (class 0 OID 0)
-- Dependencies: 251
-- Name: api_call_analytics_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.api_call_analytics_id_seq OWNED BY fhir_resources.api_call_analytics.id;


--
-- TOC entry 230 (class 1259 OID 24681)
-- Name: api_call_log; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.api_call_log (
    id integer NOT NULL,
    endpoint_id integer,
    called_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    response_time_ms integer,
    http_status_code integer,
    response_size_bytes integer,
    error_message text,
    request_parameters jsonb,
    response_headers jsonb,
    user_agent character varying(255),
    ip_address inet
);


ALTER TABLE fhir_resources.api_call_log OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 24680)
-- Name: api_call_log_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.api_call_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.api_call_log_id_seq OWNER TO postgres;

--
-- TOC entry 3637 (class 0 OID 0)
-- Dependencies: 229
-- Name: api_call_log_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.api_call_log_id_seq OWNED BY fhir_resources.api_call_log.id;


--
-- TOC entry 226 (class 1259 OID 24647)
-- Name: api_endpoints; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.api_endpoints (
    id integer NOT NULL,
    endpoint_url character varying(500) NOT NULL,
    resource_type character varying(100) NOT NULL,
    http_method character varying(10) NOT NULL,
    description text,
    is_active boolean DEFAULT true,
    discovered_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    last_successful_call timestamp without time zone,
    total_calls integer DEFAULT 0,
    successful_calls integer DEFAULT 0,
    failed_calls integer DEFAULT 0
);


ALTER TABLE fhir_resources.api_endpoints OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 24646)
-- Name: api_endpoints_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.api_endpoints_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.api_endpoints_id_seq OWNER TO postgres;

--
-- TOC entry 3638 (class 0 OID 0)
-- Dependencies: 225
-- Name: api_endpoints_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.api_endpoints_id_seq OWNED BY fhir_resources.api_endpoints.id;


--
-- TOC entry 236 (class 1259 OID 24738)
-- Name: bundle_entries; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.bundle_entries (
    id integer NOT NULL,
    bundle_id character varying(255),
    raw_response_id integer,
    entry_index integer,
    resource_type character varying(100),
    resource_id character varying(255),
    search_mode character varying(50),
    search_score numeric(5,3)
);


ALTER TABLE fhir_resources.bundle_entries OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 24737)
-- Name: bundle_entries_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.bundle_entries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.bundle_entries_id_seq OWNER TO postgres;

--
-- TOC entry 3639 (class 0 OID 0)
-- Dependencies: 235
-- Name: bundle_entries_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.bundle_entries_id_seq OWNED BY fhir_resources.bundle_entries.id;


--
-- TOC entry 222 (class 1259 OID 24621)
-- Name: encounters; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.encounters (
    id integer NOT NULL,
    fhir_id character varying(64) NOT NULL,
    identifier_value character varying(255),
    identifier_system character varying(255),
    status character varying(50) NOT NULL,
    class_code character varying(50),
    class_display character varying(255),
    class_system character varying(255),
    type_code character varying(100),
    type_display character varying(255),
    type_system character varying(255),
    subject_reference character varying(255),
    participant_individual_reference character varying(255)[],
    participant_type_code character varying(100)[],
    period_start timestamp without time zone,
    period_end timestamp without time zone,
    reason_code character varying(100)[],
    reason_display character varying(255)[],
    hospitalization_admit_source_code character varying(100),
    hospitalization_discharge_disposition_code character varying(100),
    location_reference character varying(255)[],
    service_provider_reference character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    raw_fhir_data jsonb
);


ALTER TABLE fhir_resources.encounters OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24620)
-- Name: encounters_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.encounters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.encounters_id_seq OWNER TO postgres;

--
-- TOC entry 3640 (class 0 OID 0)
-- Dependencies: 221
-- Name: encounters_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.encounters_id_seq OWNED BY fhir_resources.encounters.id;


--
-- TOC entry 242 (class 1259 OID 24785)
-- Name: extraction_errors; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.extraction_errors (
    id integer NOT NULL,
    job_id integer,
    raw_response_id integer,
    field_name character varying(255),
    error_type character varying(100),
    error_message text,
    raw_value text,
    occurred_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE fhir_resources.extraction_errors OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 24784)
-- Name: extraction_errors_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.extraction_errors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.extraction_errors_id_seq OWNER TO postgres;

--
-- TOC entry 3641 (class 0 OID 0)
-- Dependencies: 241
-- Name: extraction_errors_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.extraction_errors_id_seq OWNED BY fhir_resources.extraction_errors.id;


--
-- TOC entry 240 (class 1259 OID 24770)
-- Name: extraction_jobs; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.extraction_jobs (
    id integer NOT NULL,
    job_name character varying(255) NOT NULL,
    resource_type character varying(100),
    started_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    completed_at timestamp without time zone,
    status character varying(50) DEFAULT 'running'::character varying,
    total_records integer DEFAULT 0,
    processed_records integer DEFAULT 0,
    successful_extractions integer DEFAULT 0,
    failed_extractions integer DEFAULT 0,
    error_summary text,
    last_processed_id integer
);


ALTER TABLE fhir_resources.extraction_jobs OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 24769)
-- Name: extraction_jobs_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.extraction_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.extraction_jobs_id_seq OWNER TO postgres;

--
-- TOC entry 3642 (class 0 OID 0)
-- Dependencies: 239
-- Name: extraction_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.extraction_jobs_id_seq OWNED BY fhir_resources.extraction_jobs.id;


--
-- TOC entry 234 (class 1259 OID 24726)
-- Name: fhir_bundles; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.fhir_bundles (
    id integer NOT NULL,
    bundle_id character varying(255) NOT NULL,
    bundle_type character varying(50),
    total_entries integer,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    search_parameters jsonb,
    next_page_url character varying(500),
    raw_bundle_data jsonb
);


ALTER TABLE fhir_resources.fhir_bundles OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 24725)
-- Name: fhir_bundles_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.fhir_bundles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.fhir_bundles_id_seq OWNER TO postgres;

--
-- TOC entry 3643 (class 0 OID 0)
-- Dependencies: 233
-- Name: fhir_bundles_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.fhir_bundles_id_seq OWNED BY fhir_resources.fhir_bundles.id;


--
-- TOC entry 238 (class 1259 OID 24757)
-- Name: field_extraction_rules; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.field_extraction_rules (
    id integer NOT NULL,
    resource_type character varying(100) NOT NULL,
    field_name character varying(255) NOT NULL,
    json_path character varying(500) NOT NULL,
    target_table character varying(255) NOT NULL,
    target_column character varying(255) NOT NULL,
    data_type character varying(100) NOT NULL,
    extraction_function character varying(255),
    is_required boolean DEFAULT false,
    is_array boolean DEFAULT false,
    validation_regex character varying(500),
    default_value text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    is_active boolean DEFAULT true
);


ALTER TABLE fhir_resources.field_extraction_rules OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 24756)
-- Name: field_extraction_rules_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.field_extraction_rules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.field_extraction_rules_id_seq OWNER TO postgres;

--
-- TOC entry 3644 (class 0 OID 0)
-- Dependencies: 237
-- Name: field_extraction_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.field_extraction_rules_id_seq OWNED BY fhir_resources.field_extraction_rules.id;


--
-- TOC entry 224 (class 1259 OID 24634)
-- Name: medications; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.medications (
    id integer NOT NULL,
    fhir_id character varying(64) NOT NULL,
    identifier_value character varying(255),
    identifier_system character varying(255),
    code_code character varying(100),
    code_display character varying(255),
    code_system character varying(255),
    status character varying(50),
    manufacturer_reference character varying(255),
    form_code character varying(100),
    form_display character varying(255),
    ingredient_item_reference character varying(255)[],
    ingredient_strength_numerator_value numeric(10,3)[],
    ingredient_strength_numerator_unit character varying(50)[],
    ingredient_strength_denominator_value numeric(10,3)[],
    ingredient_strength_denominator_unit character varying(50)[],
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    raw_fhir_data jsonb
);


ALTER TABLE fhir_resources.medications OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24633)
-- Name: medications_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.medications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.medications_id_seq OWNER TO postgres;

--
-- TOC entry 3645 (class 0 OID 0)
-- Dependencies: 223
-- Name: medications_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.medications_id_seq OWNED BY fhir_resources.medications.id;


--
-- TOC entry 250 (class 1259 OID 24849)
-- Name: observation_subjects; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.observation_subjects (
    id integer NOT NULL,
    observation_fhir_id character varying(255) NOT NULL,
    subject_fhir_id character varying(255) NOT NULL,
    subject_type character varying(100) NOT NULL,
    relationship_confidence numeric(3,2) DEFAULT 1.0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE fhir_resources.observation_subjects OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 24848)
-- Name: observation_subjects_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.observation_subjects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.observation_subjects_id_seq OWNER TO postgres;

--
-- TOC entry 3646 (class 0 OID 0)
-- Dependencies: 249
-- Name: observation_subjects_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.observation_subjects_id_seq OWNED BY fhir_resources.observation_subjects.id;


--
-- TOC entry 220 (class 1259 OID 24608)
-- Name: observations; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.observations (
    id integer NOT NULL,
    fhir_id character varying(64) NOT NULL,
    identifier_value character varying(255),
    identifier_system character varying(255),
    status character varying(50) NOT NULL,
    category_code character varying(100),
    category_display character varying(255),
    code_code character varying(100) NOT NULL,
    code_display character varying(255),
    code_system character varying(255),
    subject_reference character varying(255),
    subject_type character varying(50),
    encounter_reference character varying(255),
    effective_datetime timestamp without time zone,
    effective_period_start timestamp without time zone,
    effective_period_end timestamp without time zone,
    issued timestamp without time zone,
    performer_reference character varying(255)[],
    value_quantity_value numeric(10,3),
    value_quantity_unit character varying(50),
    value_quantity_system character varying(255),
    value_quantity_code character varying(50),
    value_string text,
    value_boolean boolean,
    value_integer integer,
    interpretation_code character varying(100),
    interpretation_display character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    raw_fhir_data jsonb
);


ALTER TABLE fhir_resources.observations OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24607)
-- Name: observations_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.observations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.observations_id_seq OWNER TO postgres;

--
-- TOC entry 3647 (class 0 OID 0)
-- Dependencies: 219
-- Name: observations_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.observations_id_seq OWNED BY fhir_resources.observations.id;


--
-- TOC entry 248 (class 1259 OID 24836)
-- Name: patient_provider_relationships; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.patient_provider_relationships (
    id integer NOT NULL,
    patient_fhir_id character varying(255) NOT NULL,
    provider_fhir_id character varying(255) NOT NULL,
    relationship_type character varying(100),
    relationship_source character varying(100),
    effective_start date,
    effective_end date,
    is_active boolean DEFAULT true,
    confidence_score numeric(3,2),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE fhir_resources.patient_provider_relationships OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 24835)
-- Name: patient_provider_relationships_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.patient_provider_relationships_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.patient_provider_relationships_id_seq OWNER TO postgres;

--
-- TOC entry 3648 (class 0 OID 0)
-- Dependencies: 247
-- Name: patient_provider_relationships_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.patient_provider_relationships_id_seq OWNED BY fhir_resources.patient_provider_relationships.id;


--
-- TOC entry 216 (class 1259 OID 24579)
-- Name: patients; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.patients (
    id integer NOT NULL,
    fhir_id character varying(64) NOT NULL,
    identifier_value character varying(255),
    identifier_system character varying(255),
    name_family character varying(255),
    name_given character varying(255)[],
    gender character varying(20),
    birth_date date,
    phone character varying(50),
    email character varying(255),
    address_line1 character varying(255),
    address_city character varying(100),
    address_state character varying(50),
    address_postal_code character varying(20),
    address_country character varying(50),
    active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    raw_fhir_data jsonb
);


ALTER TABLE fhir_resources.patients OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 24578)
-- Name: patients_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.patients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.patients_id_seq OWNER TO postgres;

--
-- TOC entry 3649 (class 0 OID 0)
-- Dependencies: 215
-- Name: patients_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.patients_id_seq OWNED BY fhir_resources.patients.id;


--
-- TOC entry 256 (class 1259 OID 24898)
-- Name: performance_baselines; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.performance_baselines (
    id integer NOT NULL,
    endpoint_id integer,
    measurement_date date DEFAULT CURRENT_DATE,
    min_response_time_ms integer,
    max_response_time_ms integer,
    avg_response_time_ms integer,
    median_response_time_ms integer,
    p95_response_time_ms integer,
    p99_response_time_ms integer,
    total_calls integer,
    successful_calls integer,
    failed_calls integer,
    avg_response_size_bytes integer,
    most_common_error character varying(255),
    error_rate numeric(5,4),
    uptime_percentage numeric(5,4),
    longest_downtime_minutes integer
);


ALTER TABLE fhir_resources.performance_baselines OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 24897)
-- Name: performance_baselines_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.performance_baselines_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.performance_baselines_id_seq OWNER TO postgres;

--
-- TOC entry 3650 (class 0 OID 0)
-- Dependencies: 255
-- Name: performance_baselines_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.performance_baselines_id_seq OWNED BY fhir_resources.performance_baselines.id;


--
-- TOC entry 218 (class 1259 OID 24593)
-- Name: practitioners; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.practitioners (
    id integer NOT NULL,
    fhir_id character varying(64) NOT NULL,
    identifier_value character varying(255),
    identifier_system character varying(255),
    name_family character varying(255),
    name_given character varying(255)[],
    name_prefix character varying(50)[],
    name_suffix character varying(50)[],
    gender character varying(20),
    birth_date date,
    phone character varying(50),
    email character varying(255),
    qualification_code character varying(50),
    qualification_display character varying(255),
    active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    raw_fhir_data jsonb
);


ALTER TABLE fhir_resources.practitioners OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24592)
-- Name: practitioners_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.practitioners_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.practitioners_id_seq OWNER TO postgres;

--
-- TOC entry 3651 (class 0 OID 0)
-- Dependencies: 217
-- Name: practitioners_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.practitioners_id_seq OWNED BY fhir_resources.practitioners.id;


--
-- TOC entry 254 (class 1259 OID 24883)
-- Name: rate_limit_events; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.rate_limit_events (
    id integer NOT NULL,
    endpoint_id integer,
    detected_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    http_status_code integer,
    retry_after_seconds integer,
    rate_limit_headers jsonb,
    calls_in_window integer,
    window_duration_seconds integer,
    reset_time timestamp without time zone
);


ALTER TABLE fhir_resources.rate_limit_events OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 24882)
-- Name: rate_limit_events_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.rate_limit_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.rate_limit_events_id_seq OWNER TO postgres;

--
-- TOC entry 3652 (class 0 OID 0)
-- Dependencies: 253
-- Name: rate_limit_events_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.rate_limit_events_id_seq OWNED BY fhir_resources.rate_limit_events.id;


--
-- TOC entry 232 (class 1259 OID 24705)
-- Name: raw_fhir_responses; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.raw_fhir_responses (
    id integer NOT NULL,
    endpoint_id integer,
    resource_type character varying(100) NOT NULL,
    resource_id character varying(255),
    bundle_id character varying(255),
    http_status_code integer,
    response_timestamp timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    response_headers jsonb,
    response_body jsonb NOT NULL,
    response_size_bytes integer,
    processing_status character varying(50) DEFAULT 'raw'::character varying,
    processing_errors text[],
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE fhir_resources.raw_fhir_responses OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 24704)
-- Name: raw_fhir_responses_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.raw_fhir_responses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.raw_fhir_responses_id_seq OWNER TO postgres;

--
-- TOC entry 3653 (class 0 OID 0)
-- Dependencies: 231
-- Name: raw_fhir_responses_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.raw_fhir_responses_id_seq OWNED BY fhir_resources.raw_fhir_responses.id;


--
-- TOC entry 246 (class 1259 OID 24821)
-- Name: reference_resolution_log; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.reference_resolution_log (
    id integer NOT NULL,
    reference_id integer,
    resolution_attempt_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    resolution_status character varying(50),
    http_status_code integer,
    error_message text,
    response_time_ms integer
);


ALTER TABLE fhir_resources.reference_resolution_log OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 24820)
-- Name: reference_resolution_log_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.reference_resolution_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.reference_resolution_log_id_seq OWNER TO postgres;

--
-- TOC entry 3654 (class 0 OID 0)
-- Dependencies: 245
-- Name: reference_resolution_log_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.reference_resolution_log_id_seq OWNED BY fhir_resources.reference_resolution_log.id;


--
-- TOC entry 244 (class 1259 OID 24805)
-- Name: resource_references; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.resource_references (
    id integer NOT NULL,
    source_resource_type character varying(100) NOT NULL,
    source_resource_id character varying(255) NOT NULL,
    source_field_path character varying(500) NOT NULL,
    target_reference character varying(500) NOT NULL,
    target_resource_type character varying(100),
    target_resource_id character varying(255),
    reference_type character varying(50),
    display_text character varying(500),
    is_resolved boolean DEFAULT false,
    resolved_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE fhir_resources.resource_references OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 24804)
-- Name: resource_references_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.resource_references_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.resource_references_id_seq OWNER TO postgres;

--
-- TOC entry 3655 (class 0 OID 0)
-- Dependencies: 243
-- Name: resource_references_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.resource_references_id_seq OWNED BY fhir_resources.resource_references.id;


--
-- TOC entry 228 (class 1259 OID 24661)
-- Name: response_structures; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.response_structures (
    id integer NOT NULL,
    endpoint_id integer,
    resource_type character varying(100),
    field_path character varying(500),
    field_name character varying(255),
    field_type character varying(100),
    is_required boolean DEFAULT false,
    is_array boolean DEFAULT false,
    sample_values text[],
    occurrence_count integer DEFAULT 0,
    first_seen timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    last_seen timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE fhir_resources.response_structures OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 24660)
-- Name: response_structures_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.response_structures_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.response_structures_id_seq OWNER TO postgres;

--
-- TOC entry 3656 (class 0 OID 0)
-- Dependencies: 227
-- Name: response_structures_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.response_structures_id_seq OWNED BY fhir_resources.response_structures.id;


--
-- TOC entry 258 (class 1259 OID 24911)
-- Name: schema_changes; Type: TABLE; Schema: fhir_resources; Owner: postgres
--

CREATE TABLE fhir_resources.schema_changes (
    id integer NOT NULL,
    resource_type character varying(100),
    detected_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    change_type character varying(50),
    field_path character varying(500),
    old_value text,
    new_value text,
    confidence_score numeric(3,2),
    sample_count integer,
    first_seen_in_response integer
);


ALTER TABLE fhir_resources.schema_changes OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 24910)
-- Name: schema_changes_id_seq; Type: SEQUENCE; Schema: fhir_resources; Owner: postgres
--

CREATE SEQUENCE fhir_resources.schema_changes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE fhir_resources.schema_changes_id_seq OWNER TO postgres;

--
-- TOC entry 3657 (class 0 OID 0)
-- Dependencies: 257
-- Name: schema_changes_id_seq; Type: SEQUENCE OWNED BY; Schema: fhir_resources; Owner: postgres
--

ALTER SEQUENCE fhir_resources.schema_changes_id_seq OWNED BY fhir_resources.schema_changes.id;


--
-- TOC entry 3342 (class 2604 OID 24866)
-- Name: api_call_analytics id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.api_call_analytics ALTER COLUMN id SET DEFAULT nextval('fhir_resources.api_call_analytics_id_seq'::regclass);


--
-- TOC entry 3308 (class 2604 OID 24684)
-- Name: api_call_log id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.api_call_log ALTER COLUMN id SET DEFAULT nextval('fhir_resources.api_call_log_id_seq'::regclass);


--
-- TOC entry 3296 (class 2604 OID 24650)
-- Name: api_endpoints id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.api_endpoints ALTER COLUMN id SET DEFAULT nextval('fhir_resources.api_endpoints_id_seq'::regclass);


--
-- TOC entry 3316 (class 2604 OID 24741)
-- Name: bundle_entries id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.bundle_entries ALTER COLUMN id SET DEFAULT nextval('fhir_resources.bundle_entries_id_seq'::regclass);


--
-- TOC entry 3290 (class 2604 OID 24624)
-- Name: encounters id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.encounters ALTER COLUMN id SET DEFAULT nextval('fhir_resources.encounters_id_seq'::regclass);


--
-- TOC entry 3329 (class 2604 OID 24788)
-- Name: extraction_errors id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.extraction_errors ALTER COLUMN id SET DEFAULT nextval('fhir_resources.extraction_errors_id_seq'::regclass);


--
-- TOC entry 3322 (class 2604 OID 24773)
-- Name: extraction_jobs id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.extraction_jobs ALTER COLUMN id SET DEFAULT nextval('fhir_resources.extraction_jobs_id_seq'::regclass);


--
-- TOC entry 3314 (class 2604 OID 24729)
-- Name: fhir_bundles id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.fhir_bundles ALTER COLUMN id SET DEFAULT nextval('fhir_resources.fhir_bundles_id_seq'::regclass);


--
-- TOC entry 3317 (class 2604 OID 24760)
-- Name: field_extraction_rules id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.field_extraction_rules ALTER COLUMN id SET DEFAULT nextval('fhir_resources.field_extraction_rules_id_seq'::regclass);


--
-- TOC entry 3293 (class 2604 OID 24637)
-- Name: medications id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.medications ALTER COLUMN id SET DEFAULT nextval('fhir_resources.medications_id_seq'::regclass);


--
-- TOC entry 3339 (class 2604 OID 24852)
-- Name: observation_subjects id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.observation_subjects ALTER COLUMN id SET DEFAULT nextval('fhir_resources.observation_subjects_id_seq'::regclass);


--
-- TOC entry 3287 (class 2604 OID 24611)
-- Name: observations id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.observations ALTER COLUMN id SET DEFAULT nextval('fhir_resources.observations_id_seq'::regclass);


--
-- TOC entry 3336 (class 2604 OID 24839)
-- Name: patient_provider_relationships id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.patient_provider_relationships ALTER COLUMN id SET DEFAULT nextval('fhir_resources.patient_provider_relationships_id_seq'::regclass);


--
-- TOC entry 3279 (class 2604 OID 24582)
-- Name: patients id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.patients ALTER COLUMN id SET DEFAULT nextval('fhir_resources.patients_id_seq'::regclass);


--
-- TOC entry 3347 (class 2604 OID 24901)
-- Name: performance_baselines id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.performance_baselines ALTER COLUMN id SET DEFAULT nextval('fhir_resources.performance_baselines_id_seq'::regclass);


--
-- TOC entry 3283 (class 2604 OID 24596)
-- Name: practitioners id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.practitioners ALTER COLUMN id SET DEFAULT nextval('fhir_resources.practitioners_id_seq'::regclass);


--
-- TOC entry 3345 (class 2604 OID 24886)
-- Name: rate_limit_events id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.rate_limit_events ALTER COLUMN id SET DEFAULT nextval('fhir_resources.rate_limit_events_id_seq'::regclass);


--
-- TOC entry 3310 (class 2604 OID 24708)
-- Name: raw_fhir_responses id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.raw_fhir_responses ALTER COLUMN id SET DEFAULT nextval('fhir_resources.raw_fhir_responses_id_seq'::regclass);


--
-- TOC entry 3334 (class 2604 OID 24824)
-- Name: reference_resolution_log id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.reference_resolution_log ALTER COLUMN id SET DEFAULT nextval('fhir_resources.reference_resolution_log_id_seq'::regclass);


--
-- TOC entry 3331 (class 2604 OID 24808)
-- Name: resource_references id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.resource_references ALTER COLUMN id SET DEFAULT nextval('fhir_resources.resource_references_id_seq'::regclass);


--
-- TOC entry 3302 (class 2604 OID 24664)
-- Name: response_structures id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.response_structures ALTER COLUMN id SET DEFAULT nextval('fhir_resources.response_structures_id_seq'::regclass);


--
-- TOC entry 3349 (class 2604 OID 24914)
-- Name: schema_changes id; Type: DEFAULT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.schema_changes ALTER COLUMN id SET DEFAULT nextval('fhir_resources.schema_changes_id_seq'::regclass);


--
-- TOC entry 3624 (class 0 OID 24863)
-- Dependencies: 252
-- Data for Name: api_call_analytics; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.api_call_analytics (id, endpoint_id, called_at, http_method, full_url, query_parameters, request_headers, request_body_size, response_time_ms, http_status_code, response_size_bytes, response_headers, resource_count, bundle_type, has_next_page, error_category, error_message, retry_count, dns_lookup_time_ms, tcp_connect_time_ms, tls_handshake_time_ms, first_byte_time_ms, user_agent, client_ip, session_id) FROM stdin;
\.


--
-- TOC entry 3602 (class 0 OID 24681)
-- Dependencies: 230
-- Data for Name: api_call_log; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.api_call_log (id, endpoint_id, called_at, response_time_ms, http_status_code, response_size_bytes, error_message, request_parameters, response_headers, user_agent, ip_address) FROM stdin;
\.


--
-- TOC entry 3598 (class 0 OID 24647)
-- Dependencies: 226
-- Data for Name: api_endpoints; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.api_endpoints (id, endpoint_url, resource_type, http_method, description, is_active, discovered_at, last_successful_call, total_calls, successful_calls, failed_calls) FROM stdin;
\.


--
-- TOC entry 3608 (class 0 OID 24738)
-- Dependencies: 236
-- Data for Name: bundle_entries; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.bundle_entries (id, bundle_id, raw_response_id, entry_index, resource_type, resource_id, search_mode, search_score) FROM stdin;
\.


--
-- TOC entry 3594 (class 0 OID 24621)
-- Dependencies: 222
-- Data for Name: encounters; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.encounters (id, fhir_id, identifier_value, identifier_system, status, class_code, class_display, class_system, type_code, type_display, type_system, subject_reference, participant_individual_reference, participant_type_code, period_start, period_end, reason_code, reason_display, hospitalization_admit_source_code, hospitalization_discharge_disposition_code, location_reference, service_provider_reference, created_at, updated_at, raw_fhir_data) FROM stdin;
\.


--
-- TOC entry 3614 (class 0 OID 24785)
-- Dependencies: 242
-- Data for Name: extraction_errors; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.extraction_errors (id, job_id, raw_response_id, field_name, error_type, error_message, raw_value, occurred_at) FROM stdin;
\.


--
-- TOC entry 3612 (class 0 OID 24770)
-- Dependencies: 240
-- Data for Name: extraction_jobs; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.extraction_jobs (id, job_name, resource_type, started_at, completed_at, status, total_records, processed_records, successful_extractions, failed_extractions, error_summary, last_processed_id) FROM stdin;
\.


--
-- TOC entry 3606 (class 0 OID 24726)
-- Dependencies: 234
-- Data for Name: fhir_bundles; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.fhir_bundles (id, bundle_id, bundle_type, total_entries, "timestamp", search_parameters, next_page_url, raw_bundle_data) FROM stdin;
\.


--
-- TOC entry 3610 (class 0 OID 24757)
-- Dependencies: 238
-- Data for Name: field_extraction_rules; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.field_extraction_rules (id, resource_type, field_name, json_path, target_table, target_column, data_type, extraction_function, is_required, is_array, validation_regex, default_value, created_at, is_active) FROM stdin;
1	Patient	id	$.id	patients	fhir_id	VARCHAR(64)	\N	t	f	\N	\N	2025-07-16 16:04:28.32332	t
2	Patient	family_name	$.name[0].family	patients	name_family	VARCHAR(255)	\N	f	f	\N	\N	2025-07-16 16:04:28.32332	t
3	Patient	given_names	$.name[0].given	patients	name_given	VARCHAR(255)[]	\N	f	f	\N	\N	2025-07-16 16:04:28.32332	t
4	Patient	birth_date	$.birthDate	patients	birth_date	DATE	\N	f	f	\N	\N	2025-07-16 16:04:28.32332	t
5	Patient	gender	$.gender	patients	gender	VARCHAR(20)	\N	f	f	\N	\N	2025-07-16 16:04:28.32332	t
\.


--
-- TOC entry 3596 (class 0 OID 24634)
-- Dependencies: 224
-- Data for Name: medications; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.medications (id, fhir_id, identifier_value, identifier_system, code_code, code_display, code_system, status, manufacturer_reference, form_code, form_display, ingredient_item_reference, ingredient_strength_numerator_value, ingredient_strength_numerator_unit, ingredient_strength_denominator_value, ingredient_strength_denominator_unit, created_at, updated_at, raw_fhir_data) FROM stdin;
\.


--
-- TOC entry 3622 (class 0 OID 24849)
-- Dependencies: 250
-- Data for Name: observation_subjects; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.observation_subjects (id, observation_fhir_id, subject_fhir_id, subject_type, relationship_confidence, created_at) FROM stdin;
\.


--
-- TOC entry 3592 (class 0 OID 24608)
-- Dependencies: 220
-- Data for Name: observations; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.observations (id, fhir_id, identifier_value, identifier_system, status, category_code, category_display, code_code, code_display, code_system, subject_reference, subject_type, encounter_reference, effective_datetime, effective_period_start, effective_period_end, issued, performer_reference, value_quantity_value, value_quantity_unit, value_quantity_system, value_quantity_code, value_string, value_boolean, value_integer, interpretation_code, interpretation_display, created_at, updated_at, raw_fhir_data) FROM stdin;
\.


--
-- TOC entry 3620 (class 0 OID 24836)
-- Dependencies: 248
-- Data for Name: patient_provider_relationships; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.patient_provider_relationships (id, patient_fhir_id, provider_fhir_id, relationship_type, relationship_source, effective_start, effective_end, is_active, confidence_score, created_at) FROM stdin;
\.


--
-- TOC entry 3588 (class 0 OID 24579)
-- Dependencies: 216
-- Data for Name: patients; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.patients (id, fhir_id, identifier_value, identifier_system, name_family, name_given, gender, birth_date, phone, email, address_line1, address_city, address_state, address_postal_code, address_country, active, created_at, updated_at, raw_fhir_data) FROM stdin;
\.


--
-- TOC entry 3628 (class 0 OID 24898)
-- Dependencies: 256
-- Data for Name: performance_baselines; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.performance_baselines (id, endpoint_id, measurement_date, min_response_time_ms, max_response_time_ms, avg_response_time_ms, median_response_time_ms, p95_response_time_ms, p99_response_time_ms, total_calls, successful_calls, failed_calls, avg_response_size_bytes, most_common_error, error_rate, uptime_percentage, longest_downtime_minutes) FROM stdin;
\.


--
-- TOC entry 3590 (class 0 OID 24593)
-- Dependencies: 218
-- Data for Name: practitioners; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.practitioners (id, fhir_id, identifier_value, identifier_system, name_family, name_given, name_prefix, name_suffix, gender, birth_date, phone, email, qualification_code, qualification_display, active, created_at, updated_at, raw_fhir_data) FROM stdin;
\.


--
-- TOC entry 3626 (class 0 OID 24883)
-- Dependencies: 254
-- Data for Name: rate_limit_events; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.rate_limit_events (id, endpoint_id, detected_at, http_status_code, retry_after_seconds, rate_limit_headers, calls_in_window, window_duration_seconds, reset_time) FROM stdin;
\.


--
-- TOC entry 3604 (class 0 OID 24705)
-- Dependencies: 232
-- Data for Name: raw_fhir_responses; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.raw_fhir_responses (id, endpoint_id, resource_type, resource_id, bundle_id, http_status_code, response_timestamp, response_headers, response_body, response_size_bytes, processing_status, processing_errors, created_at) FROM stdin;
\.


--
-- TOC entry 3618 (class 0 OID 24821)
-- Dependencies: 246
-- Data for Name: reference_resolution_log; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.reference_resolution_log (id, reference_id, resolution_attempt_at, resolution_status, http_status_code, error_message, response_time_ms) FROM stdin;
\.


--
-- TOC entry 3616 (class 0 OID 24805)
-- Dependencies: 244
-- Data for Name: resource_references; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.resource_references (id, source_resource_type, source_resource_id, source_field_path, target_reference, target_resource_type, target_resource_id, reference_type, display_text, is_resolved, resolved_at, created_at) FROM stdin;
\.


--
-- TOC entry 3600 (class 0 OID 24661)
-- Dependencies: 228
-- Data for Name: response_structures; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.response_structures (id, endpoint_id, resource_type, field_path, field_name, field_type, is_required, is_array, sample_values, occurrence_count, first_seen, last_seen) FROM stdin;
\.


--
-- TOC entry 3630 (class 0 OID 24911)
-- Dependencies: 258
-- Data for Name: schema_changes; Type: TABLE DATA; Schema: fhir_resources; Owner: postgres
--

COPY fhir_resources.schema_changes (id, resource_type, detected_at, change_type, field_path, old_value, new_value, confidence_score, sample_count, first_seen_in_response) FROM stdin;
\.


--
-- TOC entry 3658 (class 0 OID 0)
-- Dependencies: 251
-- Name: api_call_analytics_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.api_call_analytics_id_seq', 1, false);


--
-- TOC entry 3659 (class 0 OID 0)
-- Dependencies: 229
-- Name: api_call_log_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.api_call_log_id_seq', 1, false);


--
-- TOC entry 3660 (class 0 OID 0)
-- Dependencies: 225
-- Name: api_endpoints_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.api_endpoints_id_seq', 1, false);


--
-- TOC entry 3661 (class 0 OID 0)
-- Dependencies: 235
-- Name: bundle_entries_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.bundle_entries_id_seq', 1, false);


--
-- TOC entry 3662 (class 0 OID 0)
-- Dependencies: 221
-- Name: encounters_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.encounters_id_seq', 1, false);


--
-- TOC entry 3663 (class 0 OID 0)
-- Dependencies: 241
-- Name: extraction_errors_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.extraction_errors_id_seq', 1, false);


--
-- TOC entry 3664 (class 0 OID 0)
-- Dependencies: 239
-- Name: extraction_jobs_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.extraction_jobs_id_seq', 1, false);


--
-- TOC entry 3665 (class 0 OID 0)
-- Dependencies: 233
-- Name: fhir_bundles_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.fhir_bundles_id_seq', 1, false);


--
-- TOC entry 3666 (class 0 OID 0)
-- Dependencies: 237
-- Name: field_extraction_rules_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.field_extraction_rules_id_seq', 5, true);


--
-- TOC entry 3667 (class 0 OID 0)
-- Dependencies: 223
-- Name: medications_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.medications_id_seq', 1, false);


--
-- TOC entry 3668 (class 0 OID 0)
-- Dependencies: 249
-- Name: observation_subjects_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.observation_subjects_id_seq', 1, false);


--
-- TOC entry 3669 (class 0 OID 0)
-- Dependencies: 219
-- Name: observations_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.observations_id_seq', 1, false);


--
-- TOC entry 3670 (class 0 OID 0)
-- Dependencies: 247
-- Name: patient_provider_relationships_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.patient_provider_relationships_id_seq', 1, false);


--
-- TOC entry 3671 (class 0 OID 0)
-- Dependencies: 215
-- Name: patients_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.patients_id_seq', 1, false);


--
-- TOC entry 3672 (class 0 OID 0)
-- Dependencies: 255
-- Name: performance_baselines_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.performance_baselines_id_seq', 1, false);


--
-- TOC entry 3673 (class 0 OID 0)
-- Dependencies: 217
-- Name: practitioners_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.practitioners_id_seq', 1, false);


--
-- TOC entry 3674 (class 0 OID 0)
-- Dependencies: 253
-- Name: rate_limit_events_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.rate_limit_events_id_seq', 1, false);


--
-- TOC entry 3675 (class 0 OID 0)
-- Dependencies: 231
-- Name: raw_fhir_responses_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.raw_fhir_responses_id_seq', 1, false);


--
-- TOC entry 3676 (class 0 OID 0)
-- Dependencies: 245
-- Name: reference_resolution_log_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.reference_resolution_log_id_seq', 1, false);


--
-- TOC entry 3677 (class 0 OID 0)
-- Dependencies: 243
-- Name: resource_references_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.resource_references_id_seq', 1, false);


--
-- TOC entry 3678 (class 0 OID 0)
-- Dependencies: 227
-- Name: response_structures_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.response_structures_id_seq', 1, false);


--
-- TOC entry 3679 (class 0 OID 0)
-- Dependencies: 257
-- Name: schema_changes_id_seq; Type: SEQUENCE SET; Schema: fhir_resources; Owner: postgres
--

SELECT pg_catalog.setval('fhir_resources.schema_changes_id_seq', 1, false);


--
-- TOC entry 3422 (class 2606 OID 24872)
-- Name: api_call_analytics api_call_analytics_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.api_call_analytics
    ADD CONSTRAINT api_call_analytics_pkey PRIMARY KEY (id);


--
-- TOC entry 3383 (class 2606 OID 24689)
-- Name: api_call_log api_call_log_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.api_call_log
    ADD CONSTRAINT api_call_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3379 (class 2606 OID 24659)
-- Name: api_endpoints api_endpoints_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.api_endpoints
    ADD CONSTRAINT api_endpoints_pkey PRIMARY KEY (id);


--
-- TOC entry 3397 (class 2606 OID 24745)
-- Name: bundle_entries bundle_entries_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.bundle_entries
    ADD CONSTRAINT bundle_entries_pkey PRIMARY KEY (id);


--
-- TOC entry 3369 (class 2606 OID 24632)
-- Name: encounters encounters_fhir_id_key; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.encounters
    ADD CONSTRAINT encounters_fhir_id_key UNIQUE (fhir_id);


--
-- TOC entry 3371 (class 2606 OID 24630)
-- Name: encounters encounters_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.encounters
    ADD CONSTRAINT encounters_pkey PRIMARY KEY (id);


--
-- TOC entry 3403 (class 2606 OID 24793)
-- Name: extraction_errors extraction_errors_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.extraction_errors
    ADD CONSTRAINT extraction_errors_pkey PRIMARY KEY (id);


--
-- TOC entry 3401 (class 2606 OID 24783)
-- Name: extraction_jobs extraction_jobs_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.extraction_jobs
    ADD CONSTRAINT extraction_jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 3393 (class 2606 OID 24736)
-- Name: fhir_bundles fhir_bundles_bundle_id_key; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.fhir_bundles
    ADD CONSTRAINT fhir_bundles_bundle_id_key UNIQUE (bundle_id);


--
-- TOC entry 3395 (class 2606 OID 24734)
-- Name: fhir_bundles fhir_bundles_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.fhir_bundles
    ADD CONSTRAINT fhir_bundles_pkey PRIMARY KEY (id);


--
-- TOC entry 3399 (class 2606 OID 24768)
-- Name: field_extraction_rules field_extraction_rules_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.field_extraction_rules
    ADD CONSTRAINT field_extraction_rules_pkey PRIMARY KEY (id);


--
-- TOC entry 3375 (class 2606 OID 24645)
-- Name: medications medications_fhir_id_key; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.medications
    ADD CONSTRAINT medications_fhir_id_key UNIQUE (fhir_id);


--
-- TOC entry 3377 (class 2606 OID 24643)
-- Name: medications medications_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.medications
    ADD CONSTRAINT medications_pkey PRIMARY KEY (id);


--
-- TOC entry 3418 (class 2606 OID 24860)
-- Name: observation_subjects observation_subjects_observation_fhir_id_subject_fhir_id_key; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.observation_subjects
    ADD CONSTRAINT observation_subjects_observation_fhir_id_subject_fhir_id_key UNIQUE (observation_fhir_id, subject_fhir_id);


--
-- TOC entry 3420 (class 2606 OID 24858)
-- Name: observation_subjects observation_subjects_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.observation_subjects
    ADD CONSTRAINT observation_subjects_pkey PRIMARY KEY (id);


--
-- TOC entry 3365 (class 2606 OID 24619)
-- Name: observations observations_fhir_id_key; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.observations
    ADD CONSTRAINT observations_fhir_id_key UNIQUE (fhir_id);


--
-- TOC entry 3367 (class 2606 OID 24617)
-- Name: observations observations_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.observations
    ADD CONSTRAINT observations_pkey PRIMARY KEY (id);


--
-- TOC entry 3414 (class 2606 OID 24847)
-- Name: patient_provider_relationships patient_provider_relationship_patient_fhir_id_provider_fhir_key; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.patient_provider_relationships
    ADD CONSTRAINT patient_provider_relationship_patient_fhir_id_provider_fhir_key UNIQUE (patient_fhir_id, provider_fhir_id, relationship_type);


--
-- TOC entry 3416 (class 2606 OID 24845)
-- Name: patient_provider_relationships patient_provider_relationships_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.patient_provider_relationships
    ADD CONSTRAINT patient_provider_relationships_pkey PRIMARY KEY (id);


--
-- TOC entry 3354 (class 2606 OID 24591)
-- Name: patients patients_fhir_id_key; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.patients
    ADD CONSTRAINT patients_fhir_id_key UNIQUE (fhir_id);


--
-- TOC entry 3356 (class 2606 OID 24589)
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);


--
-- TOC entry 3430 (class 2606 OID 24904)
-- Name: performance_baselines performance_baselines_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.performance_baselines
    ADD CONSTRAINT performance_baselines_pkey PRIMARY KEY (id);


--
-- TOC entry 3358 (class 2606 OID 24605)
-- Name: practitioners practitioners_fhir_id_key; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.practitioners
    ADD CONSTRAINT practitioners_fhir_id_key UNIQUE (fhir_id);


--
-- TOC entry 3360 (class 2606 OID 24603)
-- Name: practitioners practitioners_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.practitioners
    ADD CONSTRAINT practitioners_pkey PRIMARY KEY (id);


--
-- TOC entry 3428 (class 2606 OID 24891)
-- Name: rate_limit_events rate_limit_events_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.rate_limit_events
    ADD CONSTRAINT rate_limit_events_pkey PRIMARY KEY (id);


--
-- TOC entry 3391 (class 2606 OID 24715)
-- Name: raw_fhir_responses raw_fhir_responses_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.raw_fhir_responses
    ADD CONSTRAINT raw_fhir_responses_pkey PRIMARY KEY (id);


--
-- TOC entry 3412 (class 2606 OID 24829)
-- Name: reference_resolution_log reference_resolution_log_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.reference_resolution_log
    ADD CONSTRAINT reference_resolution_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3408 (class 2606 OID 24814)
-- Name: resource_references resource_references_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.resource_references
    ADD CONSTRAINT resource_references_pkey PRIMARY KEY (id);


--
-- TOC entry 3410 (class 2606 OID 24816)
-- Name: resource_references resource_references_source_resource_type_source_resource_id_key; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.resource_references
    ADD CONSTRAINT resource_references_source_resource_type_source_resource_id_key UNIQUE (source_resource_type, source_resource_id, source_field_path, target_reference);


--
-- TOC entry 3381 (class 2606 OID 24673)
-- Name: response_structures response_structures_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.response_structures
    ADD CONSTRAINT response_structures_pkey PRIMARY KEY (id);


--
-- TOC entry 3432 (class 2606 OID 24919)
-- Name: schema_changes schema_changes_pkey; Type: CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.schema_changes
    ADD CONSTRAINT schema_changes_pkey PRIMARY KEY (id);


--
-- TOC entry 3423 (class 1259 OID 24878)
-- Name: idx_api_analytics_endpoint_time; Type: INDEX; Schema: fhir_resources; Owner: postgres
--

CREATE INDEX idx_api_analytics_endpoint_time ON fhir_resources.api_call_analytics USING btree (endpoint_id, called_at);


--
-- TOC entry 3424 (class 1259 OID 24881)
-- Name: idx_api_analytics_errors; Type: INDEX; Schema: fhir_resources; Owner: postgres
--

CREATE INDEX idx_api_analytics_errors ON fhir_resources.api_call_analytics USING btree (error_category) WHERE (error_category IS NOT NULL);


--
-- TOC entry 3425 (class 1259 OID 24880)
-- Name: idx_api_analytics_performance; Type: INDEX; Schema: fhir_resources; Owner: postgres
--

CREATE INDEX idx_api_analytics_performance ON fhir_resources.api_call_analytics USING btree (response_time_ms);


--
-- TOC entry 3426 (class 1259 OID 24879)
-- Name: idx_api_analytics_status; Type: INDEX; Schema: fhir_resources; Owner: postgres
--

CREATE INDEX idx_api_analytics_status ON fhir_resources.api_call_analytics USING btree (http_status_code);


--
-- TOC entry 3384 (class 1259 OID 24700)
-- Name: idx_api_calls_endpoint; Type: INDEX; Schema: fhir_resources; Owner: postgres
--

CREATE INDEX idx_api_calls_endpoint ON fhir_resources.api_call_log USING btree (endpoint_id);


--
-- TOC entry 3385 (class 1259 OID 24701)
-- Name: idx_api_calls_time; Type: INDEX; Schema: fhir_resources; Owner: postgres
--

CREATE INDEX idx_api_calls_time ON fhir_resources.api_call_log USING btree (called_at);


--
-- TOC entry 3372 (class 1259 OID 24699)
-- Name: idx_encounters_period; Type: INDEX; Schema: fhir_resources; Owner: postgres
--

CREATE INDEX idx_encounters_period ON fhir_resources.encounters USING btree (period_start, period_end);


--
-- TOC entry 3373 (class 1259 OID 24698)
-- Name: idx_encounters_subject; Type: INDEX; Schema: fhir_resources; Owner: postgres
--

CREATE INDEX idx_encounters_subject ON fhir_resources.encounters USING btree (subject_reference);


--
-- TOC entry 3361 (class 1259 OID 24697)
-- Name: idx_observations_code; Type: INDEX; Schema: fhir_resources; Owner: postgres
--

CREATE INDEX idx_observations_code ON fhir_resources.observations USING btree (code_code);


--
-- TOC entry 3362 (class 1259 OID 24703)
-- Name: idx_observations_raw_gin; Type: INDEX; Schema: fhir_resources; Owner: postgres
--

CREATE INDEX idx_observations_raw_gin ON fhir_resources.observations USING gin (raw_fhir_data);


--
-- TOC entry 3363 (class 1259 OID 24696)
-- Name: idx_observations_subject; Type: INDEX; Schema: fhir_resources; Owner: postgres
--

CREATE INDEX idx_observations_subject ON fhir_resources.observations USING btree (subject_reference);


--
-- TOC entry 3351 (class 1259 OID 24695)
-- Name: idx_patients_fhir_id; Type: INDEX; Schema: fhir_resources; Owner: postgres
--

CREATE INDEX idx_patients_fhir_id ON fhir_resources.patients USING btree (fhir_id);


--
-- TOC entry 3352 (class 1259 OID 24702)
-- Name: idx_patients_raw_gin; Type: INDEX; Schema: fhir_resources; Owner: postgres
--

CREATE INDEX idx_patients_raw_gin ON fhir_resources.patients USING gin (raw_fhir_data);


--
-- TOC entry 3386 (class 1259 OID 24724)
-- Name: idx_raw_responses_body_gin; Type: INDEX; Schema: fhir_resources; Owner: postgres
--

CREATE INDEX idx_raw_responses_body_gin ON fhir_resources.raw_fhir_responses USING gin (response_body);


--
-- TOC entry 3387 (class 1259 OID 24721)
-- Name: idx_raw_responses_resource_type; Type: INDEX; Schema: fhir_resources; Owner: postgres
--

CREATE INDEX idx_raw_responses_resource_type ON fhir_resources.raw_fhir_responses USING btree (resource_type);


--
-- TOC entry 3388 (class 1259 OID 24723)
-- Name: idx_raw_responses_status; Type: INDEX; Schema: fhir_resources; Owner: postgres
--

CREATE INDEX idx_raw_responses_status ON fhir_resources.raw_fhir_responses USING btree (processing_status);


--
-- TOC entry 3389 (class 1259 OID 24722)
-- Name: idx_raw_responses_timestamp; Type: INDEX; Schema: fhir_resources; Owner: postgres
--

CREATE INDEX idx_raw_responses_timestamp ON fhir_resources.raw_fhir_responses USING btree (response_timestamp);


--
-- TOC entry 3404 (class 1259 OID 24817)
-- Name: idx_references_source; Type: INDEX; Schema: fhir_resources; Owner: postgres
--

CREATE INDEX idx_references_source ON fhir_resources.resource_references USING btree (source_resource_type, source_resource_id);


--
-- TOC entry 3405 (class 1259 OID 24818)
-- Name: idx_references_target; Type: INDEX; Schema: fhir_resources; Owner: postgres
--

CREATE INDEX idx_references_target ON fhir_resources.resource_references USING btree (target_resource_type, target_resource_id);


--
-- TOC entry 3406 (class 1259 OID 24819)
-- Name: idx_references_unresolved; Type: INDEX; Schema: fhir_resources; Owner: postgres
--

CREATE INDEX idx_references_unresolved ON fhir_resources.resource_references USING btree (is_resolved) WHERE (is_resolved = false);


--
-- TOC entry 3441 (class 2606 OID 24873)
-- Name: api_call_analytics api_call_analytics_endpoint_id_fkey; Type: FK CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.api_call_analytics
    ADD CONSTRAINT api_call_analytics_endpoint_id_fkey FOREIGN KEY (endpoint_id) REFERENCES fhir_resources.api_endpoints(id);


--
-- TOC entry 3434 (class 2606 OID 24690)
-- Name: api_call_log api_call_log_endpoint_id_fkey; Type: FK CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.api_call_log
    ADD CONSTRAINT api_call_log_endpoint_id_fkey FOREIGN KEY (endpoint_id) REFERENCES fhir_resources.api_endpoints(id);


--
-- TOC entry 3436 (class 2606 OID 24746)
-- Name: bundle_entries bundle_entries_bundle_id_fkey; Type: FK CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.bundle_entries
    ADD CONSTRAINT bundle_entries_bundle_id_fkey FOREIGN KEY (bundle_id) REFERENCES fhir_resources.fhir_bundles(bundle_id);


--
-- TOC entry 3437 (class 2606 OID 24751)
-- Name: bundle_entries bundle_entries_raw_response_id_fkey; Type: FK CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.bundle_entries
    ADD CONSTRAINT bundle_entries_raw_response_id_fkey FOREIGN KEY (raw_response_id) REFERENCES fhir_resources.raw_fhir_responses(id);


--
-- TOC entry 3438 (class 2606 OID 24794)
-- Name: extraction_errors extraction_errors_job_id_fkey; Type: FK CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.extraction_errors
    ADD CONSTRAINT extraction_errors_job_id_fkey FOREIGN KEY (job_id) REFERENCES fhir_resources.extraction_jobs(id);


--
-- TOC entry 3439 (class 2606 OID 24799)
-- Name: extraction_errors extraction_errors_raw_response_id_fkey; Type: FK CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.extraction_errors
    ADD CONSTRAINT extraction_errors_raw_response_id_fkey FOREIGN KEY (raw_response_id) REFERENCES fhir_resources.raw_fhir_responses(id);


--
-- TOC entry 3443 (class 2606 OID 24905)
-- Name: performance_baselines performance_baselines_endpoint_id_fkey; Type: FK CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.performance_baselines
    ADD CONSTRAINT performance_baselines_endpoint_id_fkey FOREIGN KEY (endpoint_id) REFERENCES fhir_resources.api_endpoints(id);


--
-- TOC entry 3442 (class 2606 OID 24892)
-- Name: rate_limit_events rate_limit_events_endpoint_id_fkey; Type: FK CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.rate_limit_events
    ADD CONSTRAINT rate_limit_events_endpoint_id_fkey FOREIGN KEY (endpoint_id) REFERENCES fhir_resources.api_endpoints(id);


--
-- TOC entry 3435 (class 2606 OID 24716)
-- Name: raw_fhir_responses raw_fhir_responses_endpoint_id_fkey; Type: FK CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.raw_fhir_responses
    ADD CONSTRAINT raw_fhir_responses_endpoint_id_fkey FOREIGN KEY (endpoint_id) REFERENCES fhir_resources.api_endpoints(id);


--
-- TOC entry 3440 (class 2606 OID 24830)
-- Name: reference_resolution_log reference_resolution_log_reference_id_fkey; Type: FK CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.reference_resolution_log
    ADD CONSTRAINT reference_resolution_log_reference_id_fkey FOREIGN KEY (reference_id) REFERENCES fhir_resources.resource_references(id);


--
-- TOC entry 3433 (class 2606 OID 24674)
-- Name: response_structures response_structures_endpoint_id_fkey; Type: FK CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.response_structures
    ADD CONSTRAINT response_structures_endpoint_id_fkey FOREIGN KEY (endpoint_id) REFERENCES fhir_resources.api_endpoints(id);


--
-- TOC entry 3444 (class 2606 OID 24920)
-- Name: schema_changes schema_changes_first_seen_in_response_fkey; Type: FK CONSTRAINT; Schema: fhir_resources; Owner: postgres
--

ALTER TABLE ONLY fhir_resources.schema_changes
    ADD CONSTRAINT schema_changes_first_seen_in_response_fkey FOREIGN KEY (first_seen_in_response) REFERENCES fhir_resources.raw_fhir_responses(id);


-- Completed on 2025-07-17 19:19:49

--
-- PostgreSQL database dump complete
--

