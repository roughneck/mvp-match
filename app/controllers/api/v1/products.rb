module API
  module V1
    class Products < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :products do
        desc 'Return all products'
        get do
          present Product.all
        end

        desc 'Return a specific product'
        route_param :id do
          get do
            present Product.find(params[:id])
          end
        end

        desc 'Create a new product'
        params do
          requires :name, type: String
          requires :cost, type: Integer
          requires :amount_available, type: Integer
        end
        post do
          error!('Error: buyers are not allowed to create products', 401) if current_user.role?(:buyer)

          present Product.create!(
            name: params[:name],
            cost: params[:cost],
            amount_available: params[:amount_available],
            user_id: current_user.id
          )
        end

        desc 'Update a specific product'
        route_param :id do
          put do
            error!('Error: buyers are not allowed to update products', 401) if current_user.role?(:buyer)

            product = Product.find(params[:id])
            error!('Error: you are not allowed to update this product', 401) if product.user != current_user            
            product.update(params)
          end
        end

        desc 'Delete a specific product'
        route_param :id do
          delete do
            error!('Error: buyers are not allowed to delete products', 401) if current_user.role?(:buyer)

            product = Product.find(params[:id])
            error!('Error: you are not allowed to delete this product', 401) if product.user != current_user
            product.destroy
          end
        end
      end
    end
  end
end
