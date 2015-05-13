class PostsController < ApplicationController
  before_action :authorize_administrator,  only: [:new, :create, :edit, :update, :destroy]
  
  def index
    @posts = Post.paginate(page: params[:page], per_page: 10) 
  end

  def create
    @post = Post.new(user: current_user)   
    super
  end

  def update
    @post = Post.find(params[:id])
    @post.user = current_user
    super
  end
    
  private
    def resource_params
      params.require(:post).permit(:title, :content)
    end
    
end
