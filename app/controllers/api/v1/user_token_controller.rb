module Api
  module V1
    class UserTokenController < Knock::AuthTokenController
      skip_before_action :verify_authenticity_token, raise: false

      def user_params
        params.require(:user).permit(:email, :nickname, :password, :password_confirmation)
      end

    end
  end
end