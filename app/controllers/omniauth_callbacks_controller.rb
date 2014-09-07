class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    
  def facebook
    @user = User.from_omniauth(auth)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      if !User.where(email: @user.email).empty?
        set_flash_message(:devise_alert, :failure, kind: "Facebook", reason: "the email is already in use") 
      end
      session["devise.email"] = auth.info.email
      redirect_to new_user_registration_url
    end
  end

  def twitter
    @user = User.from_omniauth(auth)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Twitter") if is_navigational_format?
    else
      if !User.where(email: @user.email).empty?
        # We shouldn't end up here for Twitter since we use dummy emails but just in case.
        set_flash_message(:devise_alert, :failure, kind: "Twitter", reason: "the email is already in use") 
      end
      session["devise.email"] = "#{auth.info.nickname}@twitter.com"
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    @user = User.from_omniauth(auth)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    else
      if !User.where(email: @user.email).empty?
        # We shouldn't end up here for Twitter since we use dummy emails but just in case.
        set_flash_message(:devise_alert, :failure, kind: "Google", reason: "the email is already in use") 
      end
      set_flash_message(:devise_alert, :failure, kind: "Google", reason: "the email is already in use") 
      session["devise.email"] = auth.info.email
      redirect_to new_user_registration_url
    end
  end
  
  def auth
    request.env["omniauth.auth"]
  end
end