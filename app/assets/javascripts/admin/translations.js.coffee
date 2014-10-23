APP['admin/translations'] =
  index: () ->
    $('form').on 'ajax:success', () -> alert '已更新'
    .on 'ajax:error', () -> alert '失敗'