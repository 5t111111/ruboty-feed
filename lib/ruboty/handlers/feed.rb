require 'ruboty'
require 'ruboty/feed'
require 'feedjira'

module Ruboty
  module Handlers
    class Feed < Base
      on(
        /subscribe (?<feed_url>.+)/,
        description: 'Subscribe a feed',
        name: :subscribe
      )

      def subscribe(message)
        feed_url = message[:feed_url].strip
        feed = Feedjira::Feed.fetch_and_parse(feed_url)

        feed.entries.each do |e|
          entry = Ruboty::Feed::Entry.new(e, robot)
          next if entry.stored?
          message.reply(entry.format)
          entry.store!
          sleep 0.5
        end
      end
    end
  end
end
