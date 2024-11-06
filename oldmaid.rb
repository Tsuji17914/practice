class Card
  attr_accessor :number, :suit

  def initialize(number,suit)
    @number = number
    @suit = suit
  end

  def to_s
    @info ||= "<Card #{suite} #{number}>"
  end
end

class Player
  attr_accessor :hand, :name

  def initialize(name)
    @name = name
    @hand = []
  end
end

def check(player_hand)
  remain = []
  while (card = player_hand.hand.shift)
      pair = player_hand.hand.find {|c| c.number == card.number }
    if pair
      player_hand.hand.delete(pair)
    else
    remain << card
    end
  end
  remain.each do |card|
   player_hand.hand << card
  end
end

def pick(player_hand,opponent_hand)
  opponent_hand.hand.shuffle
  player_hand.hand << opponent_hand.hand.shift
end

def win(player_hand) 
  if player_hand.hand.empty?
    puts "#{player_hand.name}の勝ち"
  end
end

def play_start(players)
  until players.any? { |player| player.hand.empty?}
    players.each_with_index do |player,index|
      if players.any? { |player| player.hand.empty?}
        break
      else
        puts "#{player.name}のターンです"
        pick(player,players[index - 1])
        check(player)
        puts "#{player.name}の手札は残り#{player.hand.size}枚です"
        puts "#{players[index - 1].name}の手札は残り#{players[index - 1].hand.size}枚です"
        win(player)
        win(players[index - 1])
      end
    end
  end
end

def remain_players_check(players)
  winner = players.detect{|player| player.hand.empty?}
  winner_index = players.find_index(winner)
  new_players = players[winner_index+1..] || []
  new_players.concat(winner_index > 0 ? players[..winner_index-1] : [])
end

numbers = ["A","2","3","4","5","6","7","8","9","10","J","Q","K"]
suits = ["ハート","スペード","ダイヤ","クローバー"]
cards = []

cards << Card.new("0","Joker")
numbers.each do |number|
  suits.each do |suit|
    cards << Card.new(number,suit)
  end
end

yamada = Player.new("山田さん")
suzuki = Player.new("鈴木さん")
kinoshita = Player.new("木下さん")

players = []
players << yamada
players << suzuki
players << kinoshita

cards.shuffle!
cards.each_with_index do |card, index|
  player_index = index % players.size 
  players[player_index].hand << card
end

players.each_with_index do |player, index|
  check(players[index])
  puts "#{players[index].name}の手札は#{players[index].hand.size}枚です"
end

puts "ゲームを開始します"

while (players.size > 1) do
  play_start(players)
  players = remain_players_check(players)
end

puts "ゲームを終了します"
