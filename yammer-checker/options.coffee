# 読み込み時処理
$ ->
    # 保存済みの更新間隔時間があれば選択する
    $("#update_interval").val(localStorage.ls_update_interval) if localStorage.ls_update_interval?
    # 保存済みの通知非表示時間があれば選択する
    $("#notification_interval").val(localStorage.ls_notification_interval) if localStorage.ls_notification_interval?
    # 保存済みの通知非表示時間があれば選択する
    $("#notification_link").val(localStorage.ls_notification_link) if localStorage.ls_notification_link?

    $("#save_button").click ->
        # 選択した値を取得
        update_interval = $("#update_interval").val()
        notification_interval = $("#notification_interval").val()
        notification_link = $("#notification_link").val()
        # 保存
        localStorage.ls_update_interval = update_interval
        localStorage.ls_notification_interval = notification_interval
        localStorage.ls_notification_link = notification_link

        alert("save")

    $("#save_ignore_button").click ->
        save_ignore()


    $("#clear_ignore_button").click ->
        # 設定値を削除
        localStorage.ls_ignore_email = JSON.stringify({emails:[]})

        alert("clear")


# 非通知ユーザ登録
save_ignore = ->
    # 選択した値を取得
    ignore_email = $("#ignore_email").val()

    if ignore_email.length != 0

        # 保存済みのアドレスがあれば追加する
        if localStorage.ls_ignore_email?

            # 保存済みの json をオブジェクトに
            all_ignore = JSON.parse(localStorage.ls_ignore_email)

            if all_ignore.emails.length != 0
                # 要素があれば追加
                all_ignore.emails.push ignore_email
            else
                # 要素が無いので空で作成
                all_ignore = {emails:[]}

            # json で追加
            localStorage.ls_ignore_email = JSON.stringify(all_ignore)

        alert("save")
