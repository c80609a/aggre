class ActiveRecord::Migration

  def migrate_sql(action)
    action = action.to_s
    raise 'You must specify action :up or :down.' unless %w(up down).include?(action)

    migration = '%s/%s_%s.sql' % [CONFIG[:deploy][:migrate], '%0.3d' % self.version, action]
    if File.exist?(migration)
      execute(File.read migration)
    else
      raise 'File \'%s\' doesn\'t exist.' % migration
    end
  end

  def up
    migrate_sql :up
  end

  def down
    migrate_sql :down
  end
end

ActiveRecord::Base.schema_format = :sql
