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

  def find_bank(bank_name)
    resp = Client.new.find_bank(bank_name)
    resp['d']['results'].map { |result|
      FDIC::Bank.new(result)
    }
  end

  def find_institution(cert_number)
    resp = Client.new.find_institution(cert_number)
    resp['d']['results'].map { |result|
      FDIC::Institution.new(result)
    }
  end

  def find_branches(cert_number)
    resp = Client.new.find_branches(cert_number)
    resp['d']['results'].map { |result|
      FDIC::Branch.new(result)
    }
  end

  def find_history_events(bank_name, cert_number)
    resp = Client.new.find_history_events(bank_name, cert_number)
    resp['d']['results'].map { |result|
      FDIC::HistoryEvent.new(result)
    }
  end

  extend self
end
