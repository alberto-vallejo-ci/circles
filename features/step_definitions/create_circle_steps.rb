Given /^A circle exists$/ do
  Fabricate :circle
end

Given /^(?:|I )see the users circles$/ do
  step 'wait for the request "1" seconds'
  page.all('.circle').count.should eq 2
end

#Given /^(?:|I )see my circle$/ do
#  page.find('.circle').count.should eq 2
#end