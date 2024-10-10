# この下にコードを追加してください
class Parser
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

str = <<-EOS
メロン\t400\t1割引
バナナ\t80\t半額
EOS

parser = Parser.new("\t")
items = parser.parse(str)
p items.size #=> 2
p items.first.price #=> 400
p items.last.discount #=> "半額"
p items.map(&:name) #=> ["メロン", "バナナ"]
