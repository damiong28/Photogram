require 'rails_helper.rb'

feature 'Index displays a list of posts' do  
  
  background do
    user = create(:user)
    sign_in_with user 
  end
  
  scenario 'the index displays correct created job information' do
    create(:post, caption: "This is post one")
    create(:post, caption: "This is the second post")

    visit '/browse/'
    expect(page).to have_content("This is post one")
    expect(page).to have_content("This is the second post")
    expect(page).to have_css("img[src*='coffee']")
  end
  
end