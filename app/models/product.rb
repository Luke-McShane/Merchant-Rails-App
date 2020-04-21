class Product < ApplicationRecord
    validates_numericality_of :price

    def price=(input)
        input.delete! "$" "£" "€"
        #input.delete!("$", "£", "€")
        super
    end
end
