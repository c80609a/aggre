ThinkingSphinx::Index.define :category, :with => :active_record do
  indexes title,    sortable: true

  has shop_id,     :type => :integer
  has created_at,  :type => :timestamp
  has updated_at,  :type => :timestamp
end
