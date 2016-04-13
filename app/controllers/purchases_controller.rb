class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]

  # GET /purchases
  # GET /purchases.json
  def index
    @purchases = Purchase.all
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new 
  end

  # GET /purchases/1/edit
  def edit
  end

  # POST /purchases
  # POST /purchases.json
  def create
    @purchase = Purchase.new(purchase_params)

    respond_to do |format|
      if @purchase.save
        format.html { redirect_to @purchase, notice: 'Purchase was successfully created.' }
        format.json { render :show, status: :created, location: @purchase }
      else
        format.html { render :new }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchases/1
  # PATCH/PUT /purchases/1.json
  def update
    respond_to do |format|
      if @purchase.update(purchase_params)
        format.html { redirect_to @purchase, notice: 'Purchase was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    @purchase.destroy
    respond_to do |format|
      format.html { redirect_to purchases_url, notice: 'Purchase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def machine
    @machines = Machine.all
  end

  def part
    @parts = Part.all
  end

  def needle
    @needles = Needle.all
  end

  def motor
    @motors = Motor.all
  end

  def table
    @tables = Table.all
  end

  def stand
    @stands = Stand.all
  end

  def add_cart
    session[:purchase_cart] ||= []
    if Purchase.valid_category(params[:category])
      session[:purchase_cart] = Purchase.add_to_cart(session[:purchase_cart], params[:category], params[:id])
      redirect_to Purchase.valid_url(params[:category]), notice: "Operation success #{session[:purchase_cart]}"
    else
      redirect_to root_path, notice: "Invalid operation perform on Purchase cart."      
    end
  end
  
  def cart
    #@session = Purchase.get_items(session[:purchase_cart])
    #@session = session[:purchase_cart]
    # get by category then id
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
      params.require(:purchase).permit(:name, :address, :nic, :phone, :total)
    end

end
