require 'csv'

class Gossip
  attr_accessor :author, :content, :id

  #Initialisation d'un Gossip.new avec deux variables d'instances
  def initialize (author, content)
    @author = author
    @content = content
  end

  #définition de la méthode save pour enregistrer un gossip dans un fichier CSV
  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  #Méthode self.all, permet d'intégrer les données du csv dans un tableau et de retourner les valeurs du tableau
  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  #Méthode pour retourner l'index de chaque élément du tableau
  def self.find(id)
    self.all[id.to_i]
  end

  #Méthode pour éditer un Gossip
  def self.update(id, author, content)
    edited_gossips =  CSV.read('./db/gossip.csv').each_with_index do |gossip, index| #création d'un nouveau tableau à partir des données du fichier csv
    #méthode if pour valider le bon index pour modifier les données
      if index == id.to_i
        gossip[0] = [author].join('')
        gossip[1] = [content].join('')

      else
        gossip
      end
    end
    File.open('./db/gossip.csv', 'w') {|file| file.truncate(0)} #suppression des données initiaux dans le csv

    #Intégration des nouvelles valeurs du tabeau
    edited_gossips.each do |csv|
      Gossip.new(csv[0],csv[1]).save
    end
  end

end
