require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
# SETUP
  before :each do
    @category = Category.create! name: 'Electronics'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see description for product" do
    # ACT
    visit root_path
    first('.product').click_link('Details')
    expect(page).to have_css '.products-show'
    save_screenshot
  end
end
