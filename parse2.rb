# この下にコードを追加してください
require 'debug'
class Parser
  def initialize(a)
  end

  def parse(str)
    str.split("\n").map do |content|
      details = content.split(",")
      price = details[1]
      discount = details[2]
      name = details[0]
      Item.new(price,discount,name)
    end
  end
end

class Item
attr_reader :price, :discount, :name
  def initialize(price,discount,name)
    @price = price.to_i
    @discount = discount
    @name = name
  end
end

# ここから下はそのままにしてください
# デバッグのため一時的に変更するのは構いません

str = <<-EOS
いちご,200,半額
さくらんぼ,300,3割引
EOS

parser = Parser.new(",")
items = parser.parse(str)

p items.size #=> 2
p items.first.price #=> 200
p items.last.discount #=> "3割引"
p items.map(&:name) #=> ["いちご", "さくらんぼ"]

# str = <<-EOS
# メロン\t400\t1割引
# バナナ\t80\t半額
# EOS

# parser = Parser.new("\t")
# items = parser.parse(str)
# p items.size #=> 2
# p items.first.price #=> 400
# p items.last.discount #=> "半額"
# p items.map(&:name) #=> ["メロン", "バナナ"]
