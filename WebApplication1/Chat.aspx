<%@ Page Language="C#" AutoEventWireup="true" Inherits="ChatSample.Chat" CodeBehind="Chat.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="Stylesheet" href="Styles/Site.css" />
    <script src="Scripts/jquery-1.6.4.js" type="text/javascript"></script>
    <script src="Scripts/json2.js" type="text/javascript"></script>
    <script src="Scripts/jquery.signalR-1.0.0-rc2.min.js" type="text/javascript"></script>
    <script src="signalr/hubs" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            // Proxy created on the fly
            var chat = $.connection.chatHub;

            chat.client.OnlineStatus = function (connectionId, userList) {
                $("img[id^=stat]").attr('src', 'images/offline.png');
                $(userList).each(function (index, obj) {
                    if (obj == "111") {
                        $("#stat1").attr('src', 'images/online.png');
                        $("#status1").addClass('online');
                    }
                    else if (obj == "222") {
                        $("#stat2").attr('src', 'images/online.png');
                        $("#status2").addClass('online');
                    }
                    else if (obj == "333") {
                        $("#stat3").attr('src', 'images/online.png');
                        $("#status3").addClass('online');
                    }
                });
            };

            chat.client.joined = function (connectionId, userList) {
                $(userList).each(function (index, obj) {
                    if (obj == "111") {
                        $("#stat1").attr('src', 'images/online.png');
                        $("#stat1").addClass('online');
                    }
                    else if (obj == "222") {
                        $("#stat2").attr('src', 'images/online.png');
                        $("#stat2").addClass('online');
                    }
                    else if (obj == "333") {
                        $("#stat3").attr('src', 'images/online.png');
                        $("#stat3").addClass('online');
                    }
                });
            };

            chat.client.setChatWindow = function (strGroupName, strChatTo) {
                $('div[chatToId=' + strChatTo + ']').attr('groupname', strGroupName);
                $('div[chatToId=' + strChatTo + ']').css('display', 'block')
            };
            // Declare a function on the chat hub so the server can invoke it
            chat.client.addMessage = function (message, groupName) {
                if ($('div[groupname=' + groupName + ']').length == 0) {
                    var chatWindow = $("#divChatWindow").clone(true);
                    $(chatWindow).css('display', 'block');
                    $(chatWindow).attr('groupname', groupName);
                    $("#chatContainer").append(chatWindow);
                }
                $('div[groupname=' + groupName + ']').find('ul').append('<LI>' + message + '');
            };
            $("#broadcast").click(function () {
                // Call the chat method on the server
                chat.server.send($('#msg').val());
            });
            // Start the connection
            $.connection.hub.start(function () {
                chat.server.getAllOnlineStatus();
            });

            $('.UserItem').click(function () {
                if ($(this).hasClass('online')) {
                    chat.server.createGroup($('#hdnUserId').val(), $(this).attr('data-userid'));
                    var chatWindow = $("#divChatWindow").clone(true);
                    //$(chatWindow).css('display', 'block');
                    $(chatWindow).attr('chatToId', $(this).attr('data-userid'));
                    $("#chatContainer").append(chatWindow);
                }
                return false;
            });

            $(".ChatSend").click(function () {
                strChatText = $('.ChatText', $(this).parent()).val();
                if (strChatText != '') {
                    var strGroupName = $(this).parent().attr('groupname');
                    if (typeof strGroupName !== 'undefined' && strGroupName !== false)
                        chat.server.send($("#hdnUserName").val() + ' : ' + strChatText, $(this).parent().attr('groupname'));
                    $('.ChatText', $(this).parent()).find('ul').append(strChatText);
                    $('.ChatText', $(this).parent()).val('');
                }
                return false;
            });
        });

    </script>
</head>
<body>
    <form id="form1" runat="server">

        <div id="divChatWindow" style="border: 1px solid #3366CC; float: left; width: 365px; display: none; margin-right: 10px">
            <div style="border: 1px solid blue;">
                <ul id="messages" style="width: 465px; height: 100px; font: normal 2 verdana"></ul>
            </div>
            <hr />
            <asp:TextBox runat="server" ID="msg" CssClass="ChatText" Width="280px" BorderColor="#666699"
                BorderStyle="Solid" BorderWidth="1px" Height="22px"></asp:TextBox>
            <asp:Button ID="btnChatSend" runat="server" CssClass="ChatSend" Text="Submit" OnClientClick="return false"
                BackColor="#99ccff" Font-Size="Smaller" BorderStyle="Solid" BorderWidth="1px"
                BorderColor="#0066FF" ForeColor="#336699" Height="24px" />
        </div>

        <br />
        <asp:Label ID="lblUserName" runat="server" Font-Bold="true"/>
        <br />
        <div style="border: thin solid #C0C0C0; font-family: Tunga; width: 70px; font-weight: 500;">            
            <asp:Image ID="stat1" runat="server" Width="18px" Height="18px" ImageUrl="~/Images/offline.png" />
            <a id="status1" class="UserItem" data-userid="111" href="#">Kedar</a>
            <br />
            <asp:Image ID="stat2" runat="server" Width="18px" Height="18px" ImageUrl="~/Images/offline.png" />
            <a id="status2" class="UserItem" data-userid="222" href="#">abc</a>
            <br />
            <asp:Image ID="stat3" runat="server" Width="18px" Height="18px" ImageUrl="~/Images/offline.png" />
            <a id="status3" class="UserItem" data-userid="333" href="#">xyz</a>
        </div>
        <div style="float: left" id="chatContainer">
        </div>
        <asp:HiddenField ID="hdnUserId" runat="server" />
        <asp:HiddenField ID="hdnUserName" runat="server" />
    </form>
</body>
</html>
