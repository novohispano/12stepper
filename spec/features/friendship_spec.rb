require 'spec_helper'

describe "User Friendships" do
  before :each do
    @user1 = FactoryGirl.create(:user)
    @user2 = FactoryGirl.create(:user, email: "billy@example.com", username: "billy")
    @user3 = FactoryGirl.create(:user, email: "benny@example.com", username: "benny")
    FactoryGirl.create(:friendship, user_id: @user1.id, friend_id: @user2.id, status: "approved")
    FactoryGirl.create(:friendship, user_id: @user3.id, friend_id: @user1.id, status: "pending")
  end

  context "user can request a friend" do
    it "can find a user and request to be her friend", js: true do
      friendship_login
      click_on "Welcome back, SecretSanta!"
      click_on "Find Friends"

      expect(current_path).to eq(new_friends_search_path(locale: :en))
      
      fill_in "Search for a Friend", with: "billy"
      page.execute_script("$('#friend-search-form').submit()")

      within "#friend-search-results" do
        expect(page).to_not have_content("benny")
        within "#search-result-billy" do
          expect(page).to have_content("billy")
          page.execute_script("$('#search-result-billy form').submit()")
        end
      end

      expect(page).to have_content("Your friend request was sent.")
    end
  end

  context "user views all of her friendships" do
    it "should see all of its friends on the friend index page", js: true do
      friendship_login

      click_on "Welcome back, SecretSanta!"
      click_on "View My Friends"
      expect(page).to have_content(@user2.username)
    end
  end

  context "user accepts a friend request" do
    it "can see pending friend requests", js: true do
      friendship_login
      click_on "Welcome back, SecretSanta!"
      click_on "View My Friends"

      within "#pending-friendships" do
        expect(page).to have_content "benny"
        within "#pending-benny" do
          click_on "Accept"
        end
      end

      expect(page).to have_content("You are now friends with benny.")
    end
  end

  def friendship_login
    visit login_path(locale: :en)
    page.execute_script("$('#password').show()")
    within "#login-form" do
      fill_in "email", with: @user1.email
      fill_in "password", with: @user1.password
      click_on "Log in"
    end
  end
end