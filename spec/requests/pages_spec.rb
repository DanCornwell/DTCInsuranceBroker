require 'spec_helper'

describe "Pages" do

  subject {page}

  describe "Index Page" do
    before { visit root_path }

    it {should have_content('Welcome to DTC online insurance broker!')}
    it {should have_title(full_title(''))}
    it {should_not have_title('| Home')}
  end

  describe "User Form Page" do
    before { visit user_form_path }

    it {should have_content('Please fill in the forms below:')}
    it {should have_title(full_title('User Form'))}
  end

  describe "About Page" do
    before { visit about_path }

    it {should have_title(full_title('About'))}

  end

  describe "Help Page" do
    before { visit help_path }

    it {should have_title(full_title('Help'))}

  end

end