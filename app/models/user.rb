class User < ApplicationRecord
    def self.find_or_create_by_auth(auth_data)
        find_or_create_by_provider_and_uid(auth_data["provider"], auth_data["uid"], 
                                           name: auth_data["info"]["name"])
      end

      def self.from_omniauth(auth)
        # Creates a new user only if it doesn't exist
        where(email: auth.info.email).first_or_initialize do |user|
          user.name = auth.info.name
          user.email = auth.info.email
        end
      end
end
