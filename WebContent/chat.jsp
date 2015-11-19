<script type="text/javascript">
    /*global window, document, newRequest, send, receive, alert, XMLHttpRequest, ActiveXObject*/
    var request;

    /* this function receives the chat message and writes it to the text area */
    function receive(request) {
        var txt = document.getElementById("history");
        txt.innerHTML = txt.innerHTML + request.responseText;
        send('connect'); /* current request is dead, must create a new one */
    }

    /* this function initiates a request, either to send a message or to connect */
    function send(arg) {
        var url = '/TomcatComet/Chat';

        if (typeof request == 'undefined') {
            /* create new request */
            request = new XMLHttpRequest();
        }

        request.open("POST", url, true);
        request.setRequestHeader("Content-Type", "application/x-javascript;");

        request.onreadystatechange = function() {
            /* we are interested only in a complete response */
            if (request.readyState >= 4 && request.status == 200) {
                if (request.responseText) {
                    receive(request);
                }
            }
        };

        if (arg.substring(0, 4) == "send") {
            arg = document.messageForm.message.value;
            document.messageForm.message.value = "";
            document.messageForm.message.focus();

            request.send(arg);
        } else if (arg.substring(0, 7) == "connect") {
            request.send();
        }
    }
</script>
</head>

<body onload="send('connect');">
    <form name="messageForm">
        <textarea name="history" id="history" readonly cols=80 rows=10></textarea>
        <br />
        <textarea name="message" id="message" cols=80 rows=2></textarea>
        <br /> <input type="button" value="Send" onclick="send('send');" />
    </form>
</body>