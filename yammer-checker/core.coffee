# JSON 取得先
feed_api_url = "https://www.yammer.com/api/v1/messages/my_feed.json"
user_api_url = "https://www.yammer.com/api/v1/users/" # + {user_id} + ".json"
# 更新間隔(秒)
delay_time = 60 * 3
# 最終更新時間
last_time = 0
# 通知が消えるまでの時間(秒)
disappear_time = 5

# 更新確認開始
check = ->

    delay_time = 60 * localStorage.ls_update_interval if localStorage.ls_update_interval?
    disappear_time = localStorage.ls_notification_interval if localStorage.ls_notification_interval?
    # console.log "check start"
    main()
    # 次の確認まで待機
    setTimeout(check, delay_time * 1000)

# JSON を取得、更新有無確認、更新があれば通知
main = ->

    # console.log "main start"

    jQuery ->
        $.getJSON feed_api_url, (response) =>
            # console.log response
            items = response.messages
            # 配列の先頭とそれ以外を分ける
            [head, tail...] = items
            # メッセージ本文
            messeage = head.body.parsed
            # 投稿種別
            type = head.message_type
            # 投稿ユーザ ID
            user_id = head.sender_id

            # ローカルストレージへ保存
            localStorage.ls_message = messeage
            localStorage.ls_type = type

            # 新しい更新時間
            new_date = Date.parse(head.created_at)

            # 新しい投稿があった場合に通知処理開始
            if new_date > last_time
                # 最終更新時間退避
                last_time = new_date

                jQuery ->
                    # ユーザ ID からユーザ名を取得
                    $.getJSON user_api_url + user_id + ".json", (response) =>
                        localStorage.ls_user_name = response.full_name
                        # 通知実行
                        notify()


# 通知を表示
notify = ->
    notifications = webkitNotifications.createHTMLNotification(chrome.extension.getURL("notification.html"))
    # 通知表示
    notifications.show()

    if localStorage.ls_notification_interval != "none"
        # 一定時間後に通知を消す
        setTimeout (-> notifications.cancel()), disappear_time * 1000


# 初回起動
$ ->
    check()