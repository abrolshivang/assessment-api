class Api::V1::PostsController < ApplicationController
  before_action :authenticate!, except: %i[index show]
  before_action :authorize_post, only: %i[update destroy]

  # GET /api/v1/posts.json
  def index
    @posts = Post.all
  end

  # GET /api/v1/posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  # POST /api/v1/posts.json
  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      render :show, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/posts/1.json
  def update
    if @post.update(post_params)
      render :show, status: :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/posts/1.json
  def destroy
    @post.destroy
  end

  private

  def authorize_post
    @post = current_user.posts.where(id: params[:id])
   
    render(json: { msg: I18n.t('unauthorized') }, status: :unauthorized) && return unless @post
  end

  def post_params
    params.require(:post).permit(:title, :uri, :user_id)
  end
end
