<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlRenta_Cajas.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlRenta_Cajas" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<style type="text/css">
    .style1
    {
        width: 227px;
    }
    .style2
    {
        width: 60px;
    }
    .style3
    {
        width: 157px;
    }
</style>
Renta de Caja

<table class="style1">
    <tr>
        <td class="style2">
            Cliente:</td>
        <td class="style3">
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sdsCliente" 
                DataTextField="nombre" DataValueField="id_empresa">
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsCliente" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                SelectCommand="SELECT nombre, id_empresa FROM dbo.empresas WHERE (id_status = 5) AND (id_tipo_empresa = 1) ORDER BY nombre">
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td class="style2">
            No. Caja:</td>
        <td class="style3">
            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="sdsCaja" 
                DataTextField="economico" DataValueField="id_equipo">
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsCaja" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                SelectCommand="SELECT economico, id_equipo FROM equipo_operacion WHERE (id_status = 5) AND (id_tipo_equipo = 107)">
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td class="style2">
            Desde:</td>
        <td class="style3">
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="style2">
            Hasta:</td>
        <td class="style3">
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
        </td>
    </tr>
</table>
<asp:Button ID="btnGuardar" runat="server" Text="Guardar" />

<asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txbInicio" Format="dd/MM/yyyy" TodaysDateFormat="dd/MM/yyyy">
</asp:CalendarExtender>
