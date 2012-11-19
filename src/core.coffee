# JSON 取得先
api_url = "https://www.yammer.com/api/v1/messages/my_feed.json"
# 更新間隔(秒)
delay_time = 60 * 3
# 最終更新時間
last_time = 0

# 更新確認開始
check = ->
    console.log "check start"
    main()
    # 次の確認まで待機
    setTimeout(check, delay_time * 1000)

# JSON を取得、更新有無確認、更新があれば通知
main = ->

    console.log "main start"

    jQuery ->
        $.getJSON(api_url, (response) =>
            # console.log response
            items = response.messages
            [head, tail...] = items
            messeage = head.body.parsed
            type = head.message_type
            localStorage.ls_message = messeage
            localStorage.ls_type = type
            new_date = Date.parse(head.created_at)

            # 新しい投稿があった場合に通知
            if new_date > last_time
                last_time = new_date
                notify(type, messeage)

            # console.log new_messeage

        )

# 通知を表示
notify = (type, msg) ->
    # console.log(chrome.extension.getURL("Y-logo-300x300.png"))
    # notifications = webkitNotifications.createNotification("/Y-logo-300x300.png", type, msg)
    notifications = webkitNotifications.createHTMLNotification(chrome.extension.getURL("notification.html"))
    notifications.show()


# 初回起動
$ ->
    check()