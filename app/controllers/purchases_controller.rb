class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]

  # GET /purchases
  # GET /purchases.json
  def index
    @purchases = Purchase.order(created_at: :DESC)
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show 
    @purchase_details = PurchaseDetail.where(purchase_id: @purchase.id) 
  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new 
    @datas = Purchase.get_items(session[:purchase_cart])
    @total = get_total(session[:purchase_cart])
  end

  # GET /purchases/1/edit
  def edit
  end

  # POST /purchases
  # POST /purchases.json
  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.total = get_total(session[:purchase_cart])

    respond_to do |format|
      if @purchase.save
        
        session[:purchase_cart].each do |item|
          @purchase_detail = PurchaseDetail.new 
          @purchase_detail.purchase_id = @purchase.id
          @purchase_detail.stockable_id = item["id"]
          @purchase_detail.stockable_type = item["category"]
          @purchase_detail.qty = item["qty"]
          @purchase_detail.price = item["price"] 
          if @purchase_detail.save
            case @purchase_detail.stockable_type
            when "Machine"
              @machine = Machine.find(@purchase_detail.stockable_id)
              qty = @machine.qty
              qty += @purchase_detail.qty 
              @machine.update(:qty => qty)
            when "Part"
              @part = Part.find(@purchase_detail.stockable_id)
              qty = @part.qty
              qty += @purchase_detail.qty 
              @part.update(:qty => qty)
            when "Needle"
              @needle = Needle.find(@purchase_detail.stockable_id)
              qty = @needle.qty
              qty += @purchase_detail.qty 
              @needle.update(:qty => qty)
            when "Motor"
              @motor = Motor.find(@purchase_detail.stockable_id)
              qty = @motor.qty
              qty += @purchase_detail.qty 
              @motor.update(:qty => qty)
            when "Table"
              @table = Table.find(@purchase_detail.stockable_id)
              qty = @table.qty
              qty += @purchase_detail.qty 
              @table.update(:qty => qty)
            when "Stand"
              @stand = Stand.find(@purchase_detail.stockable_id)
              qty = @stand.qty
              qty += @purchase_detail.qty 
              @stand.update(:qty => qty)
            end
          else
            format.html { render :new }
            format.json { render json: @purchase.errors, status: :unprocessable_entity }
          end
          session.delete(:purchase_cart)
          format.html { redirect_to @purchase, notice: 'Purchase was successfully created.' }
          format.json { render :show, status: :created, location: @purchase }
        end        
        
      else
        format.html { render :new }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end

  end #end of create

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
    @machines = filter_in_session(session[:purchase_cart], Machine,"Machine")
  end

  def part
    @parts = filter_in_session(session[:purchase_cart], Part, "Part")
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
    if Purchase.valid_get_params(params[:category],params[:id])
      session[:purchase_cart] = Purchase.add_to_cart(session[:purchase_cart], params[:category], params[:id])
      redirect_to Purchase.valid_url(params[:category]), notice: "Operation success"
    else
      redirect_to root_path, notice: "Invalid operation perform on Purchase cart."      
    end
  end
  
  def cart 
    # get the :name for better presentation 
    @datas = Purchase.get_items(session[:purchase_cart])
    @total = get_total(session[:purchase_cart])
    
  end

  def update_cart
    session[:purchase_cart].each do |stuff| 
      stuff["price"] = params["p"+stuff["category"]+stuff["id"]] unless params["p"+stuff["category"]+stuff["id"]] == nil 
      stuff["qty"] = params["q"+stuff["category"]+stuff["id"]] unless params["p"+stuff["category"]+stuff["id"]] == nil
    end
    redirect_to purchase_cart_url, notice: "Updated - operation success"
  end

  def remove_cart 
    if Purchase.valid_get_params(params[:category],params[:id])
      session[:purchase_cart] = Purchase.delete_item(session[:purchase_cart], params[:category], params[:id])
      unless session[:purchase_cart].nil? || session[:purchase_cart].empty?
        redirect_to purchase_cart_path, notice: "Operation success" 
      else
        redirect_to Purchase.valid_url(params[:category]), notice: "Operation success"
      end
    else
      redirect_to root_path, notice: "Invalid operation perform on Purchase cart."      
    end
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

    # give total number for cart, can't save on session
    def get_total(session)
      total = 0
      session.each do |item|
        total += item["qty"].to_i * item["price"].to_i
      end
      total
    end

    # Those item which already in session should not display in purchase order page
    def filter_in_session(session, model, model_text)
      ids = []
      unless session.nil? || session.empty? 
        session.each do |detail|
          if detail['category'] == model_text
            ids << detail["id"]
          end
        end #do end
      end # unless end
      model.where.not(id: ids)
    end
end
