class BlogsController < ApplicationController

  before_action :move_to_index, except: :index

  def index
    @blogs = Blog.order("created_at DESC").page(params[:page]).per(5)
  end

  def new
  end

  def create
    @blog = Blog.new(text: blog_params[:text], user_id: current_user.id)
    if @blog.save
      redirect_to root_path, notice: '投稿が完了しました'
    else
      redirect_to new_blog_path, alert: "本文を入力してください"
    end
  end

  def destroy
    blog = Blog.find(params[:id])
    blog.destroy if blog.user_id == current_user.id
    redirect_to root_path, notice: '削除が完了しました'
  end

  def edit
    @blog = Blog.find(params[:id])
  end
  
  def update
    blog = Blog.find(params[:id])
    blog.update(blog_params)if blog.user_id == current_user.id
    redirect_to root_path, notice: '編集が完了しました'
  end

  private
  def blog_params
    params.permit(:text)
  end

  def move_to_index
    redirect_to action: "index" unless user_signed_in?
  end

end
