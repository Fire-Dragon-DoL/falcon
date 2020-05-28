module Domain
  module DateTime
    module Parse
      class Array
        def self.call(ary)
          instance = new
          instance.(ary)
        end

        def call(ary)
          Time.use_zone('UTC') do
            Time.zone.local(*ary)
          end
        end
      end

      class ISO8601
        def self.call(ary)
          instance = new
          instance.(ary)
        end

        def call(value)
          Time.zone.parse(value)
        end
      end
    end
  end
end
