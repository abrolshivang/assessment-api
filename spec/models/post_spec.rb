require 'rails_helper'

RSpec.describe Post, type: :model do
  context "#validate_url" do
    example "returns true for valid URL" do
      post = build(:post)
      expect(post.valid?).to be_truthy
    end

    example "return false for invalida URL" do
      post = build(:post, url: 'http://')
      expect(post.valid?).to be_falsey
    end
  end
end
