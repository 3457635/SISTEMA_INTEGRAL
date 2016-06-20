<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="insite.aspx.vb" Inherits="Sistema_Integral_TSE_v45.insite" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .style5
        {
            width: 254px;
        }
        .style6
        {
            width: 92px;
        }
        .style7
        {
            width: 152px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Registro de Insite</h1><p>
        &nbsp;<asp:SqlDataSource ID="sdsOrdenes" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            
            SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) AS orden, Ordenes.id_orden FROM Ordenes INNER JOIN fechas_ordenes ON Ordenes.id_orden = fechas_ordenes.id_orden INNER JOIN fechas ON fechas_ordenes.id_fecha = fechas.id_fecha WHERE (Ordenes.id_status &lt;&gt; 3) AND (Ordenes.id_status &lt;&gt; 5) AND (fechas.fecha BETWEEN DATEADD(month, - 6, GETDATE()) AND GETDATE()) AND (fechas.tipo_fecha = 1) ORDER BY Ordenes.ano, Ordenes.consecutivo">
        </asp:SqlDataSource>
        &nbsp;</p>
    <table class="style5">
        <tr>
            <td class="style6">
                Orden</td>
            <td class="style7">
        <asp:DropDownList ID="ddlOrden" runat="server" DataSourceID="sdsOrdenes" 
            DataTextField="orden" DataValueField="id_orden" Height="19px" Width="152px" 
                    AutoPostBack="True">
        </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style6">
                Chofer</td>
            <td class="style7">
                <asp:DropDownList ID="ddlChofer" runat="server" Height="18px" Width="150px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style6">
                Equipo</td>
            <td class="style7">
                <asp:DropDownList ID="ddlEquipo" runat="server" Height="16px" Width="149px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style6">
                Rendimiento:</td>
            <td class="style7">
                <asp:TextBox ID="txbRendimiento" runat="server" Height="25px" Width="146px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style6">
                &nbsp;</td>
            <td class="style7">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
            </td>
        </tr>
    </table>
    <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
</asp:Content>
