$:.unshift File.join(File.dirname(__FILE__), 'lib')
require "database_connection"

# This file sets up the database tables. When you change the contents of this
# file, you should rerun `ruby reset_tables.rb` to ensure that your database
# tables are re-created.

def reset_tables(db)
  db.run("DROP TABLE IF EXISTS adverts;")
  db.run("CREATE TABLE adverts (
    id SERIAL PRIMARY KEY,
    description TEXT NOT NULL,
    phone_number TEXT NOT NULL);")

  # Add your table creation SQL here
  # Each one should be a pair of lines:
  #   db.run("DROP TABLE IF EXISTS ...;")
  #   db.run("CREATE TABLE ... (id SERIAL PRIMARY KEY, ...);")
end

dev_db = DatabaseConnection.new("localhost", "web_application_dev")
reset_tables(dev_db)

test_db = DatabaseConnection.new("localhost", "web_application_test")
reset_tables(test_db)
