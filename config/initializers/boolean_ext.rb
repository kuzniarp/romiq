class TrueClass

  alias_method :orig_to_s, :to_s
  
  def to_s format=nil
    case format
    when :activation 
      "Aktywna"
    else 
      orig_to_s
    end
  end
end

class FalseClass

  alias_method :orig_to_s, :to_s
  
  def to_s format=nil
    case format
    when :activation 
      "Nieaktywna"
    else 
      orig_to_s
    end
  end
end
