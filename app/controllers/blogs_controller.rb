class BlogsController < ApplicationController

  before_action :move_to_index, except: :index

  def index
    @blogs = Blog.all
  end

  def new
  end

  def create
    Blog.create(text: blog_params[:text], user_id: current_user.id)
    redirect_to root_path, notice: '投稿が完了しました'
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
  end


  private
  def blog_params
    params.permit(:text)
  end

  def move_to_index
    redirect_to action: "index" unless user_signed_in?
  end

end
