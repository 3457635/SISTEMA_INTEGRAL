<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlTarifas.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlTarifas" %>
<p>
    &nbsp;</p>
<p>
    Trayecto:
    <asp:DropDownList ID="ddlTrayecto" runat="server" DataSourceID="SqlDataSource1" 
        DataTextField="trayecto" DataValueField="id_trayecto">
    </asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        
        SelectCommand="SELECT trayecto, id_trayecto FROM llave_trayectos order by trayecto">
    </asp:SqlDataSource>
&nbsp;</p>
<p>
    Tipo de Vehículo:
    <asp:DropDownList ID="ddlVehiculo" runat="server" DataSourceID="SqlDataSource2" 
        DataTextField="equipo" DataValueField="id_tipo_equipo">
    </asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        SelectCommand="SELECT [id_tipo_equipo], [equipo] FROM [tipo_equipos]">
    </asp:SqlDataSource>
</p>
<p>
    Tarifa:
    <asp:TextBox ID="txbTarifa" runat="server"></asp:TextBox>
    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
</p>
<asp:Label ID="lblMensaje" runat="server"></asp:Label>

