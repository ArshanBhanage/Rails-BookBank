require "stripe"

Stripe.api_key = Rails.application.credentials[:stripe][:secret]
Stripe.api_version = '2020-08-27'