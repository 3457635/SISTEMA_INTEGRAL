<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="renta_cajas.aspx.vb" Inherits="Sistema_Integral_TSE_v45.renta_cajas" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<h1>Renta de Cajas    </h1>
    <table style="width: 332px">
        <tr>
            <td style="width: 65px">
                &nbsp;</td>
            <td style="width: 257px">
                Folio:
                <asp:Label ID="lblAno" runat="server"></asp:Label>
                -<asp:Label ID="lblConsecutivo" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 65px">
                Caja:</td>
            <td style="width: 257px">
                <asp:DropDownList ID="ddlCaja" runat="server" DataSourceID="sdsCajas" 
                    DataTextField="economico" DataValueField="id_equipo">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsCajas" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT economico, id_equipo FROM equipo_operacion WHERE (id_tipo_equipo = 107) AND (id_status = 5) ORDER BY economico">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td style="width: 65px">
                Cliente:</td>
            <td style="width: 257px">
                <asp:DropDownList ID="ddlCliente" runat="server" DataSourceID="sdsCliente" 
                    DataTextField="nombre" DataValueField="id_precio_caja" 
                    AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Seleccionar...</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsCliente" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    SelectCommand="SELECT dbo.empresas.nombre, precios_cajas.id_precio_caja FROM precios_cajas INNER JOIN dbo.empresas ON precios_cajas.id_cliente = dbo.empresas.id_empresa">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td style="width: 65px">
                Desde:</td>
            <td style="width: 257px">
                <asp:TextBox ID="txbInicio" runat="server"></asp:TextBox>
                <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="txbInicio"  >
                    </asp:CalendarExtender>
            </td>
        </tr>
        <tr>
            <td style="width: 65px">
                Hasta:</td>
            <td style="width: 257px">
                <asp:TextBox ID="txbFin" runat="server"></asp:TextBox>
                <asp:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" TargetControlID="txbFin"  >
                    </asp:CalendarExtender>
            </td>
        </tr>
        <tr>
            <td style="width: 65px">
                &nbsp;</td>
            <td style="width: 257px">
                <asp:Button ID="Button1" runat="server" Text="Guardar" />
            </td>
        </tr>
    </table>

</asp:Content>
