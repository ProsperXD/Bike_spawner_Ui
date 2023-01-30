$(document).ready(function(){

    // --MENU START 
    function MenuOPen(bool) {
    if (bool) {
    $("#menu").show().css;
    } else {
    $("#menu").fadeOut();
    }
    }
    MenuOPen(false)
    window.addEventListener('message', function(event) {
    var item = event.data;
    let Data = event.data
    if (item.type === "bike_spawner") {
    if (item.status == true) {
        $(`.notificationBike`).html(`${Data.checkblocked}`)
        
        
        MenuOPen(true)
    } else {
    MenuOPen(false)
    }
    }
    });

    let ButtonstoPRess = {
        "R": 82,
        "E": 69,
        "X": 88,
        "B": 66,
        "esc": 27,
        "Z": 90,
        "Fn12": 123,
        "ESC": 27,
        }
       document.onkeyup = function(data) {
           if (data.which == ButtonstoPRess.ESC) {
               $.post(`https://${GetParentResourceName()}/close`)
               return
           }
       };
    
});


function bike1() {
    $.post(`https://${GetParentResourceName()}/spawnbike1`)
}



function bike2() {
    $.post(`https://${GetParentResourceName()}/spawnbike2`)
}