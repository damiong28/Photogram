require 'rails_helper.rb'

feature 'Editing posts' do
  
  background do
    user = create(:user)
    sign_in_with user 
    create(:post)
    visit '/'
    find(:xpath, "//a[contains(@href,'posts/1')]", match: :first).click
    click_link 'Edit'
  end
  
  scenario 'Can edit a post' do
    fill_in 'post_caption', with: "Oh god, you weren't supposed to see this!"
    click_button 'Update Post'
    expect(page).to have_content("Post edited")
    expect(page).to have_content("Oh god, you weren't supposed to see this!")
  end
  
  scenario "a post won't update without an attached image" do
    attach_file('post_image', 'spec/files/coffee.zip')
    click_button 'Update Post'
    expect(page).to have_content("Failed to edit post")
  end
  
  scenario "only the owner of a post can edit it" do
    click_link 'Logout'
    other_user = create(:user, email: 'imposter@foo.com',
                        username: 'imposter',
                        password: 'password',
                        password_confirmation: 'password',
                        id: 2)
    sign_in_with other_user
    find(:xpath, "//a[contains(@href,'posts/1')]", match: :first).click
    expect(page).to_not have_content("Edit")
    visit '/posts/1/edit'
    expect(page).to have_content("That post doesn't belong to you!")
  end

end