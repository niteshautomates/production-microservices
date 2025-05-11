DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_catalog.pg_roles WHERE rolname = 'postgres') THEN
        CREATE USER postgres WITH PASSWORD 'admin123';
    END IF;
END$$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_database WHERE datname = 'hoteldb') THEN
        CREATE DATABASE hoteldb;
    END IF;
END$$;

GRANT ALL PRIVILEGES ON DATABASE hoteldb TO postgres;
\c hoteldb
GRANT ALL PRIVILEGES ON SCHEMA public TO postgres;
GRANT CREATE ON DATABASE hoteldb TO postgres;

GRANT USAGE ON SCHEMA public TO postgres;
GRANT CREATE ON SCHEMA public TO postgres;

ALTER DATABASE hoteldb OWNER TO postgres;

-- Check if the 'hotels' table exists before altering its ownership.
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'hotels' AND table_schema = 'public') THEN
        ALTER TABLE hotels OWNER TO postgres;
    END IF;
END$$;

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
