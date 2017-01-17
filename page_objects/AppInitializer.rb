# Page Object Accessors
# Converts a method call to a page object class and establish a new instance
# Ex.
# @adminsite = PageObjects::AdminsiteApp.new
# @adminsite.home_page    # => HomePage
# @adminsite.login_page # => LoginPage

module PageObjects
  class AppInitializer

    def initialize(site)
      @pages = {}
      @site = site
    end

    def method_missing(name)
      klass = name.to_s.split('_').collect(&:capitalize).join
      @pages[klass.to_sym] ||= create_page_object_or_raise_error(klass)
    end

    private

    def create_page_object_or_raise_error(klass_string)
      begin
        class_name = "PageObjects::#{@site}::Pages::#{klass_string}".split("::").inject(Object) {|mod, class_name| mod.const_get(class_name)}
        class_name.new
      rescue
        $logger.error "Error instantiating pageobject class"
        raise StandardError, "There's no page object currently defined called #{klass_string}. Create one under features/page_objects"
      end
    end
  end

  class MainApplication < AppInitializer
    def initialize
      super("App")
    end
  end

end

