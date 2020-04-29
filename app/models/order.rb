class Order < ApplicationRecord
    #Since order_items is now dependent on order, once we destroy an order, we destroy all associated order_items as well
    has_many :order_items, dependent: :destroy
    belongs_to :user, optional: true
    #belongs_to :user
    belongs_to :address, optional: true

    def total
        total = 0
        order_items.each do |item|
            total += item.subtotal
        end
        total
    end
end
