module Aggre
  module Services

    #
    # Сделает UPSERT в таблицу.
    #

    class AbstractUpsertService

      protected

      # шаблон запроса к базе
      TPL_SQL = 'INSERT INTO %s(%s) VALUES %s ON DUPLICATE KEY UPDATE %s, updated_at = now();'.freeze


      # Строки, которые подставляются
      # в sql запрос TPL_SQL


      # @return [String] имя таблицы
      def table
        raise NotImplemented
      end


      # @return [Array] имена столбцов таблицы
      def cols
        raise NotImplemented
      end


      # соответствующие столбцам `cols` вставляемые значения
      # @param [Nokogiri::XML::NodeSet] node_set
      # @return [String]
      #
      def values(node_set)
        raise NotImplemented
      end


      # @return [String] Какие поля нужно обновить ON DUPLICATE
      def updates
        cols.map { |col| '%s = VALUES(%s)' % [col, col] } * ', '
      end

      private

      # @param [String] sql
      def _execute(sql)
        ActiveRecord::Base.connection.execute sql
      end

    end
  end
end
