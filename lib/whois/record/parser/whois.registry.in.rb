#--
# Ruby Whois
#
# An intelligent pure Ruby WHOIS client and parser.
#
# Copyright (c) 2009-2011 Simone Carletti <weppos@weppos.net>
#++


require 'whois/record/parser/base'


module Whois
  class Record
    class Parser

      #
      # = whois.registry.in parser
      #
      # Parser for the whois.registry.in server.
      #
      # NOTE: This parser is just a stub and provides only a few basic methods
      # to check for domain availability and get domain status.
      # Please consider to contribute implementing missing methods.
      # See WhoisNicIt parser for an explanation of all available methods
      # and examples.
      #
      class WhoisRegistryIn < Base

        property_supported :status do
          if content_for_scanner =~ /Status:(.+?)\n/
            content_for_scanner.scan(/Status:(.+?)\n/).flatten.map(&:downcase)
          end
        end

        property_supported :available? do
          (content_for_scanner.strip == "NOT FOUND")
        end

        property_supported :registered? do
          !available?
        end


        property_supported :created_on do
          if content_for_scanner =~ /Created On:(.*?)\n/
            Time.parse($1)
          end
        end

        property_supported :updated_on do
          if content_for_scanner =~ /Last Updated On:(.*?)\n/
            Time.parse($1)
          end
        end

        property_supported :expires_on do
          if content_for_scanner =~ /Expiration Date:(.*?)\n/
            Time.parse($1)
          end
        end


        property_supported :registrar do
          if content_for_scanner =~ /Sponsoring Registrar:(.+)\s+\((R[0-9]+-AFIN)\)\n/
            Record::Registrar.new(:id => $2, :name => $1)
          end
        end


        property_supported :nameservers do
          content_for_scanner.scan(/Name Server:([^\s]+)\n/).flatten.map do |name|
            Record::Nameserver.new(name.downcase)
          end
        end

      end

    end
  end
end
