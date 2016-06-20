<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="TablaRendimientos.aspx.vb" Inherits="Sistema_Integral_TSE_v45.TablaRendimientos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <ContentTemplate>
                    <asp:Label ID="Label3" runat="server" Text="FECHA INICIO:"></asp:Label>
                    <asp:TextBox ID="txtFInicio" runat="server" TextMode="Date"></asp:TextBox>
<br />
<br />
                    <asp:Label ID="Label4" runat="server" Text="FECHA FIN:"></asp:Label>
                    <asp:TextBox ID="txtFFin" runat="server" AutoPostBack="True" TextMode="Date"></asp:TextBox>
            <br />
            <br />
                </ContentTemplate>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <asp:DataGrid ID="DataGrid2" runat="server" DataSourceID="SqlDataSource3">
                        </asp:DataGrid>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:TablaRendimiento %>" SelectCommand="dbo.kmsRecorridos" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="txtFInicio" Name="dFechainicio" PropertyName="Text" Type="DateTime" />
                                <asp:ControlParameter ControlID="txtFFin" Name="dFechafin" PropertyName="Text" Type="DateTime" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </ContentTemplate>
        </asp:UpdatePanel>
    
    <br />
    <br />
</asp:Content>
