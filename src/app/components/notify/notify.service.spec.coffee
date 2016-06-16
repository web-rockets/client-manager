describe 'notify service', ->
  beforeEach module 'wr.notify'

  beforeEach inject (toastr, $translate, notify) ->
    spyOn(toastr, 'success').and.callThrough()
    spyOn(toastr, 'error').and.callThrough()
    spyOn(toastr, 'warning').and.callThrough()
    spyOn(toastr, 'info').and.callThrough()
    @toastr = toastr
    spyOn($translate, 'instant').and.callThrough()
    @translate = $translate
    @notify = notify

  it 'should call toastr.success when success(params)', ->
    @notify.success title: 'title', message: 'success message', options: 'options'
    expect(@toastr.success).toHaveBeenCalledWith('success message', 'title', 'options')
    expect(@translate.instant).toHaveBeenCalled()
    expect(@translate.instant.calls.count()).toBe(2)
    expect(@translate.instant.calls.argsFor(0)).toEqual(['success message'])
    expect(@translate.instant.calls.argsFor(1)).toEqual(['title'])

  it 'should call toastr.error when error(params)', ->
    @notify.error title: 'title', message: 'error message', options: 'options'
    expect(@toastr.error).toHaveBeenCalledWith('error message', 'title', 'options')
    expect(@translate.instant).toHaveBeenCalled()
    expect(@translate.instant.calls.count()).toBe(2)
    expect(@translate.instant.calls.argsFor(0)).toEqual(['error message'])
    expect(@translate.instant.calls.argsFor(1)).toEqual(['title'])

  it 'should call toastr.warning when warning(params)', ->
    @notify.warning title: 'title', message: 'warning message', options: 'options'
    expect(@toastr.warning).toHaveBeenCalledWith('warning message', 'title', 'options')
    expect(@translate.instant).toHaveBeenCalled()
    expect(@translate.instant.calls.count()).toBe(2)
    expect(@translate.instant.calls.argsFor(0)).toEqual(['warning message'])
    expect(@translate.instant.calls.argsFor(1)).toEqual(['title'])

  it 'should call toastr.info when info(params)', ->
    @notify.info title: 'title', message: 'info message', options: 'options'
    expect(@toastr.info).toHaveBeenCalledWith('info message', 'title', 'options')
    expect(@translate.instant).toHaveBeenCalled()
    expect(@translate.instant.calls.count()).toBe(2)
    expect(@translate.instant.calls.argsFor(0)).toEqual(['info message'])
    expect(@translate.instant.calls.argsFor(1)).toEqual(['title'])