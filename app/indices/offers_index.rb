ThinkingSphinx::Index.define :offer, :with => :active_record do
  indexes name,    sortable: true
  indexes description
  indexes vendor,  sortable: true
  indexes barcode, sortable: true

  has group_id,    :type => :integer
  has shop_id,     :type => :integer
  has created_at,  :type => :timestamp
  has updated_at,  :type => :timestamp
end
