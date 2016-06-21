require 'rails_helper.rb'

feature 'Creating posts' do  
  
  background do
    user = create(:user)
    sign_in_with user 
  end
  
  scenario 'can create a new post' do
    visit '/'
    click_link 'New Post'
    attach_file('post_image', "spec/files/images/coffee.jpg")
    fill_in 'post_caption', with: 'nom nom nom #coffeetime' 
    click_button 'Create Post'
    expect(page).to have_content('#coffeetime')
    expect(page).to have_css("img[src*='coffee.jpg']")
    expect(page).to have_content('testuser')
  end
  
  it 'a post needs an image to save' do  
    visit '/'
    click_link 'New Post'
    fill_in 'post_caption', with: 'No image YOLO'
    click_button 'Create Post'
    expect(page).to have_content('Failed to create post, please check your 
                                  submission and try again')
  end
  
end 