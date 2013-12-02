class PagesController < ApplicationController

  def index

  end

  def user_form

  end

  def about

  end

  def help

  end

  def error

    @errors = params[:error_messages]

  end

  def quote
    @quotes = []
    quote_array = params[:quote_messages]
    quote_array.each do |f|

      temp = {underwriter: f[:underwriter], premium: f[:premium]}
      @quotes.push(temp)

    end

    @details = details_hash(quote_array[0])

  end

  def retrieve_form

  end

  def retrieved_quote

    @quotes = []
    quote_array = params[:quote_messages]
    quote_array.each do |f|

      temp = {underwriter: f[:underwriter], premium: f[:premium]}
      @quotes.push(temp)

    end

    @details = details_hash(quote_array[0])


  end

  private

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

end