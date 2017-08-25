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
  var dlabels = [];
  var list = JSON.parse(xhttp.responseText);
  console.log(list);
  for (var x in list.items) {
    values.push(list.items[x].value);
    var segments = list.items[x].date.split("/")
    dlabels.push(segments[0] + "/" + segments[1]);
    console.log(list.items[x].value);
    console.log(x);
  }

  var myLineChart = new Chart(ctxLine, {
    type: 'line',
    data: {
        datasets: [{
            label: 'mg/dL',
            //data: [110, 120, 130, 125, 105, 115]
            data: values
        }],
        //labels: ['8/1', '8/2', '8/3', '8/4', '8/5', '8/6'],
        labels: dlabels,
    },
    options: {
        title:{
          display:true,
          text:'Glucose Readings'
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

