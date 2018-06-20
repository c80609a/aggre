module CanExecuteSql

  # Поможет безопасно выполнить запрос к базе.
  # Зависимость: @logger

  private

  # @param [String] sql
  def _execute(sql)
    # begin
      ActiveRecord::Base.connection.execute sql
    # rescue => e
    #   @logger.warn e
    # end
  end

end
