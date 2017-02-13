@success = true

# You can change cap's value, list of avaliable values
# https://wiki.saucelabs.com/display/DOCS/Platform+Configurator#/

def run_tests(platform, browser, version, junit_dir, html_dir)
  sh("platform=\"#{platform}\" browserName=\"#{browser}\" version=\"#{version}\" parallel_cucumber features -o \"--format junit --out #{junit_dir} --format html --out #{html_dir}.html --format pretty\" -n 20") do |success, _exit_code|
    @success &= success
  end
end

task :default => [:test_sauce]

task :windows_10_edge_14 do
  run_tests('Windows 10', 'edge', '14.14393', 'test_out/junit_reports/windows_10_edge_14', 'test_out/html_reports/windows_10_edge_14')
end

task :windows_10_firefox_49 do
  run_tests('Windows 10', 'firefox', '49.0', 'test_out/junit_reports/windows_10_firefox_49', 'test_out/html_reports/windows_10_firefox_49')
end

task :windows_7_ie_11 do
  run_tests('Windows 7', 'internet_explorer', '11.0', 'test_out/junit_reports/windows_7_ie_11', 'test_out/html_reports/windows_7_ie_11')
end

task :os_x_10_11_safari_10 do
  run_tests('OS X 10.11', 'safari', '10.0', 'test_out/junit_reports/os_x_10_11_safari_10', 'test_out/html_reports/os_x_10_11_safari_10')
end

task :os_x_10_10_chrome_54 do
  run_tests('OS X 10.10', 'chrome', '54.0', 'test_out/junit_reports/os_x_10_10_chrome_54', 'test_out/html_reports/os_x_10_10_chrome_54')
end

multitask :test_sauce => [
    :windows_10_edge_14,
    :windows_10_firefox_49,
    :windows_7_ie_11,
    :os_x_10_11_safari_10,
    :os_x_10_10_chrome_54
] do
  raise StandardError, "Tests failed!" unless @success
end
