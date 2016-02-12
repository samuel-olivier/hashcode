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
			@stock[type] += nbProduct.to_i
		else
			@stock << nbProduct.to_i
		end
	end

	def findProduct(type = nil)
		@stock[type] if type
		@stock.first if @stock.first
	end

	def getPosition()
		[@row, @column]
	end
	def to_s()
		"[" + @row.to_s + ", " + @column.to_s + "] : " + @stock.to_s
	end
end

if __FILE__ == $0

	warehouse = Warehouse.new
	p warehouse.findProduct

end
