require 'rails_helper.rb'

feature 'Index displays a list of posts' do  
  
  background do
    user = create(:user)
    visit '/'
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end
  
  scenario 'the index displays correct created job information' do
    job_one = create(:post, caption: "This is post one")
    job_two = create(:post, caption: "This is the second post")

    visit '/'
    expect(page).to have_content("This is post one")
    expect(page).to have_content("This is the second post")
    expect(page).to have_css("img[src*='coffee']")
  end
  
end