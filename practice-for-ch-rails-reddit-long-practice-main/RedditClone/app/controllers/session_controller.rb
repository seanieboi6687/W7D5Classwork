class SessionController < ApplicationController


    def new 
        @user = User.new 
        render :new

    end


    def create

        @user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
            )

        if @user
            login!(@user)
            redirect_to user_url
        else
            flash.now[:errors] = ['Invalid username/password']
            @user = User.new(username: params[:user][:username])
            render :new
        end

    end
    

    def destroy
        logout!
        redirect_to new_session_url

    end
end
