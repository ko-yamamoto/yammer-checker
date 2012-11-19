// Generated by CoffeeScript 1.4.0
var api_url, check, delay_time, last_time, notify, process,
  __slice = [].slice;

api_url = "https://www.yammer.com/api/v1/messages/my_feed.json";

delay_time = 60 * 5;

last_time = 0;

check = function() {
  console.log("check start");
  process();
  return setTimeout(check, delay_time * 1000);
};

process = function() {
  console.log("process start");
  return jQuery(function() {
    var _this = this;
    return $.getJSON(api_url, function(response) {
      var head, items, messeage, new_date, tail, type;
      items = response.messages;
      head = items[0], tail = 2 <= items.length ? __slice.call(items, 1) : [];
      messeage = head.body.parsed;
      type = head.message_type;
      localStorage.ls_message = messeage;
      localStorage.ls_type = type;
      new_date = Date.parse(head.created_at);
      if (new_date > last_time) {
        last_time = new_date;
        return notify(type, messeage);
      }
    });
  });
};

notify = function(type, msg) {
  var notifications;
  notifications = webkitNotifications.createHTMLNotification(chrome.extension.getURL("notification.html"));
  return notifications.show();
};

$(function() {
  return check();
});
