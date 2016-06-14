describe 'controllers', () ->
  vm = undefined

  beforeEach module 'clientManager'

  beforeEach inject ($controller) ->
    vm = $controller 'MainController'

  it 'should define more than 5 awesome things', () ->
    expect(vm.pageTitle).toBeDefined()
    expect(vm.pageTitle).toBe('Client Manager')