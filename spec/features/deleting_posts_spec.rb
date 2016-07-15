require 'rails_helper'

feature 'Deleting posts' do
  
  background do
    user = create(:user)
    sign_in_with user 
  end
  
  scenario 'Delete a post' do
    create(:post, caption: "I love my job!")
    visit '/browse/'
    find(:xpath, "//a[contains(@href,'posts/1')]", match: :first).click
    click_link 'Edit'
    click_link 'Delete'
    expect(page).to have_content("Post deleted")
    expect(page).to_not have_content("I love my job!")
  end
  
end