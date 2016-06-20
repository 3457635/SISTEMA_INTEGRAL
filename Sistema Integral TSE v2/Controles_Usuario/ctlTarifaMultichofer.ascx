<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlTarifaMultichofer.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlTarifaMultichofer" %>

<h1>Tarifa Multichofer</h1>
<p>
    &nbsp;</p>
<table class="style1">
    <tr>
        <td class="style2">
            Ruta:</td>
        <td class="style3">
            <asp:DropDownList ID="ddlRuta" runat="server" AutoPostBack="True" 
                DataSourceID="sdsRuta" DataTextField="ruta" DataValueField="id_ruta">
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsRuta" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                SelectCommand="SELECT [ruta], [id_ruta] FROM [llave_rutas] WHERE ([id_status] &lt;&gt; @id_status) ORDER BY [ruta]">
                <SelectParameters>
                    <asp:Parameter DefaultValue="6" Name="id_status" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td class="style2">
            Trayecto:</td>
        <td class="style3">
            <asp:DropDownList ID="ddlTrayecto" runat="server" DataSourceID="sdsTrayecto" 
                DataTextField="trayecto" DataValueField="id_trayecto" AutoPostBack="True" 
                Width="80px">
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsTrayecto" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                
                SelectCommand="SELECT llave_trayectos.id_trayecto, llave_trayectos.trayecto FROM llave_trayectos INNER JOIN trayecto_ruta ON llave_trayectos.id_trayecto = trayecto_ruta.id_trayecto WHERE (trayecto_ruta.id_ruta = @id_ruta) ORDER BY llave_trayectos.trayecto">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlRuta" Name="id_ruta" 
                        PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td class="style2">
            Tipo de Vehículo:</td>
        <td class="style3">
            <asp:DropDownList ID="ddlTipoVehiculo" runat="server" 
                DataSourceID="sdsVehiculo" DataTextField="equipo" 
                DataValueField="id_tipo_equipo" AutoPostBack="True">
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsVehiculo" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                SelectCommand="SELECT [equipo], [id_tipo_equipo] FROM [tipo_equipos] WHERE ([id_tipo_equipo] &lt; @id_tipo_equipo)">
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
            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" SkinID="btn" />
        </td>
        <td class="style3">
            &nbsp;</td>
    </tr>
</table>
<asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>

