require 'csv'

class Gossip
  attr_accessor :author, :content, :id

  def initialize (author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find(id)
    self.all[id.to_i]
  end

  def self.update(id, author, content)
    edited_gossips =  CSV.read('./db/gossip.csv').each_with_index do |gossip, index|
      if index == id.to_i
        gossip[0] = [author].join('')
        gossip[1] = [content].join('')

      else
        gossip
      end
    end
    File.open('./db/gossip.csv', 'w') {|file| file.truncate(0)}
    edited_gossips.each do |csv|
      Gossip.new(csv[0],csv[1]).save
    end
  end

end
