<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="MultiSelectFilter.ascx.vb" Inherits="KPILibrary.MultiSelectFilter" %>

<div style="margin-bottom:15px;">

    <div class="ms-wrapper">

    <!-- Filter Title -->
    <asp:Label ID="lblTitle" runat="server" CssClass="ms-title"></asp:Label>

    <!-- Selected Value TextBox -->
    <asp:TextBox ID="txtSelected" runat="server"
                 CssClass="ms-text"
                 ReadOnly="true"></asp:TextBox>

    <!-- Dropdown Toggle Button -->
    <asp:LinkButton ID="btnToggle" runat="server"
                    CssClass="ms-btn">▼</asp:LinkButton>

    <!-- Dropdown Panel -->
    <div id="pnlList" runat="server" class="ms-panel">
        <asp:CheckBoxList ID="CheckBoxList" runat="server"
                          CssClass="ms-list"  OnSelectedIndexChanged="CheckBoxList_SelectedIndexChanged"></asp:CheckBoxList>
    </div>

</div>


</div>

