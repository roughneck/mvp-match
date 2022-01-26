module API
  module V1
    class Reset < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :reset do

        desc "Resets user's deposit"
        put do
          error!('Error: seller not allowed to reset', 401) if current_user.has_role?(:seller)

          current_user.deposit = 0

          present current_user.save
        end
      end
    end
  end
end
