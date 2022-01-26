module API
  module V1
    class Buy < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :buy do

        desc 'Buy product'
        params do
          requires :product_id, type: Integer
          requires :amount, type: Integer
        end
        post do
          product = Product.find(params[:product_id])
          amount = params[:amount]
          total_price = product.cost * amount

          error!('Error: not enough deposit', 401) if total_price > current_user.deposit
          error!('Error: seller not allowed to buy', 401) if current_user.has_role?(:seller)
          
          current_user.deposit -= total_price
          current_user.save

          result = {
            product: product.to_json,
            change: ChangeService.new(current_user.deposit).call
          }

          present result
        end
      end
    end
  end
end
