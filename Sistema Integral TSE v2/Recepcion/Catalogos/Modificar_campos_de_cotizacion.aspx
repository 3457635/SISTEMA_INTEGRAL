<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Modificar_campos_de_cotizacion.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Modificar_campos_de_cotizacion" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:TextBox ID="txbIdCotizacion" runat="server" Visible="False"></asp:TextBox>
    <h1>Modificar fecha de vencimiento de precio</h1>
    <center>
    <table class="sample">
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" Text="Seleccione la fecha"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtFecha" runat="server" Width="195px"></asp:TextBox>
                <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy"
                    TargetControlID="txtFecha" Enabled="True">
                </asp:CalendarExtender>

            </td>
        </tr>
        <tr>
            <td colspan="2">

                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
                <asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
    </table>
      </center>  
    <p style="text-align: center">
        &nbsp;
    </p>
</asp:Content>
