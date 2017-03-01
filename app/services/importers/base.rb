class Importers::Base
  def initialize(csv_file)
    @csv_file = CSV.foreach(csv_file, encoding: 'utf-8', headers: true, header_converters: :symbol)
    @counter = 0
    @errors = []
    @log = ActiveSupport::Logger.new(File.new('log/import_csv.log', 'w'))
    @start_time = Time.zone.now
  end

  def import
    if valid?
      log_start
      import!
      log_stop
    else
      @errors << 'File is invalid, check the columns!'
      false
    end
  end

  def errors_messages
    @errors.join("\n")
  end

  def has_error?
    @errors.any?
  end

  def counter
    @counter
  end

  private

  def log_start
    @log.info "Import started at #{@start_time}"
  end

  def log_stop
    end_time = Time.zone.now
    duration = (end_time - @start_time) / 1.second
    @log.info "Import finished at #{end_time} and last #{duration} seconds."
    @log.info "Imported #{@counter} records."
    @log.close
  end

  def import!
    @csv_file.each_with_index do |row, index|
      record = assign_from_row(row)
      if record.save
        @counter += 1
      else
        error_message = "Record ##{index + 1} — #{record.errors.full_messages.to_sentence}"
        @errors << error_message
        @log.info error_message
      end
    end
  end

  def valid?
    (columns & @csv_file.first.headers).size == columns.size
  end
end
