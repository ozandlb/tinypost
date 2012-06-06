module SessionsHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    current_user = user
  end #sign_in(user)

  def signed_in?
    !current_user.nil?
  end #signed_in?

  def current_user=(user)
    @current_user = user
  end #current_user=(user)

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end #current_user

  def current_user?(user)
    user == current_user
  end #current_user?(user)

  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end # sign_out

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end #redirect_back_or(default)

  def store_location
    session[:return_to] = request.fullpath
  end #store_location

end