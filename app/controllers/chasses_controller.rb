class ChassesController < ApplicationController
  before_filter :authenticate
  before_action :set_chass, only: [:show, :edit, :update, :destroy]

  # GET /chasses
  # GET /chasses.json
  def index
    @msales = Msale.all
  end

  # GET /chasses/1
  # GET /chasses/1.json
  def show
  end

  # GET /chasses/new
  def new
    @chass = Chassis.new
  end

  # GET /chasses/1/edit
  def edit
  end

  # POST /chasses
  # POST /chasses.json
  def create
    @chass = Chassis.new(chass_params)

    respond_to do |format|
      if @chass.save
        format.html { redirect_to @chass, notice: 'Chassis was successfully created.' }
        format.json { render :show, status: :created, location: @chass }
      else
        format.html { render :new }
        format.json { render json: @chass.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chasses/1
  # PATCH/PUT /chasses/1.json
  def update
    respond_to do |format|
      if @chass.update(chass_params)
        format.html { redirect_to @chass, notice: 'Chassis was successfully updated.' }
        format.json { render :show, status: :ok, location: @chass }
      else
        format.html { render :edit }
        format.json { render json: @chass.errors, status: :unprocessable_entity }
      end
    end
  end

  def get
    @datas = MsaleDetail.where(msale_id: params["id"], msaleable_type: "Machine")
  end
  # DELETE /chasses/1
  # DELETE /chasses/1.json
  def destroy
    @chass.destroy
    respond_to do |format|
      format.html { redirect_to chasses_url, notice: 'Chassis was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chass
      @chass = Chassis.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chass_params
      params.require(:chass).permit(:msale_id, :msale_detail_id, :chassisnum)
    end
end
