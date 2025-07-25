require "rails"
require 'terminal-table'
require 'csv'
require 'simple_form'
require 'active_record'
require 'ransack'
require 'kaminari'

# Only require sprockets/rails if it's available
begin
  require 'sprockets/rails'
rescue LoadError
  # sprockets-rails is not available, continue without it
end

module RailsDb
  # Custom require relative that work with older rubies also
  # def self.require_relative(path)
  #   full_path = File.expand_path(path, File.dirname(__FILE__))
  #   Kernel.require(full_path)
  # end

  # gem in enabled
  mattr_accessor :enabled
  @@enabled = true

  # Allow read only operations
  mattr_accessor :sandbox
  @@sandbox = false

  # automatic engine routes mouting
  mattr_accessor :automatic_routes_mount
  @@automatic_routes_mount = true

  # set tables which you want to hide ONLY
  mattr_accessor :black_list_tables
  @@black_list_tables = []

  # set tables which you want to show ONLY
  mattr_accessor :white_list_tables
  @@white_list_tables = []

  # Enable http basic authentication
  mattr_accessor :http_basic_authentication_enabled
  @@http_basic_authentication_enabled = false

  # Enable http basic authentication
  mattr_accessor :http_basic_authentication_user_name
  @@http_basic_authentication_user_name = 'rails_db'

  # Enable http basic authentication
  mattr_accessor :http_basic_authentication_password
  @@http_basic_authentication_password = 'password'

  # If you want to enable access by specific conditions
  mattr_accessor :verify_access_proc
  @@verify_access_proc = proc { |controller| true }

  def self.setup
    yield(self)
  end

  def self.use_default_configuration!
    self.enabled                            = true
    self.automatic_routes_mount             = true
    self.black_list_tables                  = self.white_list_tables = []
    self.http_basic_authentication_enabled  = false
    self.verify_access_proc                 = proc { |controller| true }
  end

end

require_relative "libs"
require_relative "rails_db/engine"
require_relative "rails/routes"
require_relative "ext/simple_form_ext"
