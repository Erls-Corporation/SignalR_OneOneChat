<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="User.aspx.cs" Inherits="User" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
<style type="text/css">
      #divAlert {
     position: absolute;
     top: 0;
     padding-top:5px;
     height:50px;
     z-index:50;
     width:65%;
     direction:ltr;
     background-color:#ffff66;     
     color:Black;
     font-family:Verdana;
     font-size:3;
     font-weight:100;
     border:1 solid black;
  }
</style>

    <script src="Scripts/jquery-1.6.4.js" type="text/javascript"></script>
    <script src="Scripts/json2.js" type="text/javascript"></script>  
    <script src="Scripts/jquery.signalR.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            // Proxy created on the fly
            var connection = $.connection('echo');

            var $window = $(window),
            $stickyEl = $('#divAlert');

            var elTop = $stickyEl.offset().top;

            $window.scroll(function () {
                var windowTop = $window.scrollTop();

                $stickyEl.toggleClass('sticky', windowTop > elTop);
            });


            // Declare a function on the chat hub so the server can invoke it
            connection.received(function (data) {
                $('#divAlert').show('slow');
                $('#divAlert').html(data);
            });

            // Start the connection
            connection.start();
        });

</script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <div id="divAlert" style="display:none;">
    </div>
                    <h2>
                        User module</h2>
                    <p>
                        simple data entry form</p>
                    <div class="accountInfo">
                        <fieldset class="register">
                            <legend>Enter Transaction Details</legend>
                            <p>
                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" >Account Id</asp:Label>
                                <asp:TextBox ID="UserName" runat="server" CssClass="textEntry"></asp:TextBox>
                            </p>
                            <p>
                                <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email">Customer Name:</asp:Label>
                                <asp:TextBox ID="Email" runat="server" CssClass="textEntry"></asp:TextBox>
                            </p>
                            <p>
                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Amount</asp:Label>
                                <asp:TextBox ID="Password" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>

                            </p>
                            <p>
                                <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">Offer Name</asp:Label>
                                <asp:TextBox ID="ConfirmPassword" runat="server" CssClass="passwordEntry" TextMode="Password"></asp:TextBox>

                            </p>
                        </fieldset>
                        <p align="left" dir="ltr">
                            <asp:Button ID="CreateUserButton" runat="server" CommandName="MoveNext" Text="Add Transaction" 
                                 ValidationGroup="RegisterUserValidationGroup"/>
                        </p>
                    </div>

</asp:Content>
