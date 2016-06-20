<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlTiposPausas.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlTiposPausas" %>

<h1>Tipos de Pausas</h1>
<table class="style4">
    <tr>
        <td class="style5">
            <asp:Button ID="btnNuevo" runat="server" Text="Nuevo" />
        </td>
        <td class="style6">
            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
        </td>
        <td>
            <asp:Button ID="btnBorrar" runat="server" Text="Borrar" />
        </td>
    </tr>
</table>
<br />
<asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
<br />
<table class="style1">
    <tr>
        <td class="style2">
            &nbsp;</td>
        <td class="style3">
            <asp:DropDownList ID="ddlPausa" runat="server" DataSourceID="sdsPausas" 
                DataTextField="pausa" DataValueField="id_tipo_pausa">
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsPausas" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                SelectCommand="SELECT [id_tipo_pausa], [pausa] FROM [tipos_pausas] WHERE ([id_status] = @id_status) ORDER BY [pausa]">
                <SelectParameters>
                    <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td class="style2">
            Pausa:</td>
        <td class="style3">
            <asp:TextBox ID="txbPausa" runat="server"></asp:TextBox>
        </td>
    </tr>
</table>
<asp:TextBox ID="txbIdPausa" runat="server" Visible="False"></asp:TextBox>

