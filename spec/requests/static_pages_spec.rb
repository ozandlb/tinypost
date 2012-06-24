require 'spec_helper'

describe "StaticPages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { body.should have_selector('h1', text:heading) }
    it { body.should have_selector('title', text:full_title(page_title)) } 
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)     { 'Ruby on Rails Base App' }
    let(:page_title)  { '' }
    it_should_behave_like "all static pages"
    it { body.should_not have_selector('title', text: '| Home') }

    #it { should_not have_selector('div.pagination') }

    describe "for signed in users" do
      let(:user) { FactoryGirl.create(:user) }


      describe "with one micropost" do

        before do
          FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
          sign_in user
          visit root_path
        end #before

        it "should render the user's feed" do
          user.feed.each do |item|
            page.should have_selector("li##{item.id}", text: item.content)
          end #do |variable|
        end #should render the user's feed

        it "should have 1 micropost (singular)" do
          user.microposts.count.should == 1
          page.should have_selector('span', text: "1 micropost")
        end # should have 1 micropost (singluar)

      end #with one micropost

      describe "with two microposts" do

        before do
          FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
          FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
          sign_in user
          visit root_path
        end #before

        it "should render the user's feed" do
          user.feed.each do |item|
            page.should have_selector("li##{item.id}", text: item.content)
          end #do
        end #should render the user's feed

        it "should have 2 microposts (plural)" do
          user.microposts.count.should == 2
          page.should have_selector('span', text: "2 microposts")
        end # should have 2 microposts (plural)


        describe "follower/following counts" do
          let(:other_user) { FactoryGirl.create(:user) }
          before do
            other_user.follow!(user)
            visit root_path
          end #before
          
          it { should have_link("0 following", href: following_user_path(user)) }
          it { should have_link("1 followers", href: followers_user_path(user)) }
          
        end # follower/following counts


        describe "pagination" do

          #it "should have a pagination div" do
          #page.should have_selector('div.pagination')
          # it { should have_selector("div", class: "falsepositive") }
          # it { should have_selector('div.pagination') } 
          # ================  FAILED TEST, PLEASE FIX ===============
          # ================  FAILED TEST, PLEASE FIX ===============
          # ================  FAILED TEST, PLEASE FIX ===============

          it "should list each micropost" do
            Micropost.paginate(page: 1).each do |micropost|
              page.should have_selector('li#'<<micropost.id.to_s)
              #pp micropost.id
            end #each micropost
          end #should list each micropost
        end # pagination

      end #with two microposts
    end # for signed in users
  end #Home page

  describe "Help page" do
    before { visit help_path }
    let(:heading)     { 'Help' }
    let(:page_title)  { 'Help' }
    it_should_behave_like "all static pages"
  end

  describe "About Us page" do
    before { visit about_path }
    let(:heading)     { 'About Us' }
    let(:page_title)  { 'About Us' }
    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading)     { 'Contact Us' }
    let(:page_title)  { 'Contact Us' }
    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About Us')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Contact"
    page .should have_selector 'title', text: full_title('Contact')
    click_link "Home"
    page.should have_selector 'title', text: full_title('')
    click_link "Sign up now!"
    page.should have_selector 'title', text: full_title('Sign Up')
  end
end
