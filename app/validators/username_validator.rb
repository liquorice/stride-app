class UsernameValidator < ActiveModel::EachValidator
  # Usernames can not include an "@" symbol, so as not to interfere
  # when searching for a user by name *or* email such as in forgot_password
  def validate_each(record, attribute, value)
    if value.include?('@')
      record.errors[attribute] << (options[:message] || "can not contain @")
    end
  end
end
