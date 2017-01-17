require_relative '../../features/support/errors.rb'

module SitePrism
  class Page

    def redirection(success, failure=nil, tries=1)

      def worker(data)
        array = []
        if !(data.instance_of? Array)
          array << data
        else
          array.concat data
        end
        return array
      end

      array = worker(success)
      array += worker(failure) if !failure.nil?
      while tries < 3
        array.each do |page|
          $logger.info "Checking for #{page} to be assessable..."
          if page.displayed? tries
            return page
          elsif !(failure.nil?) && failure.displayed?(tries)
            failure
          else
            $logger.warn "Redirection to #{success} or #{failure} has failed..."
            #raise RedirectionError "Redirection to #{success} or #{failure} has failed..."
          end
        end
        redirection(success, failure=nil, tries+1)
      end
      raise RedirectionError.new "Redirection to #{array} has failed..."
    end
  end
end
