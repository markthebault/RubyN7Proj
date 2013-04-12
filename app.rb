# encoding: utf-8
require 'active_record'
require_relative './db/database'

require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/respond_with'
require 'sinatra/json'
require_relative './authentication'
require_relative './lib/model/user'

use Authentication
helpers AuthenticationHelpers

set :environment, ENV['RACK_ENV'] || :development
before '/resource*' do
  logger.info("ressource protégée")
  authenticate!
end

get '/' do
  erb <<INDEX
<% if current_user %>
  Visualisez la resource <a href="/resource/foo" class="btn btn-primary">foo</a>
<% else %>
<div class="hero-unit">
  <h1>Sinatra Skeleton</h1>
  <p>Un squelette d'application sinatra</p>
  </p>
  <p>
    <a class="btn btn-primary btn-large" href='login' >
    Identifiez-vous pour accéder au reste de l'application
    </a>
  </p>
</div>
<% end %>

INDEX
end

get '/resource/:name', :provides => [:html, :json] do
  @resource = {name: params[:name]}
  respond_to do |format|
    format.html do
      erb <<SHOW
<p>La resource que vous contemplez est : <a href="" class="btn btn-success"><%= @resource[:name] %></a></p>

<p>Pour récupérer cette ressource par l'API Rest:</p>
<pre>curl -H "Accept: application/json" -u toto:12345 http://#{request.host}:#{request.port}/resource/#{params[:name]}</pre>

<p>L'API Rest est configurée pour laisser passer toutes les requêtes s'authentifiant avec HTTP Basic et le mot de passe '12345'
</p>
SHOW
    end
    format.json { json @resource }
  end
end


##Gestion d'un nouvel utilisateur
get '/user/new' do
  erb :'user/new'
end

post '/user/new' do
  "Vous voulez enregister l'utilisateur #{params[:name]}"
  
  if not User.find_by_name(params[:name]).nil?
    "User is existing, change the name"
  else

     u = User.new
     u.name = params[:name]
     u.email = params[:email]
     u.password = params[:password] #passer au SHA1
     u.save

     redirect "/user/#{u.id}"
  end
end

get '/user/:id' do
  u = User.find_by_id(params[:id])
  "<t1>User</t1><br>name:#{u.name}, password:#{u.password}, email:#{u.email}
  <a href=\"/user/#{params[:id]}/edit\">Edit</a>"
end

get '/user/:id/edit' do
  u = User.find_by_id(params[:id])
  @username = u.name
  @email = u.email
  erb :'user/edit'
end
