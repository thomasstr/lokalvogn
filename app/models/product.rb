class Product < ActiveRecord::Base
  attr_accessible :description, :price, :quantity, :start_date, :store_name, :title

  validates :title, uniqueness: true
  validates :title, :description, :start_date, :store_name, :quantity, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  def quantity_left_in_store
    if quantity.nil?
      return "Utsolgt"
    else
      return quantity
    end
  end

  def remove_quantity_if_bought
    if @purchase.complete?
      
    end
  end
  
  private
  
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, "Line Items present")
      return false
    end
  end

  def no_date_set
    if start_date == nil
    end
  end
end
