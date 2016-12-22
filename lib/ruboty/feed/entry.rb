module Ruboty
  module Feed
    class Entry
      NAMESPACE = -'entry'

      attr_reader :url

      def initialize(e, robot)
        p e
        @url = e.url
        @id = e.entry_id
        @published = e.published
        @updated = e.updated
        @title = e.title
        @author = e.author
        @content = e.content
        @robot = robot
      end

      def stored?
        store[@id] ? true : false
      end

      def store!
        store[@id] = true
      end

      def store
        @robot.brain.data[NAMESPACE] ||= {}
      end

      def format
        <<-EOS
*#{@title}* (#{@published.strftime('%Y-%m-%d %H:%M:%S %Z')})
#{@url}
        EOS
      end
    end
  end
end
