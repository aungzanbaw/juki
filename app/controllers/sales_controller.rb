class SalesController < ApplicationController
  before_filter :authenticate_staff, except: :show
  before_action :set_sale, only: [:show, :edit, :update, :destroy,:print]

  # GET /sales
  # GET /sales.json
  def index
    @sales = Sale.all
  end

  # GET /sales/1
  # GET /sales/1.json
  def show
    @sale_details = SaleDetail.where(sale_id: @sale.id) 
  end

  def print
    @sale_details = SaleDetail.where(sale_id: params[:id]) 
  end

  # GET /sales/new
  def new
    @sale = Sale.new 
    @datas = Sale.get_items(session[:sale_cart])
    @total = get_total(session[:sale_cart])
  end

  # GET /sales/1/edit
  def edit
  end

  # POST /sales
  # POST /sales.json 

  def create
    @sale = Sale.new(sale_params)
    @sale.total = get_total(session[:sale_cart])
    @sale.tax = 0 
    @sale.staff_id = session[:staff]
    if @sale.cash 
      if @sale.cash < @sale.total
        @sale.postpone = true
      else @sale.cash == @sale.total
        @sale.postpone = false
      end
    else
      @sale.postpone = false
    end 
    @sale.currency_id = Currency.last.id
    respond_to do |format|
      if @sale.save
         
        session[:sale_cart].each do |item|
          @sale_detail = SaleDetail.new 
          @sale_detail.sale_id = @sale.id
          @sale_detail.itemable_id = item["id"]
          @sale_detail.itemable_type = item["category"]
          @sale_detail.qty = item["qty"] 

          if @sale_detail.save
            
            case @sale_detail.itemable_type  
            when "Part"
              @part = Part.find(@sale_detail.itemable_id)
              qty = @part.qty
              qty -= @sale_detail.qty 
              @part.update(:qty => qty)
            when "Needle"
              @needle = Needle.find(@sale_detail.itemable_id)
              qty = @needle.qty
              qty -= @sale_detail.qty 
              @needle.update(:qty => qty)
            end
            
          else
            format.html { render :new }
            format.json { render json: @sale.errors, status: :unprocessable_entity }
          end
          session.delete(:sale_cart)
          format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
          format.json { render :show, status: :created, location: @sale }
        end  
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Sale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def part
    @parts = filter_in_session(session[:sale_cart], Part.where.not("price <= 0 AND qty <= 0"),"Part")
  end

  def needle
    @needles = filter_in_session(session[:sale_cart], Needle.where.not("price <= 0 AND qty <= 0"),"Needle")
  end

  def add_cart
    session[:sale_cart] ||= []
    if Sale.valid_get_params(params[:category],params[:id])
      session[:sale_cart] = Sale.add_to_cart(session[:sale_cart], params[:category], params[:id])
      redirect_to Sale.valid_url(params[:category]), notice: "Operation success"
    else  
      redirect_to root_path, notice: "Invalid operation perform on Sale cart."      
    end
  end

  def cart
    @datas = Sale.get_items(session[:sale_cart])
    @total = get_total(session[:sale_cart])
  end

  def remove_cart
    if Sale.valid_get_params(params[:category],params[:id])
      session[:sale_cart] = Sale.delete_item(session[:sale_cart], params[:category], params[:id])
      unless session[:sale_cart].nil? || session[:sale_cart].empty?
        redirect_to sale_cart_path, notice: "Operation success" 
      else
        redirect_to Sale.valid_url(params[:category]), notice: "Operation success"
      end
    else
      redirect_to root_path, notice: "Invalid operation perform on Sale cart."      
    end
  end

  def update_cart
    session[:sale_cart].each do |stuff| 
      price = 0
      if stuff["category"] == "Part"
        part = Part.find(stuff["id"])
        price = part.price
      elsif stuff["category"] == "Needle"
        needle = Needle.find(stuff["id"])        
        price = needle.price
      end
      stuff["price"] = price
      stuff["qty"] = params["q"+stuff["category"]+stuff["id"]] unless params["q"+stuff["category"]+stuff["id"]] == nil
    end
    redirect_to sale_cart_url, notice: "Updated - operation success"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params.require(:sale).permit(:proforma, :staff_id, :customer, :address, :nic, :phone, :cash, :total, :postpone, :tax)
    end

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

    def get_total(session)
      total = 0
      session.each do |item|
        total += item["qty"].to_i * item["price"].to_i
      end
      total
    end
end
