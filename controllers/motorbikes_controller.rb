class App < Sinatra::Base

  configure:development do
    register Sinatra::Reloader
  end

  # Setting the root as the parent directory of the current directory
  set :root, File.join(File.dirname(__FILE__), '..')

  # Sets the view directory correctly
  set :views, Proc.new {File.join(root,"views")}

  prng = Random.new
  # Create Set of Information in an Array /// Will be Database Later
  $motorbikes = [
    { #TRY AND SORT ID OUT to prevent DUPLICATION WHEN INSERTING/DELETING
      :id =>   1,
      :make => 'Kawasaki',
      :year => 2017,
      :model => 'H2R'
    },
    {
      :id => 2,
      :make => 'Kawasaki',
      :year => 2018,
      :model => 'Ninja ZX10R'
    },
    {
      :id => 3,
      :make => 'Yamaha',
      :year => 2018,
      :model => 'R1'
    },
    {
      :id => 4,
      :make => 'KTM',
      :year => 2015,
      :model => 'RC8'
    },
    {
      :id => 5,
      :make => 'BMW',
      :year => 2015,
      :model => 'S1000RR'
    },
    {
      :id => 6,
      :make => 'Ducati',
      :year => 2010,
      :model => '1198S'
    }
  ]

  # Index
  get '/motorbikes' do
    @title = 'Home'
    @motorbikes = $motorbikes
    erb :'motorbikes/index'
  end

  # New
  get '/motorbikes/new' do
    erb :'motorbikes/new'
  end

  # Show
  get '/motorbikes/:id' do
    id = params[:id].to_i
    @motorbike = $motorbikes[id - 1]
    erb :'motorbikes/shows'
  end

  #  Create
  post '/motorbikes' do

    # initiate new ID
    id = $motorbikes.length + 1

    newBike = {
      :id => id,
      :make => params[:make],
      :model => params[:model],
      :year => params[:year]
    }
    # push values of newBike into motorbikes "database"
    $motorbikes.push newBike

    redirect '/motorbikes'
  end

#  Update
  put '/motorbikes/:id' do
    id = params[:id].to_i - 1

    bike = $motorbikes[id]

    bike[:make] = params[:make]
    bike[:model] = params[:model]
    bike[:year] = params[:year]

    $motorbikes[id] = bike

    redirect '/motorbikes'
  end

# Edit
  get '/motorbikes/:id/edit' do
    id = params[:id].to_i
    @motorbikes = $motorbikes[id- 1]
    erb :'motorbikes/edit'
  end

#  Delete
    delete '/motorbikes/:id' do
      id = params[:id].to_i
      $motorbikes.delete_at id
      redirect '/motorbikes'
    end

  # Class End
end
