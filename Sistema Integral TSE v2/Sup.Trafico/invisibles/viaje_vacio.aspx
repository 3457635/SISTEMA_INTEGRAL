<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="viaje_vacio.aspx.vb" Inherits="Sistema_Integral_TSE_v45.viaje_vacio" 
    title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table style="width: 100%">
        <tr>
            <td colspan="2">
                <asp:Label ID="lblOrden" runat="server" Visible="False"></asp:Label>
            &nbsp;<br />
                Último viaje:<br />
                <asp:Label ID="lblInfo" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 68px">
                &nbsp;</td>
            <td style="width: 92%">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="width: 68px">
                Chofer:</td>
            <td style="width: 92%">
                <asp:DropDownList ID="ddlChofer" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td style="width: 68px">
                Unidad:</td>
            <td style="width: 92%">
                <asp:DropDownList ID="ddlUnidad" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td style="width: 68px">
                Caja:</td>
            <td style="width: 92%">
                <asp:DropDownList ID="ddlCaja" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td style="width: 68px">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
            </td>
            <td style="width: 92%">
                <asp:Label ID="lblAnuncio" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 68px">
                &nbsp;</td>
            <td style="width: 92%">
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>
