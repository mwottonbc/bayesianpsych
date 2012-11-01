function throttle(delay, fn){
  var timer = null;
  return function () {
    var context = this, args = arguments;
    clearTimeout(timer);
    timer = setTimeout(function () {
      fn.apply(context, args);
    }, delay);
  };
}

$(function () {
    var minlength = 3;
    var smileys = {'Negative': '☹',
                   'Positive': '☺' };
      $("#search").keyup(function(e) {
                             if (e.which == 13) {
                                 $("#chatlog").append("<li><span>" + $("#face").text() + "</span>" + $(this).val() + "</li>");
                                 $(this).val("");
                             }

                         });
    $("#search").keypress(throttle(500, 
                                   function () {
                                       value = $(this).val();
                                       if (value.length < minlength ) { return; }
                                       $.getJSON("happy.json",
                                                 { 'text' : value },
                                                 function(msg){
                                                     t = msg['classification'];
                                                     $('#face').text(smileys[t]).removeClass('negative positive').addClass(t);

                                                 });
                                       
                                   }
                                  ));
});
