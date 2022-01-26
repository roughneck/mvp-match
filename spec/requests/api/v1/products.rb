require 'rails_helper'

describe API::Base, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let!(:product) { FactoryBot.create(:product) }

  context 'when logged in' do
    before { login_with_api(user) }

    describe 'GET /api/products' do
      before do
        get '/api/v1/products', headers: { Authorization: response.headers['Authorization'] }
      end

      it 'returns 200' do
        expect(response.status).to eq(200)
      end

      it 'returns an array with exisiting product' do
        expect(response.body).to include product.to_json
      end
    end

    describe 'GET /api/product/:id' do
      before do
        get "/api/v1/products/#{product.id}", headers: { Authorization: response.headers['Authorization'] }
      end

      it 'returns a product by id' do
        expect(response.body).to eq product.to_json
      end

      it 'returns 200' do
        expect(response.status).to eq(200)
      end
    end

    context 'when user is seller' do
      let(:user) { FactoryBot.create(:user, role: 'seller') }

      describe 'POST /api/product' do
        before do
          post '/api/v1/products',
               params: {
                 name: 'Product 10',
                 cost: 15,
                 amount_available: 5,
                 user_id: user.id
               }, headers: { Authorization: response.headers['Authorization'] }
        end

        it 'returns 201' do
          expect(response.status).to eq(201)
        end
      end

      describe 'PUT /api/product/:id' do
        before do
          put "/api/v1/products/#{product.id}", headers: { Authorization: response.headers['Authorization'] }
        end

        it 'returns 200' do
          expect(response.status).to eq(200)
        end
      end

      describe 'DELETE /api/product/:id' do
        before do
          delete "/api/v1/products/#{product.id}", headers: { Authorization: response.headers['Authorization'] }
        end

        it 'returns 200' do
          expect(response.status).to eq(200)
        end
      end
    end

    context 'when user is buyer' do
      describe 'POST /api/product' do
        before do
          post '/api/v1/products',
               params: {
                 name: 'Product 10',
                 cost: 15,
                 amount_available: 5,
                 user_id: user.id
               }, headers: { Authorization: response.headers['Authorization'] }
        end

        it 'returns 401' do
          expect(response.status).to eq(401)
        end
      end

      describe 'PUT /api/product/:id' do
        before do
          put "/api/v1/products/#{product.id}", headers: { Authorization: response.headers['Authorization'] }
        end

        it 'returns 401' do
          expect(response.status).to eq(401)
        end
      end

      describe 'DELETE /api/product/:id' do
        before do
          delete "/api/v1/products/#{product.id}", headers: { Authorization: response.headers['Authorization'] }
        end

        it 'returns 401' do
          expect(response.status).to eq(401)
        end
      end
    end
  end

  context 'when not logged in' do
    describe 'GET /api/products' do
      it 'returns 401' do
        get '/api/v1/products'

        expect(response.status).to eq(401)
      end
    end

    describe 'GET /api/product/:id' do
      it 'returns 401' do
        get "/api/v1/products/#{product.id}"

        expect(response.status).to eq(401)
      end
    end

    describe 'POST /api/product' do
      it 'returns 401' do
        post '/api/v1/products'

        expect(response.status).to eq(401)
      end
    end

    describe 'PUT /api/product/:id' do
      it 'returns 401' do
        put "/api/v1/products/#{product.id}"

        expect(response.status).to eq(401)
      end
    end

    describe 'DELETE /api/product/:id' do
      it 'returns 401' do
        delete "/api/v1/products/#{product.id}"

        expect(response.status).to eq(401)
      end
    end
  end
end
