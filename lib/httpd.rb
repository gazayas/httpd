require "httpd/version"
require "httpd/statuses"

require "optparse"
require "colorize"

module Httpd
  OptionParser.new do |opts|
    opts.banner = "A command line tool for looking up the details of http (HyperText Transfer Protocol) statuses"
    opts.separator ""
    opts.separator "Options:"

    options = {}

    colorizeAndPrint = Proc.new { |stat|
      stat[:number] = stat[:number].to_s
      case stat[:classification]
      when "Information Response"
        print stat[:number].colorize(:cyan)
      when "Success"
        print stat[:number].colorize(:light_green)
      when "Redirection"
        print stat[:number].colorize(:light_cyan)
      when "Client Error"
        print stat[:number].colorize(:light_red)
      when "Server Error"
        print stat[:number].colorize(:light_yellow)
      end
    }

    opts.on("-s [NUMBER]",
            OptionParser::DecimalInteger,
            "Shows the status with details if a number is selected. If no number, shows a master list of all statuses"
            ) do |i|
      if i == nil
        Statuses.each do |stat|
	  colorizeAndPrint.call(stat)
          print " #{stat[:status]} (#{stat[:classification]})\n"
        end
      else
        Statuses.each do |stat|
          if stat[:number] == i
	    colorizeAndPrint.call(stat)

            if ARGV.include?("-jp")
              print " #{stat[:status]} (#{stat[:classification]})\n#{stat[:details_jp]}\n"
            else
              print " #{stat[:status]} (#{stat[:classification]})\n#{stat[:details]}\n"
            end

            break
          end
        end
      end
    end

    opts.on("-jp", "Shows status details in Japanese (日本語で詳細を表示します。-s [NUMBER]の後に定義。）") do |v|
      options[:jp] = v
    end

    opts.on_tail("-h", "--help", "Shows this") do |help|
      puts opts
    end

    opts.on_tail("-v", "--version", "Show version") do
      puts VERSION
      exit
    end
  end.parse!
end
