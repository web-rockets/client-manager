class API
  constructor: ($http, APIConfig) ->
    @http = $http
    @config = APIConfig

  # GETs url request with optional params
  get: (url, params) -> return @http.get @config.baseUrl + '/api' + url, params
  # POSTs url request with params
  post: (url, params) -> return @http.post @config.baseUrl + '/api' + url, params
  # PUTs url request with params
  put: (url, params) -> return @http.put @config.baseUrl + '/api' + url, params
  # DELETEs url request with params
  delete: (url, params) -> return @http.delete @config.baseUrl + '/api' + url, params

API.$inject = ['$http', 'APIConfig']
angular.module 'wr.api'
  .service 'API', API
