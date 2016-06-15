require 'rails_helper.rb'

feature 'Creating posts' do  
  
  background do
    user = create(:user)
    visit '/'
    fill_in 'Email', with: user.email 
    fill_in 'Password', with: user.password 
    click_button 'Log in'
  end
  
  scenario 'can create a job' do
    visit '/'
    click_link 'New Post'
    attach_file('Image', "spec/files/images/coffee.jpg")
    fill_in 'Caption', with: 'nom nom nom #coffeetime' 
    click_button 'Create Post'
    expect(page).to have_content('#coffeetime')
    expect(page).to have_css("img[src*='coffee.jpg']")
  end
  
  it 'needs an image to create a post' do  
    visit '/'
    click_link 'New Post'
    fill_in 'Caption', with: 'No image YOLO'
    click_button 'Create Post'
    expect(page).to have_content('Failed to create post, please check your 
                                  submission and try again')
  end  
  
  scenario "Can view individual posts" do
    post = create(:post)
    
    visit '/'
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    expect(page.current_path).to eq(post_path(post))
  end
  
end 