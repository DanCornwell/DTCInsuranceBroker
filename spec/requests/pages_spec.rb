require 'spec_helper'

describe "Pages" do

  subject {page}

  shared_examples_for "all pages" do

    it {should have_title(full_title(page_title))}
    it "should have the right links on the layout" do
      visit root_path
      click_link "About"
      expect(page).to have_title(full_title('About'))
      click_link "Help"
      expect(page).to have_title(full_title('Help'))
      click_link "Home"
      expect(page).to have_title(full_title(''))
    end
  end

  describe "Index Page" do
    before { visit root_path }

    it {should have_content('Welcome to DTC online insurance broker!')}
    let(:page_title) {''}
    it_should_behave_like "all pages"
    it {should_not have_title('| Home')}

  end

  describe "User Form Page" do
    before { visit user_form_path }

    it {should have_content('Please fill in the forms below:')}
    let(:page_title) {'User Form'}
    it_should_behave_like "all pages"
    it {should have_selector('form')}
    it {should have_button("Cancel Application")}
  end

  describe "About Page" do
    before { visit about_path }

    let(:page_title) {'About'}
    it_should_behave_like "all pages"

  end

  describe "Help Page" do
    before { visit help_path }

    let(:page_title) {'Help'}
    it_should_behave_like "all pages"

  end

  describe "Error Page" do
    before {visit error_path}

    let(:page_title) {'Error'}

  end

  describe "Quote Page" do
    before {visit quote_path}

    let(:page_title) {'Your Quotes'}

  end

  describe "Retrieve Quotation Page" do
    before {visit retrieve_form_path}

    let(:page_title) {'Retrieve Quotation'}
    it_should_behave_like "all pages"
    it {should have_selector('form')}


  end

end