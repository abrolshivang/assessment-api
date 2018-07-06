require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Sessions" do
  post "/users/sign_in" do
    example "user sign in success" do
      user = create(:user)
      do_request(email: user.email, password: '123456')
      status.should == 200
    end

    example "user sign in failure" do
      user = create(:user)
      do_request(email: user.email, password: '12345')
      status.should == 422
    end
  end

  get "/users/refresh_token" do
    let!(:user) { create(:user) }
    let!(:refresh_token) { user.generate_token(false) }
    header 'X-REFRESH-TOKEN', :refresh_token

    example "token refresh" do
      do_request
      status.should == 200
    end
  end
end
