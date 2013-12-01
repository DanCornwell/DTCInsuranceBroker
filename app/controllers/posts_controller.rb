class PostsController < ApplicationController

  require "net/http"
  require "uri"


  def post_details

    underwriters = %w(http://safe-garden-5990.herokuapp.com/quotations)
    quotes = []
    errors = []

    if(underwriters.length == 0)

      redirect_to 'error?error=No%20underwriters%20were%20specified%20to%20be%20used.%20Contact%20the%20admin%20with%20this%20issue.'

    else

      underwriters.each do |url|

        uri = URI.parse(url)
        response = Net::HTTP.post_form(uri, params)
        if(response.code == '200')
          parsed_quote = JSON.parse(response.body).symbolize_keys
          quotes << parsed_quote
        elsif(response.code == '400')
          parsed_error = JSON.parse(response.body).symbolize_keys
          errors << parsed_error
        elsif(response.code == '404')
          errors << {error: 'An underwriter could not be reached, please try again later.'}
        end

      end

    end

    if (quotes.length == 0)
      #redirect_to controller: 'pages', action:'error', error: errors
      render template: "pages/error", error: errors
    else
      #redirect_to controller: 'pages', action:'quote', data: quotes
      render template: "pages/index", data: quotes
    end

  end

end