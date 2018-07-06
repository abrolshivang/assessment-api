require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Posts' do
  get '/api/v1/posts' do
    example "Posts listing" do
      create_list(:post, 2)
      do_request 
      status.should == 200
    end
  end

  get '/api/v1/posts/:id' do
    example "Post show" do
      do_request(id: create(:post).id)
      status.should == 200
    end
  end
end

resource 'Posts' do
  let!(:user) { create(:user) }
  let!(:token){ user.generate_token }
  header 'X-ACCESS-TOKEN', :token

  post '/api/v1/posts' do
    example "post creation success" do
      do_request(post: { title: "First title", url: "http://example.com/first-title"})
      status.should == 201
    end

    example "post creation fail" do
      do_request(post: { title: "", url: ""})
      status.should == 422
    end
  end

  put "/api/v1/posts/:id" do
    example "post update success" do
      post = create(:post, user: user)
      do_request(id: post.id, post: { title: "second title", url: "http://example.com/first-title"})
      status.should == 200
    end
    
    example "post update failure" do
      post = create(:post, user: user)
      do_request(id: post.id, post: { title: "", url: ""})
      status.should == 422
    end

    example "post update unauthorized access" do
      post = create(:post)
      do_request(id: post.id, post: { title: "", url: ""})
      status.should == 401
    end
  end

  delete "/api/v1/posts/:id" do
    example "deletion success" do
      post = create(:post, user: user)
      do_request(id: post.id)
      status.should == 204
    end

    example "post deletion unauthorized" do
      post = create(:post)
      do_request(id: post.id)
      status.should == 401
    end
  end
end
