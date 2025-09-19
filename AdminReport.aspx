<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AdminReport.aspx.vb" Inherits="KPILibrary.AdminReport" %>
<%@ Register Assembly="DevExpress.Web.v25.1, Version=25.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>KPI Report</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" />

        <h2>Admin KPI Grouping</h2>

        <dx:ASPxButton ID="btnGroup" runat="server" Text="Group" AutoPostBack="true" OnClick="btnGroup_Click" />
        <br/><br/>

        <div style="display:flex; gap:20px; align-items:flex-start;">

           
            <%--<dx:ASPxGridView ID="gvKPI" runat="server" KeyFieldName="KPI_ID" AutoGenerateColumns="False" Width="600px"
                OnPageIndexChanged="gvKPI_PageIndexChanged">
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="KPI_Name" Caption="KPI Name" VisibleIndex="0" />
                    <dx:GridViewDataTextColumn FieldName="KPI_ID" Caption="KPI ID" VisibleIndex="1">
                        <DataItemTemplate>
                            <div style="display:flex; justify-content:space-between; align-items:center; width:100%;">
                                <span><%# Eval("KPI_ID") %></span>
                                <asp:CheckBox ID="chkSelect" runat="server" />
                            </div>
                        </DataItemTemplate>
                        <HeaderTemplate>
                            KPI ID
                        </HeaderTemplate>
                    </dx:GridViewDataTextColumn>
                </Columns>
                <SettingsPager PageSize="4" />
            </dx:ASPxGridView>--%>


            <dx:ASPxGridView ID="gvKPI" runat="server" KeyFieldName="KPI_ID" AutoGenerateColumns="False" Width="600px"
    OnPageIndexChanged="gvKPI_PageIndexChanged">
    <Columns>
       
        <dx:GridViewCommandColumn ShowSelectCheckbox="true" VisibleIndex="0" />

        <dx:GridViewDataTextColumn FieldName="KPI_Name" Caption="KPI Name" VisibleIndex="1" />
        <dx:GridViewDataTextColumn FieldName="KPI_ID" Caption="KPI ID" VisibleIndex="2" />
    </Columns>

    <SettingsPager PageSize="15" />
    <SettingsBehavior AllowSelectByRowClick="true" />
</dx:ASPxGridView>

         
           <dx:ASPxGridView ID="gvGroups" runat="server" AutoGenerateColumns="False" 
    KeyFieldName="GroupID" Width="360px"
    OnPageIndexChanged="gvGroups_PageIndexChanged"
    OnRowDeleting="gvGroups_RowDeleting"
    OnRowUpdating="gvGroups_RowUpdating"
    OnCustomCallback="gvGroups_CustomCallback"
    OnCustomButtonInitialize="gvGroups_CustomButtonInitialize"
    OnDataBinding="gvGroups_DataBinding">



    <Columns>
        
        <dx:GridViewCommandColumn Caption="Expand" VisibleIndex="0" Width="50px" ButtonType="Image">
    <CustomButtons>
        <dx:GridViewCommandColumnCustomButton ID="btnExpand" Image-Url="~/Images/plus.png" />
    </CustomButtons>
</dx:GridViewCommandColumn>




        
        <dx:GridViewDataTextColumn FieldName="GroupName" Caption="Group Name" VisibleIndex="1">
            <PropertiesTextEdit>
                <ValidationSettings RequiredField-IsRequired="true" />
            </PropertiesTextEdit>
        </dx:GridViewDataTextColumn>

        
        <dx:GridViewCommandColumn ShowDeleteButton="true" ShowEditButton="true" Caption="Actions" VisibleIndex="2">
            <CustomButtons>
                <dx:GridViewCommandColumnCustomButton ID="btnAddKPI" Text="Add KPI" />
            </CustomButtons>
        </dx:GridViewCommandColumn>
    </Columns>

    <Templates>
        <DetailRow>
            <dx:ASPxGridView ID="gvGroupMembers" runat="server" AutoGenerateColumns="False"
                KeyFieldName="KPI_ID" Width="320px"
                OnBeforePerformDataSelect="gvGroupMembers_BeforePerformDataSelect"
                OnRowDeleting="gvGroupMembers_RowDeleting">
                <Columns>
                    <dx:GridViewDataTextColumn FieldName="KPI_ID" Caption="KPI ID" VisibleIndex="0" />
                    <dx:GridViewCommandColumn ShowDeleteButton="True" Caption="Remove" VisibleIndex="1" />
                </Columns>
                <SettingsPager PageSize="15" />
            </dx:ASPxGridView>
        </DetailRow>
    </Templates>

   
    <SettingsDetail ShowDetailRow="true" ShowDetailButtons="false" />
    <SettingsPager PageSize="15" />
    <SettingsEditing Mode="Inline" />

    
   <ClientSideEvents 
    CustomButtonClick="function(s, e) {
        if (e.buttonID === 'btnExpand') {
            s.PerformCallback('toggle~' + s.GetRowKey(e.visibleIndex));
        }
        else if (e.buttonID === 'btnAddKPI') {
            __doPostBack('AddKPI', s.GetRowKey(e.visibleIndex));
        }
    }" />




</dx:ASPxGridView>


        </div>

      
        <dx:ASPxPopupControl ID="popupAddKPI" runat="server" HeaderText="Select KPIs" Modal="True"
            ClientInstanceName="popupAddKPI" CloseAction="CloseButton" PopupHorizontalAlign="WindowCenter"
            PopupVerticalAlign="WindowCenter" Width="500px" ShowFooter="true">
            <ContentCollection>
                <dx:PopupControlContentControl runat="server">
                    <asp:HiddenField ID="hdnSelectedGroupId" runat="server" />
                    <dx:ASPxCheckBoxList ID="chkKPIList" runat="server" RepeatColumns="2" Width="100%" />
                </dx:PopupControlContentControl>
            </ContentCollection>
            <FooterTemplate>
                <dx:ASPxButton ID="btnSaveKPI" runat="server" Text="Save" AutoPostBack="true" OnClick="btnSaveKPI_Click" />
                <dx:ASPxButton ID="btnCancelKPI" runat="server" Text="Cancel" AutoPostBack="false" 
                    ClientSideEvents-Click="function(){ popupAddKPI.Hide(); }" />
            </FooterTemplate>
        </dx:ASPxPopupControl>
    </form>
</body>
</html>