require 'rails_helper.rb'

feature 'viewing user profiles' do
  
  background do
    user1 = create(:user, id: 1)
    user2 = create(:user, email: 'imposter@foo.com', username: 'imposter', 
                    password: 'password', password_confirmation: 'password',
                    id: 2)
    post1 = create(:post, caption: "first users post", user_id: 1, id: 1)
    post2 = create(:post, caption: "second users post", user_id: 2, id: 2)
    sign_in_with user1
    visit "/"
    click_link "#{user1.username}", match: :first
  end
  
  scenario "visiting a profile page shows the user name in the url" do
    expect(page.current_path).to eq(profile_path("testuser"))
  end
  
  scenario "a profile page only shows the specified user's posts" do
    expect(page).to have_content("first users post")
    expect(page).to_not have_content("second users post")
  end
  
end