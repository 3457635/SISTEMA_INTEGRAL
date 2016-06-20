<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlTarifaChofer.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlTarifaChofer" %>

<h1>Tarifa Unichofer</h1>
<p>
    &nbsp;</p>
<table class="style1">
    <tr>
        <td class="style2">
            Cliente:</td>
        <td class="style3">
            <asp:DropDownList ID="ddlCliente" runat="server" DataSourceID="sdsCliente" 
                DataTextField="nombre" DataValueField="id_empresa" AutoPostBack="True">
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsCliente" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                SelectCommand="SELECT [nombre], [id_empresa] FROM [empresas] WHERE (([id_tipo_empresa] = @id_tipo_empresa) AND ([id_status] = @id_status)) ORDER BY [nombre]">
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="id_tipo_empresa" Type="Int32" />
                    <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td class="style2">
            Ruta:</td>
        <td class="style3">
            <asp:DropDownList ID="ddlRuta" runat="server" DataSourceID="sdsRuta" 
                DataTextField="ruta" DataValueField="id_ruta">
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsRuta" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                
                SelectCommand="SELECT     distinct dbo.llave_rutas.ruta, dbo.llave_rutas.id_ruta
FROM         precios INNER JOIN
                      dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta
WHERE     (precios.id_empresa = @id_empresa) AND (dbo.llave_rutas.id_status &lt;&gt; 6)
order by ruta">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlCliente" Name="id_empresa" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td class="style2">
            Tipo Vehiculo:</td>
        <td class="style3">
            <asp:DropDownList ID="ddlVehiculo" runat="server" 
                DataSourceID="sdsTipoVehiculo" DataTextField="equipo" 
                DataValueField="id_tipo_equipo" AutoPostBack="True">
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsTipoVehiculo" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                SelectCommand="SELECT [id_tipo_equipo], [equipo] FROM [tipo_equipos] WHERE ([id_tipo_equipo] &lt; @id_tipo_equipo)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="106" Name="id_tipo_equipo" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td class="style2">
            Tarifa:</td>
        <td class="style3">
            <asp:TextBox ID="txbTarifa" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="style2">
            &nbsp;</td>
        <td class="style3">
            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
        </td>
    </tr>
    <tr>
        <td class="style2" colspan="2">
            <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
        </td>
    </tr>
</table>
