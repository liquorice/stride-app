module AccessLevelHelper

  def access_levels_hash_for_user(user)
    assignable_access_levels = @site.access_levels.select{|l| user.can_set_access_level?(l) }
    Hash[assignable_access_levels.map{|l| [l.id, l.name] }]
  end

end