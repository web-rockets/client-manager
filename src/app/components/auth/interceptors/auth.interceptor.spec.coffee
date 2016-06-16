describe 'Auth Interceptor', ->
  beforeEach module 'wr.auth'
  beforeEach inject ($http, $httpBackend, $state, $localStorage) ->
    @http = $http
    @backend = $httpBackend
    spyOn($state, 'go')
    @state = $state
    @storage = $localStorage
    delete @storage.token

  it 'should go to wr.auth.login if status 401', ->
    @backend.expectPOST('/any-url').respond(401)
    @http.post('/any-url')
    @backend.flush()
    # Assert
    expect(@state.go).toHaveBeenCalledWith('wr.auth.login')

  it 'should do nothing if status is different from 401', ->
    @backend.expectPOST('/any-url').respond(400)
    @http.post('/any-url')
    @backend.flush()
    # Assert
    expect(@state.go).not.toHaveBeenCalled()

  it 'should add Authorization header with token when it is defined', ->
    # Arrange
    token = 'anytoken'
    headers = {}
    @storage.token = token
    @backend.expectPOST('/any-url').respond('ok')
    @http.post('/any-url').then (response) ->
      headers = response.config.headers
    @backend.flush()
    expect(headers.Authorization).toBeDefined()
    expect(headers.Authorization).toEqual('Bearer ' + token)

  it 'should go to 404 page if status is 404', ->
    @backend.expectPOST('/dummy').respond(404)
    @http.post('/dummy')
    @backend.flush()
    expect(@state.go).toHaveBeenCalledWith('wr.auth.404')
