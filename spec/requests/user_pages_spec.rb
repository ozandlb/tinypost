require 'spec_helper'

describe "UserPages" do

  subject { page }

  describe "Signup page" do
    before { visit signup_path }
    it { body.should have_selector 'h1', text: 'Sign Up' }
    it { body.should have_selector 'title', text: full_title('Sign Up') }
  end
end
