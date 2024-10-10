# この下にコードを追加してください

# ここから下はそのままにしてください
# デバッグのため一時的に変更するのは構いません

str = <<-EOS
りんご,100,半額
みかん,130,3割引
EOS

parser = Parser.new
items = parser.parse(str)
p items.size #=> 2
p items.first.price #=> 100
p items.last.discount #=> "3割引"
p items.map(&:name) #=> ["りんご", "みかん"]

str = <<-EOS
もも,90,2割引
りんご,100,半額
なし,150,5割引
EOS

parser = Parser.new
items = parser.parse(str)
p items.size #=> 3
p items.first.price #=> 90
p items.last.discount #=> "5割引"
p items.map(&:name) #=> ["もも", "りんご", "なし"]
