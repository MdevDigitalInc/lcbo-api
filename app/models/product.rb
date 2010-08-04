class Product

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Versioning

  key :product_no

  field :product_no,                      :type => Integer
  field :is_active,                       :type => Boolean, :default => true
  field :crawl_timestamp,                 :type => Integer
  field :was_discontinued,                :type => Boolean, :default => false
  field :was_removed,                     :type => Boolean, :default => false
  field :is_on_sale,                      :type => Boolean
  field :price_in_cents,                  :type => Integer
  field :price_per_liter_in_cents,        :type => Integer
  field :alcohol_content,                 :type => Integer
  field :volume_in_milliliters,           :type => Integer, :default => 0
  field :inventory_count,                 :type => Integer, :default => 0
  field :inventory_price_in_cents,        :type => Integer, :default => 0
  field :inventory_volume_in_milliliters, :type => Integer, :default => 0
  field :name
  field :stock_type
  field :primary_category
  field :secondary_category
  field :origin
  field :package
  field :sugar_content
  field :producer_name

  index [[:product_no, Mongo::ASCENDING]], :unique => true
  index [[:crawl_timestamp, Mongo::ASCENDING]]
  index [[:inventory_count, Mongo::DESCENDING]]
  index [[:inventory_volume_in_milliliters, Mongo::ASCENDING]]

  has_many_related :inventories

  scope :older_than, lambda { |datetime|
    where(:crawl_timestamp.lt(datetime))
  }

end