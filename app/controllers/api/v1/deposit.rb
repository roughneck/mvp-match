module API
  module V1
    class Deposit < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :deposit do
        desc 'Deposits an amount'
        params do
          requires :amount, type: Integer
        end
        put do
          error!('Error: invalid deposit amount', 401) unless [5, 10, 20, 50].include? params[:amount]
          error!('Error: seller not allowed to deposit', 401) if current_user.role?(:seller)

          current_user.deposit += params[:amount]

          present current_user.save
        end
      end
    end
  end
end
