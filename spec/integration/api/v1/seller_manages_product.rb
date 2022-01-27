require 'rails_helper'

describe API::Base, type: :request do
  let(:user) { FactoryBot.build(:user, role: 'seller') }
  let(:password) { 'some-password-123' }

  describe 'user signs up' do
    let(:signed_up_user) { User.last }
    let(:bearer_token) { response.headers['Authorization'] }

    before do
      post '/users', params: {
        user: {
          email: user.email,
          password: password,
          username: user.username,
          role: user.role
        }
      }
    end

    describe 'creates product' do
      let(:product) { Product.last }

      before do
        post '/api/v1/products',
             params: {
               name: 'Product 1',
               cost: 15,
               amount_available: 5
             }, headers: { Authorization: bearer_token }
      end

      it 'assigns correct values to product' do
        expect(product.name).to eq 'Product 1'
        expect(product.cost).to eq 15
        expect(product.amount_available).to eq 5
      end

      describe 'updates product' do
        before do
          put "/api/v1/products/#{product.id}", params: { name: 'Product 1.1' }, headers: { Authorization: bearer_token }
        end

        it 'assigns correct values to product' do
          product.reload

          expect(product.name).to eq 'Product 1.1'
        end

        describe 'deletes product' do
          before do
            delete "/api/v1/products/#{product.id}", headers: { Authorization: bearer_token }
          end

          it 'deletes product' do
            expect(Product.count).to eq 0
          end
        end
      end
    end
  end
end
