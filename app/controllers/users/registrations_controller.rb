module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    private

    def respond_with(resource, _opts = {})
      resource.persisted? ? register_success : register_failed
    end

    def register_success
      render json: { message: 'Sign up successful.' }
    end

    def register_failed
      render json: { message: 'Sign up failed.', errors: resource.errors.full_messages }, status: 400
    end

    def sign_up_params
      params.require(:user).permit(:email, :password, :username, :role)
    end
  end
end
