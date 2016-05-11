# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Motor.delete_all
(0..20).each do |var|
	Motor.create!(brand: "Juki #{var}", name: "JK 1#{var}", watt: var, qty: var+20) 
	puts "Motor record #{var} created!"
end

Table.delete_all
(0..20).each do |var|
	Table.create!(brand: "Juki #{var}", name: "JK 1#{var}", width: var, height: var, qty: var+20) 
	puts "Table record #{var} created!"
end

Stand.delete_all
(0..20).each do |var|
	Stand.create!(brand: "Juki #{var}", name: "JK 1#{var}", qty: var+20) 
	puts "Stand record #{var} created!"
end

Currency.delete_all
(0..20).each do |var|
	Currency.create!(burma: 1200+var, us: 1) 
	puts "Currency record #{var} created!"
end

Staff.delete_all
(0..20).each do |var|
	Staff.create!(name: "Name #{var}", phone: 9123123+var, address: "no#{var} Blar street", password_digest: "12312#{var}") 
	puts "Currency record #{var} created!"
end

Machine.delete_all
Needle.delete_all
Part.delete_all

(1..21).each do |var|
	machine_model = %w{Juki-MO670 Juki-MB373 Juki-DDL870 Juki-LK185 Juki-LBH780}
	machine = Machine.create!(model: machine_model[rand(5)]+"#{var}", series: "Mo570#{var}s", namemm: "ဒီေန႕", nameeng: "English", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum", company: "AAA Co.,Ltd", stock: var+10, qty: var+20)
	puts "Machine record #{var} created!"
	cat = %w{R RG FG FFG}
	Needle.create!(model: "DBx#{var}", category: cat[rand(3)], machine_id: machine.id, stock: var+10, qty: var+20,price: var+0, size: "55/3#{var}") 
	puts "Needle record #{var} created!"
	Part.create!(model: "121-7387#{var}", namemm: "ဒီေန႕", nameeng: "English", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum", machine_id: machine.id, stock: var+10, qty: var+20,price: var+0) 
	puts "Part record #{var} created!"
end

puts "Delete all sale and purchase records"
Msale.delete_all
MsaleDetail.delete_all
Chassis.delete_all
Debt.delete_all

Purchase.delete_all
PurchaseDetail.delete_all

puts "All seeding procedure done"