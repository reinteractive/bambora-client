# frozen_string_literal: true

module Bambora
  module Bank
    module Adapters
      ##
      # Transforms hash keys from camelCase to snake_case and strips vendor-specific prefixes.
      class PaymentProfileResponse
        attr_reader :response

        def initialize(response)
          @response = response
        end

        def to_h
          parsed_query_string.each_with_object({}) do |(key, val), obj|
            obj[transform(key)] = val
          end
        end

        private

        def parsed_query_string
          Bambora::Adapters::QueryStringResponse.new(response).to_h
        end

        def transform(camel_case_word)
          word = camel_case_word.to_s
          word.gsub!(/([a-z])([A-Z\d])/, '\1_\2')
          word.downcase!
          word.sub(/^ord_/, '').to_sym
        end
      end
    end
  end
end