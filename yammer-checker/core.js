// Generated by CoffeeScript 1.4.0
(function() {
  var check, delay_time, disappear_time, feed_api_url, last_time, main, notify, user_api_url,
    __slice = [].slice;

  feed_api_url = "https://www.yammer.com/api/v1/messages/my_feed.json";

  user_api_url = "https://www.yammer.com/api/v1/users/";

  delay_time = 60 * 3;

  last_time = 0;

  disappear_time = 5;

  check = function() {
    main();
    return setTimeout(check, delay_time * 1000);
  };

  main = function() {
    return jQuery(function() {
      var _this = this;
      return $.getJSON(feed_api_url, function(response) {
        var head, items, messeage, new_date, tail, type, user_id;
        items = response.messages;
        head = items[0], tail = 2 <= items.length ? __slice.call(items, 1) : [];
        messeage = head.body.parsed;
        type = head.message_type;
        user_id = head.sender_id;
        localStorage.ls_message = messeage;
        localStorage.ls_type = type;
        new_date = Date.parse(head.created_at);
        if (new_date > last_time) {
          last_time = new_date;
          return jQuery(function() {
            var _this = this;
            return $.getJSON(user_api_url + user_id + ".json", function(response) {
              localStorage.ls_user_name = response.full_name;
              return notify();
            });
          });
        }
      });
    });
  };

  notify = function() {
    var notifications;
    notifications = webkitNotifications.createHTMLNotification(chrome.extension.getURL("notification.html"));
    notifications.show();
    return setTimeout((function() {
      return notifications.cancel();
    }), disappear_time * 1000);
  };

  $(function() {
    return check();
  });

}).call(this);
