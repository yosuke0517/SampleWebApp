class UsersController < ApplicationController
  protect_from_forgery except: :create

  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    # 戻るボタンの時new画面へ遷移する
    if params[:back].present?
      render :new
      return
    end

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def confirm_new
    # 入力されたユーザを作成しバリデーションを確認
    @user = User.new(user_params)
    render :new unless @user.valid?
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = '質問を更新しました。'
      redirect_to user_path(current_user)
    else
      flash[:danger] = '質問の更新に失敗しました。'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
end
