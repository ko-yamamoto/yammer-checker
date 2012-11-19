# 初回起動
$ ->
    $("#type").html(localStorage.ls_type)
    delete localStorage.ls_type

    $("#message").html(localStorage.ls_message)
    delete localStorage.ls_message