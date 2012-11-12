require 'active_record'
require "time_of_day"
require "date"
require "chronic"

class BloodPressure < ActiveRecord::Base
  # https://github.com/rails/rails/issues/783 :(
  # scope :most_recent, order("created_at DESC").first
  
  def self.records_since(date=Time.now, max=5)
    BloodPressure.where('created_at >= ?', date.beginning_of_day).order("created_at DESC").first(max)
  end

  def self.all_records
    BloodPressure.order("created_at DESC").all
  end

  def self.most_recent
    BloodPressure.where('weight > ?', 0).order("created_at DESC").first
  end
  
  def date_collected
    self.created_at.to_date
  end

  def time_collected
    self.created_at.time_of_day
  end

end