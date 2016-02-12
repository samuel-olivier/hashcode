#!/usr/bin/env ruby

class Order
	def initialize(row, column, items)
		@row = row
		@column = column
		@items = items

		# ---
		@pending = false
	end

	def pending?()
		@pending
	end
	def pending!(state = :toggle)
		@pending != true if state == :toggle
		@pending = state
	end
	def complete?()
		true unless @items.count > 0
		false
	end

	def getItems()
		@items
	end
end

if __FILE__ == $0



end
