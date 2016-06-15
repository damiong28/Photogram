require 'rails_helper.rb'

feature 'Creating a new user' do 
  
  background do
    visit '/'
    click_link 'Register'
  end
  
  scenario 'can create a new user via the index page' do
    fill_in 'Username', with: 'sxyrailsdev'
    fill_in 'Email', with: 'sxyrailsdev@myspace.com'
    fill_in 'Password', with: 'supersecret', match: :first
    fill_in 'Password confirmation', with: 'supersecret'
    click_button 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.') 
   end
   
   scenario 'requires a user name to successfully create an account' do
    fill_in 'Email', with: 'sxyrailsdev@myspace.com'
    fill_in 'Password', with: 'supersecret', match: :first
    fill_in 'Password confirmation', with: 'supersecret'
    click_button 'Sign up'
    expect(page).to have_content("can't be blank") 
  end
  
  scenario 'requires user name to be longer than three characters' do
    fill_in 'Username', with: 'abc'
    fill_in 'Email', with: 'sxyrailsdev@myspace.com'
    fill_in 'Password', with: 'supersecret', match: :first
    fill_in 'Password confirmation', with: 'supersecret'
    click_button 'Sign up'
    expect(page).to have_content("minimum is 4 characters") 
  end
  
  scenario 'requires user name to be shorter than 13 characters' do
    fill_in 'Username', with: 'a' * 13
    fill_in 'Email', with: 'sxyrailsdev@myspace.com'
    fill_in 'Password', with: 'supersecret', match: :first
    fill_in 'Password confirmation', with: 'supersecret'
    click_button 'Sign up'
    expect(page).to have_content("maximum is 12 characters") 
  end
  
end  