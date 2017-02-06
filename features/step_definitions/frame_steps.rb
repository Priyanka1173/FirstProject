When(/^I switch to "([^"]*)" frame$/) do |frame|
   tinymce.switch_to frame
end

Then(/^I type "([^"]*)" into WYSIWYG Editor$/) do |text|
  @editor = tinymce.editor
  @before_text = @editor.text
  @editor.clear
  @editor.send_keys text

end

And(/^new text should not equal old one$/) do
  after_text = @editor.text
  expect(after_text).not_to eql @before_text
end

Then(/^I return to default frame$/) do
  tinymce.switch_to_default
  expect(tinymce.page_title.text).not_to be_empty
end


