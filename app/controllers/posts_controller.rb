class PostsController < ApplicationController

  require "net/http"
  require "uri"


  def post

    underwriters = %w(http://safe-garden-5990.herokuapp.com/quotations)
    quotes = []
    bad_data = 0

    if(underwriters.length == 0)

      redirect_to 'error?error=No%20underwriters%20were%20specified%20to%20be%20used.%20Contact%20the%20admin%20with%20this%20issue.'

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
        redirect_to '/error?error=The%20data%20entered%20in%20the%20form%20was%20invalid.%20Please%20rectify%20and%20try%20again.'
      else
        redirect_to '/error?error=No%20underwriters%20could%20be%20contacted%20successfully.'
      end
    else
      redirect_to controller: 'pages', action:'quote', data: quotes
    end

  end

end