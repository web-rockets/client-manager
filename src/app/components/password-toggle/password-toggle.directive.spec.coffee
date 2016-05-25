describe 'wr-password-toggle directive', ->
  beforeEach module 'wr.password-toggle'

  html = scope = element = formGroup = undefined

  it 'should add a span with an icon to form-group element', inject ($compile, $rootScope)->
    # Arrange
    html = '<form name="form">
        <div class="form-group">
          <input type="password" name="password" wr-password-toggle>
        </div>
      </form>'
    scope = $rootScope.$new()
    element = $compile(angular.element(html))(scope)
    formGroup = element.find('.form-group')
    # Act e Assert
    expect(formGroup.has('span.wr-input-icon')).toBeTruthy()

  it 'should change input type to text if it is password and icon classes on click', ->
    # Arrange
    expect(formGroup.find('input').attr('type')).toEqual('password')
    expect(formGroup.find('.wr-input-icon i.fa').hasClass('fa-eye')).toBeTruthy()
    expect(formGroup.find('.wr-input-icon i.fa').hasClass('fa-eye-slash')).toBeFalsy()
    # Act
    $(formGroup.find('.wr-input-icon')).click()
    # Assert
    expect(formGroup.find('input').attr('type')).toEqual('text')
    expect(formGroup.find('.wr-input-icon i.fa').hasClass('fa-eye')).toBeFalsy()
    expect(formGroup.find('.wr-input-icon i.fa').hasClass('fa-eye-slash')).toBeTruthy()

  it 'should change input type to password if it is text and icon classes on click', ->
    # Arrange
    expect(formGroup.find('input').attr('type')).toEqual('text')
    expect(formGroup.find('.wr-input-icon i.fa').hasClass('fa-eye')).toBeFalsy()
    expect(formGroup.find('.wr-input-icon i.fa').hasClass('fa-eye-slash')).toBeTruthy()
    # Act
    $(formGroup.find('.wr-input-icon')).click()
    # Assert
    expect(formGroup.find('input').attr('type')).toEqual('password')
    expect(formGroup.find('.wr-input-icon i.fa').hasClass('fa-eye')).toBeTruthy()
    expect(formGroup.find('.wr-input-icon i.fa').hasClass('fa-eye-slash')).toBeFalsy()
