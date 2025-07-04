<%@ Page Language="vb" AutoEventWireup="true" CodeBehind="Login.aspx.vb" Inherits="KPILibrary.WebForm1" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <style>
        .login-container {
            width: 320px;
            margin: 100px auto;
            padding: 24px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background: #fafafa;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        .login-container h2 {
            text-align: center;
            margin-bottom: 18px;
        }
        .login-container label {
            display: block;
            margin-bottom: 6px;
        }
        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 14px;
            border: 1px solid #bbb;
            border-radius: 4px;
        }
        .login-container input[type="submit"] {
            width: 100%;
            padding: 8px;
            background: #2196F3;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-weight: bold;
            cursor: pointer;
        }
        .login-container .error {
            color: red;
            margin-bottom: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <h2>Login</h2>
            <asp:Label ID="lblError" runat="server" CssClass="error" Visible="false" />
            <label for="txtUsername">Username</label>
            <asp:TextBox ID="txtUsername" runat="server" />
            <label for="txtPassword">Password</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" />
            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
        </div>
    </form>
</body>
</html>
