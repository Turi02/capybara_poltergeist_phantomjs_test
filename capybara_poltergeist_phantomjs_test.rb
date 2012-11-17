#!/usr/bin/env ruby
require 'phantomjs'
require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
	Capybara::Poltergeist::Driver.new app, phantomjs: Phantomjs::path, debug: true
end

Capybara.run_server= false
Capybara.default_driver= :poltergeist
Capybara.use_default_driver

module Browse
	class Google
		include Capybara::DSL
		Capybara.app_host= "http://www.google.com.tr"
		def search q
			visit "/"
			fill_in "q", with: q
			click_button "Google'da Ara"
			page.driver.render "google-#{Time.now}-#{q}.pdf"
		end
	end
end

google= Browse::Google.new 
google.search "nurettin"

