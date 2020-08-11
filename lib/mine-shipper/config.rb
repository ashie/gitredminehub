require 'optparse'
require 'dotenv/load'

module MineShipper
  class Config < Hash
    DEFAULT_CONFIG = {
      log_level: ENV["MINE_SHIPPER_LOG_LEVEL"] || 'WARN',
      github: {
        access_token: ENV["GITHUB_ACCESS_TOKEN"],
        issue: nil
      },
      redmine: {
        base_url: ENV["REDMINE_BASE_URL"],
        custom_field_name: ENV["REDMINE_CUSTOM_FIELD_NAME"],
        api_key: ENV["REDMINE_API_KEY"],
      }
    }

    def initialize(argv = ARGV)
      self.merge!(DEFAULT_CONFIG)
      OptionParser.new do |opts|
        opts.on("--github-issue ISSUE") do |github_issue|
          self[:github][:issue] = github_issue
        end
        opts.parse!(argv)
      end
    end
  end
end
