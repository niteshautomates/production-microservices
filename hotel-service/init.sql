do $$
begin
  -- Check if the user 'postgres' exists, and create it if it doesn't.
  IF NOT EXISTS
    (
           SELECT 1
           FROM   pg_catalog.pg_roles
           WHERE  rolname = 'postgres') THEN
    CREATE user postgres WITH password 'admin123';END IF;
    -- Check if the database 'hoteldb' exists, and create it if it doesn't.IF NOT EXISTS
      (
             SELECT 1
             FROM   pg_database
             WHERE  datname = 'hoteldb') THEN
      CREATE DATABASE hoteldb;END IF;
      -- Grant all privileges on the database to the user.GRANT ALL privileges ON DATABASE hoteldb TO postgres;
      -- Connect to the 'hoteldb' database.\c hoteldb
      -- Grant usage and create on the public schema.
      GRANT USAGE,
      CREATE ON SCHEMA public TO postgres;
        -- **Crucial:** Set the session authorization to postgres before granting privileges.SET session authorization postgres;
        -- **Forcefully** grant all privileges on the public schema.GRANT ALL privileges ON SCHEMA public TO postgres;
        -- Reset session authorization to the original user (if needed).RESET session authorization;
        -- ALTER the database ownerALTER DATABASE hoteldb owner TO postgres;
        -- Check if the 'hotels' table exists before altering its ownership.do $$
      begin
        IF EXISTS
          (
                 SELECT 1
                 FROM   information_schema.tables
                 WHERE  table_name = 'hotels'
                 AND    table_schema = 'public') THEN
          ALTER TABLE hotels owner TO postgres;END IF;END$$;
        -- Set default privileges for future objects.ALTER DEFAULT privileges FOR role postgres IN SCHEMA public GRANT ALL ON tables TO postgres;ALTER DEFAULT privileges FOR role postgres IN SCHEMA public GRANT ALL ON sequences TO postgres;
        -- **Debugging:** Check privileges *after* the grants and before table creation.RAISE notice 'Privileges on public schema: %', pg_catalog.array_to_string(aclexplode(acl), ',');RAISE notice 'Current User: %', CURRENT_USER;RAISE notice 'Session User: %', session_user;
        -- **Debugging:** Attempt to create a test table.CREATE TABLE IF NOT EXISTS test_table
                     (
                                  id SERIAL PRIMARY KEY,
                                  data TEXT
                     );IF EXISTS
          (
                 SELECT 1
                 FROM   information_schema.tables
                 WHERE  table_name = 'test_table'
                 AND    table_schema = 'public'
          )
          THEN
          raise notice 'Successfully created test table.';ELSE
          raise notice 'Failed to create test table. CHECK PERMISSIONS IMMEDIATELY!';
          -- **Debugging:** Show the current user.RAISE notice 'Current user: %', CURRENT_USER;
          -- **Debugging:** Show the effective user.RAISE notice 'Effective user: %', session_user;END IF;
        -- Explicitly set the search pathSET search_path TO public;END $$;
