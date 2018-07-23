class UsersController < ApplicationController
  def sign_in
    user = User.find_by_email(params['email'].downcase)
    return status_422(nil, [message: 'Email or Password is uncorrect.']) if user.nil?
    return status_422(nil, [message: 'Email or Password is uncorrect.']) unless user.valid_password?(params['password'])
    # user.authentication_token = Devise.friendly_token()
    # user.authentication_token_time = Time.now() 
    # user.refresh_token = Devise.friendly_token()
    # user.refresh_token_time = Time.now()
    # user.save()
    # response.headers['Authorization'] = "Basic #{user.authentication_token}"
    session[:user_id] = user.id
    json_response({message: 'Login success.', user_id: user.id})
  end

  def sign_out
    session[:user_id] = nil
    json_response({message: 'Already sign out.'})
  end

  def create
    return status_422(nil, [{field: [:password, :password_confirmation], message: "password_confirmation can't be blank"}]) unless params[:user][:password_confirmation].present?
    return status_422(nil, [{field: [:password, :password_confirmation], message: "The values should be same."}]) unless params[:user][:password] == params[:user][:password_confirmation]
    json_response({user: User.create!(sign_up_params)})
  end
  



  private
  def sign_up_params
    params.require(:user).permit(:email, :password)
  end
end
