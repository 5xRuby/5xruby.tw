TapPay.configure do |config|
  # TapPay Merchantid ID. This is the account name that you use to log in the
  # TapPay Portal.
  config.merchant_id = Settings.third_party_payment.tappay.merchant_id

  # VAT Number and Partner Key. This can be found on the "Information" page of
  # TapPay Portal (https://portal.tappaysdk.com/information).
  config.partner_key = Settings.third_party_payment.tappay.partner_key
  config.vat_number = Settings.third_party_payment.tappay.vat_number

  # TapPay App ID and App Key.
  # You can get your ID or create a new app on the "Application" page of
  # TapPay Portal (https://portal.tappaysdk.com/myapps). Note that the App ID
  # on different server types will not be the same.
  config.app_id = Settings.third_party_payment.tappay.app_id
  config.app_key = Settings.third_party_payment.tappay.app_key
  config.sandbox_app_key = Settings.third_party_payment.tappay.sandbox_app_key

  # The server type of TapPay, "sandbox" or "production".
  config.server_type = 'sandbox'

  # Default currency to use. You can override this in every request.
  config.default_currency = 'TWD'
end
