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
            requires :user_id, type: Integer
          end
          post do
            present Product.create!(
              name: params[:name],
              cost: params[:cost],
              amount_available: params[:amount_available],
              user_id: params[:user_id]
            )
          end

          desc 'Update a specific product'
          route_param :id do
            put do
              product = Product.find(params[:id])
              product.update(params)
            end
          end

          desc 'Delete a specific product'
          route_param :id do
            delete do
              product = Product.find(params[:id])
              product.destroy
            end
          end
        end
    end
  end
end
