#!/usr/bin/env ruby

class Algo
	def initialize(map = nil)
		unless map
			raise "Hmhm ??"
		end
		@map = map
	end

	def averagePerStock()
		nbOrder = @map.orders.count
		@total = Array.new(nbOrder, 0)
		@average = Array.new(nbOrder, 0)
		@map.orders.each do |order|
			order.getItems.each do |type|
				@total[type] += 1
			end
		end
		i = 0
		@total.each do |nbType|
			@average[i] = nbType.to_f / nbOrder.to_f
			i += 1
		end
		@average
	end
	def reorganizeAverage()
		@average.each_with_index.sort.map &:last
	end
end

if __FILE__ == $0

	Algo.new

end
