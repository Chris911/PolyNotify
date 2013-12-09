require 'httparty'
require 'nokogiri'
require 'digest/md5'
require 'json'

require_relative 'PolyNotify/utilities'
require_relative 'PolyNotify/dossier_etudiant'

module PolyNotify
  class Client
    [HTTParty, Utilities, Dossier_Etudiant].each do |inc|
      include inc
    end

    def initialize
      @baseurl = 'https://www4.polymtl.ca'
      @headers = {'User-Agent' => 'PolyNotify v0.1'}
      @checksum_file = "#{ENV['HOME']}/.polynotify"
      @inputs = {}

      # For HTTParty
      self.class.base_uri @baseurl
      self.class.headers @headers
    end

    def load_config_file(file)
      @config = YAML.load(File.open(file))
    end

    def load_config_hash(hash)
      @config = hash
    end

    def checksum
      @checksum
    end

    def last_checksum
      File.read(@checksum_file)
    end

    def save_checksum
      File.open(@checksum_file, 'w') { |file| file.write(@checksum) }
    end
  end
end