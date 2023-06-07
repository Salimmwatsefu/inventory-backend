class Product < ApplicationRecord
    has_many :sales

  before_save :update_sales_count

  validates :title, uniqueness: true

  private

  def update_sales_count
    self.sales_count = sales.count
  end
end
