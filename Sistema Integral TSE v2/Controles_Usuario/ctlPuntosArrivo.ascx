<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlPuntosArrivo.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlPuntosArrivo" %>












    <h1>Puntos de Arrivo</h1>
<p>
    Puntos especificos de arrivo para cada cliente.</p>
<table class="style4">
    <tr>
        <td class="style1">
            <asp:Button ID="btnNuevo" runat="server" Text="Nuevo" SkinID="btn" />
        </td>
        <td class="style10">
            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" SkinID="btn" 
                style="height: 26px" />
        </td>
        <td class="style9">
            <asp:Button ID="btnBorrar" runat="server" Text="Borrar" SkinID="btn" />
        </td>
    </tr>
</table>
<asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
<br />
<asp:Panel ID="Panel1" runat="server">
<table class="style1">
    <tr>
        <td class="style6">
            Cliente:</td>
        <td class="style8">
            <asp:DropDownList ID="ddlCliente" runat="server" DataSourceID="sdsClientes" 
                DataTextField="nombre" DataValueField="id_empresa" AutoPostBack="True">
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsClientes" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                
                SelectCommand="SELECT [nombre], [id_empresa] FROM [empresas] WHERE (([id_status] = @id_status) AND ([id_tipo_empresa] = @id_tipo_empresa)) ORDER BY [nombre]">
                <SelectParameters>
                    <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                    <asp:Parameter DefaultValue="1" Name="id_tipo_empresa" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td class="style6">
            &nbsp;</td>
        <td class="style8">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
            <asp:DropDownList ID="ddlPunto" runat="server" AutoPostBack="True">
            </asp:DropDownList>
            </ContentTemplate>
            <Triggers><asp:AsyncPostBackTrigger ControlID="ddlCliente" EventName="SelectedIndexChanged" /></Triggers>
            </asp:UpdatePanel>
            
            
        </td>
    </tr>
    </table>
</asp:Panel>
<br />

            <asp:UpdatePanel ID="UpdatePanel1" runat="server" 
    UpdateMode="Conditional">
            <ContentTemplate>
<table class="style5">
    <tr>
        <td class="style3">
            Punto:</td>
        <td class="style2">
            <asp:TextBox ID="txbPunto" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="style3">
            Ubicacion:</td>
        <td class="style2">
            <asp:DropDownList ID="ddlUbicacion" runat="server" 
                DataSourceID="sdsUbicaciones" DataTextField="ubicacion" 
                DataValueField="id_principal">
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsUbicaciones" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                
                SelectCommand="SELECT ubicacion, id_principal FROM ubicaciones ORDER BY ubicacion">
            </asp:SqlDataSource>
        </td>
    </tr>
</table></ContentTemplate>
<Triggers>
<asp:AsyncPostBackTrigger ControlID="ddlPunto" EventName="SelectedIndexChanged" />

</Triggers>
</asp:UpdatePanel>



<p>
            <asp:TextBox ID="txbIdPunto" runat="server" Visible="False"></asp:TextBox>
        </p>
<p>
            &nbsp;</p>




