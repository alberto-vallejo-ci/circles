Given /^(?:|I )wait for the request "([^"]*)" seconds$/ do |seconds|
  sleep seconds.to_i
end