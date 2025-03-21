module Defaultable
  extend ActiveSupport::Concern

  class_methods do
    def defaults_for(key)
      defaults[key.to_sym] if defaults.key?(key.to_sym)
    end
  end
end