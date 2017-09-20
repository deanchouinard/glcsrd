// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
import http_request from "./xml_http_request.js";
import Chart from 'chart.js';
var ctx = document.getElementById("myChart");
  // var Chart = require("chart.js");
//import Chart from 'chart.js';
function displayChart(xhttp) {
  var values = [];
  var weight_values = [];
  var dlabels = [];
  var list = JSON.parse(xhttp.responseText);
  console.log(list);
  console.log("after list");
  for (var x in list.items.glucose) {
    values.push(list.items.glucose[x].value);
    var segments = list.items.glucose[x].date.split("-")
    dlabels.push(segments[1] + "/" + segments[2]);
    console.log(list.items.glucose[x].value);
    console.log(x);
  }
  for (var x in list.items.weight) {
    weight_values.push(list.items.weight[x].value);
  }


  var myLineChart = new Chart(ctxLine, {
    type: 'line',
    data: {
        datasets: [{
            label: 'mg/dL',
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
//            backgroundColor: window.chartColors.blue,
  //          borderColor: window.chartColors.blue,
            //data: [110, 120, 130, 125, 105, 115]
            data: values
        }, {
          label: 'weight',
          borderColor: 'rgba(54, 162, 235, 1)',
          backgroundColor: 'rgba(54, 162, 235, 0.2)',
          fill: false,
          data: weight_values
    //      data: [200, 201, 199, 198, 202]
        }],
        //labels: ['8/1', '8/2', '8/3', '8/4', '8/5', '8/6'],
        labels: dlabels,
    },
    options: {
        title:{
          display:true,
          text:'Glucose Readings and Weight'
        },
        scales: {
            xAxes: [{
                ticks: {
                    min: 'January'
                }
            }]
        }
    }
  });
  //for (var x in list.items) {
    //$("#slist").append("<li>" + list.items[x] + "</li>");
  //}
}

var ctxLine = document.getElementById("myLineCxt");
if (ctxLine) {
  var cUrl = "/api/readings"
  http_request.loadDoc(cUrl, displayChart);
};

var btns = document.getElementById("buttons");
if (btns) {
  var button = document.createElement("button");
  button.innerHTML = "Reload Data"
  btns.appendChild(button);
  button.addEventListener ("click",
    function() {
      var cUrl = "/api/reload"
      http_request.loadDoc(cUrl, displayChart);
    });
}

if (ctx) {
  var myCart = new Chart(ctx, {
  type: 'bar',
  data: {
        labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
        datasets: [{
            label: '# of Votes',
            data: [12, 19, 3, 5, 2, 3],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        }
    }
  });
};

