# == Schema Information
#
# Table name: store_app_product_prices
#
#  id                             :bigint(8)        not null, primary key
#  store_app_product_id(关联商品) :bigint(8)
#  currency_id(关联货币)          :bigint(8)
#  value(价格)                    :decimal(, )
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
# Indexes
#
#  index_store_app_product_prices_on_currency_id           (currency_id)
#  index_store_app_product_prices_on_store_app_product_id  (store_app_product_id)
#
# Foreign Keys
#
#  fk_rails_...  (currency_id => currencies.id)
#  fk_rails_...  (store_app_product_id => store_app_products.id)
#

require 'rails_helper'

RSpec.describe StoreAppProductPrice, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
