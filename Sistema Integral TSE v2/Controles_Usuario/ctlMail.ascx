<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlMail.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlMail" %>
<style type="text/css">
    .style1
    {
        width: 662px;
    }
    .style5
    {
        width: 52px;
    }
    .style7
    {
        width: 600px;
    }
</style>
<h1>Correo</h1>

<table class="style1">
    <tr>
        <td class="style5">
            Para:</td>
        <td class="style7">
            <asp:TextBox ID="txbPara" runat="server" Width="600px"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="style5">
            Asunto:</td>
        <td class="style7">
            <asp:TextBox ID="txbAsunto" runat="server" Width="600px"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="style5">
            Adjunto:</td>
        <td class="style7">
            <asp:Label ID="lblAdjunto" runat="server"></asp:Label>
        </td>
    </tr>
</table>
<p>
&nbsp; Mensaje:</p>
<asp:TextBox ID="txbMensaje" runat="server" Height="200px" TextMode="MultiLine" 
    Width="600px"></asp:TextBox>
<p>
    <asp:Button ID="btnEnviar" runat="server" Text="Enviar" />
&nbsp;<asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
</p>
<p>
    <asp:HiddenField ID="hdnXml" runat="server" />
</p>
<asp:HiddenField ID="hdnPdf" runat="server" />


<asp:HiddenField ID="hfldFolioFiscal" runat="server" />



