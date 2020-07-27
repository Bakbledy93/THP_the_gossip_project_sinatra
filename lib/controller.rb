require 'gossip'

#Classe ApplicationController
class ApplicationController < Sinatra::Base
  #Affichage de la page index avec Shotgun
  get '/' do
    erb :index, locals: {gossips: Gossip.all} #afficher index.erb avec les variables locales dans la classe Gossip
    end
  
  #Affichage de la page pour créer un nouveau gossp
  get '/gossips/new/' do
    erb :new_gossip
    end

  #Post du nouveau gossip
  post '/gossips/new/' do
    Gossip.new(params['gossip_author'], params['gossip_content']).save #appel de la méthode save dans gossip.rb
    puts "Salut, je suis dans le serveur"
    puts "Ceci est le contenu du hash params : #{params}"
    puts "Trop bien ! Et ceci est ce que l'utilisateur a passé dans le champ gossip_author : #{params["gossip_author"]}"
    puts "De la bombe, et du coup ça, ça doit être ce que l'utilisateur a passé dans le champ gossip_content : #{params["gossip_content"]}"
    puts "Ça déchire sa mémé, bon allez je m'en vais du serveur, ciao les BGs !"
    redirect '/' #permet de retourner sur la page index après un post de gossip
  end

  #Affichage des gossips avec leurs pages dédiées
  get '/gossips/:id' do
    erb :show, locals: {gossips: Gossip.find(params['id']), gossip_id: params['id']} 
  end

  #Affichage de l'édition d'un gossip
  get '/gossips/:id/edit/' do
    erb :edit, locals: {gossips: Gossip.find(params['id']), gossip_id: params['id']}
  end

  #Post d'un gossip modifié
  post '/gossips/:id/edit/' do 
    Gossip.update(params["id"], params["gossip_author_new"], params["gossip_content_new"])
    redirect '/'
  end

end
