class SalesController < ApplicationController
  before_filter :authenticate_staff
  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  # GET /sales
  # GET /sales.json
  def index
    @sales = Sale.all
  end

  # GET /sales/1
  # GET /sales/1.json
  def show
  end

  # GET /sales/new
  def new
    @sale = Sale.new
  end

  # GET /sales/1/edit
  def edit
  end

  # POST /sales
  # POST /sales.json
  def create
    @sale = Sale.new(sale_params)

    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render :show, status: :created, location: @sale }
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
    @parts = filter_in_session(session[:sale_cart], Part,"Part")
  end

  def needle
    @needles = filter_in_session(session[:sale_cart], Needle,"Needle")    
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
