<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="configurar_cotizador.ascx.vb" Inherits="Sistema_Integral_TSE_v45.configurar_cotizador" %>

<h1>Configurar Cotizador</h1>
<p>
    &nbsp;</p>
<table class="style1" border="1" cellpadding="0" cellspacing="0">
    <tr>
        <td class="style3">
            Precio Diesel:</td>
        <td>
            <asp:TextBox ID="txbDiesel" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="txbDiesel" ErrorMessage="Campo Obligatorio" 
                ValidationGroup="configuracion">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style3">
            Rendimiento Promedio:</td>
        <td>
            Tracto :
            <asp:TextBox ID="txbRendimientoTracto" runat="server"></asp:TextBox>
&nbsp; kms/ lt.<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="txbRendimientoTracto" ErrorMessage="Campo Obligatorio" 
                ValidationGroup="configuracion">*</asp:RequiredFieldValidator>
            <br />
            Rabon :
            <asp:TextBox ID="txbRendimientoRabon" runat="server"></asp:TextBox>
            &nbsp;kms/lt.<asp:RequiredFieldValidator ID="RequiredFieldValidator3" 
                runat="server" ControlToValidate="txbRendimientoRabon" 
                ErrorMessage="Campo Obligatorio" ValidationGroup="configuracion">*</asp:RequiredFieldValidator>
            <br />
            Pick Up :
            <asp:TextBox ID="txbRendimientoPickup" runat="server"></asp:TextBox>
        &nbsp;kms/lt.<asp:RequiredFieldValidator ID="RequiredFieldValidator4" 
                runat="server" ControlToValidate="txbRendimientoPickup" 
                ErrorMessage="Campo Obligatorio" ValidationGroup="configuracion">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style3">
            Costo por kilometro en el mercado:</td>
        <td>
            <asp:TextBox ID="txbCostoxKilometro" runat="server"></asp:TextBox>
        &nbsp;pesos<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                ControlToValidate="txbCostoxKilometro" ErrorMessage="Campo Obligatorio" 
                ValidationGroup="configuracion">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style3">
            Porcentaje de tarifa del chofer:</td>
        <td>
            <asp:TextBox ID="txbTarifaChofer" runat="server"></asp:TextBox>
        &nbsp;%<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                ControlToValidate="txbTarifaChofer" ErrorMessage="Campo Obligatorio" 
                ValidationGroup="configuracion">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style3">
            Porcentaje de reduccion de tarifa a chofer por el tipo de vehiculo a conducir:</td>
        <td>
            Rabon :
            <asp:TextBox ID="txbReduccionRabon" runat="server"></asp:TextBox>
&nbsp;%
            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                ControlToValidate="txbReduccionRabon" ErrorMessage="Campo Obligatorio" 
                ValidationGroup="configuracion">*</asp:RequiredFieldValidator>
            <br />
            Pick UP :
            <asp:TextBox ID="txbReduccionPickup" runat="server"></asp:TextBox>
&nbsp;%<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                ControlToValidate="txbReduccionPickup" ErrorMessage="Campo Obligatorio" 
                ValidationGroup="configuracion">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style3">
            Porcentaje de incremento en el precio por ser viaje redondo:</td>
        <td>
            <asp:TextBox ID="txbRedondo" runat="server"></asp:TextBox>
&nbsp;%<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" 
                ControlToValidate="txbRedondo" ErrorMessage="Campo Obligatorio" 
                ValidationGroup="configuracion">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style3">
            Meses de vigencia de la cotización:</td>
        <td>
            <asp:TextBox ID="txbMeses" runat="server"></asp:TextBox>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" 
                ControlToValidate="txbMeses" ErrorMessage="Campo Obligatorio" 
                ValidationGroup="configuracion">*</asp:RequiredFieldValidator>
            meses</td>
    </tr>
</table>

<p>
    <asp:Button ID="btnGuardar" runat="server" SkinID="btn" Text="Guardar" 
        ValidationGroup="configuracion" />
&nbsp;<asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
</p>


<asp:ValidationSummary ID="ValidationSummary1" runat="server" 
    ValidationGroup="configuracion" />



