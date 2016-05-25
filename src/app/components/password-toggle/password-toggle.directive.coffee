wrPasswordToggle = () ->
  directive =
    link: (scope, inputElement, attr) ->
      inputElement.after('<span class="wr-input-icon"><i class="fa fa-eye"></i></span>')
      icon = inputElement.parent().find('span.wr-input-icon')
      icon.on 'click', (event) ->
        if inputElement.attr('type') == 'text'
          inputElement.attr('type', 'password')
          icon.find('i').removeClass('fa-eye-slash secure')
          icon.find('i').addClass('fa-eye insecure')
        else
          inputElement.attr('type', 'text')
          icon.find('i').removeClass('fa-eye insecure')
          icon.find('i').addClass('fa-eye-slash secure')
      return
  return directive
angular.module 'wr.password-toggle'
  .directive 'wrPasswordToggle', wrPasswordToggle
