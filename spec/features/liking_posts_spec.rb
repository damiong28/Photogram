require 'rails_helper.rb'

feature 'liking posts' do 
  
  background do  
    user = create(:user)
    create(:post)
    sign_in_with user
    visit '/'
  end
  
  scenario 'can like a post' do
    expect(page).to have_css('a.glyphicon-heart-empty')
    expect(find('.likes')).to_not have_content('testuser')
    click_link "like_1"
    expect(page).to have_css('a.glyphicon-heart')
    expect(find('.likes')).to have_content('testuser')
  end
  
  scenario 'can unlike a post' do  
    click_link "like_1"
    expect(page).to have_css('a.glyphicon-heart')
    expect(find('.likes')).to have_content('testuser')
    click_link "like_1"
    expect(page).to have_css('a.glyphicon-heart-empty')
    expect(find('.likes')).to_not have_content('testuser')
  end  
  
end