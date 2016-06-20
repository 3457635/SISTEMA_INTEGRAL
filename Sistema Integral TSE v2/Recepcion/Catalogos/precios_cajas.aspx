<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="precios_cajas.aspx.vb" Inherits="Sistema_Integral_TSE_v45.precios_cajas" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Precio de Renta de Cajas</h1>
    <table style="width: 450px">
        <tr>
            <td style="width: 159px">
                Cliente:</td>
            <td style="width: 281px">
    <asp:DropDownList ID="ddlCliente" runat="server" DataSourceID="sdsClientes" 
                    DataTextField="nombre" DataValueField="id_empresa" Width="281px" 
                    AppendDataBoundItems="True" AutoPostBack="True">
        <asp:ListItem Value="0">Seleccionar...</asp:ListItem>
    </asp:DropDownList>
                <asp:SqlDataSource ID="sdsClientes" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT nombre, id_empresa FROM dbo.empresas WHERE (id_tipo_empresa = 1) AND (id_status = 5) ORDER BY nombre">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td style="width: 159px">
                Precio Diario:</td>
            <td style="width: 281px">
                <asp:TextBox ID="txbPrecioDiario" runat="server" TargetControlID="txbPrecio"></asp:TextBox>
                
                
            </td>
        </tr>
        <tr>
            <td style="width: 159px">
                Precio Mensual:</td>
            <td style="width: 281px">
                <asp:TextBox ID="txbPrecioMensual" runat="server"></asp:TextBox>
                
                
            </td>
        </tr>
        <tr>
            <td style="width: 159px">
                Tipo de moneda:</td>
            <td style="width: 281px">
                <asp:DropDownList ID="ddlMoneda" runat="server" DataSourceID="sdsMoneda" 
                    DataTextField="moneda" DataValueField="id_moneda">
                </asp:DropDownList>
                
                <asp:SqlDataSource ID="sdsMoneda" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT [moneda], [id_moneda] FROM [tipos_monedas]">
                </asp:SqlDataSource>
                
                
            </td>
        </tr>
        <tr>
            <td style="width: 159px">
                Factura en dolares:</td>
            <td style="width: 281px">
                <asp:CheckBox ID="chkFacturaDolares" runat="server" />
            </td>
        </tr>
        <tr>
            <td style="width: 159px">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
            </td>
            <td style="width: 281px">
                <asp:Label ID="lblAnuncio" runat="server" SkinID="lblMensaje"></asp:Label>
                <asp:TextBox ID="txbIdCliente" runat="server" Visible="False"></asp:TextBox>
            </td>
        </tr>
    </table>
</asp:Content>
