# CucumberWeb

1. bundle
2. mkdir test_out (if not exist)
3. SAUCE_USERNAME='username' SAUCE_API_KEY='key' cucumber features/Tests.feature:10

All settings inside env.rb 

  - Set server to :remote(for SAUSELAB) or :local (to run tests locally)
SERVER = (ENV['SERVER'] || :local).to_sym

  - Set browser to :chrome, :firefox if SERVER == local
  - Set browser to :chrome_windows, :chrome, :firefox if if server == remote
BROWSER = (ENV['BROWSER'] || :chrome).to_sym

- You can add more cap do the method, or you modify current list of caps
- About browser_caps: https://wiki.saucelabs.com/display/DOCS/Platform+Configurator#/
def browser_caps
  if BROWSER == :chrome_windows
    return { :platform => "Windows 7", :browserName => "Chrome", :version => "45" }
  elsif BROWSER == :chrome
    return { :platform => "Mac OS X 10.9", :browserName => "Chrome", :version => "31"  }
  elsif BROWSER == :firefox
    return { :platform => "Mac OS X 10.10.5", :browserName => "Firefox", :version => "48" }
  end
end
 
