class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :show, :delete]
  before_action :authenticate_admin!, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :body))

    if @post.save
      flash[:notice] = "Successfully created post!"
      redirect_to @post
    else
      flash[:alert] = "Error creating new post!"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_param)
      flash[:notice] = "Successfully updated post!"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Error updaing post!"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:notice] = "Successfully deleted post!"
      redirect_to root_path
    else
      flash[:alert] = "Error updating post!"
    end
  end

  private

  def post_param
    params.require(:post).permit(:title, :body)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
