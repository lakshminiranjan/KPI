
Public Class WebForm1
    Inherits System.Web.UI.Page

    Protected Sub btnLogin_Click(sender As Object, e As EventArgs)
        Dim username = txtUsername.Text.Trim()
        Dim password = txtPassword.Text

        ' Basic hardcoded credentials
        If username = "admin" AndAlso password = "password123" Then
            ' Set session and redirect to Default.aspx
            Session("User") = username
            Response.Redirect("Default.aspx")
        Else
            lblError.Text = "Invalid username or password."
            lblError.Visible = True
        End If
    End Sub



End Class