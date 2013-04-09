Then /^show me the page$/ do
  save_and_open_page
end

Then /^I should see "(.*?)", "(.*?)" and "(.*?)" in the map$/ do |name1, name2, name3|
  org1 = Organization.find_by_name(name1)
  org2 = Organization.find_by_name(name2)
  org3 = Organization.find_by_name(name3)
  #page.should have_xpath "//script[contains(.,'Gmaps.map.markers = [{\"lat\":#{org3.latitude},\"lng\":#{org3.longitude}},{\"lat\":#{org1.latitude},\"lng\":#{org1.longitude}},{\"lat\":#{org2.latitude},\"lng\":#{org2.longitude}')]"
  page.should have_xpath "//script[contains(.,'Gmaps.map.markers = #{Organization.all.to_gmaps4rails}')]"
  Organization.all.to_gmaps4rails.should match(name1)
  Organization.all.to_gmaps4rails.should match(name2)
  Organization.all.to_gmaps4rails.should match(name3)
end

Given /the following organizations exist/ do |organizations_table|
  organizations_table.hashes.each do |org|
    Organization.create! org
  end
end

Given /^I am on the home page$/ do
  visit "/"
end

Given /^I am on the sign in page$/ do
  visit new_charity_worker_session_path
end

Given /^I am on the sign up page$/ do
  visit new_charity_worker_registration_path
end

Then /^I should be on the new charity page$/ do
 current_path.should == new_organization_path
end

Then /^I should see "(.*?)"$/ do |text|
  page.should have_content text
end


When /^I search for "(.*?)"$/ do |text|
  fill_in 'q', with: text
  click_button 'Search'
end

Then /^I should see contact details for "([^"]*?)"$/ do |text|
  page.should have_content text
end

Then /^I should see contact details for "([^"]*?)" and "(.*?)"$/ do |text1, text2|
  page.should have_content text1
  page.should have_content text2
end


Then /^I should see contact details for "([^"]*?)", "([^"]*?)" and "(.*?)"$/ do |text1, text2, text3|
  page.should have_content text1
  page.should have_content text2
  page.should have_content text3
end
Given /^I sign in as "(.*?)" with password "(.*?)"$/ do |email, password|
  fill_in "Email" , :with => email
  fill_in "Password" , :with => password
  click_button "Sign in"
end

Given /^the following users are registered:$/ do |charity_workers_table|
  charity_workers_table.hashes.each do |charity_worker|
    CharityWorker.create! charity_worker
  end
end

Then /^I should be on the sign in page$/ do
  current_path.should == new_charity_worker_session_path
end

