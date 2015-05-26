
$(function(){
    var waypoint = new Waypoint({
        element: document.getElementById('row-1'),
        offset: 200,
        handler: function(direction) {
            $('.active').removeClass('active');
            $(".row-1").addClass("active");
        }
    });
    var waypoint2 = new Waypoint({
        element: document.getElementById('row-2'),
        offset: 200,
        handler: function(direction) {
            $('.active').removeClass('active');
            $(".row-2").addClass("active");
        }
    });
    var waypoint3 = new Waypoint({
        element: document.getElementById('row-3'),
        offset: 200,
        handler: function(direction) {
            $('.active').removeClass('active');
            $(".row-3").addClass("active");
        }
    });
    var waypoint4 = new Waypoint({
        element: document.getElementById('row-4'),
        offset: 200,
        handler: function(direction) {
            $('.active').removeClass('active');
            $(".row-4").addClass("active");
        }
    });
    var waypoint5 = new Waypoint({
        element: document.getElementById('row-5'),
        offset: 200,
        handler: function(direction) {
            $('.active').removeClass('active');
            $(".row-5").addClass("active");
        }
    });
});
