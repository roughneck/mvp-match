module API
  module V1
    class Products < Grape::API
        version 'v1', using: :path
        format :json
        prefix :api
        resource :products do
          desc 'Return all Books'
          get do
            present Product.all
          end
        end
    end
  end
end
