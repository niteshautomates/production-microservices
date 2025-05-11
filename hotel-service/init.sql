DO $$ BEGIN -- Check if the user 'postgres' exists, and create it if it doesn't.
IF NOT EXISTS (
  SELECT 
    1 
  FROM 
    pg_catalog.pg_roles 
  WHERE 
    rolname = 'postgres'
) THEN CREATE USER postgres WITH PASSWORD 'admin123';
END IF;
-- Check if the database 'hoteldb' exists, and create it if it doesn't.
IF NOT EXISTS (
  SELECT
    1
  FROM
    pg_database
  WHERE
    datname = 'hoteldb'
) THEN CREATE DATABASE hoteldb;
END IF;
-- Grant all privileges on the database to the user.
GRANT ALL PRIVILEGES ON DATABASE hoteldb TO postgres;
-- Connect to the 'hoteldb' database.
\c hoteldb -- Grant usage and create on the public schema.
GRANT USAGE,
CREATE ON SCHEMA public TO postgres;
-- **Crucial:** Set the session authorization to postgres before granting privileges.
SET
  SESSION AUTHORIZATION postgres;
-- **Forcefully** grant all privileges on the public schema.
GRANT ALL PRIVILEGES ON SCHEMA public TO postgres;
-- Reset session authorization to the original user (if needed).
RESET SESSION AUTHORIZATION;
-- ALTER the database owner
ALTER DATABASE hoteldb OWNER TO postgres;
-- Check if the 'hotels' table exists before altering its ownership.
DO $$ BEGIN IF EXISTS
  (SELECT 1
   FROM information_schema.tables
   WHERE TABLE_NAME = 'hotels'
     AND table_schema = 'public') THEN
ALTER TABLE hotels OWNER TO postgres;

END IF;

END$$;

-- Set default privileges for future objects.

ALTER DEFAULT PRIVILEGES
FOR ROLE postgres IN SCHEMA PUBLIC GRANT ALL ON TABLES TO postgres;


ALTER DEFAULT PRIVILEGES
FOR ROLE postgres IN SCHEMA PUBLIC GRANT ALL ON SEQUENCES TO postgres;

-- **Debugging:** Check privileges *after* the grants and before table creation.
RAISE NOTICE 'Privileges on public schema: %',
             pg_catalog.array_to_string(aclexplode(acl), ',');

RAISE NOTICE 'Current User: %',
             CURRENT_USER;

RAISE NOTICE 'Session User: %',
             SESSION_USER;

-- **Debugging:** Attempt to create a test table.

CREATE TABLE IF NOT EXISTS test_table (id SERIAL PRIMARY KEY,
                                                 DATA TEXT);

IF EXISTS
  (SELECT 1
   FROM information_schema.tables
   WHERE TABLE_NAME = 'test_table'
     AND table_schema = 'public') THEN RAISE NOTICE 'Successfully created test table.';

ELSE RAISE NOTICE 'Failed to create test table. CHECK PERMISSIONS IMMEDIATELY!';

-- **Debugging:** Show the current user.
RAISE NOTICE 'Current user: %',
             CURRENT_USER;

-- **Debugging:** Show the effective user.
RAISE NOTICE 'Effective user: %',
             SESSION_USER;

END IF;

-- Explicitly set the search path
SET search_path TO PUBLIC;

END $$;
