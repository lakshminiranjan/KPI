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

    Private ReadOnly Property ConnStr As String
        Get
            Return ConfigurationManager.ConnectionStrings("MyDatabase").ConnectionString
        End Get
    End Property

    Private Property CurrentKpiMetric As String
        Get
            Dim v = TryCast(ViewState("CurrentKpiMetric"), String)
            If v Is Nothing Then Return String.Empty
            Return v
        End Get
        Set(value As String)
            ViewState("CurrentKpiMetric") = value
        End Set
    End Property

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            BindFilter()
            CurrentKpiMetric = String.Empty
            BindAllData()
        End If
    End Sub

    Private Sub BindFilter()
        ddlSection.Items.Clear()
        ddlSection.Items.Add("[All]", "")
        Using cn As New SqlConnection(ConnStr)
            Using cmd As New SqlCommand("SELECT DISTINCT ISNULL([KPI or Standalone Metric],'') AS [KPI or Standalone Metric] FROM [dbo].[KPITable] ORDER BY [KPI or Standalone Metric]", cn)
                cn.Open()
                Using rdr = cmd.ExecuteReader()
                    While rdr.Read()
                        Dim val = rdr("KPI or Standalone Metric").ToString()
                        Dim text = If(String.IsNullOrWhiteSpace(val), "[Unknown]", val)
                        ddlSection.Items.Add(text, val)
                    End While
                End Using
            End Using
        End Using
        ddlSection.SelectedIndex = 0
    End Sub

    Protected Sub ddlSection_Init(sender As Object, e As EventArgs)
    End Sub

    Private Sub BindAllData()
        Dim dt = GetKpiData(CurrentKpiMetric)
        gvKPI.DataSource = dt
        gvKPI.DataBind()
        pvKPI.DataSource = dt
        pvKPI.DataBind()
    End Sub

    Private Function GetKpiData(kpiMetricFilter As String) As DataTable
        Dim sql As String =
"SELECT [ID], [KPI ID], [KPI or Standalone Metric], [KPI Name], [KPI Short Description], " &
"       [KPI Impact], [Numerator Description], [Denominator Description], [Unit], [Datasource], " &
"       [OrderWithinSecton], " &
"       CASE WHEN [Active] IN ('1','Y','y') THEN 'Active' ELSE 'Inactive' END AS [Active], " &
"       [FLAG_DIVISINAL], [FLAG_VENDOR], [FLAG_ENGAGEMENTID], " &
"       [FLAG_CONTRACTID], [FLAG_COSTCENTRE], [FLAG_DEUBALvl4], [FLAG_HRID], [FLAG_REQUESTID], [KPI_Section] " &
"FROM [dbo].[KPITable] " &
"WHERE (@kpiMetric = '' OR [KPI or Standalone Metric] = @kpiMetric) " &
"ORDER BY [KPI or Standalone Metric], [KPI Name]"


        Dim dt As New DataTable()
        Using cn As New SqlConnection(ConnStr)
            Using cmd As New SqlCommand(sql, cn)
                cmd.Parameters.Add("@kpiMetric", SqlDbType.VarChar, 100).Value =
                If(String.IsNullOrEmpty(kpiMetricFilter), String.Empty, kpiMetricFilter)
                Using da As New SqlDataAdapter(cmd)
                    da.Fill(dt)
                End Using
            End Using
        End Using
        Return dt
    End Function


    Protected Sub cpMain_Callback(sender As Object, e As CallbackEventArgsBase)
        Select Case e.Parameter
            Case "apply"
                Dim sel As Object = ddlSection.Value
                CurrentKpiMetric = If(sel Is Nothing, String.Empty, sel.ToString())
                BindAllData()
            Case "exportGrid"
                If gvKPI.DataSource Is Nothing Then BindAllData()
                ExportGrid()
            Case "exportPivot"
                If pvKPI.DataSource Is Nothing Then BindAllData()
                ExportPivot()
        End Select
    End Sub

    Private Sub ExportGrid()
        Try
            Dim t = gridExporter.GetType()
            Dim m = t.GetMethod("WriteXlsxToResponse", New Type() {GetType(String)})
            If m IsNot Nothing Then
                m.Invoke(gridExporter, New Object() {"KPI_Grid_" & DateTime.Now.ToString("yyyyMMdd_HHmm") & ".xlsx"})
                Return
            End If
            m = t.GetMethod("WriteXlsToResponse", New Type() {GetType(String)})
            If m IsNot Nothing Then
                m.Invoke(gridExporter, New Object() {"KPI_Grid_" & DateTime.Now.ToString("yyyyMMdd_HHmm") & ".xls"})
                Return
            End If
            WriteDataTableAsCsvResponse(TryCast(gvKPI.DataSource, DataTable), "KPI_Grid_" & DateTime.Now.ToString("yyyyMMdd_HHmm") & ".csv")
        Catch
            WriteDataTableAsCsvResponse(TryCast(gvKPI.DataSource, DataTable), "KPI_Grid_" & DateTime.Now.ToString("yyyyMMdd_HHmm") & ".csv")
        End Try
    End Sub

    Private Sub ExportPivot()
        Try
            Dim t = pivotExporter.GetType()
            Dim m = t.GetMethod("WriteXlsxToResponse", New Type() {GetType(String)})
            If m IsNot Nothing Then
                m.Invoke(pivotExporter, New Object() {"KPI_Pivot_" & DateTime.Now.ToString("yyyyMMdd_HHmm") & ".xlsx"})
                Return
            End If
            m = t.GetMethod("WriteXlsToResponse", New Type() {GetType(String)})
            If m IsNot Nothing Then
                m.Invoke(pivotExporter, New Object() {"KPI_Pivot_" & DateTime.Now.ToString("yyyyMMdd_HHmm") & ".xls"})
                Return
            End If
            WriteDataTableAsCsvResponse(TryCast(pvKPI.DataSource, DataTable), "KPI_Pivot_" & DateTime.Now.ToString("yyyyMMdd_HHmm") & ".csv")
        Catch
            WriteDataTableAsCsvResponse(TryCast(pvKPI.DataSource, DataTable), "KPI_Pivot_" & DateTime.Now.ToString("yyyyMMdd_HHmm") & ".csv")
        End Try
    End Sub

    Private Sub WriteDataTableAsCsvResponse(dt As DataTable, fileName As String)
        If dt Is Nothing Then dt = GetKpiData(CurrentKpiMetric)
        Response.Clear()
        Response.ContentType = "text/csv"
        Response.AddHeader("Content-Disposition", "attachment;filename=" & fileName)
        For i As Integer = 0 To dt.Columns.Count - 1
            Response.Write("""" & dt.Columns(i).ColumnName.Replace("""", """""") & """")
            If i < dt.Columns.Count - 1 Then Response.Write(",")
        Next
        Response.Write(vbCrLf)
        For Each r As DataRow In dt.Rows
            For i As Integer = 0 To dt.Columns.Count - 1
                Dim v As String = If(r(i) IsNot Nothing, r(i).ToString(), "")
                v = v.Replace("""", """""")
                Response.Write("""" & v & """")
                If i < dt.Columns.Count - 1 Then Response.Write(",")
            Next
            Response.Write(vbCrLf)
        Next
        Response.End()
    End Sub

    Protected Sub gvKPI_HtmlDataCellPrepared(sender As Object, e As ASPxGridViewTableDataCellEventArgs) Handles gvKPI.HtmlDataCellPrepared
        If String.Equals(e.DataColumn.FieldName, "Active", StringComparison.OrdinalIgnoreCase) Then
            Dim val As String = If(e.CellValue, "").ToString().Trim().ToLowerInvariant()
            If val = "inactive" Then
                e.Cell.BackColor = System.Drawing.Color.MistyRose
            ElseIf val = "active" Then
                e.Cell.BackColor = System.Drawing.Color.Honeydew
            End If
        End If
    End Sub


    Protected Sub pvKPI_CellClick(sender As Object, e As EventArgs)
        Try
            Dim pivot = TryCast(sender, DevExpress.Web.ASPxPivotGrid.ASPxPivotGrid)
            If pivot IsNot Nothing Then
                ' use reflection to call e.CreateDrillDownDataSource()
                Dim m = e.GetType().GetMethod("CreateDrillDownDataSource")
                If m IsNot Nothing Then
                    Dim ds = m.Invoke(e, Nothing)
                    gvDrill.DataSource = ds
                    gvDrill.DataBind()
                    popupDrillDown.ShowOnPageLoad = True
                    Return
                End If
            End If
            ' fallback if reflection fails
            gvDrill.DataSource = GetKpiData(CurrentKpiMetric)
            gvDrill.DataBind()
            popupDrillDown.ShowOnPageLoad = True
        Catch
            gvDrill.DataSource = GetKpiData(CurrentKpiMetric)
            gvDrill.DataBind()
            popupDrillDown.ShowOnPageLoad = True
        End Try
    End Sub
End Class
