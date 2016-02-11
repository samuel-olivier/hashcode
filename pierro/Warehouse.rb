#!/usr/bin/env ruby



class Warehouse
	def initialize(row = 0, column = 0)
		# position
		@row = row
		@column = column
		@stock = []
	end

	def add(nbProduct, type = nil)
		if type
			@stock[type] += nbProduct
		else
			@stock << nbProduct
		end
	end

	def findProduct(type = nil)
		@stock[type].first if type
		@stock.first.first if @stock.first
	end

	def to_s()
		"[" + @row.to_s + ", " + @column.to_s + "] : " + @stock.to_s
	end
end

if __FILE__ == $0

	warehouse = Warehouse.new
	p warehouse.findProduct

end
