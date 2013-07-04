require 'selenium-framework'
require 'selenium-webdriver'
require 'test/unit'
require 'date'
require 'csv'
require 'faker'
require 'mail'
require 'open-uri'
require 'nokogiri'
require 'uri'
require 'headless'
require 'fileutils'
require 'xmlsimple'
require 'ostruct'
require 'random-word'
Dir.chdir('testcases')
Dir['**/*'].reject { |fn| File.directory?(fn) }.each do |r|
  require '../testcases/'+r
end
Dir.chdir('..')
