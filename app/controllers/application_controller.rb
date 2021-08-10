class ApplicationController < ActionController::API
    def hello
        render :json => {message: "Hello world !"}
    end
    
end
