<%@ page pageEncoding="UTF-8" %>
<%
    response.setHeader("Cache-Control","no-cache");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader ("Expires", -1);
%>
<html>

<head>
    <link rel="stylesheet" href="style.css" type="text/css"/>
    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="invalid.js"></script>
    <jsp:useBean id="results" class="server.ResultsHolder" scope="session">
    </jsp:useBean>

</head>
<body>
<%
    if(request.getParameter("clear")!=null)results.refresh();
%>
<table id="tmain">
    <tr class="logohead">
        <td class="logo" colspan="2">
            <div>
                Очаковский Юрий Владимирович P3213

                Вариант N213014
            </div>
            <div id="logimg"></div>
            <div>
                Powered by YURAN.US
            </div>
        </td>
    </tr>
    <tr class="values">
        <td id="zone">
            <canvas height="360px" width="360px" id="zoneCanvas"></canvas>
        </td>
        <td class="data_response" id="dresp" rowspan="6">
            <center>
                <a href="index.jsp?clear=1">Очистка</a><br>
                <div>
                    <div class="headsc"><span>X</span><span>Y</span><span>R</span><span>Result</span></div>
                    <div class="cont"> <table class="kek"><tbody  id="rtab">
                    <%=
                    results.toString()
                    %>
                    </tbody></table></div>

                </div>
            </center>
        </td>
    </tr>
    <tr class="valuess">
        <td class="data_value" id="box_X">
            <span>Pos X:</span><div id="xdata" class="xbuts">
                <select form="mform" name="posX" id="posX">
                    <option value="-4">-4</option>
                    <option value="-3">-3</option>
                    <option value="-2">-2</option>
                    <option value="-1">-1</option>
                    <option value="0">0</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>

                </select>
            </div>
        </td>
    </tr>
    <tr class="valuess">
        <td class="data_value" id="box_Y">
            <form method="GET" id="mform" onsubmit="return isValidIns();">
                <span>Pos Y:</span><input type="text" name="posY" id="posY" class="yin" maxlength="12" onkeyup="reqValid();" value="9">
            </form>
        </td>
    </tr>
    <tr class="valuess">
        <td class="data_value" id="box_R">
            <span>Radius:</span><div id="rdata" class="rbuts">
                <input type="text" form="mform" name="ras" id="ras" class="yin" maxlength="12" onkeyup="reqValid(); redrawGraph();" value="4">
            </div>
        </td>
    </tr>
    <tr>
        <td id="sbutton">
            <button type="button" form="mform" id="sbutk" disabled onclick="formrequest();" name="submit_btn" >
                Поехали
            </button>
        </td>
    </tr>
    <tr class="butkon">


    </tr>
</table>
<script>

    var plot_canvas = document.getElementById("zoneCanvas");
    var plot_context = plot_canvas.getContext("2d");
    redrawGraph();



    function drawPoint(r,x,y,color) {
        plot_context.beginPath();
        plot_context.fillStyle = color;
        plot_context.arc(x*180/6 + 180, y*(-180)/6 + 180,3,0,2*3.14);
        plot_context.fill();
        plot_context.closePath();

    }
    <%=
    results.drawPoints()
    %>
    function formrequest() {
        if (!isValidIns()) {
            return
        }
        var xvalue = document.getElementById('posX').value;
        var yvalue = document.getElementById('posY').value;
        var R = document.getElementById('ras').value;
        sendAjax(xvalue,yvalue,R);
    }
    function redrawGraph() {

        //var rr = document.getElementById("r");
        var R = document.getElementById('ras').value;

        plot_context.clearRect(0, 0, plot_canvas.width, plot_canvas.height);
        if(isValidR()) {
            plot_context.strokeStyle = "#000000";
            plot_context.fillStyle = "#000000";


            plot_context.beginPath();
            plot_context.arc(180, 180, R * 150 / 5,  Math.PI * 1.5, Math.PI * 2);
            plot_context.lineTo(180, 180);
            plot_context.closePath();

            plot_context.rect(180 - R * 150 / 5, 180, R * 150 / 5, R * 75 / 5);
            plot_context.fillStyle = 'blue';
            plot_context.fill();

            plot_context.beginPath();
            plot_context.moveTo(180, 180);
            plot_context.lineTo(180, 180 + R * 75 / 5);
            plot_context.lineTo(180 + R * 75 / 5, 180);
            plot_context.lineTo(180, 180);
            plot_context.closePath();
            plot_context.fillStyle = 'blue';
            plot_context.fill();
            $.post("control", {"Redraw":true, "x":0.0, "y":0.0, "r":R},function(){});
        }
        plot_context.beginPath();
        //Ox
        plot_context.fillStyle = 'black';
        plot_context.moveTo(0, 180);
        plot_context.lineTo(360, 180); //360, 180
        plot_context.lineTo(350, 170); //290, 140
        plot_context.moveTo(360, 180); //360, 180
        plot_context.lineTo(350, 190); //290, 160
        plot_context.moveTo(360, 180); //360, 180
        //0x markers

        plot_context.moveTo(330, 176); //
        plot_context.lineTo(330, 184); //+5
        plot_context.moveTo(300, 176); //
        plot_context.lineTo(300, 184); //+4
        plot_context.moveTo(270, 176); //
        plot_context.lineTo(270, 184); //+3
        plot_context.moveTo(240, 176); //
        plot_context.lineTo(240, 184); //+2
        plot_context.moveTo(210, 176); //
        plot_context.lineTo(210, 184); //+1
        plot_context.moveTo(150, 176); //
        plot_context.lineTo(150, 184); //-1
        plot_context.moveTo(120, 176); //
        plot_context.lineTo(120, 184); //-2
        plot_context.moveTo(90, 176); //
        plot_context.lineTo(90, 184); //-3
        plot_context.moveTo(60, 176); //
        plot_context.lineTo(60, 184); //-4
        plot_context.moveTo(30, 176); //
        plot_context.lineTo(30, 184); //-5

        //Oy
        plot_context.moveTo(180, 0);
        plot_context.lineTo(170, 10);
        plot_context.moveTo(180, 0);
        plot_context.lineTo(190, 10);
        plot_context.moveTo(180, 0);
        plot_context.lineTo(180, 360);
        plot_context.moveTo(30, 180);

        //0y markers

        plot_context.moveTo(176, 330); //
        plot_context.lineTo(184, 330); //+5
        plot_context.moveTo(176, 300); //
        plot_context.lineTo(184, 300); //+4
        plot_context.moveTo(176, 270); //
        plot_context.lineTo(184, 270); //+3
        plot_context.moveTo(176, 240); //
        plot_context.lineTo(184, 240); //+2
        plot_context.moveTo(176, 210); //
        plot_context.lineTo(184, 210); //+1
        plot_context.moveTo(176, 150); //
        plot_context.lineTo(184, 150); //-1
        plot_context.moveTo(176, 120); //
        plot_context.lineTo(184, 120); //-2
        plot_context.moveTo(176, 90); //
        plot_context.lineTo(184, 90); //-3
        plot_context.moveTo(176, 60); //
        plot_context.lineTo(184, 60); //-4
        plot_context.moveTo(176, 30); //
        plot_context.lineTo(184, 30); //-5

        plot_context.closePath();
        plot_context.stroke();
        plot_context.fillStyle = "#000000";
        plot_context.textAlign ="center";
        plot_context.font = "18px Arial";

        plot_context.fillText("x", 345, 165);
        plot_context.fillText("y", 190, 15);
        plot_context.font = "10px Arial";
        plot_context.fillText("0", 170, 195);
        //x
        plot_context.fillText("-5", 30, 195);
        plot_context.fillText("-4", 60, 195);
        plot_context.fillText("-3", 90, 195);
        plot_context.fillText("-2", 120, 195);
        plot_context.fillText("-1", 150, 195);
        plot_context.fillText("1", 210, 195);
        plot_context.fillText("2", 240, 195);
        plot_context.fillText("3", 270, 195);
        plot_context.fillText("4", 300, 195);
        plot_context.fillText("5", 330, 195);
        //y
        plot_context.fillText("5", 170, 35);
        plot_context.fillText("4", 170, 65);
        plot_context.fillText("3", 170, 95);
        plot_context.fillText("2", 170, 125);
        plot_context.fillText("1", 170, 155);
        plot_context.fillText("-1", 170, 215);
        plot_context.fillText("-2", 170, 245);
        plot_context.fillText("-3", 170, 275);
        plot_context.fillText("-4", 170, 305);
        plot_context.fillText("-5", 170, 335);


    }
    function sendAjax(x, y, r){
        $.ajax({
            type:'POST',
            url:'control',
            dataType:"text",
            data:{"x":x, "y":y, "r":r},
            response:'text',
            error: function (message) {
                console.log(message);
            },
            success:function (data) {

                if(x==null || y==null || r==null)
                {
                    console.log("PARAMETRNULL!");
                    return
                }
                console.log(data);
                let jdata = JSON.parse(data);

                document.getElementById('rtab').innerHTML = jdata['htmltxt'] + document.getElementById('rtab').innerHTML;
                //drawPoint(value*100/R+180, -1*yvalue*100/R+180,3,0,2*3.14,"#00FF00")
                plot_context.beginPath();
                if(jdata['Inside'] == "1")
                {
                    drawPoint(r, x, y, "#00FF00");
                }
                else if(jdata['Inside'] == "2")
                {

                        drawPoint(r, x, y, "#AFAFAF");

                }
                else
                {
                    drawPoint(r, x, y, "#FF0000");
                }
                /*iframe = document.getElementById('if');
                if(iframe.contentWindow.document.getElementsByTagName("tr")[1].getElementsByTagName("td")[3].innerText=="+"){
                    plot_context.fillStyle = "green";
                }
                else {
                    plot_context.fillStyle = "red";

                }*/

            }
        });

    }
    document.getElementById("zoneCanvas").addEventListener("click", function (e) {
        if(isValidR()) {
            const x = (e.x - document.getElementById("zoneCanvas").getBoundingClientRect().left - 180) / (30);
            const y = (e.y - document.getElementById("zoneCanvas").getBoundingClientRect().top - 180) / (-30);
            sendAjax(x,y,document.getElementById("ras").value);
        }
    });
</script>
</body>
</html>
