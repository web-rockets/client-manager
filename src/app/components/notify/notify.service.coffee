class Notify
  $inject: ['toastr', '$translate']

  constructor: (toastr, $translate) ->
    @toastr = toastr
    @translate = $translate

  success: (params) ->
    @toastr.success @translate.instant(params.message), @translate.instant(params.title), params.options
  error: (params) ->
    @toastr.error @translate.instant(params.message), @translate.instant(params.title), params.options
  warning: (params) ->
    @toastr.warning @translate.instant(params.message), @translate.instant(params.title), params.options
  info: (params) ->
    @toastr.info @translate.instant(params.message), @translate.instant(params.title), params.options

angular.module 'wr.notify'
  .service 'notify', Notify