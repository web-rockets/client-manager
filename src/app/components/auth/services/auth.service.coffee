class AuthService
  constructor: ($state, API, $localStorage) ->
    @state = $state
    @api = API
    @storage = $localStorage

  authenticate: (credentials) ->
    $this = @
    return @api.post('/user_token', auth: credentials).then (response) ->
      $this.storage.token = response.data.jwt
      return $this.current_user()

  current_user: ->
    $this = @
    return @api.post('/me').then (response) ->
      $this.storage.current_user = response.data
      return $this.storage.current_user
  logout: ->
    delete @storage.current_user
    delete @storage.token
    @state.go('wr.auth.login')


AuthService.$inject = ['$state', 'API', '$localStorage']

angular.module 'wr.auth'
  .service 'AuthService', AuthService
