module Analyzable

  def average_price(data)
    (data.inject(0) {|total, item| total += item.price.to_f} / data.length).round(2)
  end

  def print_report(products)
    report = "Average Price: #{average_price(products)}\n"
    report
  end

end
