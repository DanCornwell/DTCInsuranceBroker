require 'spec_helper'

describe PostsController do

  describe "Sending a post request" do

    hash = {
        title: 'Mr',
        forename: 'Phil',
        surname: 'Smite',
        email: 'huir@aber.ac.uk',
        dob: Date.new(1990,1,1).strftime("%Y-%m-%d"),
        telephone: '80976271829',
        street: 'Park Lane',
        city: 'Monopoly',
        county: 'Gropils',
        postcode: 'GI8 9FK',
        license_type: 'Full',
        license_period: 5,
        occupation: 'banker',
        registration: 'reg123',
        mileage: 6000,
        estimated_value: 8000,
        parking: 'On a street',
        start_date: Date.current.strftime("%Y-%m-%d"),
        number_incidents: 1,
        excess: 10,
        breakdown_cover: 'European',
        windscreen_cover: 'Yes',
        incident_date1: Date.new(2000,1,1).strftime("%Y-%m-%d"),
        claim_sum1: 12345,
        incident_type1: 'Head on collision',
        description1: "crash"
    }

    it "should make a post request" do
      post :post_details, hash
      hash[:underwriter] = 'DTC Insurance Underwriter'
      hash[:premium] = 660
      quotes = [hash]
      response.should redirect_to(controller: 'pages', action:'quote', quote_messages: quotes)

    end

    it "should redirect to error" do

      hash[:email] = "error"
      post :post_details, hash
      errors = [{underwriter: 'DTC Insurance Underwriter', error: "The form data was incorrect. Please try again."}]
      response.should redirect_to(controller: 'pages', action:'error', error_messages: errors)

    end

  end

end