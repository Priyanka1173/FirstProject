# module Assertion
#   def assert_redirection(expected_page, tries=3)
#     $logger.info "Asserting being on page '#{expected_page}'..."
#     if tries > 0
#       begin
#         expect(expected_page).to be_displayed
#       rescue Exception => e
#         assert_redirection(expected_page, tries-1)
#       end
#     end
#     expect(expected_page).to be_displayed
#   end
# end