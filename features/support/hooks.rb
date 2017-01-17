
Before do |scenario|
  $logger.info "Starting scenario '#{scenario.name}'"
  $setup.reset_session!
end
#
# After do
#   # $setup.quit
# end

