class GoompsController < ApplicationController
  before_action :set_goomp, only: [:edit, :update, :destroy, :join]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /goomps
  # GET /goomps.json
  def index
    @goomps = Goomp.includes(:memberships, :user).page(params[:page])
    @joined_goomps = current_user&.joined_goomps || []
  end

  # GET /goomps/1
  # GET /goomps/1.json
  def show
    @goomp = Goomp.friendly.find(params[:id])

    @subtopics = @goomp.subtopics
    @posts = FeedQuery.new(posts: @goomp.posts, page: params[:page]).posts
    @posts = @posts.where(subtopic_id: params[:subtopic_id]) if params[:subtopic_id]

    respond_to do |f|
      f.html do
        set_meta_tags(
          title: @goomp.name,
          description: @goomp.description,
          og: {
            image: @goomp.cover
          },
          url: goomp_url(@goomp)
        )
        render layout: 'pages'

      end
      f.js { render "posts/infinite_posts" }
    end
  end

  def join
    current_user.join @goomp, params[:token]
  end

  # GET /goomps/new
  def new
    @goomp = Goomp.new logo: ActionController::Base.helpers.asset_path("logo-v.png")
  end

  # GET /goomps/1/edit
  def edit
  end

  # POST /goomps
  # POST /goomps.json
  def create
    @goomp = current_user.goomps.new(goomp_params)

    if @goomp.save
      current_user.memberships.create goomp: @goomp
      StripeService.create_plan_for @goomp
      redirect_to @goomp, notice: 'Goomp was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /goomps/1
  # PATCH/PUT /goomps/1.json
  def update
    respond_to do |format|
      if @goomp.update(goomp_params)
        format.html { redirect_to @goomp, notice: 'Goomp was successfully updated.' }
        format.json { render :show, status: :ok, location: @goomp }
      else
        format.html { render :edit }
        format.json { render json: @goomp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goomps/1
  # DELETE /goomps/1.json
  def destroy
    # @goomp.destroy
    # respond_to do |format|
    #   format.html { redirect_to goomps_url, notice: 'Goomp was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goomp
      @goomp = Goomp.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goomp_params
      params.require(:goomp).permit(:name, :cover, :slug, :price, :description, :memberships_count, :user_id, :logo)
    end
end
