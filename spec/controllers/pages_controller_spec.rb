require 'spec_helper'

describe PagesController do

  describe "request to error page" do

    it "shows error on page" do
      get "error", {error:"test error"}
      controller.params[:error].should eq "test error"
    end

  end

end