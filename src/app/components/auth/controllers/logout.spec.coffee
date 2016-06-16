describe 'AuthLogoutController', ->
  beforeEach module 'wr.auth'
  it 'should logout when initialized', inject (AuthService, $controller, $rootScope) ->
    # Arrange
    spyOn AuthService, 'logout'
    scope = $rootScope.$new()
    # Act
    $controller('AuthLogoutController as vm', $scope: scope)
    # Assert
    expect(AuthService.logout).toHaveBeenCalled()