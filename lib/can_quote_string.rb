module CanQuoteString

  private

  # Вспомогательная утилита для safe write в базу:
  # экранирует одинарные кавычки в строках
  def _quote(s)
    return unless s
    if s.is_a?(String)
      return s.gsub(/\\/, '\&\&').gsub(/'/, "''") # ' (for ruby-mode)
    end
    s
  end

end
