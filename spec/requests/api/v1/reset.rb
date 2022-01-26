require 'rails_helper'

describe API::Base, type: :request do
  let(:user) { FactoryBot.create(:user, deposit: 10) }

  context 'when logged in' do
    before { login_with_api(user) }

    context 'when user is seller' do
      let(:user) { FactoryBot.create(:user, deposit: 10, role: 'seller') }

      describe 'POST /api/v1/reset' do
        before do        
          put '/api/v1/reset', headers: { 'Authorization': response.headers['Authorization'] }
        end

        context 'when depositing a valid amount' do
          it 'returns 200' do
            expect(response.status).to eq(200)
          end

          it 'increases deposit of user' do
            user.reload

            expect(user.deposit).to eq(0)
          end
        end
      end
    end

    context 'when user is buyer' do
      describe 'POST /api/v1/reset' do
        before do        
          put '/api/v1/reset', headers: { 'Authorization': response.headers['Authorization'] }
        end

        context 'when depositing a valid amount' do
          it 'returns 200' do
            expect(response.status).to eq(200)
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
    describe 'POST /api/v1/reset' do
      it 'returns 401' do
        post '/api/v1/reset'

        expect(response.status).to eq(401)
      end
    end
  end
end
