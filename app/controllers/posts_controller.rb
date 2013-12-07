class PostsController < ApplicationController

  require "net/http"
  require "uri"

  # Method that posts the form data to the various underwriters
  def post_details

    # Holds all the urls for the underwriters
    underwriters = %w(http://dtcinsuranceunderwriter.herokuapp.com/quotations)
    # Array to hold all the quotes we receive
    quotes = []
    # Array to hold any errors we receive
    errors = []

    # If no underwriters have been specified redirect to the error page with error saying this
    if(underwriters.length == 0)

      redirect_to 'error?error=No%20underwriters%20were%20specified%20to%20be%20used.%20Contact%20the%20admin%20with%20this%20issue.'

    else

      underwriters.each do |url|

        # Send a post request and receive the response
        uri = URI.parse(url)
        response = Net::HTTP.post_form(uri, params)

        # If ok turn the json object into a hash and add to the quotes array
        if(response.code == '200')
          parsed_quote = JSON.parse(response.body).symbolize_keys
          quotes << parsed_quote
        # If not ok turn the json object into a hash (will contain error messages) and add to the errors array
        elsif(response.code == '400')
          parsed_error = JSON.parse(response.body).symbolize_keys
          errors << parsed_error
        # If page not found add and error onto the error array
        elsif(response.code == '404')
          errors << {error: 'An underwriter could not be reached, please try again later.'}
        end

      end

    end

    # If no quotes received redirect to the error page with the result errors
    if (quotes.length == 0)
      redirect_to controller: 'pages', action:'error', error_messages: errors
    # Else redirect to the quotes page and display the received quotes
    else
      redirect_to controller: 'pages', action:'quote', quote_messages: quotes
    end

  end

  # Method that retrieves a quote from an underwriter
  def post_retrieve

    # Sets the url based on the 3 character identifier on the beginning of the code
    url = ""
    url = "http://dtcinsuranceunderwriter.herokuapp.com/quotations/retrieve" if params[:code][0..2] == 'dtc'

    # Array to hold all the quotes we receive
    quotes = []
    # Array to hold any errors we receive
    errors = []

    # If url is not blank
    if(url != "")
      # Retrieve the quote from the url using the code and email supplied
      uri = URI.parse(url)
      # Trim the identifier off the code
      data = {code: params[:code][3..-1], email: params[:email]}
      response = Net::HTTP.post_form(uri, data)

      # If ok turn the json object into a hash and add to the quotes array
      if(response.code == '200')
        parsed_quote = JSON.parse(response.body).symbolize_keys
        quotes << parsed_quote
      # If ok turn the json object into a hash and add to the errors array
      elsif(response.code == '400')
        parsed_error = JSON.parse(response.body).symbolize_keys
        errors << parsed_error
      # If page not found add and error onto the error array
      elsif(response.code == '404')
        errors << {error: 'An underwriter could not be reached, please try again later.'}
      end

    end

    # If no identifier is entered redirect to error
    if(url == "")
      redirect_to controller: 'pages', action:'error', error_messages: ["No quotations could be found with that code and email combination. Please check your details and try again."]
    # If quotes array empty redirect to errors
    elsif (quotes.length == 0)
      redirect_to controller: 'pages', action:'error', error_messages: errors
    # Else redirect to retrieved quote
    else
      redirect_to controller: 'pages', action:'retrieved_quote', quote_messages: quotes
    end

  end

end