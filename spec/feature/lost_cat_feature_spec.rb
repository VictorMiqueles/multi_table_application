require "helpers/database_helpers"

RSpec.describe "Lost Cats Feature", type: :feature do
  before(:each) do
    DatabaseHelpers.clear_table("adverts")
  end

  it "starts with an empty list" do
    visit "/adverts"
    expect(page).to have_content "All cats are secure."
  end

  it "adds and lists cat adverts" do
    visit "/adverts"
    click_link "Post New Advert"
    fill_in "Description", with: "My beautiful cat is gone."
    fill_in "Phone Number", with: "+447800000000"
    click_button "Post Advert"
    expect(page).to have_content "My beautiful cat is gone."
    expect(page).to have_content "+447800000000"
  end

  it "adds and lists multiple cat adverts" do
    visit "/adverts"

    click_link "Post New Advert"
    fill_in "Description", with: "My beautiful cat is gone."
    fill_in "Phone Number", with: "+447800000000"
    click_button "Post Advert"

    click_link "Post New Advert"
    fill_in "Description", with: "My arty cat is gone."
    fill_in "Phone Number", with: "+447800000001"
    click_button "Post Advert"

    click_link "Post New Advert"
    fill_in "Description", with: "My sorry cat is gone."
    fill_in "Phone Number", with: "+447800000002"
    click_button "Post Advert"

    expect(page).to have_content "My beautiful cat is gone."
    expect(page).to have_content "+447800000000"
    expect(page).to have_content "My arty cat is gone."
    expect(page).to have_content "+447800000001"
    expect(page).to have_content "My sorry cat is gone."
    expect(page).to have_content "+447800000002"
  end
end
