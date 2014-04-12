Given /^A circle exists$/ do
  Fabricate :circle
end

Given /^(?:|I )see the existing circle$/ do
  page.should have_css('#circle_1234567890')
end

Given /^(?:|I) see "([^"]*)" circles$/ do |number|
  step 'wait for the request "1" seconds'
  page.all('.circle').count.should eq number.to_i
end