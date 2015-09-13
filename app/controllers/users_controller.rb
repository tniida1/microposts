class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  def show # 追加
      @user = User.find(params[:id])
  end
  
  def new
    @user = User.new  
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    if current_user != @user
    # キャッシュのIDと、URLパラメータのIDが一致している場合のみ表示
    # 一致していない場合、notice付きでshowに戻す、を書く予定。
    # URLを直接叩くと誰でも更新できてしまうため、それを防止する
      flash[:info] = 'ユーザ情報を更新するにはログインしてください'
      redirect_to action: 'show'
    end
  end
  
  def update
    if @user.update(user_params)
      #保存に成功した場合はshowページへリダイレクト？
      flash[:info] = 'ユーザ情報を更新しました'
      redirect_to action: 'show'
    else
      #保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :introduction, :locationtext,
                                 :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
