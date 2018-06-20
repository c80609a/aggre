module Aggre
  module Services

    #
    # Зарегистрирует в системе магазин по его имени,
    # которое заранее было извлечено из XML каталога.
    #

    class RegisterShopByName
      include CanExecuteSql

      # @param [String] shop_name   Название магазина.
      #
      def call(shop_name)

        # нет ли такого магазина уже в таблице? Если есть - уходим с его id.
        sql1    = 'SELECT id FROM shops WHERE name = \'%s\' LIMIT 1' % shop_name
        shop_id = _execute(sql1).first
        return shop_id[0] if shop_id

        # если нету - добавляем, и уходим с его id.
        sql2    = 'INSERT INTO shops(name) VALUES(\'%s\')' % shop_name
        sql3    = 'SELECT LAST_INSERT_ID() LIMIT 1'

        ActiveRecord::Base.transaction do
          _execute sql2
          shop_id = _execute(sql3).first[0]
        end

        shop_id
      end

    end
  end
end
