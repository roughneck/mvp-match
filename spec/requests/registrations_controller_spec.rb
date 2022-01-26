require 'rails_helper'

describe Users::RegistrationsController, type: :request do
  let(:user) { FactoryBot.build(:user) }
  let(:existing_user) { FactoryBot.create(:user) }
  let(:password) { 'some-password-123' }

  context 'when creating a new user' do
    before do
      post '/users', params: {
        user: {
          email: user.email,
          password: password,
          username: user.username,
          role: user.role
        }, as: :json
      }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns Authorization token' do
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns error message' do
      expect(response.body).to include('Sign up successful.')
    end
  end

  context 'when an email already exists' do
    before do
      post '/users', params: {
        user: {
          email: existing_user.email,
          password: password,
          username: existing_user.username,
          role: existing_user.role
        }, as: :json
      }
    end

    it 'returns 400' do
      expect(response.status).to eq(400)
    end
  end
end
