#!/usr/bin/env ruby

class Algo
	def initialize(map = nil)
		unless map
			raise "Hmhm ??"
		end
		@map = map
	end

	def averagePerStock()
		@average = Array.new()
		@map.orders.each do |order|
			items = order.getItems

		end
	end
end

if __FILE__ == $0

	Algo.new

end
