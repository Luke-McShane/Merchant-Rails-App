module ProductsHelper
    def print_price(price)
        number_to_currency price
    end

    def print_stock(stock, requested_amount = 1)
        if (stock > 0 && stock < requested_amount)
            content_tag(:span, "Insufficient stock (#{stock})", class: "low_stock")
        elsif (stock > 0 && stock >= requested_amount)
            content_tag(:span, "In Stock: #{stock}", class: "in_stock")
            #<span class="in_stock">In Stock: (%{stock})</span>
        else
            content_tag(:span, "Out of Stock", class: "out_of_stock")
            #<span class="out_of_stock">Out of Stock</span>
        end
    end
end
