class Purchase < ActiveRecord::Base

	def self.valid_get_params(category, id)
		unless category.nil? || category.empty? || id.nil? || id.empty? 
      %w[Machine Part Needle Motor Table Stand].each do |controller|
        return true if category == controller
      end
    end    
    return false
	end

	def self.add_to_cart(session, category, id)  
		if session.nil? || session.empty?
			puts "Nothing"
			session << {"category" => category, "id" => id}
		end
		session << {"category"=> category, "id" => id}	
		session.uniq
	end

	def self.valid_url(controller)
		case controller
		when "Machine"
			"/machines_purchase"
		when "Part"
			"/parts_purchase"
		when "Needle"
			"/needles_purchase"
		when "Motor"
			"/motors_purchase"
		when "Table"
			"/tables_purchase"
		when "Stand"
			"/stands_purchase"
		end
	end

	def self.get_items(sessions)
		all_in_one = []
		sessions.each do |session|
			case session["category"]
			when "Machine"
				@machine = Machine.find(session["id"])
				all_in_one << {"name" => @machine.model,"id" => session["id"],"category" => session["category"],"qty" => session["qty"], "price" => session["price"]}
			when "Part"
				@part = Part.find(session["id"])
				all_in_one << {"name" => @part.model + " (" + @part.machine.model + ")" , "id" => session["id"], "category" => session["category"], "qty" => session["qty"], "price" => session["price"]}
			when "Needle"
				@needle = Needle.find(session["id"]) 
				all_in_one << {"name" => @needle.model + "-" + @needle.category + " (" + @needle.size  + ")", "id" => session["id"], "category" => session["category"], "qty" => session["qty"], "price" => session["price"]}
			when "Motor"
				@motor = Motor.find(session["id"])
				all_in_one << {"name" => @motor.name + "-" + @motor.brand + " (" + @motor.watt.to_s  + " W)" , "id" => session["id"], "category" => session["category"], "qty" => session["qty"], "price" => session["price"]}
			when "Table"
				@table = Table.find(session["id"])
				all_in_one << {"name" => @table.name + " " + @table.brand + " (" + @table.width.to_s + "x" + @table.height.to_s  + ")", "id" => session["id"], "category" => session["category"], "qty" => session["qty"], "price" => session["price"]}
			when "Stand"
				@stand = Stand.find(session["id"])
				all_in_one << {"name" => @stand.name + " " + @stand.brand, "id" => session["id"], "category" => session["category"], "qty" => session["qty"], "price" => session["price"]}
			end # end of case when
		end # end of sesssions each loop

		return all_in_one
	end # method end

	def self.delete_item(session,category,id)
		
		if session.nil? || session.empty?
			[]
		end

		session.each_with_index do |item,index|
			if item["category"] == category && item["id"] == id
				session.delete_at(index)
			end
		end
		
		session.uniq

	end

end
