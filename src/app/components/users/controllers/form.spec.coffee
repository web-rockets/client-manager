describe 'UserFormController', ->
  beforeEach module 'wr.users'

  scope = undefined
  user = id: 1, name: 'Ok'
  form = $invalid: true

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    $controller('UserFormController as vm', '$scope': scope, 'user': user)

  it 'should receive a user object resolved', inject (userService) ->
    # Assert
    expect(scope.vm.user).toBe(user)

  describe 'when submit(form)', ->

    it 'should set vm.submitted to true', ->
      # Act
      scope.vm.submit(form)
      # Assert
      expect(scope.vm.submitted).toBeTruthy()

    it 'should do nothing if form is invalid', inject (userService) ->
      # Arrange
      form.$invalid = true
      spyOn userService, 'save'
      # Act
      scope.vm.submit(form)
      # Assert
      expect(userService.save).not.toHaveBeenCalled()

    it 'should call userService.save if form is valid', inject (userService, $q) ->
      # Arrange
      form.$invalid = false
      deferredUser = $q.defer()
      spyOn(userService, 'save').and.returnValue(deferredUser.promise)
      # Act
      scope.vm.submit(form)
      # Assert
      expect(userService.save).toHaveBeenCalledWith(scope.vm.user)

    it 'should change state to wr.users.list when userService.save ends successfully', inject (
      userService, $q, $rootScope, $state) ->
        # Arrange
        form.$invalid = false
        deferredUser = $q.defer()
        spyOn(userService, 'save').and.returnValue(deferredUser.promise)
        spyOn($state, 'go')
        deferredUser.resolve(user)
        # Act
        scope.vm.submit(form)
        $rootScope.$digest()
        # Assert
        expect(userService.save).toHaveBeenCalledWith(scope.vm.user)
        expect($state.go).toHaveBeenCalledWith('wr.users.list')
        # TODO: expect(toastr.success).toHaveBeenCalledWith('saved_successfully')
