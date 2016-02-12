#!/usr/bin/env ruby

class Order
	def initialize(row, column, items)
		@row = row
		@column = column
		@items = []
		items.each do |item|
			@items << item.to_i
		end

		# ---
		@pending = false
	end

	def pending?()
		@pending
	end

	def getItems()
		@items
	end
end

if __FILE__ == $0



end
