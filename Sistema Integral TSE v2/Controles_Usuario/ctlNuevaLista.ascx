<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlNuevaLista.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlNuevaLista" %>
<p>
    Correos:</p>
<p>
    <asp:TextBox ID="txbCorreos" runat="server" Height="212px" TextMode="MultiLine" 
        Width="670px"></asp:TextBox>
</p>
<asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
&nbsp;<asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>

<asp:TextBox ID="txbIdEmpresa" runat="server" Visible="False"></asp:TextBox>
<asp:TextBox ID="txbIdRuta" runat="server" Visible="False"></asp:TextBox>
<asp:TextBox ID="txbIdLista" runat="server" Visible="False"></asp:TextBox>


