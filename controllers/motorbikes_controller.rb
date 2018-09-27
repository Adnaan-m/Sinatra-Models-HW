class App < Sinatra::Base

  configure:development do
    register Sinatra::Reloader
  end

  # Setting the root as the parent directory of the current directory
  set :root, File.join(File.dirname(__FILE__), '..')

  # Sets the view directory correctly
  set :views, Proc.new {File.join(root,"views")}

  prng = Random.new

  # Index
  get '/motorbikes' do
    @title = 'Home'
    @motorbikes = Motorbike.all
    erb :'motorbikes/index'
  end

  # New
  get '/motorbikes/new' do
    erb :'motorbikes/new'
  end

  # Show
  get '/motorbikes/:id' do
    id = params[:id].to_i
    @motorbikes = Motorbike.find id

    erb :'motorbikes/shows'
  end

  #  Create
  post '/motorbikes' do

    # initiate new ID
    motorbike = Motorbike.new

    motorbike.id = params[:id]
    motorbike.make = params[:make]
    motorbike.model = params[:model]
    motorbike.year = params[:year]

    # push values of newBike into motorbikes "database"
    motorbike.save

    redirect '/motorbikes'
  end

  #  Update
  put '/motorbikes/:id' do
    id = params[:id].to_i

    bike = Motorbike.find id

    bike.make = params[:make]
    bike.model = params[:model]
    bike.year = params[:year]

    bike.save

    redirect '/motorbikes'
  end

  # Edit
  get '/motorbikes/:id/edit' do
    id = params[:id].to_i
    @motorbikes = Motorbike.find id
    erb :'motorbikes/edit'
  end

  #  Delete
  delete '/motorbikes/:id' do
    id = params[:id].to_i
    Motorbike.destroy id
    redirect '/motorbikes'
  end

  # Class End
end
