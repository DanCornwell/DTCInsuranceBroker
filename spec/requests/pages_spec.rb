require 'spec_helper'

describe "Pages" do

  describe "Index Page" do

    it "should have the content 'Welcome to DTC online insurance broker!'"   do
      visit '/pages/index'
      expect(page).to have_content('Welcome to DTC online insurance broker!')
    end
    it "should have the title 'Home'" do
      visit '/pages/index'
      expect(page).to have_title("DTCInsuranceBroker | Home")
    end
  end

end