module AvatarHelper

  def self.avatar_colours
    # These are the colours available to be chosen in the editor,
    # and so this does not include "0", the special moderator colour
    1..10
  end

  def self.avatar_faces
    1..10
  end

end