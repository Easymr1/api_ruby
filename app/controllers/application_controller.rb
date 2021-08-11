class ApplicationController < ActionController::API
    private
    def token(user_id, user_name, user_email)
      exp = Time.now.to_i + 4 * 3600
      payload = { user_id: user_id, user_name: user_name, user_email: user_email}
      JWT.encode(payload, hmac_secret, 'HS256')
    end
  
    def hmac_secret
      ENV["API_SECRET"]
    end
  
    def client_has_valid_token?
      !!current_user_id
    end

    def id_for_publication
      current_user_id
    end
  
    def current_user_id
      begin
        token = request.headers["Authorization"].split(' ')[1]
        decoded_array = JWT.decode(token, hmac_secret, true, { algorithm: 'HS256' })
        payload = decoded_array.first
      rescue #JWT::VerificationError
        return nil
      end
      payload["user_id"]
    end
  
    def require_login
      render json: {error: 'Unauthorized'}, status: :unauthorized if !client_has_valid_token?
    end
end
