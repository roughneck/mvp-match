require 'rails_helper'

describe API::Base, type: :request do
  let(:user) { FactoryBot.build(:user) }
  let(:password) { 'some-password-123' }
  let(:product) { FactoryBot.create(:product, cost: 5) }

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

    describe 'deposits an amount' do
      before do
        put '/api/v1/deposit',
            params: {
              amount: 100
            }, headers: { Authorization: bearer_token }
      end

      it "updates user's deposit" do
        expect(signed_up_user.deposit).to eq 100
      end

      describe 'buys product' do
        let(:product_result) { JSON.parse(json.fetch('product')) }

        before do
          post '/api/v1/buy',
               params: {
                 product_id: product.id,
                 amount: 1
               }, headers: { Authorization: bearer_token }
        end

        it 'returns product' do
          product.reload

          expect(product_result.fetch('amount_available')).to eq product.amount_available
          expect(product_result.fetch('cost')).to eq product.cost
          expect(product_result.fetch('name')).to eq product.name
        end

        it 'returns change' do
          expect(json.fetch('change')).to eq({ '10' => 0, '100' => 0, '20' => 2, '5' => 1, '50' => 1 })
        end
      end
    end
  end
end
