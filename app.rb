# These lines load Sinatra and a helper tool to reload the server
# when we have changed the file.
require 'sinatra/base'
require 'sinatra/reloader'

# You will want to require your data model class here
require "database_connection"
require "adverts_table"
require "advert_entity"

class WebApplicationServer < Sinatra::Base
  # This line allows us to send HTTP Verbs like `DELETE` using forms
  use Rack::MethodOverride

  configure :development do
    # In development mode (which you will be running) this enables the tool
    # to reload the server when your code changes
    register Sinatra::Reloader

    # In development mode, connect to the development database
    db = DatabaseConnection.new("localhost", "web_application_dev")
    $global = { db: db }
  end

  configure :test do
    # In test mode, connect to the test database
    db = DatabaseConnection.new("localhost", "web_application_test")
    $global = { db: db }
  end

  def adverts_table
    $global[:adverts_table] ||= AdvertsTable.new($global[:db])
  end

  get "/adverts" do
    erb :adverts_index, locals: {
      adverts: adverts_table.list
    }
  end

  get "/adverts/new" do
    erb :adverts_new
  end

  post "/adverts" do
    advert = AdvertEntity.new(
      params["description"],
      params["phone_number"]
    )
    adverts_table.add(advert)
    redirect "/adverts"
  end
end
