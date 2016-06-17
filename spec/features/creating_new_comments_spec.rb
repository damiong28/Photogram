require 'rails_helper.rb'

feature 'Creating comments' do
  
  scenario 'can comment on an existing post' do
    user = create(:user)
    post = create(:post)
    sign_in_with user
    visit '/'
    fill_in 'comment_content', with: ';P', match: :first
    click_button 'Submit'
    expect(page).to have_content ';P'
  end
  
end