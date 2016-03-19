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
    all.find do |product|
      product.id == id
    end
  end

  def self.destroy(id)
    destroyed_product = find(id)
    updated_products = all.delete_if { |product| product.id == id }
    rewrite_csv(updated_products)
    destroyed_product
  end

  def self.rewrite_csv(products)
    CSV.open(CSV_FILE, 'wb') do |csv|
      csv << %w(id brand name price)
      products.each do |product|
        csv << [product.id, product.brand, product.name, product.price]
      end
    end
  end

end
