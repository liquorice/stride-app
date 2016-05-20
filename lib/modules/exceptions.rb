module Exceptions
  class NotFoundError < StandardError
  end

  class NotAuthorisedError < StandardError
  end

  class SuspendedUserError < StandardError
  end

end