# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hello_dictionary_session',
  :secret      => 'dc9932fc65311961e4e900ea9c47d7bda1f690057daf1d25a6ca0a43ff6a810ec1c4a8ed81ed2b1af30443863ef2fc7604bb855462878f20fc8d4c55eabff427'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
