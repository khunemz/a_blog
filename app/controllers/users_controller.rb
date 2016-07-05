class UsersController < ApplicationController
  before_action :require_same_user , only: [ :edit , :update ,:destroy]
  # before_action :require_user, except: [:new]
  before_action :set_user, only: [:show , :edit , :update, :destroy]
  def new
    @user = User.new
  end

  def show
      @user_articles = @user.articles.order(created_at: :desc)
      .paginate(page: params[:page] , per_page: 20)
  end

  def create
    @user = User.new(user_params)
    if @user.save
        redirect_to new_session_path, notice: 'ขอบคุณที่ลงทะเบียนกับเราครับ'
    else
        render :new, notice: 'โอะโอวว มีบางอย่างผิดพลาด กรุณาลองอีกครั้ง'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user) , notice: 'แก้ไขข้อมูลผู้ใช้เรียบร้อยแล้ว'
    else
      render :edit , notice: 'มีบางอย่างผิดพลาด กรุณาลองอีกครั้ง'
    end
  end

  def destroy
    if @user.destroy
      redirect_to new_user_path , notice: 'ลบผู้ใช้งานออกเรียบร้อย'
    else
      render user_path(@user) , notice: 'มีบางอย่างผิดพลาด กรุณาลองอีกครั้ง'
    end

  end

  private
  def set_user
    @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
  end

  def user_params
    params.require(:user).permit(:name, :email , :password, :password_confirmation)
  end

  def require_same_user
    if current_user != set_user
      redirect_to user_path(set_user) , notice: 'ทำไม่ได้ครับ คุณต้องทำกับบัญชีคุณเท่านั้น'
    end
  end
end
