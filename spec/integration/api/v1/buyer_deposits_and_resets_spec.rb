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

      describe 'resets deposit' do
        before do
          put '/api/v1/reset', headers: { Authorization: bearer_token }
        end

        it "resets user's deposit" do
          expect(signed_up_user.deposit).to eq 0
        end
      end
    end
  end
end
