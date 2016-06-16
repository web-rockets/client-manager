describe 'AuthLoginController', ->
  beforeEach module 'wr.auth'
  describe 'when vm.submit(form)', ->
    it 'should authenticate credentials when form is valid',
    inject (AuthService, $state, $q, $controller, $rootScope) ->
      # Arrange
      authenticate = $q.defer()
      spyOn(AuthService, 'authenticate').and.returnValue(authenticate.promise)
      spyOn($state, 'go')
      authenticate.resolve('ok')
      credentials =
        email: 'email@mail.com'
        password: '123456'
      scope = $rootScope.$new()
      scope.vm = credentials
      form = {$invalid: false}
      # Act
      $controller('AuthLoginController as vm', $scope: scope)
      scope.vm.submit(form)
      scope.$digest()
      # Assert
      expect(AuthService.authenticate).toHaveBeenCalled()
      expect($state.go).toHaveBeenCalledWith('wr.users.list')

    it 'should do nothing if form is $invalid', inject ($controller, $state, AuthService, $rootScope) ->
      # Arrange
      spyOn AuthService, 'authenticate'
      spyOn $state, 'go'
      form = $invalid: true
      scope = $rootScope.$new()
      # Act
      $controller('AuthLoginController as vm', $scope: scope)
      scope.vm.submit(form)
      # Assert
      expect(AuthService.authenticate).not.toHaveBeenCalled()
      expect($state.go).not.toHaveBeenCalled()
      
      
    