require 'rails_helper'

RSpec.describe Product, type: :model do

  before(:each) do
    cat1 = Category.find_or_create_by! name: 'Apparel'
    @product = cat1.products.create!({
      name:  'Men\'s Classy shirt',
      description: Faker::Hipster.paragraph(4),
      quantity: rand(1..20),
      price: rand(5..100)
    })
  end

  describe 'Validations' do
    it 'should be valid if all params are present' do
      expect(@product).to be_valid
    end
    it 'should be invalid if name is not present' do
      @product.name = nil
      expect(@product).to_not be_valid
    end
    it 'should be invalid if price is not present' do
      @product.price = ''
      expect(@product).to_not be_valid
    end
    it 'should be invalid if price is not a num' do
      @product.price ='helllo'
      expect(@product).to_not be_valid
    end
    it 'should be invalid if there is no quantity or not a num' do
      @product.quantity = 'string'
      expect(@product).to_not be_valid
    end
  end
end
