require "helpers/database_helpers"

RSpec.describe "Comments Feature", type: :feature do
  before(:each) do
    DatabaseHelpers.clear_table("adverts")
    DatabaseHelpers.clear_table("comments")
  end

  it "adds comments on adverts and lists them out" do
    visit "/adverts"

    click_link "Post New Advert"
    fill_in "Description", with: "My beautiful cat is gone."
    fill_in "Phone Number", with: "+447800000000"
    click_button "Post Advert"

    click_link "Post New Comment"

    fill_in "Contents", with: "I've seen him!"
    click_button "Post Comment"

    expect(page).to have_content "I've seen him!"
  end
end
