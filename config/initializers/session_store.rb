# Be sure to restart your server when you modify this file.

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
if Rails.env.production?
  ReduApps::Application.config.session_store :active_record_store,
    :key => '_redu_session',
    :domain => '.local.redu'
else
  ReduApps::Application.config.session_store :active_record_store,
    :key => '_redu_session'
end
