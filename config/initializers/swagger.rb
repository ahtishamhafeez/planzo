GrapeSwaggerRails.options.url = '/swagger_doc.json'
GrapeSwaggerRails.options.app_name = 'Planzo API'
GrapeSwaggerRails.options.before_action do
  GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
end
