module Aggre
  module Services

    #
    # Сделает UPSERT в таблицу Товары.
    #

    class UpsertOffersService < AbstractUpsertService
      include CanParseOffer
      include CanPager


      # @param [Nokogiri::XML::NodeSet] offers      Список товаров.
      # @param [Integer]                shop_id     Primary Key магазина.
      #
      def call(offers, shop_id)
        # vals = values offers, shop_id
        # sql  = TPL_SQL % [table, cols * ',', vals, updates]
        # _execute sql

        # будем перебирать частями
        ptr   = 1
        limit = 1000
        while true
          # берём порцию данных
          page_offers = page offers, ptr, limit
          break if page_offers.nil?

          # совершаем операции
          vals = values page_offers, shop_id
          sql  = TPL_SQL % [table, cols * ',', vals, updates]
          _execute sql

          # делаем шаг
          ptr += 1
        end
      end

      protected


      def table
        :offers.to_s
      end


      def cols
        %w'id
           available
           group_id
           name
           description
           price
           url
           picture
           vendor
           age
           barcode
           delivery'
      end


      # Соберём в одну строку вида '(a,b,c),(v1,v2,v3),' через запятую все значения, вставляемые в таблицу.
      # @param [Nokogiri::XML::NodeSet] node_set
      # @param [Integer]                shop_id
      #
      def values(node_set, shop_id)
        node_set.map do |offer|
          values = []
          mapped = _map_offer offer
          # порядок и кол-во должны соответствовать `def col`
          values << '\'%s\'' % offer.attr('id').to_i              # Integer
          values << '\'%s\'' % _bool(offer.attr('available'))       # boolean
          values << '\'%s\'' % offer.attr('group_id').to_i        # Integer
          values << '\'%s\'' % _fetch(mapped, 'name')        # String
          values << '\'%s\'' % _fetch(mapped, 'description') # Text
          values << '\'%s\'' % _fetch(mapped, 'price')       # Float
          values << '\'%s\'' % _fetch(mapped, 'url')         # String
          values << '\'%s\'' % _fetch(mapped, 'picture')     # String
          values << '\'%s\'' % _fetch(mapped, 'vendor')      # String
          values << '\'%s\'' % _fetch(mapped, 'age')         # String
          values << '\'%s\'' % _fetch(mapped, 'barcode').to_i     # Integer
          values << '\'%s\'' % _bool(_fetch(mapped, 'delivery'))    # boolean

          '(%s)' % (values * ',')
        end * ','
      end

    end
  end
end
