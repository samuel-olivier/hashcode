#!/usr/bin/env ruby

class Algo
	def initialize(map = nil)
		unless map
			raise "Hmhm ??"
		end
		@map = map
	end

	# bootstraps
	def sortSizeOrderedProduct()
		productTypes = @map.productTypes
		nbProduct = productTypes.count
		weighs = []
		@map.orders.each do |order|
			order.getItems.each do |type|
				weighs << type.weigh
			end
		end
		@sortedByWeight = weighs.each_with_index.sort.reverse.map &:last
	end
	def averagePerStock()
		nbProduct = @map.productTypes.count
		@total = Array.new(nbProduct, 0)
		@average = Array.new(nbProduct, 0)
		@map.orders.each do |order|
			order.getItems.each do |type|
				@total[type.index] += 1
			end
		end
		i = 0
		@total.each do |nbType|
			@average[i] = nbType.to_f / nbProduct.to_f
			i += 1
		end
		@average
	end
	def reorganizeAverage()
		@indexedAverage = @average.each_with_index.sort.reverse.map &:last
	end

	# maestros
	def loadDronesWithAveragePayload()
		# the purpose here is to take care of the big part of the orders first without considering orders as objects.

		@map.drones(nil, :no).each do |drone|
			p @map.productTypes[@indexedAverage.first], @total[@indexedAverage.first]
			@total[@indexedAverage.first] -= 1
		end
	end
end

if __FILE__ == $0

	Algo.new

end
