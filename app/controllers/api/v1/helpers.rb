module API
  module V1
    module Helpers

      extend Grape::API::Helpers

      def user_authenticated?
        warden.authenticate!

        if warden.authenticated?
          return true
        else
          error!('401 Unauthorized', 401)
        end
      end

      def warden
        env['warden']
      end

      def current_user
        warden.user
      end
    end
  end
end
