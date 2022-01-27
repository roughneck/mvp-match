require 'rails_helper'

describe API::Base, type: :request do
  let(:user) { FactoryBot.create(:user, deposit: 15) }
  let(:product) { FactoryBot.create(:product, cost: 5) }

  context 'when logged in' do
    before { login_with_api(user) }

    context 'when user is seller' do
      let(:user) { FactoryBot.create(:user, role: 'seller', deposit: 15) }
      let(:amount) { 1 }

      describe 'POST /api/v1/buy' do
        before do
          post '/api/v1/buy',
               params: {
                 product_id: product.id,
                 amount: amount
               }, headers: { Authorization: response.headers['Authorization'] }
        end

        it 'returns 401' do
          expect(response.status).to eq(401)
        end
      end
    end

    context 'when user is buyer' do
      describe 'POST /api/deposit' do
        before do
          post '/api/v1/buy',
               params: {
                 product_id: product.id,
                 amount: amount
               }, headers: { Authorization: response.headers['Authorization'] }
        end

        context 'when buying a valid amount' do
          let(:amount) { 1 }

          it 'returns 201' do
            expect(response.status).to eq(201)
          end

          it 'increases deposit of user' do
            user.reload

            expect(user.deposit).to eq(10)
          end
        end

        context 'when buying an invalid amount' do
          let(:amount) { 10 }

          it 'returns 400' do
            expect(response.status).to eq(400)
          end

          it 'increases deposit of user' do
            user.reload

            expect(user.deposit).to eq(15)
          end
        end
      end
    end
  end

  context 'when not logged in' do
    describe 'POST /api/deposit' do
      it 'returns 401' do
        post '/api/v1/buy'

        expect(response.status).to eq(401)
      end
    end
  end
end
