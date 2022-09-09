require 'capybara'
require 'capybara/cucumber'
require 'faker'
require 'selenium-webdriver'
require 'site_prism'
require 'ostruct'
require_relative 'page_helper.rb'

BROWSER = ENV['BROWSER']
AMBIENTE = ENV['AMBIENTE'] #homolog

CONFIG = YAML.load_file(File.dirname(__FILE__) + "/ambientes/#{AMBIENTE}.yml" ) #homolog.yml


World(Pages)

Capybara.register_driver :selenium do |app|
  if BROWSER.eql?('chrome')
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  
  # elsif BROWSER.eql?('chrome_headless')
  #   Capybara::Selenium::Driver.new(app, :browser => :chrome,
  #   desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
  #    'chromeOptions' => {'args' =>['--headless', 'disable-gpu']}
  #   )
  #   )
  elsif BROWSER.eql?('firefox')
    Capybara::Selenium::Driver.new(app, :browser => :firefox, :marionette => true)

  # elsif BROWSER.eql?('firefox_headless')
  #   browser_options = Selenium::WebDriver::Firefox::Options.new(args: ['--headless'])
  #   Capybara::Selenium::Driver.new(app, :browser => :firefox, options: browser_options)

    
  end
end



Capybara.configure do |config|
    config.default_driver = :selenium #selenium_chrome #selenium_chrome_headless
    config.app_host = CONFIG['url_padrao']
    config.default_max_wait_time = 5
  end