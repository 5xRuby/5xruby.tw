class Admin::AuthorsController < AdminController
  before_action :set_admin_author, only: [:show, :edit, :update, :destroy]

  # GET /admin/authors
  # GET /admin/authors.json
  def index
    @admin_authors = Admin::Author.all.order('id DESC').page(params[:page])
  end

  # GET /admin/authors/1
  # GET /admin/authors/1.json
  def show
  end

  # GET /admin/authors/new
  def new
    @admin_author = Admin::Author.new
  end

  # GET /admin/authors/1/edit
  def edit
  end

  # POST /admin/authors
  # POST /admin/authors.json
  def create
    @admin_author = Admin::Author.new(admin_author_params)

    respond_to do |format|
      if @admin_author.save
        format.html { redirect_to @admin_author, notice: t('crud.created_successfully!', name: Admin::Author.model_name.human) }
        format.json { render :show, status: :created, location: @admin_author }
      else
        format.html { render :new }
        format.json { render json: @admin_author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/authors/1
  # PATCH/PUT /admin/authors/1.json
  def update
    respond_to do |format|
      if @admin_author.update(admin_author_params)
        format.html { redirect_to @admin_author, notice: t('crud.updated_successfully!', name: Admin::Author.model_name.human) }
        format.json { render :show, status: :ok, location: @admin_author }
      else
        format.html { render :edit }
        format.json { render json: @admin_author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/authors/1
  # DELETE /admin/authors/1.json
  def destroy
    @admin_author.destroy
    respond_to do |format|
      format.html { redirect_to admin_authors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_author
      @admin_author = Admin::Author.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_author_params
      params.require(:admin_author).permit(:name)
    end
end
