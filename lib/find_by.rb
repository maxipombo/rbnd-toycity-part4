class Module
  def create_finder_methods(*attributes)
    attributes.each do |attribute|
      finder_methods = %{
        def self.find_by_#{attribute}(#{attribute})
          all.find do |product|
            product.#{attribute} == #{attribute}
          end
        end
      }
    class_eval(finder_methods)
    end
  end
end
