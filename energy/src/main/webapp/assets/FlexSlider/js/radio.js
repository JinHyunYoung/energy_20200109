/*

CUSTOM FORM ELEMENTS

Created by Ryan Fait
www.ryanfait.com

The only things you may need to change in this file are the following
variables: checkboxHeight, radioHeight and selectWidth (lines 24, 25, 26)

The numbers you set for checkboxHeight and radioHeight should be one quarter
of the total height of the image want to use for checkboxes and radio
buttons. Both images should contain the four stages of both inputs stacked
on top of each other in this order: unchecked, unchecked-clicked,
checked, checked-clicked.

You may need to adjust your images a bit if there is a slight vertical
movement during the different stages of the button activation.

The value of selectWidth should be the width of your select list image.


*/

//JSHint Validated Custom JS Code

var checkboxHeight = "25";
var radioHeight = "25";
var selectWidth = "190";
var myArray = ["africa", "europe", "c_america", "australia", "n_america", "carribean", "asia", "s_america", "middle_east"];

var africa = ["Benin", "Gambia", "Egypt", "Malawi", "Zambia", "Niger", "Madacascar", "Lorem"];
var europe = ["Roma", "Bolzano", "Praga", "Praga", "Venezia", "Parigi", "Cagli", "Puglia"];
var c_america = ["Jamaica", "Mexico", "Guatemala", "David", "Mexico", "Mexico", "Cuba", "Jamaica"];
var australia = ["Melbourne", "Sydney", "Perth", "Sydney", "Sydney", "Melbourne", "Perth", "Perth"];
var n_america = ["Miami", "Canada", "San Diego", "New York", "Detroit", "Chicago", "Los Angeles", "New York"];
var carribean = ["Jamaica", "Cuba", "Puerto Rico", "Bahamas", "Cayman", "Haiti", "Cuba", "Jamaica"];
var asia = ["Cina", "India", "Russia", "Afganistan", "Mongoli", "China", "Korea", "Japan"];
var s_america = ["Argentina", "Brasil", "Cile", "Peru", "Brasil", "Argentina", "Cile", "Brasil"];
var middle_east = ["Iraq", "Iran", "Arabic", "Iran", "Iran", "Iraq", "Iraq", "Iraq"];

var map_africa = "https://maps.google.com.mt/maps?f=q&amp;source=s_q&amp;hl=it&amp;geocode=&amp;q=africa&amp;aq=&amp;sll=-8.783195,34.508523&amp;sspn=121.214187,270.527344&amp;gl=mt&amp;g=Africa&amp;ie=UTF8&amp;hq=&amp;hnear=Africa&amp;ll=-8.783195,34.508523&amp;spn=71.733665,135.263672&amp;t=h&amp;z=4&amp;output=embed";
var map_europe = "https://www.google.it/maps?sll=41.442726,12.392577999999995&amp;sspn=12.757592603316278,22.715160604868103&amp;t=m&amp;q=Europa&amp;dg=opt&amp;ie=UTF8&amp;hq=&amp;hnear=Europa&amp;ll=49.5,22&amp;spn=26.529675,67.631836&amp;z=5&amp;output=embed";
var map_c_america = "https://maps.google.com/?ie=UTF8&amp;ll=15.474857,-80.15625&amp;spn=18.433987,33.815918&amp;t=h&amp;z=6&amp;output=embed";
var map_australia = "http://goo.gl/maps/CC06B";
var map_n_america = "https://www.google.com/maps?f=q&amp;source=s_q&amp;hl=it&amp;geocode=&amp;q=united+states&amp;aq=&amp;sll=37.09024,-95.712891&amp;sspn=60.158465,135.263672&amp;ie=UTF8&amp;hq=&amp;hnear=Stati+Uniti&amp;t=m&amp;z=5&amp;ll=37.09024,-95.712891&amp;output=embed";
var map_carribean = "http://goo.gl/maps/GTDNn";
var map_asia = "http://goo.gl/maps/Xqytr";
var map_s_america = "http://goo.gl/maps/jIy5z";
var map_middle_east = "http://goo.gl/maps/qWgNW";

/* No need to change anything after this */


document.write('<style type="text/css">input.styled { display: none; } select.styled { position: relative; width: ' + selectWidth + 'px; opacity: 0; filter: alpha(opacity=0); z-index: 5; } .disabled { opacity: 0.5; filter: alpha(opacity=50); }</style>');

var Custom = {
    init: function () {
        var inputs = document.getElementsByTagName("input"), span = Array(), textnode, option, active;
        for (a = 0; a < inputs.length; a++) {
            if ((inputs[a].type === "checkbox" || inputs[a].type === "radio") && inputs[a].className === "styled") {
                span[a] = document.createElement("span");
                span[a].className = inputs[a].type;

                if (inputs[a].checked === true) {
                    if (inputs[a].type === "checkbox") {
                        position = "0 -" + (checkboxHeight * 2) + "px";
                        span[a].style.backgroundPosition = position;
                    } else {
                        position = "0 -" + (radioHeight * 2) + "px";
                        span[a].style.backgroundPosition = position;
                    }
                }
                inputs[a].parentNode.insertBefore(span[a], inputs[a]);
                inputs[a].onchange = Custom.clear;
                if (!inputs[a].getAttribute("disabled")) {
                    span[a].onmousedown = Custom.pushed;
                    span[a].onmouseup = Custom.check;
                } else {
                    span[a].className = span[a].className += " disabled";
                }
            }
        }
        inputs = document.getElementsByTagName("select");
        for (a = 0; a < inputs.length; a++) {
            if (inputs[a].className === "styled") {
                option = inputs[a].getElementsByTagName("option");
                active = option[0].childNodes[0].nodeValue;
                textnode = document.createTextNode(active);
                for (b = 0; b < option.length; b++) {
                    if (option[b].selected === true) {
                        textnode = document.createTextNode(option[b].childNodes[0].nodeValue);
                    }
                }
                span[a] = document.createElement("span");
                span[a].className = "select";
                span[a].id = "select" + inputs[a].name;
                span[a].appendChild(textnode);
                inputs[a].parentNode.insertBefore(span[a], inputs[a]);
                if (!inputs[a].getAttribute("disabled")) {
                    inputs[a].onchange = Custom.choose;
                } else {
                    inputs[a].previousSibling.className = inputs[a].previousSibling.className += " disabled";
                }
            }
        }
        document.onmouseup = Custom.clear;
    },
    pushed: function () {
        element = this.nextSibling;
        if (element.checked === true && element.type == "checkbox") {
            this.style.backgroundPosition = "0 -" + checkboxHeight * 3 + "px";
        } else if (element.checked === true && element.type == "radio") {
            this.style.backgroundPosition = "0 -" + radioHeight * 3 + "px";
            document.getElementById('txtState').innerHTML = element.title;
        } else if (element.checked !== true && element.type === "checkbox") {
            this.style.backgroundPosition = "0 -" + checkboxHeight + "px";
        } else {
            this.style.backgroundPosition = "0 -" + radioHeight + "px";

            var imgSrc;
            var arrayTitleCyty;
            var mapSrc;

            var imgNum = document.getElementById('ulCarousel').getElementsByTagName('img').length;
            imgSrc = document.getElementById('ulCarousel').getElementsByTagName('img')[0].src.split('/');
            var nameNation;
            for (var k = 0; k < myArray.length; k++) {
                for (var p = 0; p < imgSrc.length; p++)
                    if (imgSrc[p] === myArray[k]) {
                        nameNation = myArray[k];
                    }

            }
            //Change title

            if (element.id === "africa") {
                arrayTitleCyty = africa;
                mapSrc = map_africa;
            }
            if (element.id === "europe") {
                arrayTitleCyty = europe;
                mapSrc = map_europe;
            }
            if (element.id === "c_america") {
                arrayTitleCyty = c_america;
                mapSrc = map_c_america;
            }
            if (element.id === "australia") {
                arrayTitleCyty = australia;
                mapSrc = map_australia;
            }
            if (element.id === "n_america") {
                arrayTitleCyty = n_america;
                mapSrc = map_n_america;
            }
            if (element.id === "carribean") {
                arrayTitleCyty = carribean;
                mapSrc = map_carribean;
            }
            if (element.id === "asia") {
                arrayTitleCyty = asia;
                mapSrc = map_asia;
            }
            if (element.id === "s_america") {
                arrayTitleCyty = s_america;
                mapSrc = map_s_america;
            }
            if (element.id === "middle_east") {
                arrayTitleCyty = middle_east;
                mapSrc = map_middle_east;
            }


            for (var i = 0; i < imgNum; i++) {
                var val = document.getElementById('ulCarousel').getElementsByTagName('img')[i].src.replace(nameNation, element.id);
                document.getElementById('ulCarousel').getElementsByTagName('img')[i].src = val;
                var val2 = $("#h" + i).attr("href");
                var val3 = val2.replace(nameNation, element.id);
                $("#h" + i).attr("href", val3);

                //Change title

                document.getElementById('title' + i).innerHTML = arrayTitleCyty[i];

                //Change map
                //                $("#map" + i).attr("href", mapSrc);
                document.getElementById('map' + i).href = mapSrc;

            }


            document.getElementById('txtState').innerHTML = element.title;
        }
    },
    check: function () {
        element = this.nextSibling;
        if (element.checked === true && element.type === "checkbox") {
            this.style.backgroundPosition = "0 0";
            element.checked = false;
        } else {
            if (element.type === "checkbox") {
                this.style.backgroundPosition = "0 -" + checkboxHeight * 2 + "px";
            } else {
                this.style.backgroundPosition = "0 -" + radioHeight * 2 + "px";
                group = this.nextSibling.name;
                inputs = document.getElementsByTagName("input");
                for (a = 0; a < inputs.length; a++) {
                    if (inputs[a].name === group && inputs[a] != this.nextSibling) {
                        inputs[a].previousSibling.style.backgroundPosition = "0 0";
                    }
                }
            }
            element.checked = true;
        }
    },
    clear: function () {
        inputs = document.getElementsByTagName("input");
        for (var b = 0; b < inputs.length; b++) {
            if (inputs[b].type == "checkbox" && inputs[b].checked === true && inputs[b].className === "styled") {
                inputs[b].previousSibling.style.backgroundPosition = "0 -" + checkboxHeight * 2 + "px";
            } else if (inputs[b].type == "checkbox" && inputs[b].className === "styled") {
                inputs[b].previousSibling.style.backgroundPosition = "0 0";
            } else if (inputs[b].type == "radio" && inputs[b].checked === true && inputs[b].className === "styled") {
                inputs[b].previousSibling.style.backgroundPosition = "0 -" + radioHeight * 2 + "px";
            } else if (inputs[b].type == "radio" && inputs[b].className === "styled") {
                inputs[b].previousSibling.style.backgroundPosition = "0 0";
            }
        }
    },
    choose: function () {
        option = this.getElementsByTagName("option");
        for (d = 0; d < option.length; d++) {
            if (option[d].selected === true) {
                document.getElementById("select" + this.name).childNodes[0].nodeValue = option[d].childNodes[0].nodeValue;
            }
        }
    }
};
window.onload = Custom.init;