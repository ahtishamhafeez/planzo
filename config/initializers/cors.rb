Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Change this to 'http://localhost:3001' for more security

    resource '*',
             headers: :any,
             expose: ['Authorization'],
             methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
