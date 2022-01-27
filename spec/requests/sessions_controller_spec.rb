require 'rails_helper'

describe Users::SessionsController, type: :request do
  let(:existing_user) { FactoryBot.create(:user, password: password) }
  let(:password) { 'some-password-123' }

  context 'when user exists' do
    before do
      post '/users/sign_in', params: {
        user: {
          email: existing_user.email,
          password: password
        }
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns Authorization token' do
      expect(response.headers['Authorization']).to be_present
    end
  end
end
