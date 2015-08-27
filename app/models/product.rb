class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :brand
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  
  validates :name,:category_id, :brand_id, :price, :description, :quantity,  presence: true
  validates :name, uniqueness: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  
  has_attached_file :image, styles: { medium: "300x300#", thumb: "100x100#" }, default_url: "/:style_missing.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  
  private
  
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
end
