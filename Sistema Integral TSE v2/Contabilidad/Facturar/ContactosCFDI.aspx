<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ContactosCFDI.aspx.vb" MasterPageFile="~/Site.master" Inherits="Sistema_Integral_TSE_v45.ContactosCFDI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div>
    <h1>Contactos Facturación</h1>
        Cliente:<br />
        <asp:DropDownList ID="ddlEmpresa" runat="server" Height="18px" Width="161px" 
            AutoPostBack="True" DataSourceID="sdsEmpresas" DataTextField="razon_social" 
            DataValueField="id_dato">
        </asp:DropDownList>
        <asp:SqlDataSource ID="sdsEmpresas" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="SELECT datos_facturacion.razon_social, datos_facturacion.id_dato FROM dbo.empresas INNER JOIN datos_facturacion ON dbo.empresas.id_empresa = datos_facturacion.id_empresa WHERE (dbo.empresas.id_status = 5) AND (dbo.empresas.id_tipo_empresa = 1) ORDER BY datos_facturacion.razon_social">
        </asp:SqlDataSource>
    </div>
    <p>
        Correos:</p>
    <p>
        <asp:TextBox ID="txbCorreos" runat="server" Height="152px" TextMode="MultiLine" 
            Width="555px"></asp:TextBox>
    </p>
    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
&nbsp;<br />
    <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
    <br />
    <br />
    <asp:Label ID="lblMailIncorrectos" runat="server" SkinID="lblMensaje"></asp:Label>
    <br />
    <br />
    <br />
    <br />
</asp:Content>

