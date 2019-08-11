class SessionsController < ApplicationController
  def new
  end
  def create
    auth = request.env["omniauth.auth"]
    if auth.present?
      unless @auth = Authorization.find_from_auth(auth)
      @auth = Authorization.create_from_auth(auth)
      end
      #登場のログイン処理
      # user = @auth.user
      # redirect_back_or user
      session[:user_id] = @auth.user_id
      flash[:success] = 'ログインしました。'
      redirect_to root_path
    else
      user = User.find_by(email: session_params[:email])
      if user&.authenticate(session_params[:password])
        session[:user_id] = user.id
        flash[:success] = 'ログインしました。'
        redirect_to root_path
      else
        flash[:danger] = 'ログインに失敗しました。'
        render :new
      end
    end
  end

  # def create
  #   user = User.find_by(email: session_params[:email])
  #   if user&.authenticate(session_params[:password])
  #     session[:user_id] = user.id
  #     flash[:success] = 'ログインしました。'
  #     redirect_to root_path
  #   else
  #     flash[:danger] = 'ログインに失敗しました。'
  #     render :new
  #   end
  # end

  def destroy
    reset_session
    flash[:info] = 'ログアウトしました。'
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
