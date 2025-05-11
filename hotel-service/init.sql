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
