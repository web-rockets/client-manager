describe 'controllers', () ->
  vm = undefined

  beforeEach module 'clientManager'

  beforeEach inject ($controller, webDevTec, toastr) ->
    vm = $controller 'MainController'

  it 'should define more than 5 awesome things', () ->
    expect(angular.isArray(vm.awesomeThings)).toBeTruthy()
    expect(vm.awesomeThings.length == 5).toBeTruthy()
