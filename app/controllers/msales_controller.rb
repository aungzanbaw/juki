class MsalesController < ApplicationController
  before_filter :authenticate
  before_action :set_msale, only: [:show, :edit, :update, :destroy]

  # GET /msales
  # GET /msales.json
  def index
    @msales = Msale.all    
  end

  # GET /msales/1
  # GET /msales/1.json
  def show
    @msale_details = MsaleDetail.where(msale_id: @msale.id)
    @chasses = Chassis.where(msale_id: @msale.id)
  end

  # GET /msales/new
  def new
    @msale = Msale.new
    @datas = Msale.get_items(session[:msale_cart])
    @total = get_total(session[:msale_cart])
  end

  # GET /msales/1/edit
  def edit
  end

  # POST /msales
  # POST /msales.json
  def create
    @msale = Msale.new(msale_params)
    @msale.total = get_total(session[:msale_cart])
    @msale.tax = 0 
    @msale.debt = false
    @msale.delivery = false
    @msale.withdraw = false
    
    respond_to do |format|
      if @msale.save
        
        session[:msale_cart].each do |item|
          @msale_detail = MsaleDetail.new 
          @msale_detail.msale_id = @msale.id
          @msale_detail.msaleable_id = item["id"]
          @msale_detail.msaleable_type = item["category"]
          @msale_detail.qty = item["qty"]
          @msale_detail.price = item["price"] 

          if @msale_detail.save
            if @msale.proforma == false 
              case @msale_detail.msaleable_type 
              when "Machine"
                @machine = Machine.find(@msale_detail.msaleable_id)
                qty = @machine.qty
                qty -= @msale_detail.qty 
                @machine.update(:qty => qty)
              when "Motor"
                @motor = Motor.find(@msale_detail.msaleable_id)
                qty = @motor.qty
                qty -= @msale_detail.qty 
                @motor.update(:qty => qty)
              when "Table"
                @table = Table.find(@msale_detail.msaleable_id)
                qty = @table.qty
                qty -= @msale_detail.qty 
                @table.update(:qty => qty)
              when "Stand"
                @stand = Stand.find(@msale_detail.msaleable_id)
                qty = @stand.qty
                qty -= @msale_detail.qty 
                @stand.update(:qty => qty)
              end
            end
          else
            format.html { render :new }
            format.json { render json: @msale.errors, status: :unprocessable_entity }
          end
          session.delete(:msale_cart)
          format.html { redirect_to @msale, notice: 'Purchase was successfully created.' }
          format.json { render :show, status: :created, location: @msale }
        end        
        
      else
        format.html { render :new }
        format.json { render json: @msale.errors, status: :unprocessable_entity }
      end
    end 

  end

  # PATCH/PUT /msales/1
  # PATCH/PUT /msales/1.json
  def update
    respond_to do |format|
      if @msale.update(msale_params)
        if @msale.proforma == false
          @msale_details = MsaleDetail.where(msale_id: @msale.id)
          @msale_details.each do |msale_detail|
            case msale_detail.msaleable_type 
            when "Machine"
              @machine = Machine.find(msale_detail.msaleable_id)
              qty = @machine.qty
              qty -= msale_detail.qty 
              @machine.update(:qty => qty)
            when "Motor"
              @motor = Motor.find(msale_detail.msaleable_id)
              qty = @motor.qty
              qty -= msale_detail.qty 
              @motor.update(:qty => qty)
            when "Table"
              @table = Table.find(msale_detail.msaleable_id)
              qty = @table.qty
              qty -= msale_detail.qty 
              @table.update(:qty => qty)
            when "Stand"
              @stand = Stand.find(msale_detail.msaleable_id)
              qty = @stand.qty
              qty -= msale_detail.qty 
              @stand.update(:qty => qty)
            end
          end
        end
        # format.html { redirect_to @msale, notice: 'Machine sale was successfully updated.' }
        format.html { redirect_to @msale, notice: @msale_detail}
        format.json { render :show, status: :ok, location: @msale } 
      else
        format.html { render :edit }
        format.json { render json: @msale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /msales/1
  # DELETE /msales/1.json
  def destroy
    @msale.destroy
    respond_to do |format|
      format.html { redirect_to msales_url, notice: 'Machine sale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def machine
    @machines = filter_in_session(session[:msale_cart], Machine,"Machine")
  end

  def motor
    @motors = filter_in_session(session[:msale_cart], Motor, "Motor")
  end

  def table
    @tables = filter_in_session(session[:msale_cart], Table,"Table")
  end

  def stand
    @stands = filter_in_session(session[:msale_cart], Stand,"Stand")
  end

  def add_cart
    session[:msale_cart] ||= []
    if Msale.valid_get_params(params[:category],params[:id])
      session[:msale_cart] = Msale.add_to_cart(session[:msale_cart], params[:category], params[:id])
      redirect_to Msale.valid_url(params[:category]), notice: "Operation success"
    else
      redirect_to root_path, notice: "Invalid operation perform on Sale cart."      
    end
  end

  def cart
    @datas = Msale.get_items(session[:msale_cart])
    @total = get_total(session[:msale_cart])
  end

  def remove_cart 
    if Msale.valid_get_params(params[:category],params[:id])
      session[:msale_cart] = Msale.delete_item(session[:msale_cart], params[:category], params[:id])
      unless session[:msale_cart].nil? || session[:msale_cart].empty?
        redirect_to msale_cart_path, notice: "Operation success" 
      else
        redirect_to Msale.valid_url(params[:category]), notice: "Operation success"
      end
    else
      redirect_to root_path, notice: "Invalid operation perform on Machine Sale cart."      
    end
  end

  def update_cart
    session[:msale_cart].each do |stuff| 
      stuff["price"] = params["p"+stuff["category"]+stuff["id"]] unless params["p"+stuff["category"]+stuff["id"]] == nil 
      stuff["qty"] = params["q"+stuff["category"]+stuff["id"]] unless params["p"+stuff["category"]+stuff["id"]] == nil
    end
    redirect_to msale_cart_url, notice: "Updated - operation success"
  end

  def chassis
    @datas = MsaleDetail.where(msale_id: params["id"], msaleable_type: "Machine")
  end

  def update_msale_chassis
    @datas = MsaleDetail.where(msale_id: params["msale"], msaleable_type: "Machine") 
    
    @datas.each do |data| 
      data["qty"].times do |qty_local| 
        Chassis.find_or_create_by(msale_id: params["msale"], msale_detail_id: data["id"], chassisnum: params[data["id"].to_s+"q"+qty_local.to_s])
      end 
    end

    @msale = Msale.find(params["msale"])
    
    render :print_chassis 

  end

  def print_chassis
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_msale
      @msale = Msale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def msale_params
      params.require(:msale).permit(:proforma, :customer, :nic, :address, :phone, :total, :debt, :tax)
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
