class ArticlesController < ApplicationController
   before_action :require_same_user , only: [ :edit , :update ,:destroy]
  before_action :require_user, except: [:index , :show]
  before_action :set_article , :only => [:show , :edit , :update, :destroy]
  def index
    @articles = Article.order(created_at: :desc).paginate(page: params[:page],per_page: 20)
    rescue ActiveRecord::RecordNotFound
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      redirect_to article_path(@article), notice: 'สร้างบล๊อกเรียบร้อยแล้ว'
    else
      render :new, notice: 'ม่ายนะ !! มีบางอย่างผิดพลาด กรุณาลองใหม่อีกครั้ง'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to article_path(@article), notice: 'อัพเดทกระทู้เรียบร้อยแล้ว'
    else
      render :edit , notice: 'อื้มมม ไม่สามารถอัพเดทได้ ลองใหม่อีกครั้งนะ'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: 'ลบกระทู้เรียบร้อยแล้ว'
  end

  private
  def set_article
    @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

   def require_same_user
    if current_user != @article.user
      redirect_to root_path , notice: 'ทำไม่ได้ครับ '
    end
  end
end
