# frozen_string_literal: true

  if Rails.env === 'production'
    Rails.application.config.session_store :cookie_store, {
      :key => '_api_apiback_session',
      :domain => "final-api-backend.herokuapp.com",
      :same_site => :none,
      :secure => :true,
      :tld_length => 2
    }
  else
   Rails.application.config.session_store :cookie_store, {
      :key => '_api_apiback_session',
      :domain => :all,
      :same_site => :none,
      :secure => :true,
      :tld_length => 2
    }
  end