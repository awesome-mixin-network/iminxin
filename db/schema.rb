# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_08_12_040321) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "administrators", comment: "管理员", force: :cascade do |t|
    t.string "name", null: false, comment: "账号"
    t.string "password_digest", null: false, comment: "密码"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_administrators_on_name", unique: true
  end

  create_table "currencies", comment: "支持的货币", force: :cascade do |t|
    t.string "name", comment: "mixin 中的 name"
    t.string "symbol", comment: "mixin 中的 symbol"
    t.string "icon_url", comment: "mixin 中的 icon_url"
    t.string "asset_id", comment: "mixin 中的 asset_id"
    t.string "chain_id", comment: "mixin 中的 chain_id"
    t.string "price_btc", comment: "mixin 中的 price_btc"
    t.string "price_usd", comment: "mixin 中的 price_usd"
    t.string "change_btc", comment: "mixin 中的 change_btc"
    t.string "change_usd", comment: "mixin 中的 change_usd"
    t.datetime "synced_at", comment: "同步价格时间"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mx_app_store_order_items", force: :cascade do |t|
    t.bigint "mx_app_store_order_id"
    t.bigint "mx_app_store_product_id"
    t.bigint "currency_id", comment: "支付币种"
    t.decimal "price", comment: "单价"
    t.integer "quantity", comment: "数量"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_mx_app_store_order_items_on_currency_id"
    t.index ["mx_app_store_order_id"], name: "index_mx_app_store_order_items_on_mx_app_store_order_id"
    t.index ["mx_app_store_product_id"], name: "index_mx_app_store_order_items_on_mx_app_store_product_id"
  end

  create_table "mx_app_store_orders", comment: "商城订单", force: :cascade do |t|
    t.bigint "mx_app_store_id"
    t.bigint "buyer_id", comment: " 买家"
    t.bigint "currency_id", comment: "支付币种"
    t.decimal "total", comment: "订单总价"
    t.string "number", comment: "订单编号"
    t.string "state", comment: "订单状态"
    t.string "memo", comment: "备注"
    t.datetime "payment_started_at", comment: "发起支付时间"
    t.datetime "paid_at", comment: "支付完成时间"
    t.datetime "delivered_at", comment: "交付时间"
    t.datetime "completed_at", comment: "订单完成时间"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_mx_app_store_orders_on_buyer_id"
    t.index ["currency_id"], name: "index_mx_app_store_orders_on_currency_id"
    t.index ["mx_app_store_id"], name: "index_mx_app_store_orders_on_mx_app_store_id"
  end

  create_table "mx_app_store_payments", comment: "商城支付", force: :cascade do |t|
    t.bigint "mx_app_store_order_id"
    t.bigint "payer_id", comment: "支付者"
    t.bigint "currency_id", comment: "支付币种"
    t.decimal "total"
    t.string "state", comment: "支付状态"
    t.string "number", comment: "支付编号"
    t.string "memo", comment: "备注"
    t.datetime "completed_at", comment: "支付完成时间"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_mx_app_store_payments_on_currency_id"
    t.index ["mx_app_store_order_id"], name: "index_mx_app_store_payments_on_mx_app_store_order_id"
    t.index ["payer_id"], name: "index_mx_app_store_payments_on_payer_id"
  end

  create_table "mx_app_store_product_prices", comment: "商品价格", force: :cascade do |t|
    t.bigint "mx_app_store_product_id", comment: "关联商品"
    t.bigint "currency_id", comment: "关联货币"
    t.decimal "value", comment: "价格"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["currency_id"], name: "index_mx_app_store_product_prices_on_currency_id"
    t.index ["mx_app_store_product_id"], name: "index_mx_app_store_product_prices_on_mx_app_store_product_id"
  end

  create_table "mx_app_store_products", comment: "电商应用的商品", force: :cascade do |t|
    t.bigint "mx_app_store_id"
    t.string "number", comment: "商品编号"
    t.string "name", comment: "商品名"
    t.text "introduction", comment: "商品介绍"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mx_app_store_id"], name: "index_mx_app_store_products_on_mx_app_store_id"
  end

  create_table "mx_app_users", comment: "mixin 应用的用户", force: :cascade do |t|
    t.bigint "mx_app_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mx_app_id"], name: "index_mx_app_users_on_mx_app_id"
    t.index ["user_id"], name: "index_mx_app_users_on_user_id"
  end

  create_table "mx_apps", comment: "mixin 应用", force: :cascade do |t|
    t.bigint "owner_id"
    t.string "type"
    t.string "number", comment: "编号"
    t.datetime "deleted_at", comment: "软删"
    t.string "client_id"
    t.string "client_secret"
    t.string "session_id"
    t.string "pin_token"
    t.text "private_key"
    t.json "raw", comment: "mixin 返回的 profile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "audited_at", comment: "mixin账号审核时间"
    t.index ["number"], name: "index_mx_apps_on_number", unique: true
    t.index ["owner_id"], name: "index_mx_apps_on_owner_id"
  end

  create_table "user_authorizations", comment: "用户认证", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "provider", comment: "第三方来源"
    t.string "uid", comment: "第三方 user_id"
    t.json "raw", comment: "第三方返回的原始数据"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_user_authorizations_on_provider_and_uid", unique: true
    t.index ["user_id"], name: "index_user_authorizations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", comment: "用户名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "mx_app_store_order_items", "currencies"
  add_foreign_key "mx_app_store_order_items", "mx_app_store_orders"
  add_foreign_key "mx_app_store_order_items", "mx_app_store_products"
  add_foreign_key "mx_app_store_orders", "currencies"
  add_foreign_key "mx_app_store_orders", "mx_app_users", column: "buyer_id"
  add_foreign_key "mx_app_store_orders", "mx_apps", column: "mx_app_store_id"
  add_foreign_key "mx_app_store_payments", "currencies"
  add_foreign_key "mx_app_store_payments", "mx_app_store_orders"
  add_foreign_key "mx_app_store_payments", "mx_app_users", column: "payer_id"
  add_foreign_key "mx_app_store_product_prices", "currencies"
  add_foreign_key "mx_app_store_product_prices", "mx_app_store_products"
  add_foreign_key "mx_app_store_products", "mx_apps", column: "mx_app_store_id"
  add_foreign_key "mx_app_users", "mx_apps"
  add_foreign_key "mx_app_users", "users"
  add_foreign_key "mx_apps", "users", column: "owner_id"
  add_foreign_key "user_authorizations", "users"
end
