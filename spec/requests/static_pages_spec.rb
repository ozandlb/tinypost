require 'spec_helper'

describe "StaticPages" do


  describe "Home page" do

    it "should have the h1 'RoR App 1'" do
      visit '/static_pages/home'
      page.should have_selector('h1', :text=>'RoR App 1')
    end

    it "should have the title 'Home'" do
      visit '/static_pages/home'
      page.should have_selector('title', 
                                :text=>"RoR App 1 | Home")
    end
  end


  describe "Help page" do

    it "should have the h1 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('h1', :text=>'Help')
    end

    it "should have the title 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('title', 
                                :text=>"RoR App 1 | Help")
    end
  end


  describe "About Us page" do

    it "should have the h1 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('h1', :text=>'About Us')
    end

    it "should have the title 'About Us'" do
      visit '/static_pages/about'
      page.should have_selector('title', 
                              :text=>"RoR App 1 | About Us")
    end
  end



end
