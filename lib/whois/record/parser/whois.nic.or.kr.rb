#
# = Ruby Whois
#
# An intelligent pure Ruby WHOIS client and parser.
#
#
# Category::    Net
# Package::     Whois
# Author::      Simone Carletti <weppos@weppos.net>
# License::     MIT License
#
#--
#
#++


require 'whois/record/parser/whois.kr'


module Whois
  class Record
    class Parser

      # Parser for the <tt>whois.nic.or.kr</tt> server.
      # Aliases the <tt>whois.kr</tt>.
      WhoisNicOrKr = WhoisKr

    end
  end
end