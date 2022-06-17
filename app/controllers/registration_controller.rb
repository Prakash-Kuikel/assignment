class RegistrationController < Devise::RegistrationsController
    def create
        @user = User.new(registration_params)
        @user.save

        render json: @user
    end

    private

    def registration_params
        params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end
end
