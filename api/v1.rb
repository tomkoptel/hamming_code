class CodesV1 < Sinatra::Base
  set :root, "#{File.dirname(__FILE__)}"
  set :haml, :layout => :'/layouts/application'
  set :views, root + '/views'

  helpers do
    include Sprockets::Helpers
  end

  get '/' do
    haml :index
  end

end