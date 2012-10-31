module FormattingHelper
  # Retorna um número dentro de parênteses caso ele seja maior que zero.
  def parentize(number)
    result = ""
    if number > 0
      result = "(" + number.to_s + ")"
    end
  end
end
