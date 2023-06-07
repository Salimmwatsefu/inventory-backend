class SalesController < ApplicationController
    before_action :set_sale, only: [:show, :edit, :destroy]
  
    def index
      @sales = Sale.all
      render json: @sales
    end
  
    def show
    end
  
  
    def create
      @sale = Sale.new(sale_params)
      @sale.quantity = params[:quantity]
  
      if @sale.save
        render json: @sale, status: :created, location: @sale
      else
        render json: @sale.errors, status: :unprocessable_entity
      end
    end

  
    
  
    def destroy
      @sale.destroy
      head :no_content
    end

    def sales_report
      @start_date = Date.strptime(params[:start_date], '%m/%d/%Y')
      @end_date = Date.strptime(params[:end_date], '%m/%d/%Y')
        @sales = Sale.where(date: @start_date..@end_date)
        render json: { message: "sales report successfully generated", sales: @sales }
      end
      
  
    private
  
    def set_sale
      if params[:id] != 'report'
        @sale = Sale.find(params[:id])
      end
    end
    
  
    def sale_params
      params.require(:sale).permit(:id, :title, :quantity, :amount, :date, :product_id)
    end
  
    
  end
  
