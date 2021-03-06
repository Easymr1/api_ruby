class MicropostsController < ApplicationController

    def index
        if client_has_valid_token?
            @Micropost = Micropost.select('microposts.*, users.name').joins(:user)
            render json: @Micropost
            

        else
            require_login
        end
    end

    def show
        if client_has_valid_token?
            @microposts = Micropost.find(params[:id])
            render json: @microposts
        else
            require_login
        end
    end

    def create
        if client_has_valid_token?
            @user = User.find(user_id_token)
            @micropost = @user.microposts.build(micropost_params)
            if @micropost.save
                render json: {message: "Post crée avec succes"}  
            else
                render json: {message: "Post non crée"}  
            end
        else
            require_login
        end
    end

    def update
        @micropost = Micropost.find(params[:id])
        if user_id_token === @micropost.user_id || is_admin
            if @micropost.update(micropost_params)
                render json: {message: "modification réussi !"}
            else
                render json: {message: "modification échouer !"}
            end
        else
            render json: { message: "Se n'est pas votre post" }
        end
    end

    def destroy
        @micropost = Micropost.find(params[:id])
        if user_id_token === @micropost.user_id || is_admin
            if @micropost.destroy
                render json: {message: "Micropost supprimer !"}
            else
                render json: {message: "Micropost non supprimer !"}
            end
        else
            render json: { message: "Se n'est pas votre post" }
        end
    end

    private

    def micropost_params
      params.require(:micropost).permit(:content)
    end
end
