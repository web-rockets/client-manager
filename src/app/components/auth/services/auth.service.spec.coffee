describe 'AuthService', ->
  beforeEach module 'wr.auth'
  beforeEach inject (API, AuthService, $q, $rootScope, $localStorage, $state) ->
    @storage = $localStorage
    @post = $q.defer()
    @jwt = 'some.jwt.code'
    @scope = $rootScope.$new()
    @credentials =
      email: 'marco@email.com'
      password: '123456'
    spyOn(AuthService, 'current_user')
    @service = AuthService
    spyOn(API, 'post')
    @api = API
    spyOn($state, 'go')
    @state = $state
    @user =
      name: 'Marco'
      id: 1
      email: @credentials.email
      password: @credentials.password

  describe 'when authenticate(credentials)', ->
    it 'should post to create a new token and store it in $localStorage', ->
      @api.post.and.returnValue(@post.promise)
      @post.resolve(data: {jwt: @jwt})
      # Act
      @service.authenticate(@credentials)
      @scope.$digest()

      expect(@api.post).toHaveBeenCalledWith('/user_token', auth: @credentials)
      expect(@storage.token).toEqual(@jwt)
    it 'should call current_user on success', inject (AuthService, API, $q) ->
      @api.post.and.returnValue(@post.promise)
      @post.resolve(data: {jwt: @jwt})
      # Act
      @service.authenticate(@credentials)
      @scope.$digest()

      expect(@service.current_user).toHaveBeenCalled()
    it 'should notify user if fail', inject (AuthService, API, $q) ->
      # TODO: implement this after implementation of toastr

  describe 'when current_user()', ->
    it 'should call API.post to /me url', inject (AuthService, API, $q) ->
      @api.post.and.returnValue(@post.promise)
      @post.resolve(data: @user)
      @service.current_user.and.callThrough()
      # Act
      @service.current_user()
      @scope.$digest()

      expect(@api.post).toHaveBeenCalledWith('/me')
    it 'should store current_user in $localSotrage on success',
    inject (AuthService, API, $q, $rootScope, $localStorage) ->
      @api.post.and.returnValue(@post.promise)
      @post.resolve(data: @user)
      @service.current_user.and.callThrough()
      # Act
      @service.current_user()
      @scope.$digest()

      expect(@storage.current_user).toBeDefined()
      expect(@storage.current_user).toEqual(@user)
    it 'should notify user if fail', ->
      # TODO: implement this after implementation of toastr


  describe 'when logout()', ->
    it 'should remove current_user and token from $localStorage and go to state wr.auth.login', ->
      @storage.token = @jwt
      @storage.current_user = @user
      # Act
      @service.logout()

      expect(@storage.current_user).not.toBeDefined()
      expect(@storage.token).not.toBeDefined()
      expect(@state.go).toHaveBeenCalledWith('wr.auth.login')
