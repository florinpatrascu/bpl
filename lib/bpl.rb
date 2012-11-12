require "version"
require 'yajl'
require "models/blood_pressure"
require "csv"

module Bpl
  def options(opts={})
    @opts=opts
  end
  
  def self.add(sys, dia, hr, arm='l', weight=nil)
    @sys = sys.to_i
    @dia = dia.to_i
    @hr  = hr.to_i
    @arm = arm
    @weight = weight
    
    if weight.nil?
      begin
        @weight = BloodPressure.most_recent.weight
      rescue => e
        puts "Problems: #{e.message}"
        puts "You should add your weight next time. It is: 0, now."
        @weight = 0
      end      
    end
    
    if @opts[:datetime]
      @created_at = Chronic.parse @opts[:datetime]
    else
      @created_at = Chronic.parse "#{@opts[:date]} #{@opts[:time]}"
    end
    
    bp = BloodPressure.new(:sys => @sys, :dia => @dia, :hr => @hr, 
                           :arm => arm(@arm), :weight => @weight,
                           :created_at => @created_at, 
                           :notes => @opts[:message])
    bp.save
    Bpl.echo unless @opts[:quiet]
    bp
  end

  def self.remove(id)
    begin
      BloodPressure.find(id).delete unless id.nil?
      puts "record: \##{id}, was removed."
    rescue => e
      puts e.message
    end
    
  end
  
  def self.view(silent=false)
    table = [['ID', 'DATE', 'SYS', 'DIA', 'HR', 'ARM', 'WEIGHT', 'NOTES']]
    records = []
    
    if @opts[:all]
      records = BloodPressure.all_records
    else
      records = BloodPressure.records_since(Chronic.parse(@opts[:date]), @opts[:page])
    end
    
    if records.empty?
      puts "the database has no records."
    else
      records.each do |r|
        table << [r.id ,"#{r.date_collected} #{r.time_collected.time_of_day}", r.sys, r.dia, r.hr, r.arm, r.weight, r.notes.nil? ? '' : r.notes]
      end

      if @opts[:raw]
        table.shift
        puts table.inspect
      else
        puts Tablizer::Table.new(table, header: true) # can add align: 'ansi_rjust'
      end unless silent
    end

    table   
  end
  
  def self.echo    
    puts "[#{@created_at.inspect}] Sys: #{@sys}, DIA: #{@dia}, HR: #{@hr}, arm: #{arm(@arm)}, W: #{@weight}; Notes: #{@opts[:message]}"
  end
  
  def self.export
    begin      
      table = Bpl.view true      
      csv_string = CSV.generate do |csv|
        csv << table[0]
        table.shift
        table.each do |r|
          csv << [r[0], "'#{r[1]}'", r[2], r[3], r[4], "'#{r[5]}'", r[6], "'#{r[7]}'"]
        end
      end
      
      csv_string
    rescue => e
      # puts e.inspect
      # puts e.backtrace
      # or:
      puts caller
      puts "Error while exporting the data: #{e.message}"
      ''
    end    
  end
  
  protected
  def arm(which_one)
    which_one =~ /[rR]/ ? 'RIGHT' : 'LEFT'
  end
  
end
