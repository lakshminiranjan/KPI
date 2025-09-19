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

    Private isBindingGroups As Boolean = False

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            BindKPIGrid()
            BindGroupsGrid()
        Else
            Dim eventTarget = Request("__EVENTTARGET")
            Dim eventArg = Request("__EVENTARGUMENT")
            If eventTarget = "AddKPI" AndAlso Not String.IsNullOrEmpty(eventArg) Then
                LoadKPISelectionPopup(Convert.ToInt32(eventArg))
            End If
        End If
    End Sub

    ' Load KPI Table
    Private Sub BindKPIGrid(Optional filter As String = "")
        Dim sql As String = "SELECT [ID], [KPI Name] AS KPI_Name, [KPI ID] AS KPI_ID FROM [dbo].[KPITable]"
        If Not String.IsNullOrEmpty(filter) Then
            sql &= " WHERE [KPI ID] LIKE @KPI_ID"
        End If
        sql &= " ORDER BY [KPI ID]"

        Dim dt As New DataTable()
        Using cn As New SqlConnection(ConnStr)
            Using cmd As New SqlCommand(sql, cn)
                If Not String.IsNullOrEmpty(filter) Then
                    cmd.Parameters.AddWithValue("@KPI_ID", "%" & filter & "%")
                End If
                Using da As New SqlDataAdapter(cmd)
                    da.Fill(dt)
                End Using
            End Using
        End Using

        gvKPI.DataSource = dt
        gvKPI.DataBind()
    End Sub

    Private Sub BindGroupsGrid()
        If isBindingGroups Then Exit Sub
        isBindingGroups = True
        Try
            Dim sql As String = "SELECT DISTINCT GroupID, GroupName FROM KPI_Groups ORDER BY GroupID"
            Dim dt As New DataTable()
            Using cn As New SqlConnection(ConnStr)
                Using da As New SqlDataAdapter(sql, cn)
                    da.Fill(dt)
                End Using
            End Using
            gvGroups.DataSource = dt
            gvGroups.DataBind()
        Finally
            isBindingGroups = False
        End Try
    End Sub

    'Protected Sub btnGroup_Click(sender As Object, e As EventArgs)
    '    Dim newGroupName As String = "Group " & (GetNextGroupNumber())
    '    Dim newGroupID As Integer

    '    Using cn As New SqlConnection(ConnStr)
    '        cn.Open()
    '        Using cmdGroup As New SqlCommand("INSERT INTO KPI_Groups (GroupName) OUTPUT INSERTED.GroupID VALUES (@GroupName)", cn)
    '            cmdGroup.Parameters.AddWithValue("@GroupName", newGroupName)
    '            newGroupID = Convert.ToInt32(cmdGroup.ExecuteScalar())
    '        End Using

    '        For i As Integer = 0 To gvKPI.VisibleRowCount - 1
    '            Dim chk As CheckBox = TryCast(gvKPI.FindRowCellTemplateControl(i, gvKPI.Columns(1), "chkSelect"), CheckBox)
    '            If chk IsNot Nothing AndAlso chk.Checked Then
    '                Dim kpiIdObj = gvKPI.GetRowValues(i, "KPI_ID")
    '                If kpiIdObj IsNot Nothing Then
    '                    Using cmd As New SqlCommand("INSERT INTO KPI_GroupMembers (GroupID, KPI_ID) VALUES (@GroupID, @KPI_ID)", cn)
    '                        cmd.Parameters.AddWithValue("@GroupID", newGroupID)
    '                        cmd.Parameters.AddWithValue("@KPI_ID", kpiIdObj.ToString())
    '                        cmd.ExecuteNonQuery()
    '                    End Using
    '                End If
    '            End If
    '        Next
    '    End Using

    '    BindGroupsGrid()
    '    BindKPIGrid()
    'End Sub


    Protected Sub btnGroup_Click(sender As Object, e As EventArgs)
        Dim newGroupName As String = "Group " & (GetNextGroupNumber())
        Dim newGroupID As Integer

        Dim selectedKPIs As List(Of Object) = gvKPI.GetSelectedFieldValues("KPI_ID")

        Using cn As New SqlConnection(ConnStr)
            cn.Open()

            ' Insert new group
            Using cmdGroup As New SqlCommand("INSERT INTO KPI_Groups (GroupName) OUTPUT INSERTED.GroupID VALUES (@GroupName)", cn)
                cmdGroup.Parameters.AddWithValue("@GroupName", newGroupName)
                newGroupID = Convert.ToInt32(cmdGroup.ExecuteScalar())
            End Using

            ' Insert selected KPIs
            For Each obj In selectedKPIs
                Using cmd As New SqlCommand("INSERT INTO KPI_GroupMembers (GroupID, KPI_ID) VALUES (@GroupID, @KPI_ID)", cn)
                    cmd.Parameters.AddWithValue("@GroupID", newGroupID)
                    cmd.Parameters.AddWithValue("@KPI_ID", obj.ToString())
                    cmd.ExecuteNonQuery()
                End Using
            Next
        End Using

        gvKPI.Selection.UnselectAll()
        BindGroupsGrid()
    End Sub


    Private Function GetNextGroupNumber() As Integer
        Dim sql As String = "SELECT COUNT(*) FROM KPI_Groups"
        Using cn As New SqlConnection(ConnStr)
            Using cmd As New SqlCommand(sql, cn)
                cn.Open()
                Return Convert.ToInt32(cmd.ExecuteScalar()) + 1
            End Using
        End Using
    End Function

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

    'Protected Sub gvGroupMembers_BeforePerformDataSelect(sender As Object, e As EventArgs)
    '    Dim detailGrid As ASPxGridView = CType(sender, ASPxGridView)
    '    Dim groupId As Integer = Convert.ToInt32((CType(detailGrid.NamingContainer, GridViewDetailRowTemplateContainer)).KeyValue)
    '    Dim sql As String = "SELECT KPI_ID FROM KPI_GroupMembers WHERE GroupID = @GroupID"
    '    Dim dt As New DataTable()
    '    Using cn As New SqlConnection(ConnStr)
    '        Using da As New SqlDataAdapter(sql, cn)
    '            da.SelectCommand.Parameters.AddWithValue("@GroupID", groupId)
    '            da.Fill(dt)
    '        End Using
    '    End Using
    '    detailGrid.DataSource = dt
    'End Sub

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

    Protected Sub gvKPI_PageIndexChanged(sender As Object, e As EventArgs)
        BindKPIGrid()
    End Sub

    Protected Sub gvGroups_PageIndexChanged(sender As Object, e As EventArgs)
        BindGroupsGrid()
    End Sub

    ' Load KPI Selection Popup
    Private Sub LoadKPISelectionPopup(groupId As Integer)
        hdnSelectedGroupId.Value = groupId.ToString()
        Dim allKpi As New DataTable()
        Using cn As New SqlConnection(ConnStr)
            Using da As New SqlDataAdapter("SELECT [KPI ID] AS KPI_ID FROM KPITable ORDER BY [KPI ID]", cn)
                da.Fill(allKpi)
            End Using
        End Using

        ' Get existing KPIs for this group
        Dim existing As New List(Of String)
        Using cn As New SqlConnection(ConnStr)
            Using cmd As New SqlCommand("SELECT KPI_ID FROM KPI_GroupMembers WHERE GroupID=@GroupID", cn)
                cmd.Parameters.AddWithValue("@GroupID", groupId)
                cn.Open()
                Using rdr = cmd.ExecuteReader()
                    While rdr.Read()
                        existing.Add(rdr("KPI_ID").ToString())
                    End While
                End Using
            End Using
        End Using

        chkKPIList.Items.Clear()
        For Each row As DataRow In allKpi.Rows
            Dim kpiId As String = row("KPI_ID").ToString()
            Dim item As New DevExpress.Web.ListEditItem(kpiId, kpiId)
            item.Selected = existing.Contains(kpiId)
            chkKPIList.Items.Add(item)
        Next

        popupAddKPI.ShowOnPageLoad = True
    End Sub

    Protected Sub btnSaveKPI_Click(sender As Object, e As EventArgs)
        Dim groupId As Integer = Convert.ToInt32(hdnSelectedGroupId.Value)
        Dim selected = chkKPIList.SelectedValues.Cast(Of String)().ToList()

        Using cn As New SqlConnection(ConnStr)
            cn.Open()

            ' First remove all KPIs from group (so we can reset selection)
            Using cmdDel As New SqlCommand("DELETE FROM KPI_GroupMembers WHERE GroupID=@GroupID", cn)
                cmdDel.Parameters.AddWithValue("@GroupID", groupId)
                cmdDel.ExecuteNonQuery()
            End Using

            ' Add selected KPIs
            For Each kpiId In selected
                Using cmdAdd As New SqlCommand("INSERT INTO KPI_GroupMembers (GroupID, KPI_ID) VALUES (@GroupID, @KPI_ID)", cn)
                    cmdAdd.Parameters.AddWithValue("@GroupID", groupId)
                    cmdAdd.Parameters.AddWithValue("@KPI_ID", kpiId)
                    cmdAdd.ExecuteNonQuery()
                End Using
            Next
        End Using

        popupAddKPI.ShowOnPageLoad = False
        BindGroupsGrid()
    End Sub

    ' Server-side callback handler invoked from the client when user clicks the custom image button.
    'Protected Sub gvGroups_CustomCallback(sender As Object, e As DevExpress.Web.ASPxGridViewCustomCallbackEventArgs) Handles gvGroups.CustomCallback
    '    Dim grid As ASPxGridView = CType(sender, ASPxGridView)
    '    If String.IsNullOrEmpty(e.Parameters) Then Return

    '    Dim parts = e.Parameters.Split("~"c)
    '    If parts.Length <> 2 Then Return

    '    If parts(0) = "toggle" Then
    '        Dim key = parts(1)
    '        Dim vi As Integer = grid.FindVisibleIndexByKeyValue(key)
    '        If vi >= 0 Then
    '            If grid.DetailRows.IsVisible(vi) Then
    '                grid.DetailRows.CollapseRow(vi)
    '            Else
    '                grid.DetailRows.ExpandRow(vi)
    '            End If
    '        End If
    '    End If
    'End Sub

    ' Ensure the custom button cell shows the correct image (plus/minus) when grid renders.
    'Protected Sub gvGroups_HtmlCommandCellPrepared(sender As Object, e As DevExpress.Web.ASPxGridViewTableCommandCellEventArgs) Handles gvGroups.HtmlCommandCellPrepared
    '    ' only handle our Expand command column
    '    If e.CommandColumn Is Nothing OrElse e.CommandColumn.Caption <> "Expand" Then
    '        Return
    '    End If

    '    Dim grid As ASPxGridView = CType(sender, ASPxGridView)
    '    Dim imgUrl As String = If(grid.DetailRows.IsVisible(e.VisibleIndex), ResolveUrl("~/Images/minus.png"), ResolveUrl("~/Images/plus.png"))

    '    ' Try to locate runtime control for the custom button (several control types possible depending on DevExpress version)
    '    Dim btnCtrl As System.Web.UI.Control = Nothing
    '    For Each c As System.Web.UI.Control In e.Cell.Controls
    '        If Not String.IsNullOrEmpty(c.ID) AndAlso c.ID.IndexOf("btnExpand", StringComparison.OrdinalIgnoreCase) >= 0 Then
    '            btnCtrl = c
    '            Exit For
    '        End If
    '    Next

    '    If btnCtrl IsNot Nothing Then
    '        ' If it's a DevExpress ASPxButton, set its Image.Url
    '        If TypeOf btnCtrl Is DevExpress.Web.ASPxButton Then
    '            CType(btnCtrl, DevExpress.Web.ASPxButton).Image.Url = imgUrl
    '            CType(btnCtrl, DevExpress.Web.ASPxButton).Image.Width = Unit.Pixel(16)
    '            CType(btnCtrl, DevExpress.Web.ASPxButton).Image.Height = Unit.Pixel(16)
    '        ElseIf TypeOf btnCtrl Is System.Web.UI.WebControls.ImageButton Then
    '            CType(btnCtrl, System.Web.UI.WebControls.ImageButton).ImageUrl = imgUrl
    '            CType(btnCtrl, System.Web.UI.WebControls.ImageButton).Width = Unit.Pixel(16)
    '            CType(btnCtrl, System.Web.UI.WebControls.ImageButton).Height = Unit.Pixel(16)
    '        Else
    '            ' fallback - inject an <img> tag at the start of the cell
    '            Dim imgTag As String = "<img src='" & imgUrl & "' style='width:16px;height:16px;vertical-align:middle;margin-right:4px;' />"
    '            e.Cell.Controls.AddAt(0, New LiteralControl(imgTag))
    '        End If

    '    Else
    '        ' fallback - inject an <img> tag at the start of the cell
    '        Dim imgTag As String = "<img src='" & imgUrl & "' style='width:16px;height:16px;vertical-align:middle;margin-right:4px;' />"
    '        e.Cell.Controls.AddAt(0, New LiteralControl(imgTag))
    '    End If

    'End Sub

    ' Set correct image for custom expand button
    'Protected Sub gvGroups_CustomButtonInitialize(sender As Object, e As DevExpress.Web.ASPxGridViewCustomButtonEventArgs) Handles gvGroups.CustomButtonInitialize
    '    If e.ButtonID = "btnExpand" Then
    '        Dim grid As ASPxGridView = CType(sender, ASPxGridView)

    '        ' Toggle between plus/minus depending on expand state
    '        If grid.DetailRows.IsVisible(e.VisibleIndex) Then
    '            e.Image.Url = ResolveUrl("~/Images/minus.png")
    '        Else
    '            e.Image.Url = ResolveUrl("~/Images/plus.png")
    '        End If

    '        e.Image.Width = Unit.Pixel(16)
    '        e.Image.Height = Unit.Pixel(16)
    '    End If
    'End Sub



    Protected Sub gvGroupMembers_BeforePerformDataSelect(sender As Object, e As EventArgs)
        Dim detailGrid As ASPxGridView = CType(sender, ASPxGridView)
        Dim groupId As Integer = Convert.ToInt32((CType(detailGrid.NamingContainer, GridViewDetailRowTemplateContainer)).KeyValue)

        Dim sql As String = "
        SELECT gm.KPI_ID
        FROM KPI_GroupMembers gm
        INNER JOIN KPITable k ON gm.KPI_ID = k.[KPI ID]
        WHERE gm.GroupID = @GroupID
        ORDER BY gm.KPI_ID
    "

        Dim dt As New DataTable()
        Using cn As New SqlConnection(ConnStr)
            Using da As New SqlDataAdapter(sql, cn)
                da.SelectCommand.Parameters.AddWithValue("@GroupID", groupId)
                da.Fill(dt)
            End Using
        End Using

        detailGrid.DataSource = dt
    End Sub



    Protected Sub gvGroups_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs) Handles gvGroups.CustomCallback
        Dim grid As ASPxGridView = CType(sender, ASPxGridView)
        If String.IsNullOrEmpty(e.Parameters) Then Return

        Dim parts = e.Parameters.Split("~"c)
        If parts.Length <> 2 Then Return

        If parts(0) = "toggle" Then
            Dim key = parts(1)
            Dim vi As Integer = grid.FindVisibleIndexByKeyValue(key)
            If vi >= 0 Then
                If grid.DetailRows.IsVisible(vi) Then
                    grid.DetailRows.CollapseRow(vi)
                Else
                    grid.DetailRows.ExpandRow(vi)
                End If
            End If
        End If

        ' 🔑 Ensure rebind so child grid loads and button image updates
        grid.DataBind()
    End Sub



    Protected Sub gvGroups_CustomButtonInitialize(sender As Object, e As ASPxGridViewCustomButtonEventArgs) Handles gvGroups.CustomButtonInitialize
        If e.ButtonID = "btnExpand" Then
            Dim grid As ASPxGridView = CType(sender, ASPxGridView)
            If grid.DetailRows.IsVisible(e.VisibleIndex) Then
                e.Image.Url = ResolveUrl("~/Images/minus.png")
            Else
                e.Image.Url = ResolveUrl("~/Images/plus.png")
            End If
            e.Image.Width = Unit.Pixel(16)
            e.Image.Height = Unit.Pixel(16)
        End If
    End Sub




    Protected Sub gvGroups_DataBinding(sender As Object, e As EventArgs)
        BindGroupsGrid()
    End Sub



End Class