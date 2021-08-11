class MicropostsController < ApplicationController

    def index
        render json: Micropost.all
    end

    def show
        @user = User.find(params[:id])
        @microposts = @user.microposts
        render json: @microposts
    end

    def create
        @user = User.find(id_for_publication)
        @micropost = @user.microposts.build(micropost_params)
        if @micropost.save
            render json: {message: "Post crée avec succes"}  
        else
            render json: {message: "Post non crée"}  
        end 
    end

    def update
        @micropost = Micropost.find(params[:id])
        if id_for_publication === @micropost.user_id # ajouter droit admin
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
        if id_for_publication === @micropost.user_id # ajouter droit admin
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
