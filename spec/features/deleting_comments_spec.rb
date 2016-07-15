require 'rails_helper.rb'

feature 'Deleting comments' do
  
  background do
    user_one = create(:user)
    user_two = create(:user,  email: 'two@user.com',
                              username: 'usertwo',
                              password: 'password',
                              password_confirmation: 'password',
                              id: 2)
    post = create(:post)
    comment = create(:comment, post_id: post.id, user_id: user_two.id, id: 1)
    other_comment = create(:comment, user_id: user_one.id, post_id: post.id, 
                          content: 'woot', id: 2)
    sign_in_with user_two
  end
  
  scenario 'Can delete a comment belonging to you' do
    visit '/browse/'
    find(:xpath, "//a[contains(@href,'1/comments/1')]").click
    expect(page).to_not have_content('rofl')
    expect(page).to have_content('Comment deleted')
  end
  
  scenario "Other users can't delete your comments via UI" do
    visit '/browse/'
    expect(page).to have_content('woot')
    expect(page).to_not have_css("#delete-2")
  end
  
  scenario "Other users can't delete your comments via URLs" do
    visit '/browse/'
    expect(page).to have_content('rofl')
    visit '/'
    page.driver.submit :delete, "posts/1/comments/2", {}
    expect(page).to have_content("That comment doesn't belong to you!")
    visit '/browse/'
    expect(page).to have_content('rofl')
  end
  
end