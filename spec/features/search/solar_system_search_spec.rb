require 'rails_helper'

RSpec.describe 'As a user' do
  describe 'from any page' do
    before do
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    end

    it 'I can search for an included solar system object', :vcr do
      stub_omniauth
      visit '/'
      click_button 'Sign-In with Google'
      user = User.last

      expect(current_path).to eq('/profile')
      expect(page).to have_content("Hi, #{user.first_name}!")
      
      fill_in "search", with: "Jupiter"
      click_button 'Search'
      
      expect(current_path).to eq('/search')
      
      save_and_open_page
    end
  end
end