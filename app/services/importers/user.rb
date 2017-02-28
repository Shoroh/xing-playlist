class Importers::User
  USER_COLUMNS = [:first_name, :last_name, :email, :user_name].freeze

  def initialize(csv_file)
    @csv_file = CSV.foreach(csv_file, headers: true, header_converters: :symbol)
    @counter = 0
    @errors = []
    @log = ActiveSupport::Logger.new(File.new('log/import/users.log', 'w'))
    @start_time = Time.zone.now
    @users_count = ::User.count
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
    @errors.each {|error| puts error }
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
    @log.close
  end

  def import!
    @csv_file.each_with_index do |row, index|
      user = assign_from_row(row)
      if user.save
        @counter += 1
      else
        error_message = "User ##{index + 1} — #{user.errors.full_messages.to_sentence}"
        @errors << error_message
        @log.info error_message
      end
    end
  end

  def assign_from_row(row)
    user = ::User.where(email: row[:email]).first_or_initialize
    user.assign_attributes(row.to_hash.slice(*USER_COLUMNS))
    user
  end

  def valid?
    (USER_COLUMNS & @csv_file.first.headers).size == USER_COLUMNS.size
  end
end
