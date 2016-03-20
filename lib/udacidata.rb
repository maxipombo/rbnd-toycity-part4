require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
create_finder_methods(:brand, :name)

CSV_FILE = File.dirname(__FILE__) + '/../data/data.csv'

  def self.create(options = {})
    product = new(options)
    unless all.any? { |item| item.id == product.id }
      CSV.open(CSV_FILE, 'ab') do |csv|
        csv << [product.id, product.brand, product.name, product.price]
      end
    end
    product
  end

  def self.all
    products = []
    CSV.foreach(CSV_FILE, headers: true) do |row|
      products << new(id: row['id'].to_i, brand: row['brand'], name: row['product'],
      price: row['price'])
    end
    products
  end

  def self.first(*n)
    n[0] ? all.first(n[0]) : all.first
  end

  def self.last(*n)
    n[0] ? all.first(n[0]) : all.last
  end

  def self.find(id)
    product = all.find { |product| product.id == id }
    unless product
      raise ProductNotFoundError, "Could not find a product with ID: #{id}"
    end
    product
  end

  def self.destroy(id)
    destroyed_product = find(id)
    updated_products = all.delete_if { |product| product.id == id }
    rewrite_csv(updated_products)
    destroyed_product
  end

  def self.rewrite_csv(products)
    CSV.open(CSV_FILE, 'wb') do |csv|
      csv << %w(id brand product price)
      products.each do |product|
        csv << [product.id, product.brand, product.name, product.price]
      end
    end
  end

  def self.where(options = {})
    brand_products = []
    if options[:brand]
      brand_products = all.select { |product| product.brand == options[:brand] }
    end
    name_products = []
    if options[:name]
      name_products = all.select { |product| product.name == options[:name] }
    end
    brand_products.concat(name_products)
  end

  def update(options = {})
    Product.destroy(id)
    brand = options[:brand] if options[:brand]
    name = options[:name] if options[:name]
    price = options[:price] if options[:price]
    Product.create(id: id, brand: brand, name: name, price: price)
  end

end
