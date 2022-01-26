module API
  module V1
    class Reset < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :reset do

        desc "Resets user's deposit"
        put do
          current_user.deposit = 0

          present current_user.save
        end
      end
    end
  end
end
