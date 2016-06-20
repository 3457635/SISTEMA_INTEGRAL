<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="cxp.aspx.vb" Inherits="Sistema_Integral_TSE_v45.cxp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <br />
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" EnableModelValidation="True" 
            AutoGenerateColumns="False" SkinID="GridView1">
            <Columns>
                <asp:BoundField DataField="factura" HeaderText="FACTURA" />
                <asp:BoundField DataField="proveedor" HeaderText="PROVEEDOR" />
                <asp:BoundField DataField="descripcion" HeaderText="DESCRIPCIÓN" />
                <asp:BoundField DataField="importe" DataFormatString="{0:c}" 
                    HeaderText="IMPORTE" />
                <asp:BoundField DataField="fecha" HeaderText="FECHA" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
    </p>
</asp:Content>
