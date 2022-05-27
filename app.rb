# These lines load Sinatra and a helper tool to reload the server
# when we have changed the file.
require 'sinatra/base'
require 'sinatra/reloader'

# You will want to require your data model class here
require "database_connection"
require "adverts_table"
require "advert_entity"
require "comments_table"
require "comment_entity"

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

  def comments_table
    $global[:comments_table] ||= CommentsTable.new($global[:db])
  end

  def adverts_table
    $global[:adverts_table] ||= AdvertsTable.new($global[:db], comments_table)
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

  get "/adverts/:advert_id/comments/new" do
    erb :comments_new, locals: {
      advert_id: params[:advert_id].to_i
    }
  end

  post "/adverts/:advert_id/comments" do
    comment = CommentEntity.new(params[:contents], params[:advert_id].to_i)
    comments_table.add(comment)
    redirect "/adverts"
  end
end
