<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlNuevasRecargasParciales.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlNuevasRecargasParciales" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<style type="text/css">
    .auto-style1 {
        width: 100%;
    }

    .auto-style2 {
        width: 199px;
    }

    .auto-style3 {
        width: 222px;
    }
</style>
<br />
Unidad:
                        <asp:DropDownList ID="ddlUnidad" runat="server" DataSourceID="sdsUnidad" DataTextField="economico" DataValueField="id_equipo" Height="16px" Width="130px">
                        </asp:DropDownList>
<asp:SqlDataSource ID="sdsUnidad" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="SELECT economico, id_equipo FROM equipo_operacion WHERE (id_tipo_equipo &lt;= 105) AND (id_status = 5) ORDER BY economico"></asp:SqlDataSource>
&nbsp;<br />
<br />
Fecha de ordenes:
<br />
Desde
                        <asp:TextBox ID="txbDesde" runat="server"></asp:TextBox>
<asp:CalendarExtender ID="txbDesde_extender" runat="server" Enabled="True" Format="yyyy/MM/dd" TargetControlID="txbDesde">
</asp:CalendarExtender>
&nbsp;Hasta
                        <asp:TextBox ID="txbHasta" runat="server"></asp:TextBox>
<asp:CalendarExtender ID="txbHasta_extener" runat="server" Enabled="True" Format="yyyy/MM/dd" TargetControlID="txbHasta">
</asp:CalendarExtender>
&nbsp;<asp:Button ID="btnBuscar" runat="server" Text="Buscar" />
&nbsp;<asp:Button ID="Button1" runat="server" Text="Nuevo parcial" />
<br />
<br />
<table class="auto-style1">
    <tr>
        <td class="auto-style2">Ordenes:
                            <telerik:RadListBox ID="RadListBox1" runat="server" AllowDelete="True" AllowTransfer="True" DataKeyField="id_viaje" DataSortField="orden" DataSourceID="sdsRecargas" DataTextField="orden" DataValueField="id_viaje" TransferToID="RadListBox3" AutoPostBackOnTransfer="True">
                                <ButtonSettings TransferButtons="All" />
                            </telerik:RadListBox>
        </td>
        <td class="auto-style3">Parciales:<telerik:RadListBox ID="RadListBox3" runat="server">
            <ButtonSettings TransferButtons="All" />
        </telerik:RadListBox>
        </td>
        <td>

            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />

            <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>


            <br />
            <asp:Literal ID="ltlIndicador" runat="server"></asp:Literal>
            <asp:GridView ID="grdRecargasParciales" runat="server" AutoGenerateColumns="False" DataSourceID="sdsRecargasParciales" EnableModelValidation="True">
                <Columns>
                    <asp:BoundField DataField="ano" SortExpression="ano" />
                    <asp:BoundField DataField="consecutivo" HeaderText="ORDEN" SortExpression="consecutivo" />
                    <asp:BoundField DataField="kms" HeaderText="KMS" SortExpression="kms" DataFormatString="{0:n2}" />
                    <asp:BoundField DataField="lts" HeaderText="LTS" SortExpression="lts" DataFormatString="{0:n2}" />
                    <asp:BoundField DataField="rendimiento" HeaderText="RENDMIENTO" SortExpression="rendimiento" DataFormatString="{0:n2}" />
                </Columns>
            </asp:GridView>


        </td>
    </tr>
</table>

<asp:SqlDataSource ID="sdsRecargas" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="SELECT        
distinct convert(nvarchar,o.ano)+'-'+convert(nvarchar, o.consecutivo)+'  Rendimiento:'+convert(nvarchar,convert(decimal(18,2),r.rendimiento)) as orden,v.id_viaje
FROM            
equipo_asignado ea
 INNER JOIN
viajes v
ON ea.ViajeId = v.id_viaje 
join
rendimientos r
on r.idEquipoAsignado=ea.id_equipo_asignado
INNER JOIN
Ordenes o
ON v.id_orden = o.id_orden 
INNER JOIN
fechas_viaje fv
ON v.id_viaje = fv.id_viaje 
INNER JOIN
fechas f
ON fv.id_fecha = f.id_fecha
where 
ea.id_equipo=@idEquipo
and f.fecha between @desde and @hasta
and v.id_status&lt;&gt;5
and v.id_status&lt;&gt;3
order by orden desc">
    <SelectParameters>
        <asp:ControlParameter ControlID="ddlUnidad" Name="idEquipo" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="txbDesde" Name="desde" PropertyName="Text" />
        <asp:ControlParameter ControlID="txbHasta" Name="hasta" PropertyName="Text" />
    </SelectParameters>
</asp:SqlDataSource>








<br />
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
WHERE (rp.grupo =@grupo)">
    <SelectParameters>
        <asp:Parameter Name="grupo" />
    </SelectParameters>
</asp:SqlDataSource>


<br />
