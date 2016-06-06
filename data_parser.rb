require 'csv'
require 'erb'


data = []
fry , leela , bender , amy=0
CSV.foreach("planet_express_logs.csv", headers: true) do |row|
  logs = row.to_hash
  data.push logs
  # puts logs.inspect
end
moneylog = data.map do |data|
  data["Money"].to_i
end

total_income = moneylog.reduce(:+)

puts "Total weekly income is $#{total_income}!"

destArr = data.map do |data|
  data["Destination"]
end
shipment = data.map do |data|
  data["Shipment"]
end
puts shipment.inspect
fry = destArr.select do |destArr|
  destArr.include?("Earth")
end
amy = destArr.select do |destArr|
  destArr.include?("Mars")
end
bender = destArr.select do |destArr|
  destArr.include?("Uranus")
end
runsWOleela= (fry.length + amy.length + bender.length)
rLeela = (destArr.length)-(runsWOleela)

rFry =  fry.length
rAmy=amy.length
rBender =  bender.length
puts "Runs made by fry: #{rFry}"
puts "Runs made by amy: #{rAmy}"
puts "Runs made by bender: #{rBender}"
puts "Runs made by leela: #{rLeela}"

monArr = data.map do |data|
  data["Money"].to_i
end

puts monArr.inspect

fryPay=monArr[0]+monArr[2]
amyPay=monArr[3]
benderPay=monArr[4]+monArr[7]
leelaPay= total_income-(fryPay+amyPay+benderPay)

fryBonus=fryPay  *(0.10)
amyBonus=amyPay  *(0.10)
benderBonus=benderPay  *(0.10)
leelaBonus=leelaPay  *(0.10)

puts fryPay
puts amyPay
puts benderPay
puts leelaPay

erb = File.read("report.erb")
html= ERB.new(erb).result(binding)
File.open("index.html", "wb") {|file| file << html}
