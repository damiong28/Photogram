require 'rails_helper.rb'

feature 'editing user profiles' do
  
  background do
    user1 = create(:user, id: 1)
    user2 = create(:user, email: 'imposter@foo.com', username: 'imposter', 
                    password: 'password', password_confirmation: 'password',
                    id: 2)
    create(:post, caption: "first users post", user_id: user1.id)
    create(:post, caption: "second users post", user_id: user2.id)
    sign_in_with user1
    visit "/browse"
  end
  
  scenario "a user can change their own profile details" do 
    click_link "testuser", match: :first
    click_link "Edit Profile"
    attach_file('user_avatar', "spec/files/images/coffee.jpg")
    fill_in 'user_bio', with: 'Is this real life?' 
    click_button "Update Profile"

    expect(page.current_path).to eq(profile_path('testuser'))
    expect(page).to have_css("img[src*='coffee.jpg']")
    expect(page).to have_content "Is this real life?"
  end
  
  scenario "a user cannot change someone elses profile picture" do
    click_link "imposter", match: :first
    expect(page).to_not have_content "Edit Profile"
  end
  
  scenario "a user cannot navigate directly to edit a users profile" do
    visit '/'
    visit '/imposter/edit'
    expect(page).to have_content("That profile doesn't belong to you!")
    expect(page.current_path).to eq(root_path)
  end
  
end