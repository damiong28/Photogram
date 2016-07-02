require 'rails_helper.rb'

feature 'viewing individual posts' do
  
  background do
    user = create(:user)
    sign_in_with user 
  end
  
  scenario "Can view individual posts" do
    post = create(:post)
    
    visit '/'
    find(:xpath, "//a[contains(@href,'posts/1')]", match: :first).click
    expect(page.current_path).to eq(post_path(post))
  end
  
end