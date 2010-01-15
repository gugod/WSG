$.fn.moreText = function(n) {
    this.each(function() {
        var m = n;
        var self = $(this);

        if (!m) {
            var matched = self.attr("class").match(/lipsum\((\d+)\)/);
            if (matched) {
                m = matched[1]
            }
            else {
                m = 1
            }
        }

        $.getJSON("/sentences.json", { 'n': m }, function(data) {
            self.append(data.sentences.join(""));
        });
    });
};

$(function() {
    $("*[class*=lipsum]").moreText();

    $("#button\\\:regenerate-text").bind("click", function() {
        $("*[class*=lipsum]").empty().moreText();
        return false;
    })
});