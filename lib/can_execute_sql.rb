module CanExecuteSql

  private

  # @param [String] sql
  def _execute(sql)
    ActiveRecord::Base.connection.execute sql
  end

end
