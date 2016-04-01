class NeedlesController < ApplicationController
  before_action :set_needle, only: [:show, :edit, :update, :destroy]

  # GET /needles
  # GET /needles.json
  def index
    @needles = Needle.all
  end

  # GET /needles/1
  # GET /needles/1.json
  def show
  end

  # GET /needles/new
  def new
    @needle = Needle.new
  end

  # GET /needles/1/edit
  def edit
  end

  # POST /needles
  # POST /needles.json
  def create
    @needle = Needle.new(needle_params)
    @needle.qty = 0
    respond_to do |format|
      if @needle.save
        format.html { redirect_to needles_path, notice: 'Needle was successfully created.' }
        format.json { render :show, status: :created, location: @needle }
      else
        format.html { render :new, locals: {objects: params[:category]} }
        format.json { render json: @needle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /needles/1
  # PATCH/PUT /needles/1.json
  def update
    respond_to do |format|
      if @needle.update(needle_params)
        format.html { redirect_to needles_path, notice: 'Needle was successfully updated.' }
        format.json { render :show, status: :ok, location: @needle }
      else
        format.html { render :edit }
        format.json { render json: @needle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /needles/1
  # DELETE /needles/1.json
  def destroy
    @needle.destroy
    respond_to do |format|
      format.html { redirect_to needles_url, notice: 'Needle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_needle
      @needle = Needle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def needle_params
      params.require(:needle).permit(:model, :category, :size, :machine_id, :stock, :qty, :price)
    end
end
