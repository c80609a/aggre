module Aggre
  module Services

    #
    # Сделает UPSERT в таблицу Категории.
    #

    class UpsertCategoriesService < AbstractUpsertService


      # @param [Nokogiri::XML::NodeSet] categories
      def call(categories)
        vals = values categories
        sql  = TPL_SQL % [table, cols * ',', vals, updates]
        _execute sql
      end

      protected


      def table
        :categories.to_s
      end


      def cols
        %w'id parent_id title'
      end


      # Соберём в одну строку через запятую все значения, вставляемые в таблицу.
      # @param [Nokogiri::XML::NodeSet] node_set
      #
      def values(node_set)
        node_set.map do |category|
          id        = category.attr 'id'
          parent_id = category.attr 'parentId'
          parent_id = parent_id.blank? ? 'NULL' : parent_id
          title     = category.text
          '(%s,%s,\'%s\')' % [id, parent_id, title]
        end * ','
      end

    end
  end
end
