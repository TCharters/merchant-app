require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "product fields must not be empty" do
    product = Product.new
    assert_not product.save, "saved product with empty attributes"
  end
  
  test "product name should be unique" do
    product = Product.new(price: 1, description: "my description", category_id: 1, brand_id: 1, quantity: 1)
    product.name = products(:one).name
    #product.name = products(:one).name
    assert_not product.save, "saved product with non-unique name"
  end
  
  test "product price must be positive and greater than zero" do
    product = Product.new(name: "my product", description: "my description", category_id: 1, brand_id: 1, quantity: 1)
    product.price = 0
    assert_not product.save, "saved product with a price that is less than or equal to zero"
  end
  
  test "product saves with all valid attributes" do
    product = Product.new(name: "my product", description: "my description", category_id: 1, brand_id: 1, quantity: 1, price: 1)
    assert product.save, "product wasn't saved when valid fields given"
  end
end