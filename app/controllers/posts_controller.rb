class PostsController < ApplicationController

  require "net/http"
  require "uri"


  def post

    underwriters = %w(http://safe-garden-5990.herokuapp.com/quotations)
    quotes = []
    bad_data = 0

    if(underwriters.length == 0)

      redirect_to '/error?error=No underwriters were specified to be used. Contact the admin with this issue.'

    else

      underwriters.each do |url|

        uri = URI.parse(url)
        response = Net::HTTP.post_form(uri, params)

        if(response.code == 200)
         quotes.push(response.body)
        elsif(response.code == 400)
          bad_data += 1
        end

      end

    end

    if (quotes.length == 0)
      if(bad_data > 0)
        redirect_to '/error?error=The data entered in the form was invalid. Please rectify and try again.'
      else
      redirect_to '/error?error=No underwriters could be contacted successfully.'
      end
    else
      redirect_to controller: 'pages', action:'quote', data: quotes
    end

  end

end