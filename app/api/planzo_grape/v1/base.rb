module PlanzoGrape
  module V1
    class Base < ::Grape::API
      mount Users::Root
      mount Projects::Root
      mount Tasks::Root

      add_swagger_documentation \
        base_path: '/',
        title: 'Planzo API',
        doc_version: 'v1',
        add_version: true,
        api_documentation: { desc: 'API documentation for Planzo' },
        hide_documentation_path: true,
        consumes: ['application/json', 'application/x-www-form-urlencoded'],
        produces: ['application/json', 'application/octet-stream'],
        info: {
          title: 'Planzo API',
          description: 'API documentation for Planzo',
          contact_email: 'ahtisham232@gmail.com',
          contact_name: 'Ahtisham Qazi',
          contact: 'Planzo Team'
        }
    end
  end
end
