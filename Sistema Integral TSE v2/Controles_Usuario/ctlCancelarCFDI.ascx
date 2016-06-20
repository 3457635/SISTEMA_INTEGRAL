<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlCancelarCFDI.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlCancelarCFDI" %>

<h1>Cancelar CFDI</h1>
<p>
    Folio Fiscal - UUID:
    <asp:TextBox ID="txbFolio" runat="server" Width="194px"></asp:TextBox>
&nbsp;&nbsp;
    <asp:Button ID="btnCancelar" runat="server" Text="Cancelar CFDI" />
&nbsp;<asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
</p>


