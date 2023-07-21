Rails.application.config.session_store :cookie_store, key: 'inventory_session', domain: :all, secure: Rails.env.production?, httponly: true
