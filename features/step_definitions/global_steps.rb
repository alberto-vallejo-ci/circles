Given /^(?:|I )wait for the request "([^"]*)" seconds$/ do |seconds|
  sleep seconds.to_i
end

Given /^(?:|I am) on browser "([^"]*)"$/ do |name|
  Capybara.session_name = name
end