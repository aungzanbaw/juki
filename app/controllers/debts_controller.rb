class DebtsController < ApplicationController
  before_filter :authenticate
  before_action :set_debt, only: [:show, :edit, :update, :destroy]

  # GET /debts
  # GET /debts.json
  def index
    @datas = [] 
    debts = Debt.where(paid: false)
    debts.each do |debt|
      if Date.today.to_date >= debt.date.to_date
        @datas << debt 
      end
    end
  end

  # GET /debts/1
  # GET /debts/1.json
  def show
  end

  # GET /debts/new
  def new
    unless params["msale"].nil? || params["msale"].empty?
      @debt = Debt.new
      @debts = Debt.where(msale_id: params["msale"])
      @msale = Msale.find(params["msale"])
    else
      redirect_to msales_path
    end
  end

  # GET /debts/1/edit
  def edit

  end

  # POST /debts
  # POST /debts.json
  def create
    @debt = Debt.new(debt_params)
    @debt.paid = false
    respond_to do |format|
      if @debt.save
        @msale = Msale.find(@debt.msale_id)
        @msale.update(debt: true)
        format.html { redirect_to new_debt_path(msale: @debt.msale_id), notice: 'Debt was successfully created.' }
        format.json { render :show, status: :created, location: @debt }
      else
        format.html { render :new }
        format.json { render json: @debt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /debts/1
  # PATCH/PUT /debts/1.json
  def update
    @debt.paid = true
    respond_to do |format|
      if @debt.update(debt_params)
        format.html { redirect_to new_debt_path(msale: @debt.msale_id), notice: 'Debt was successfully updated.' }
        format.json { render :show, status: :ok, location: @debt }
      else
        format.html { render :edit }
        format.json { render json: @debt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /debts/1
  # DELETE /debts/1.json
  def destroy
    @debt.destroy
    respond_to do |format|
      format.html { redirect_to debts_url, notice: 'Debt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def paid
    @debt = Debt.find(params["id"])
    @debt.paid = true
    respond_to do |format|
      if @debt.save
        format.html { redirect_to new_debt_path(msale: @debt.msale_id), notice: 'Debt was successfully created.' }
      else
        redirect_to msales_path
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_debt
      @debt = Debt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def debt_params
      params.require(:debt).permit(:msale_id, :amount, :date, :paid)
    end
end
