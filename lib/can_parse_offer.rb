# Оснащает двумя методами для работы с <offers> XML каталога.
#
module CanParseOffer
  include CanQuoteString

  private


  # Разберёт детей узла <offer> из XML каталога.
  #
  # @param  [Nokogiri::XML::Element] offer
  # @return [Array of Hashes]
  #
  def _map_offer(offer)
    offer.children.map do |ccc|
      [ccc.name, ccc.text.strip] if ccc.elem?
    end.compact
  end


  # Выдаст значение из mapped-массива по имени узла.
  #
  # @param [Array of Hashes] mapped
  # @param [String] name
  # @return [String]
  #
  def _fetch(mapped, name)
    res = mapped.find { |e| e[0] == name }[1] rescue nil
    _quote res
  end


  # Вспомогательная утилита для парсинга:
  # Преобразует `true` в 1 а `false` в 2
  #
  def _bool(value)
    value.to_s.eql?('true') ? 1 : 0
  end


end
