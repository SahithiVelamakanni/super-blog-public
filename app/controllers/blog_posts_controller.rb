class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :admin_only, only: [:edit, :update, :destroy, :manage_positions, :update_positions]

  # GET /blog_posts or /blog_posts.json
  def index
      @q = BlogPost.ransack(params[:q])
      @blog_posts = @q.result(distinct: true)

  end

  # GET /blog_posts/1 or /blog_posts/1.json
  def show
  end

  # GET /blog_posts/new
  def new
    @blog_post = BlogPost.new
  end

  # GET /blog_posts/1/edit
  def edit
  end

  # POST /blog_posts or /blog_posts.json
  def create
    @blog_post = BlogPost.new(blog_post_params)
  
    if params[:blog_post][:image].present?
      @blog_post.image.attach(params[:blog_post][:image])
    end
  
    respond_to do |format|
      if @blog_post.save
        format.html { redirect_to @blog_post, notice: 'Blog post was successfully created.' }
        format.json { render :show, status: :created, location: @blog_post }
      else
        format.html { render :new }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # PATCH/PUT /blog_posts/1 or /blog_posts/1.json
  def update
    respond_to do |format|
      if @blog_post.update(blog_post_params)
        format.html { redirect_to blog_post_url(@blog_post), notice: "Blog post was successfully updated." }
        format.json { render :show, status: :ok, location: @blog_post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blog_posts/1 or /blog_posts/1.json
  def destroy
    @blog_post.destroy

    respond_to do |format|
      format.html { redirect_to blog_posts_url, notice: "Blog post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def manage_positions
    @blog_posts = BlogPost.order(:position)
  end

  def update_positions
    params[:positions].each_with_index do |id, index|
      BlogPost.where(id: id).update_all(position: index + 1)
    end
    redirect_to blog_posts_path, notice: "Positions updated."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog_post
      @blog_post = BlogPost.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_post_params
      params.require(:blog_post).permit(:title, :content, :user_id,:user,:rating,:image)
    end

    def admin_only
      redirect_to(root_path, alert: "Not authorized") unless current_user.admin?
    end
end
