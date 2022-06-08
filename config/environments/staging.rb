if Rails.env.production?
  config.myGlobalVariable = {backend_server: 'http://localhost:3000/api/v1'}

else
  config.myGlobalVariable = backend_server: 'https://mmim-be.herokuapp.com'
end
