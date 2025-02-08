module Durationable
  extend ActiveSupport::Concern
  DURATION_UNIT = %w[hours days weeks months years].freeze
  DURATIONS = (1..12).to_a.freeze
  included do
    validates :duration, presence: true
    validate :validate_duration_format

    after_initialize :set_default_duration

    def formatted_duration
      "#{duration['period']} #{duration['unit']}"
    end
  end

  def validate_duration_format
    return if duration.is_a?(Hash) && duration.key?('unit') && duration.key?('period')

    errors.add(:duration, "must be a JSON object with 'unit' and 'period' keys")
  end

  private

  def set_default_duration
    self.duration ||= { unit: nil, period: nil }
  end
end
