class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		session[:user_id] = user.id
  		redirect_to user_path(user), notice: 'ลงชื่อเข้าใช้สำเร็จ ยินดีต้อนรับกลับมาครับ'
  	else
  		render :new, notice: 'ลงชื่อเข้าใช้ผิดพลาด กรุณาลองใหม่อีกครั้ง'
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to new_session_path , notice: 'ลงชื่อออกสำเร็จ'
  end
end
