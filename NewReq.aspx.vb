Imports System
Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports System.Reflection
Imports DevExpress.Web
Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxPivotGrid
Imports DevExpress.XtraPivotGrid
Imports DevExpress.XtraRichEdit.Export.Doc
Imports DevExpress.XtraRichEdit.Import.Doc
Imports DocumentFormat.OpenXml.Spreadsheet

Partial Public Class NewReq
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            BindMainGrid()
        End If
    End Sub

    Private Sub BindMainGrid()
        Dim dt As New DataTable()
        dt.Columns.Add("ID", GetType(Integer))
        dt.Columns.Add("Name", GetType(String))
        dt.Columns.Add("Role", GetType(String))

        dt.Rows.Add(1, "Niranjan", "Admin")
        dt.Rows.Add(2, "Anita", "Manager")
        dt.Rows.Add(3, "Rahul", "User")

        gvDemo.DataSource = dt
        gvDemo.DataBind()
    End Sub

    Protected Sub gvDetail_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Dim detailGrid As DevExpress.Web.ASPxGridView = CType(sender, DevExpress.Web.ASPxGridView)
        Dim parentID As Integer = Convert.ToInt32((CType(detailGrid.NamingContainer, DevExpress.Web.GridViewDetailRowTemplateContainer)).KeyValue)

        Dim dt As New DataTable()
        dt.Columns.Add("Project", GetType(String))
        dt.Columns.Add("Status", GetType(String))

        If parentID = 1 Then
            dt.Rows.Add("KPI001", "Active")
            dt.Rows.Add("KPI002", "Inactive")
        ElseIf parentID = 2 Then
            dt.Rows.Add("HR001", "Ongoing")
            dt.Rows.Add("HR002", "Completed")
        Else
            dt.Rows.Add("USR001", "Pending")
            dt.Rows.Add("USR002", "Done")
        End If

        detailGrid.DataSource = dt
    End Sub



End Class
