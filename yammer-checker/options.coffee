# 読み込み時処理
$ ->
    # 保存済みの更新間隔時間があれば選択する
    $("#update_interval").val(localStorage.ls_update_interval) if localStorage.ls_update_interval?
    # 保存済みの通知非表示時間があれば選択する
    $("#notification_interval").val(localStorage.ls_notification_interval) if localStorage.ls_notification_interval?

    $("#save_button").click ->
        # 選択した値を取得
        update_interval = $("#update_interval").val()
        notification_interval = $("#notification_interval").val()
        # 保存
        localStorage.ls_update_interval = update_interval
        localStorage.ls_notification_interval = notification_interval

        alert("save")