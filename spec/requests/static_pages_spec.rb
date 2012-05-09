require 'spec_helper'

describe "StaticPages" do

  #render_views

  #let(:base_title) { "RoR App 1" }

  describe "Home page" do
    before { visit root_path }

    it { body.should have_selector('h1', text: 'RoR App 1') }
    it { body.should have_selector('title', text: full_title('')) }
    it { body.should_not have_selector('title', text: '| Home') }
  end

  describe "Help page" do
    before { visit help_path }
    it { body.should have_selector 'h1', text: 'Help' }
    it { body.should have_selector('title', text: full_title('Help')) }
  end

  describe "About Us page" do
    before { visit about_path }
    it { body.should have_selector 'h1', text: 'About Us' }
    it { body.should have_selector('title', text: full_title('About Us')) }
  end

  describe "Contact page" do
    before { visit contact_path }
    it { body.should have_selector 'h1', text: 'Contact Us' }
    it { body.should have_selector('title', text: full_title('Contact Us')) }
  end

end
