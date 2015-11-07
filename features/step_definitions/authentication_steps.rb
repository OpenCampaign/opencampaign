Given /^I am not logged in$/ do
  visit '/logout'
end

Given /^I am logged in as an authenticated user$/ do
  user = FactoryGirl.create(:user)
  page.set_rack_session(user_id: user.id)
end

When(/^I login through the authentication provider$/) do
  visit '/auth/developer'
end

Then /^I should be logged in$/ do
  user = User.last
  user.name.should     == "John Locke"
  user.username.should == "johnlocke"
  user.email.should    == "john.locke@gmail.com"
end
