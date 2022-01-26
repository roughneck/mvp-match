module API
  module V1
    class Base < Grape::API
      helpers API::V1::Helpers

      before { user_authenticated? }
      
      mount API::V1::Products
    end
  end
end
