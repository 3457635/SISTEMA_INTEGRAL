<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlRecargasParcialesRegistradas.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlRecargasParcialesRegistradas" %>
<style type="text/css">
    .auto-style1 {
        width: 100%;
    }
    .auto-style3 {
        width: 82px;
    }
</style>
<p>
    &nbsp;</p>
<table class="auto-style1">
    <tr>
        <td class="auto-style3">Unidad:</td>
        <td>
    <asp:DropDownList ID="ddlUnidad" runat="server" Height="16px" Width="149px" DataSourceID="sdsUnidades" DataTextField="economico" DataValueField="id_equipo" AutoPostBack="True">
    </asp:DropDownList>
            <asp:SqlDataSource ID="sdsUnidades" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="SELECT economico, id_equipo FROM equipo_operacion where id_tipo_equipo&lt;106 and id_status=5 order by economico"></asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td class="auto-style3">No. Parciales</td>
        <td>
    <asp:DropDownList ID="ddlRecargas" runat="server" Height="16px" Width="170px" DataSourceID="sdsNoParcial" DataTextField="grupo" DataValueField="grupo">
    </asp:DropDownList>
            <asp:SqlDataSource ID="sdsNoParcial" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="SELECT DISTINCT recargaParcial.grupo FROM equipo_asignado INNER JOIN rendimientos ON equipo_asignado.id_equipo_asignado = rendimientos.idEquipoAsignado INNER JOIN recargaParcial ON rendimientos.idRendimiento = recargaParcial.idRendimiento WHERE (equipo_asignado.id_equipo = @idEquipo)
order by recargaParcial.grupo desc">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlUnidad" Name="idEquipo" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td class="auto-style3">&nbsp;</td>
        <td>
            <asp:Button ID="btnConsultar" runat="server" Text="Consultar" />
&nbsp;<asp:Button ID="btnEliminarParcial" runat="server" Text="Eliminar" />
        </td>
    </tr>
</table>
                                        <asp:GridView ID="grdRecargasParciales" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRecargasParciales" EnableModelValidation="True">
                                            <Columns>
                                                <asp:BoundField DataField="ano" SortExpression="ano" />
                                                <asp:BoundField DataField="consecutivo" HeaderText="ORDEN" SortExpression="consecutivo" />
                                                <asp:BoundField DataField="kms" HeaderText="KMS" SortExpression="kms" DataFormatString="{0:n2}" />
                                                <asp:BoundField DataField="lts" HeaderText="LTS" SortExpression="lts" DataFormatString="{0:n2}" />
                                                <asp:BoundField DataField="rendimiento" HeaderText="RENDMIENTO" SortExpression="rendimiento" DataFormatString="{0:n2}" />
                                            </Columns>
                                        </asp:GridView>
<asp:SqlDataSource ID="sdsRecargasParciales" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="SELECT 
O.ano, 
O.consecutivo, 
r.kms, 
r.lts, 
r.rendimiento 
FROM 
rendimientos r
INNER JOIN 
recargaParcial rp
ON r.idRendimiento = rp.idRendimiento 
INNER JOIN 
equipo_asignado ea
ON r.idEquipoAsignado = ea.id_equipo_asignado 
INNER JOIN 
viajes v
ON ea.ViajeId = v.id_viaje 
INNER JOIN 
Ordenes o
ON v.id_orden = o.id_orden 
WHERE (rp.grupo = @grupo)">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddlRecargas" Name="grupo" PropertyName="SelectedValue" />
    </SelectParameters>
</asp:SqlDataSource>
                       

           


