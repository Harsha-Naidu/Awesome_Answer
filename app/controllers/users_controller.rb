# rails g controller Users
class UsersController < ApplicationController
    def new
        @user=User.new
    end

    def create
        @user=User.new user_params
        if @user.save
            session[:user_id]=@user.id # we are storing the user id alone in the session 
            redirect_to root_path, notice: "Logged in Successfully!"
        else
            render :new
        end
    end


    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
