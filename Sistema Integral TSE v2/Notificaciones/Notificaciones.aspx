<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Notificaciones.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Notificaciones1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .style5
        {
            width: 102px;
        }
        .style7
        {
            width: 56px;
        }
        .style9
        {
            width: 4px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<h1>Configuración de Notificaciones</h1>
    <table class="style5">
        <tr>
            <td class="style7">
                Descripción:</td>
            <td class="style9">
                <asp:DropDownList ID="ddlDescripcion" runat="server" Width="200px">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style7">
                Notificar&nbsp; a:</td>
            <td class="style9">
                &nbsp;</td>
        </tr>
    </table>
    <p>&nbsp;</p>
</asp:Content>
