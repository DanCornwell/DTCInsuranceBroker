class PagesController < ApplicationController

  def index

  end

  def user_form

  end

  def about

  end

  def help

  end

  # Sets the error variable for the error page
  def error

    @errors = params[:error_messages]

  end

  # Sets the quotes and details variable for the quote page
  def quote
    @quotes = get_quotes
    # Take the first quote from the params as we only need one details hash
    @details = details_hash(params[:quote_messages][0])

  end

  def retrieve_form

  end

  # Sets the quotes and details variable for the retrieved quote page
  def retrieved_quote

    @quotes = get_quotes

    # Take the first quote from the params  as we only need one details hash
    @details = details_hash(params[:quote_messages][0])


  end

  private

  # Returns a hash of the details the user inputted to get this quote
  # Needed as an underwriter can return more things
  def details_hash(details)

    hash = {
     title: details[:title],
     forename: details[:forename],
     surname: details[:surname],
     email: details[:email],
     dob: details[:dob],
     telephone: details[:telephone],
     street: details[:street],
     city: details[:city],
     county: details[:county],
     postcode: details[:postcode],
     license_type: details[:license_type],
     license_period: details[:license_period],
     occupation: details[:occupation],
     registration: details[:registration],
     mileage: details[:mileage],
     estimated_value: details[:estimated_value],
     parking: details[:parking],
     start_date: details[:start_date],
     number_incidents: details[:number_incidents],
     excess: details[:excess],
     breakdown_cover: details[:breakdown_cover],
     windscreen_cover: details[:windscreen_cover]
    }
    if(details[:number_incidents].to_i>0)
      (1..details[:number_incidents].to_i).each do |i|

        hash[:"incident_date#{i}"] = details[("incident_date#{i}").to_sym]
        hash[:"claim_sum#{i}"] = details[("claim_sum#{i}").to_sym]
        hash[:"incident_type#{i}"] = details[("incident_type#{i}").to_sym]
        hash[:"description#{i}"] = details[("description#{i}").to_sym]

      end
    end
    return hash

  end

  # Returns the quotes received in the form of an array
  def get_quotes

    quotes = []

    quote_array = params[:quote_messages]
    quote_array.each do |f|

      temp = {underwriter: f[:underwriter], premium: f[:premium]}
      quotes.push(temp)

    end
    return quotes
  end

end