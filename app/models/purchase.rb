class Purchase < ActiveRecord::Base

	def self.valid_category(category)
		unless category.nil? || category.empty?
      %w[Machine Part Needle Motor Table Stand].each do |controller|
        return true if category == controller        
      end
    end    
    return false
	end

	def self.add_to_cart(session, category, id)  
		if session.nil? || session.empty?
			session << {category: category, id: id, qty: 1, price: 0}
			return session	
		else
			session << {category: category, id: id, qty:1, price: 10}
			return session.uniq!
		end
	end

	def self.valid_url(controller)
		case controller
		when "Machine"
			"/machines_purchase"
		when "Part"
			"/part_purchase"
		when "Needle"
			"/needle_purchase"
		when "Motor"
			"/motor_purchase"
		when "Table"
			"/table_purchase"
		when "Stand"
			"/stand_purchase"
		end
	end

	def self.get_items(sessions)
		all_in_one = []
		sessions.each do |session|
			case session["category"]
			when "Machine"
				@machine = Machine.find(session["id"])
				all_in_one << {name: @machine.model,id: session["id"],category: session["category"],qty: session["qty"], price: session["price"]}
			when "Part"
				@part = Part.find(session["id"])
				all_in_one << {name: @part.model, id: session["id"], category: session["category"], qty: session["qty"], price: session["price"]}
			when "Needle"
				@needle = Needle.find(session["id"]) 
				all_in_one << {name: @needle.model + "-" + @needle.category + "(" + @needle.size  + ")", id: session["id"], category: session["category"], qty: session["qty"], price: session["price"]}
			when "Motor"
				@motor = Motor.find(session["id"])
				all_in_one << {name: @motor.name + "-" + @stand.brand + "(" + @motor.watt  + ")" , id: session["id"], category: session["category"], qty: session["qty"], price: session["price"]}
			when "Table"
				@table = Table.find(session["id"])
				all_in_one << {name: @table.model + " " + @stand.brand + "(" + @table.width + "x" + @table.height  + ")", id: session["id"], category: session["category"], qty: session["qty"], price: session["price"]}
			when "Stand"
				@stand = Stand.find(session["id"])
				all_in_one << {name: @stand.model + " " + @stand.brand, id: session["id"], category: session["category"], qty: session["qty"], price: session["price"]}
			end # end of case when
		end # end of sesssions each loop

		return all_in_one
	end # method end


end
