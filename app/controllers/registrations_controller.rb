class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    def create
        @user = User.new(registration_params)
        @user.save

        respond_with(resource)
    end

    private

    def registration_params
        params.require(:user).permit(:email, :name, :password, :password_confirmation)
    end

    def respond_with(resource, _opts = {})
        resource.persisted? ? register_success : register_failed
    end
    def register_success
        render json: { message: 'Signed up.', user: @user }
    end
    def register_failed
        render json: { message: "Sign up failure." }
    end
end
