require 'spec_helper'

describe "Submitting pages" do

  subject{page}


  describe "Submitting blank retrieve form" do
    before do
      visit retrieve_form_path
      click_button "Retrieve Quotation"
    end
    it{should have_title(full_title('Retrieve Quotation'))}
  end


end