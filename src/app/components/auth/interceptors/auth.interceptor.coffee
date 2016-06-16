Interceptor = ($httpProvider) ->
  $httpProvider.interceptors.push AuthInterceptor

Interceptor.$inject = ['$httpProvider']

AuthInterceptor = ($q, $injector) ->
  return {
    request: (config) ->
      token = $injector.get('$localStorage').token
      if token
        config.headers.Authorization = 'Bearer ' + token
      return config
    responseError: (rejection) ->
      if rejection.status == 401
        $injector.get('$state').go('wr.auth.login')
        return $q.reject(rejection)
      if rejection.status == 404
        $injector.get('$state').go('wr.auth.404')
        return $q.reject(rejection)
      return rejection
  }

AuthInterceptor.$inject = ['$q', '$injector']

angular.module 'wr.auth'
  .config Interceptor
