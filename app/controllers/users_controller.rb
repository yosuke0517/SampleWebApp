class UsersController < ApplicationController
  protect_from_forgery except: :create

  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @questions = @user.questions.where(user_id: @user)
    @answers = Answer.includes(:question).where(user_id: @user).uniq
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    # Entryモデル：どのUserがどのRoomに所属しているか
    # ユーザの詳細を取得した際に自分自身でない時DMをするためのRoomとEntryを確保する
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
    # @user = User.includes(:questions, :answers).find(params[:id])
    @followings = @user.followings.page(params[:page])
    @followers = @user.followers.page(params[:page])
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
      redirect_to root_path
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
      redirect_to user_path(@user)
    else
      flash[:danger] = '質問の更新に失敗しました。'
      render :edit
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :provider)
  end
end
