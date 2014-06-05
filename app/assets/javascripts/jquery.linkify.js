
function linkify(string, buildHashtagUrl, buildUserUrl) {
  var orig_string = string;
  string = string.replace(/(http|https|ftp)\:\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(:[a-zA-Z0-9]*)?\/?([a-zA-Z0-9\-\._\?\,\'\/\\\+&amp;%\$#:\=~])*/g, function(str) {return imagify(str, orig_string);});
  if (buildHashtagUrl) {
    string = string.replace(/\B#(\w+)/g, "<a href=" + buildHashtagUrl("$1") +">#$1</a>");
  }
  if (buildUserUrl) {
    string = string.replace(/\B@(\w+)/g, "<a href=" + buildUserUrl("$1") +">@$1</a>");
  }
  return string;
}

(function($) {
  $.fn.linkify = function(buildHashtagUrl, buildUserUrl) {
    return this.each(function() {
      var $this = $(this);
      $this.html(linkify($this.html(), buildHashtagUrl, buildUserUrl));
    });
  }
})(jQuery);
