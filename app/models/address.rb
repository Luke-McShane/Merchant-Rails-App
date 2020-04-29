class Address < ApplicationRecord
    belongs_to :user
    has_many :orders

    validates :line1, :city, :state, :postcode, presence: true
    validates :postcode, numericality: { only_integer: true }, length: { maximum: 4,
        wrong_length: "The postcode must contain 4 integers." }  

    def to_s
        [line1, line2, city, state, postcode].select{ |attr| !attr.blank? }
            .map{ |item| item.insert(0, ' ') }
            .join(',')
    end
        
end
