require 'spec_helper'

describe PagesController do

  describe "request to error page" do

    it "posts error messages" do
      post "error", {error_messages: ['error1','error2','error3']}
      assigns(:errors).should eq ['error1','error2','error3']
    end

  end

  describe "request to quote page" do

    it "posts quote messages" do
      post "quote", quote_messages: [ {
          underwriter: 'test underwriter',
          premium: 500,
          title: 'Mr',
          forename: 'Phil',
          surname: 'Smite',
          email: 'huir@aber.ac.uk',
          dob: Date.new(2000,1,1),
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
          start_date: Date.current,
          number_incidents: 1,
          excess: 10,
          breakdown_cover: 'European',
          windscreen_cover: 'Yes',
          incident_date1: Date.current,
          claim_sum1: 12345,
          incident_type1: 'Head on collision',
          description1: "crash"
          }]
      assigns(:quotes).should eq [{underwriter: "test underwriter", premium: '500'}]
      hash = {
            title: 'Mr',
            forename: 'Phil',
            surname: 'Smite',
            email: 'huir@aber.ac.uk',
            dob: Date.new(2000,1,1).strftime("%Y-%m-%d"),
            telephone: '80976271829',
            street: 'Park Lane',
            city: 'Monopoly',
            county: 'Gropils',
            postcode: 'GI8 9FK',
            license_type: 'Full',
            license_period: '5',
            occupation: 'banker',
            registration: 'reg123',
            mileage: '6000',
            estimated_value: '8000',
            parking: 'On a street',
            start_date: Date.current.strftime("%Y-%m-%d"),
            number_incidents: '1',
            excess: '10',
            breakdown_cover: 'European',
            windscreen_cover: 'Yes',
            incident_date1: Date.current.strftime("%Y-%m-%d"),
            claim_sum1: '12345',
            incident_type1: 'Head on collision',
            description1: "crash"
      }
      assigns(:details).should eq hash

    end

  end

end