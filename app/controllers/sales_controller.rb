class SalesController < ApplicationController
    before_action :set_sale, only: [:show, :edit, :update, :destroy]
  
    def index
      @sales = Sale.all
      render json: @sales
    end
  
    def show
    end
  
  
    def create
      @sale = Sale.new(sale_params)
  
      if @sale.save
        render json: @sale, status: :created, location: @sale
      else
        render json: @sale.errors, status: :unprocessable_entity
      end
    end

  
    def update
      if @sale.update(sale_params)
        render json: @sale
      else
        render json: @sale.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @sale.destroy
      head :no_content
    end

    def sales_report
        @start_date = params[:start_date].to_date
        @end_date = params[:end_date].to_date
      
        @sales = Sale.where(date: @start_date..@end_date)
      end
      
  
    private
  
    def set_sale
      @sale = Sale.find(params[:id])
    end
  
    def sale_params
      params.require(:sale).permit(:title, :quantity, :amount, :date, :product_id)
    end
  end
  
