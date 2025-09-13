Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports DevExpress.Web

Public Class AdminReport
    Inherits System.Web.UI.Page

    Private ReadOnly Property ConnStr As String
        Get
            Return System.Configuration.ConfigurationManager.ConnectionStrings("MyDatabase").ConnectionString
        End Get
    End Property

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            BindKPIGrid()
            BindGroupsGrid()
        End If
    End Sub

    ' Load KPI Table
    Private Sub BindKPIGrid()
        Dim sql As String = "SELECT [ID], [KPI Name] AS KPI_Name, [KPI ID] AS KPI_ID FROM [dbo].[KPITable] ORDER BY [KPI ID]"
        Dim dt As New DataTable()
        Using cn As New SqlConnection(ConnStr)
            Using da As New SqlDataAdapter(sql, cn)
                da.Fill(dt)
            End Using
        End Using
        gvKPI.DataSource = dt
        gvKPI.DataBind()
    End Sub

    ' Load Groups Panel (master list)
    Private Sub BindGroupsGrid()
        Dim sql As String = "SELECT DISTINCT GroupID, GroupName FROM KPI_Groups ORDER BY GroupID"
        Dim dt As New DataTable()
        Using cn As New SqlConnection(ConnStr)
            Using da As New SqlDataAdapter(sql, cn)
                da.Fill(dt)
            End Using
        End Using
        gvGroups.DataSource = dt
        gvGroups.DataBind()
    End Sub

    ' Handle Group Button Click - create group and add selected KPI IDs
    Protected Sub btnGroup_Click(sender As Object, e As EventArgs)
        Dim newGroupName As String = "Group " & (GetNextGroupNumber())
        Dim newGroupID As Integer
        'Dim selectedKPIs As List(Of Object) = gvKPI.GetSelectedFieldValues("KPI_ID")
        Dim selectedKPIs As List(Of Object) = gvKPI.GetSelectedFieldValues("KPI_ID")

        Using cn As New SqlConnection(ConnStr)
            cn.Open()

            ' Insert new group and get GroupID
            Using cmdGroup As New SqlCommand("INSERT INTO KPI_Groups (GroupName) OUTPUT INSERTED.GroupID VALUES (@GroupName)", cn)
                cmdGroup.Parameters.AddWithValue("@GroupName", newGroupName)
                newGroupID = Convert.ToInt32(cmdGroup.ExecuteScalar())
            End Using

            ' Loop visible rows and find the checkbox in the template (column index 1 = KPI_ID column)
            'For i As Integer = 0 To gvKPI.VisibleRowCount - 1
            '    Dim chk As CheckBox = TryCast(gvKPI.FindRowCellTemplateControl(i, gvKPI.Columns(1), "chkSelect"), CheckBox)
            '    If chk IsNot Nothing AndAlso chk.Checked Then
            '        Dim rawValue = gvKPI.GetRowValues(i, "KPI_ID")
            '        If rawValue IsNot Nothing Then
            '            Dim kpiId As String = rawValue.ToString()
            '            Using cmd As New SqlCommand("INSERT INTO KPI_GroupMembers (GroupID, KPI_ID) VALUES (@GroupID, @KPI_ID)", cn)
            '                cmd.Parameters.AddWithValue("@GroupID", newGroupID)
            '                cmd.Parameters.AddWithValue("@KPI_ID", kpiId)
            '                cmd.ExecuteNonQuery()
            '            End Using
            '        End If
            '    End If
            'Next
            For Each obj In selectedKPIs
                Dim kpiId As String = obj.ToString()
                Using cmd As New SqlCommand("INSERT INTO KPI_GroupMembers (GroupID, KPI_ID) VALUES (@GroupID, @KPI_ID)", cn)
                    cmd.Parameters.AddWithValue("@GroupID", newGroupID)
                    cmd.Parameters.AddWithValue("@KPI_ID", kpiId)
                    cmd.ExecuteNonQuery()
                End Using
            Next
        End Using
        gvKPI.Selection.UnselectAll()

        BindGroupsGrid()
    End Sub

    ' Compute next group number
    Private Function GetNextGroupNumber() As Integer
        Dim sql As String = "SELECT COUNT(*) FROM KPI_Groups"
        Using cn As New SqlConnection(ConnStr)
            Using cmd As New SqlCommand(sql, cn)
                cn.Open()
                Return Convert.ToInt32(cmd.ExecuteScalar()) + 1
            End Using
        End Using
    End Function

    ' Delete entire group (and its members)
    Protected Sub gvGroups_RowDeleting(sender As Object, e As DevExpress.Web.Data.ASPxDataDeletingEventArgs)
        Dim groupId As Integer = Convert.ToInt32(e.Keys("GroupID"))

        Using cn As New SqlConnection(ConnStr)
            cn.Open()
            Using cmd As New SqlCommand("DELETE FROM KPI_GroupMembers WHERE GroupID=@GroupID", cn)
                cmd.Parameters.AddWithValue("@GroupID", groupId)
                cmd.ExecuteNonQuery()
            End Using
            Using cmd As New SqlCommand("DELETE FROM KPI_Groups WHERE GroupID=@GroupID", cn)
                cmd.Parameters.AddWithValue("@GroupID", groupId)
                cmd.ExecuteNonQuery()
            End Using
        End Using

        e.Cancel = True
        BindGroupsGrid()
    End Sub

    ' Edit group name (inline update)
    Protected Sub gvGroups_RowUpdating(sender As Object, e As DevExpress.Web.Data.ASPxDataUpdatingEventArgs)
        Dim groupId As Integer = Convert.ToInt32(e.Keys("GroupID"))
        Dim newName As String = Convert.ToString(e.NewValues("GroupName"))

        Using cn As New SqlConnection(ConnStr)
            Using cmd As New SqlCommand("UPDATE KPI_Groups SET GroupName=@GroupName WHERE GroupID=@GroupID", cn)
                cmd.Parameters.AddWithValue("@GroupName", newName)
                cmd.Parameters.AddWithValue("@GroupID", groupId)
                cn.Open()
                cmd.ExecuteNonQuery()
            End Using
        End Using

        e.Cancel = True
        gvGroups.CancelEdit()
        BindGroupsGrid()
    End Sub

    ' Bind detail grid: KPIs for a group
    Protected Sub gvGroupMembers_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Dim detailGrid As ASPxGridView = CType(sender, ASPxGridView)
        Dim groupId As Integer = Convert.ToInt32((CType(detailGrid.NamingContainer, GridViewDetailRowTemplateContainer)).KeyValue)

        Dim sql As String = "SELECT KPI_ID FROM KPI_GroupMembers WHERE GroupID = @GroupID"
        Dim dt As New DataTable()
        Using cn As New SqlConnection(ConnStr)
            Using da As New SqlDataAdapter(sql, cn)
                da.SelectCommand.Parameters.AddWithValue("@GroupID", groupId)
                da.Fill(dt)
            End Using
        End Using
        detailGrid.DataSource = dt
    End Sub

    ' Delete KPI from group (detail row)
    Protected Sub gvGroupMembers_RowDeleting(sender As Object, e As DevExpress.Web.Data.ASPxDataDeletingEventArgs)
        Dim detailGrid As ASPxGridView = CType(sender, ASPxGridView)
        Dim groupId As Integer = Convert.ToInt32((CType(detailGrid.NamingContainer, GridViewDetailRowTemplateContainer)).KeyValue)
        Dim kpiId As String = e.Keys("KPI_ID").ToString()

        Using cn As New SqlConnection(ConnStr)
            Using cmd As New SqlCommand("DELETE FROM KPI_GroupMembers WHERE GroupID=@GroupID AND KPI_ID=@KPI_ID", cn)
                cmd.Parameters.AddWithValue("@GroupID", groupId)
                cmd.Parameters.AddWithValue("@KPI_ID", kpiId)
                cn.Open()
                cmd.ExecuteNonQuery()
            End Using
        End Using

        e.Cancel = True
        detailGrid.DataBind()
    End Sub

    ' Ensure paging works by rebinding on page change
    Protected Sub gvKPI_PageIndexChanged(sender As Object, e As EventArgs)
        BindKPIGrid()
    End Sub

    Protected Sub gvGroups_PageIndexChanged(sender As Object, e As EventArgs)
        BindGroupsGrid()
    End Sub

End Class
