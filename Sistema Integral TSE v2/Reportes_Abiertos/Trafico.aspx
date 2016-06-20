<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Trafico.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Trafico" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .auto-style4 {
            font-size: x-large;
        }
        .auto-style5 {
            text-align: left;
            color: #42916A;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <hr />
    <div class="auto-style4">
        <h2 class="auto-style5"><strong>SELECCIONA UN ARCHIVO</strong></h2>
    </div>
    <br />
    <br />
    <asp:FileUpload ID="FileUpload1" runat="server" Width="429px" />
    <asp:Button ID="Button1" runat="server" Text="Guardar" CssClass="btn" Height="38px" Width="74px" />
    <br />
    <br />
    <hr />
    <br />
    <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="X-Large" ForeColor="Red"></asp:Label>
            <asp:GridView ID="GridView2" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:HyperLinkField DataNavigateUrlFields="Nombre" DataNavigateUrlFormatString="~\Reportes_Abiertos\Trafico\{0}" DataTextField="Nombre" HeaderText="Descargar" />
                </Columns>
                <EditRowStyle BackColor="#7C6F57" />
                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#E3EAEB" />
                <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#F8FAFA" />
                <SortedAscendingHeaderStyle BackColor="#246B61" />
                <SortedDescendingCellStyle BackColor="#D4DFE1" />
                <SortedDescendingHeaderStyle BackColor="#15524A" />
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <br />
    <br />
    <br />
    <br />
</asp:Content>