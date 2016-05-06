require 'ruboty'
require 'ruboty/feed'
require 'feedjira'

module Ruboty
  module Handlers
    class Feed < Base
      NAMESPACE = 'feed'

      on(
        /subscribe (?<feed_url>.+)/,
        description: 'Subscribe a feed',
        name: :subscribe
      )

      def subscribe(message)
        feed_url = message[:feed_url]
        feed = Feedjira::Feed.fetch_and_parse(feed_url)

        feed.entries.each do |entry|
          next if stored?(entry.url)
          message.reply(entry.url)
          store_entry_url(entry.url)
        end
      end

      private

      def store
        robot.brain.data[NAMESPACE] ||= {}
      end

      def store_entry_url(entry_url)
        store[entry_url] = true
      end

      def stored?(entry_url)
        store[entry_url] ? true : false
      end
    end
  end
end
