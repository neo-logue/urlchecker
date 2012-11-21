#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'rubygems'
require 'thor'
require 'uri'
require 'mechanize'

class UrlChecker < Thor
  desc "check", "check FILEでファイル中のリンクをチェックします"
  def check(text_path)
    file = open(text_path)
    content = file.read

    mechanize = Mechanize.new

    urls = URI.extract content
    urls.each do |url|
      puts "チェック中: #{url}"
      begin
        page = mechanize.get(url)
      rescue Mechanize::ResponseCodeError, Errno::ETIMEDOUT, Timeout::Error
        puts "!!!!!!!!!! URL ERROR !!!!!!!!!"
        next
      end
      puts "\tOK: #{page.title}"
    end
  end
end

UrlChecker.start
