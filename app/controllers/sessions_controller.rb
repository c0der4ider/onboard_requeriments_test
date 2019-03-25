class SessionsController < ApplicationController

  # Create session for user by callback from Google, in this case login with Google Account (Oauth2 system).
  #
  def create
    # First check if exist with UID params from response from login.
    user = User.from_omniauth(request.env["omniauth.auth"])

    if user.present?
      # If not exists, create a user, saving UID and name from Google Account. Then, set params session.
      session[:user] = Marshal.dump(user).force_encoding('ISO-8859-1').encode('UTF-8')
      flash[:info] = "Haz iniciado tu sesión con éxito."
      redirect_to root_path
    else
      flash[:alert] = "No se ha encontrado ningun usuario asociado a la cuenta."
      redirect_to root_path
    end
  end

  # Destroy sessions params loaded in system.
  #
  # * *Returns (output)* :
  # - redirection to root page (main page). Session params deleted.
  #
  def destroy
    session.delete :user
    redirect_to root_path
  end

end
