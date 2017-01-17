
module PageObjects
  module App
    module Pages
      class BasicAuthPage < SitePrism::Page

        set_url "/basic_auth"

        include Bucket

        element :message, '#content p'


        def login(user)
          page.visit("http://#{user[:username]}:#{user[:password]}@the-internet.herokuapp.com//basic_auth")
        end

      end
    end
  end
end
