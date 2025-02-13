GrapeSwaggerRails.options.url = '/swagger_doc.json'
GrapeSwaggerRails.options.app_name = 'Planzo API'
GrapeSwaggerRails.options.before_action do
  GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
end
GrapeSwaggerRails.options.api_auth = 'basic'
GrapeSwaggerRails.options.api_key_name = 'Authorization'
GrapeSwaggerRails.options.api_key_type = 'header'
GrapeSwaggerRails.options.api_key_placeholder = 'Basic Auth Token'
