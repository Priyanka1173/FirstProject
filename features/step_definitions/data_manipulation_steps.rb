Given(/^I have a "([^"]*)" object$/) do |factory_name, *table|
  if table.size != 0
    @parsed_table = table[0].rows_hash
  end
  params = FactoryGirl.attributes_for(factory_name.to_sym, @parsed_table)
  instance_variable_set("@#{factory_name}", params)
  $logger.info "Initialized #{factory_name} factory object"
end
