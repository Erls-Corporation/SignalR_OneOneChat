<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ChatSample.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
<div id="divPage" style="width: 900px;height:500px; vertical-align: central; text-align: center">
            <div id="divLogin" style="top:300px;left:300px">
                <table>
                    <tr>
                        <td>User Name</td>
                        <td>
                            <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td>
                            <asp:TextBox ID="txtPassword" TextMode="Password" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:Button ID="btnLogin" runat="server" BackColor="#99ccff" Font-Size="Smaller" BorderStyle="Solid" BorderWidth="1px"
                                BorderColor="#0066FF" ForeColor="#336699" Height="24px" Text="Login" OnClick="btnLogin_Click"/></td>
                    </tr>
                </table>
                <hr />
            </div>
        </div>
    </form>
</body>
</html>
