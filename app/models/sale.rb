class Sale < ApplicationRecord
  belongs_to :product, counter_cache: true

  validates_presence_of :product_id, :quantity, :amount, :date

  attr_accessor :quantity_before_last_save

  after_create :update_product_stock
  before_destroy :set_quantity_before_destroy
  after_destroy :restore_product_stock

  def quantity=(value)
    super(value.present? ? value.to_i : nil)
  end

  private

  def update_product_stock
    return unless quantity.present?

    product.decrement!(:instock, quantity)
  end

  def set_quantity_before_destroy
    self.quantity_before_last_save = quantity
  end

  def restore_product_stock
    return unless quantity_before_last_save.present?

    product.increment!(:instock, quantity_before_last_save)
  end
end
