module Aggre
  module Services

    #
    # Сделает UPSERT в таблицу Категории.
    #

    class UpsertCategoriesService < AbstractUpsertService
      include CanQuoteString

      # @param [Nokogiri::XML::NodeSet] categories  Список категорий.
      # @param [Integer]                shop_id     Primary Key магазина.
      #
      def call(categories, shop_id)
        vals = values categories, shop_id
        sql  = TPL_SQL % [table, cols * ',', vals, updates]
        _execute sql
      end

      protected


      def table
        :categories.to_s
      end


      def cols
        %w'id parent_id title shop_id'
      end


      # Соберём в одну строку через запятую все значения, вставляемые в таблицу.
      # @param [Nokogiri::XML::NodeSet] node_set
      # @param [Integer]                shop_id
      #
      def values(node_set, shop_id)
        @logger.info '<UpsertCategoriesService> categories count: %s' % node_set.count
        node_set.map do |category|
          id        = category.attr 'id'
          parent_id = category.attr 'parentId'
          parent_id = parent_id.blank? ? 'NULL' : parent_id
          title     = _quote category.text.strip
          '(%s,%s,\'%s\',%s)' % [id, parent_id, title, shop_id]
        end * ','
      end

    end
  end
end
