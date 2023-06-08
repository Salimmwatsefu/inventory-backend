class EmployeesController < ApplicationController

    before_action :set_employee, only: [:show, :edit, :update, :destroy]

    def index
        @employees = Employee.all
        render json: @employees
    end

    def show
    end

    def create
        @employee = Employee.new(employee_params)
        if @employee.save
            render json: @employee, status: :created, location: @employee
        else
            render json: @employee.errors, status: :unprocessable_entity
        end
    end

    def update
        if @employee.update(employee_params)
            render json: @employee
        else
            render json: @employee.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @employee.destroy
        head :no_content
    end

            private

    def set_employee
        @employee = Employee.find(params[:id])
    end

    def employee_params
        params.require(:employee).permit(:name, :job_title, :salary, :phone_number, :start_date)
    end
end
