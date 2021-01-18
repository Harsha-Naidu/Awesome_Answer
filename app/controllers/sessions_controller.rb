#rails g controller sessions
class SessionsController < ApplicationController
    def new

    end

    def create
                
        @user = User.find_by_email params[:email]
        if  @user && @user.authenticate(params[:password])
            # authenticate is a method created by has_secure_password in a User model behind the scene
            # this mehtod takes the password convert it in to an encrypted hash 
            # in a same manner as it did while signing up user, and then compare it with password digest in a db. 
            # it will return true in case the hash is matched else false.
            session[:user_id]=@user.id
            # The 👆🏻'session' is an object usable in a controller that uses cookies to store encrypted data.
            # To sign in a user, we store their user_id in the session for later use or retreival
            redirect_to root_path, notice: 'Logged in'
        else
            flash[:alert]= 'Wrong email or password.'
            render :new
        end

    end

    def destroy
        session[:user_id]=nil
        redirect_to root_path, notice: 'Logged Out!'
    end


end
