require 'httparty'
require 'logger'
require "fdic/version"
require 'fdic/client'
require 'fdic/record'
require 'fdic/bank'
require 'fdic/institution'
require 'fdic/branch'
require 'fdic/history_event'

module FDIC
  module BankFind

    def find_bank(bank_name)
      resp = Client.new.find_bank(bank_name)
      resp['d']['results'].map { |result|
        Bank.new(result)
      }
    end

    def find_institution(certificate_number)
      resp = Client.new.find_institution(certificate_number)
      result = resp['d']['results'].first
      Institution.new(result)
    end

    def find_branches(certificate_number)
      resp = Client.new.find_branches(certificate_number)
      resp['d']['results'].map { |result|
        Branch.new(result)
      }
    end

    def find_history_events(bank_name, certificate_number)
      resp = Client.new.find_history_events(bank_name, certificate_number)
      resp['d']['results'].map { |result|
        HistoryEvent.new(result)
      }
    end

    extend self
  end
end
