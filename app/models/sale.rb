class Sale < ApplicationRecord
  belongs_to :product, counter_cache: true

  validates_presence_of :product_id, :quantity, :amount, :date

  after_create :update_product_stock

  private

  def update_product_stock
    product.update(instock: product.instock - quantity)
  end
end
