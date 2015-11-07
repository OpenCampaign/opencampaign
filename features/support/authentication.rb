OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:default] = OmniAuth::AuthHash.new({
  'provider'  => 'developer',
  'uid'       => 'john_locke',
  'info'      => {
    'username' => 'johnlocke',
    'email'    => 'john.locke@gmail.com',
    'name'     => 'John Locke'
  }
})

# OmniAuth.config.mock_auth[:developer] = :invalid_credentials
