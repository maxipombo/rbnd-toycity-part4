module Analyzable

  def average_price(data)
    (data.inject(0) {|total, item| total += item.price.to_f} / data.length).round(2)
  end

  def print_report(products)
    brands = count_by_brand(products)
  	names =  count_by_name(products)
    report = "Average Price: #{average_price(products)}\n"
    report += "\nInventory by Brand:\n"
  	brands.each do |brand, count|
  		report += "  - #{brand}: #{count}\n"
  	end
  	report += "\nInventory by Name:\n"
  	names.each do |name, count|
  		report += "  - #{name}: #{count}\n"
  	end
    report
  end

  def count_by_brand(products)
  	brands = {}
  	products.each do |product|
  		if brands.include? product.brand
  			brands[product.brand] += 1
  		else
  			brands[product.brand] = 1
  		end
  	end
  	brands
  end

	def count_by_name(products)
  	names = {}
  	products.each do |product|
  		if names.include? product.name
  			names[product.name] += 1
  		else
  			names[product.name] = 1
  		end
  	end
  	names
  end

end
