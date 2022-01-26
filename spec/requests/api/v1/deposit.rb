require 'rails_helper'

describe API::Base, type: :request do
  let(:user) { FactoryBot.create(:user) }

  context 'when logged in' do
    before { login_with_api(user) }

    context 'when user is seller' do
      let(:user) { FactoryBot.create(:user, role: 'seller') }

      describe 'POST /api/v1/deposit' do
        before do
          put '/api/v1/deposit',
              params: {
                amount: amount
              }, headers: { Authorization: response.headers['Authorization'] }
        end

        context 'when depositing a valid amount' do
          let(:amount) { 5 }

          it 'returns 200' do
            expect(response.status).to eq(200)
          end

          it 'increases deposit of user' do
            user.reload

            expect(user.deposit).to eq(5)
          end
        end

        context 'when depositing an invalid amount' do
          let(:amount) { 3 }

          it 'returns 401' do
            expect(response.status).to eq(401)
          end

          it 'increases deposit of user' do
            user.reload

            expect(user.deposit).to eq(0)
          end
        end
      end
    end

    context 'when user is buyer' do
      describe 'POST /api/v1/deposit' do
        before do
          put '/api/v1/deposit',
              params: {
                amount: amount
              }, headers: { Authorization: response.headers['Authorization'] }
        end

        context 'when depositing a valid amount' do
          let(:amount) { 5 }

          it 'returns 200' do
            expect(response.status).to eq(200)
          end

          it 'increases deposit of user' do
            user.reload

            expect(user.deposit).to eq(5)
          end
        end

        context 'when depositing an invalid amount' do
          let(:amount) { 3 }

          it 'returns 401' do
            expect(response.status).to eq(401)
          end

          it 'increases deposit of user' do
            user.reload

            expect(user.deposit).to eq(0)
          end
        end
      end
    end
  end

  context 'when not logged in' do
    describe 'POST /api/v1/deposit' do
      it 'returns 401' do
        post '/api/v1/deposit'

        expect(response.status).to eq(401)
      end
    end
  end
end
