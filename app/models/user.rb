class User < ApplicationRecord
    has_many :orders

    def self.from_omniauth(auth)
      # Creates a new user only if it doesn't exist
      where(uid: auth.info.email).first_or_initialize do |user|
        user.name = auth.info.name
        user.uid = auth.info.email
      end
    end
end
