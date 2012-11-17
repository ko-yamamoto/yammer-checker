# Settings
# 更新間隔(秒)
delay_seconds = 60 * 5

# JSON 取得先
target_url = "https://www.yammer.com/api/v1/streams/notifications.json"

# 最終更新時間
previous_post_time = 0

# 更新確認開始
check_update = ->
    console.log "check start"
    process()
    # next check
    setTimeout(check_update, 1000 * delay_seconds)

# JSON を取得、更新有無確認、更新があれば通知
process = ->

    console.log "process2"
    jQuery ->
        $.getJSON(target_url, (response) =>
            # console.log response
            items = response.items
            [head, tail...] = items
            new_messeage = head.message
            new_date = Date.parse(head.created_at)

            if new_date > previous_post_time
                previous_post_time = new_date
                notify(new_messeage)

            console.log new_messeage

        )

# 通知を表示
notify = (msg) ->
    note = webkitNotifications.createNotification(null, "New!", msg)
    note.show()

# 起動
$ ->
    console.log "check start"
    process()
    setTimeout(check_update, 1000 * delay_seconds)
