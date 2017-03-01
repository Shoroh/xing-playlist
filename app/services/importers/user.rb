class Importers::User < Importers::Base
  USER_COLUMNS = [:first_name, :last_name, :email, :user_name].freeze

  private

  def assign_from_row(row)
    user = ::User.where(email: row[:email]).first_or_initialize
    user.assign_attributes(row.to_hash.slice(*columns))
    user
  end

  def columns
    USER_COLUMNS
  end
end
