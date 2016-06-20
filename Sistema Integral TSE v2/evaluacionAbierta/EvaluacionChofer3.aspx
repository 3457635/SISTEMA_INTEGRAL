<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EvaluacionChofer3.aspx.vb" Inherits="Sistema_Integral_TSE_v45.EvaluacionChofer3" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function hide() {
            document.poppedLayer = eval('document.getElementById("hide")');
            document.poppedLayer.style.visibility = "hidden";
            window.print();
        }
    </script> 
    <style type="text/css">
        .style1
        {
            width: 349px;
        }
        .style2
        {
            width: 130px;
        }
        .style6
        {
            width: 321px;
        }
        .style7
        {
            width: 364px;
        }
        .style10
        {
            color: #009900;
        }
        .style11
        {
            width: 39px;
        }
        .style12
        {
            width: 274px;
        }
        .style13
        {
            width: 225px;
        }
        .style18
        {
            width: 187px;
        }
        .style21
        {
            color: #009900;
            width: 464px;
        }
        .style22
        {
            width: 470px;
        }
        .style25
        {
            color: #000000;
            text-decoration: underline;
        }
        .style26
        {
            color: #000000;
        }
        .style27
        {
            width: 364px;
            height: 135px;
        }
        .style29
        {
            width: 464px;
        }
        .style31
        {
            width: 124px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="hide">
    
        &nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        <asp:HiddenField ID="hfdIdEquipo" runat="server" />
        </div>
        <table class="style12">
            <tr>
                <td class="style11">
    
                    &nbsp;</td>
                <td class="style13">
        <strong><span class="style26">EVALUACIÓN VIAJE CHOFER</span></strong></td>
            </tr>
        </table>
        Chofer: 
                <asp:Label ID="lblChofer" runat="server" style="font-weight: 700"></asp:Label>
            
    &nbsp;Inspector que inicia:
    <asp:Label ID="lblInspectorInicio" runat="server" Font-Bold="True"></asp:Label>
&nbsp; Inspector que cierra:
    <asp:Label ID="lblInspectorFin" runat="server" Font-Bold="True"></asp:Label>
&nbsp;<table class="style1">
        <tr>
            <td class="style2">
                <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="sdsRuta" EnableModelValidation="True" Width="500px">
                    <Columns>
                        <asp:BoundField DataField="id_orden" InsertVisible="False" ReadOnly="True" 
                            SortExpression="id_orden">
                        <ItemStyle Font-Size="0pt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="idEmpleado" SortExpression="idEmpleado">
                        <ItemStyle Font-Size="0pt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="orden" HeaderText="ORDEN" ReadOnly="True" 
                            SortExpression="orden" />
                        <asp:BoundField DataField="nombre" HeaderText="CLIENTE" 
                            SortExpression="nombre" />
                        <asp:BoundField DataField="ruta" HeaderText="RUTA" SortExpression="ruta" />
                        <asp:BoundField DataField="fecha" HeaderText="FECHA" SortExpression="fecha" />
                        <asp:TemplateField HeaderText="TRAYECTO">
                            <ItemTemplate>
                                <asp:GridView ID="GridView9" runat="server" AutoGenerateColumns="False" 
                                    DataSourceID="sdsTrayectoEnOrden" EnableModelValidation="True" 
                                    SkinID="grdAnidado">
                                    <Columns>
                                        <asp:BoundField DataField="trayecto" HeaderText="trayecto" 
                                            SortExpression="trayecto" />
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsTrayectoEnOrden" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                    SelectCommand="	SELECT DISTINCT 
	llT.trayecto
	FROM 
	llave_trayectos llT
	INNER JOIN 
	trayectos_asignados ta
	ON llT.id_trayecto = ta.id_trayecto 
	INNER JOIN equipo_asignado ea
	ON ta.EquipoAsignadoId = ea.id_equipo_asignado 
	INNER JOIN 
	Ordenes ord
	INNER JOIN 
	viajes vi
	ON Ord.id_orden = vi.id_orden 
	ON ea.ViajeId = vi.id_viaje 
	join
	recorridoEquipo re
	on re.idEquipoAsignado=ea.id_equipo_asignado
	WHERE 
	vi.id_status&lt;&gt;5 and
	vi.id_status&lt;&gt;3 and
	(ord.id_orden=@idOrden) AND 
	(ea.idEmpleado = @idEmpleado) ANd
	ea.id_Equipo=@idEquipo">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="" Name="idOrden" Type="Int32" />
                                        <asp:Parameter Name="idEmpleado" Type="Int32" />
                                        <asp:Parameter Name="idEquipo" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>
    <table class="style22">
        <tr>
            <td class="style21">
                <strong>
                <span class="style25">INFORMACIÓN DE RENDIMIENTO</span></strong></td>
        </tr>
        <tr>
            <td class="style29">
                <table class="style29">
                    <tr>
                        <td class="style27">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="sqlSalida" EnableModelValidation="True">
                    <Columns>
                        <asp:BoundField DataField="id_equipo_asignado" InsertVisible="False" 
                            ReadOnly="True" SortExpression="id_equipo_asignado">
                        <ItemStyle Font-Size="0pt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="tipo_trayecto" SortExpression="tipo_trayecto" />
                        <asp:BoundField DataField="odometro" HeaderText="ODOMETRO" 
                            SortExpression="odometro" />
                        <asp:BoundField DataField="num_ejes" HeaderText="EJES" 
                            SortExpression="num_ejes" />
                        <asp:BoundField DataField="economico" HeaderText="UNIDAD" 
                            SortExpression="economico" />
                        <asp:BoundField DataField="equipo" HeaderText="EQUIPO" 
                            SortExpression="equipo" />
                        <asp:TemplateField HeaderText="CAJA">
                            <ItemTemplate>
                                <asp:GridView ID="GridView8" runat="server" AutoGenerateColumns="False" 
                                    DataSourceID="sdsCajas" EnableModelValidation="True" SkinID="grdAnidado">
                                    <Columns>
                                        <asp:BoundField DataField="economico" HeaderText="economico" 
                                            SortExpression="economico" />
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsCajas" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                    SelectCommand="SELECT equipo_operacion.economico FROM cajaAsignada INNER JOIN equipo_operacion ON cajaAsignada.CajaId = equipo_operacion.id_equipo WHERE (cajaAsignada.EquipoAsignadoId = @idEquipoAsignado)">
                                    <SelectParameters>
                                        <asp:Parameter Name="idEquipoAsignado" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="inspector" HeaderText="INSPECTOR" 
                            SortExpression="inspector" />
                    </Columns>
                </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td class="style7">
                            <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table class="style6">
        <tr>
            <td class="style18">
                <strong>Recargas Externas</strong></td>
            <td class="style31">
                <strong>Recargas Internas</strong></td>
        </tr>
        <tr>
            <td class="style18">
                <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="sdsRecargas" EnableModelValidation="True">
                    <Columns>
                        <asp:BoundField DataField="lugar" HeaderText="lugar" SortExpression="lugar" />
                        <asp:BoundField DataField="lts" HeaderText="lts" SortExpression="lts" />
                        <asp:BoundField DataField="cantidad" DataFormatString="{0:c}" 
                            HeaderText="cantidad" SortExpression="cantidad" />
                        <asp:BoundField DataField="folio" HeaderText="folio" SortExpression="folio" />
                    </Columns>
                </asp:GridView>
            </td>
            <td class="style31">
                <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="sdsRecargasInternas" EnableModelValidation="True">
                    <Columns>
                        <asp:BoundField DataField="lts" HeaderText="lts" SortExpression="lts" />
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td class="style18">
                <asp:GridView ID="grdRecargasExternasParciales" runat="server" 
                    AutoGenerateColumns="False" DataSourceID="sdsParcialesExternas" 
                    EnableModelValidation="True">
                    <Columns>
                        <asp:BoundField DataField="ano" HeaderText="ano" 
                            SortExpression="ano" />
                        <asp:BoundField DataField="consecutivo" HeaderText="consecutivo" 
                            SortExpression="consecutivo" />
                        <asp:BoundField DataField="num_viaje" HeaderText="num_viaje" 
                            SortExpression="num_viaje" />
                        <asp:BoundField DataField="nombre" HeaderText="nombre" 
                            SortExpression="nombre" />
                        <asp:BoundField DataField="ruta" HeaderText="ruta" SortExpression="ruta" />
                        <asp:BoundField DataField="kms" HeaderText="kms" SortExpression="kms" />
                        <asp:BoundField DataField="lts" HeaderText="lts" SortExpression="lts" />
                        <asp:BoundField DataField="rendimiento" DataFormatString="{0:N2}" 
                            HeaderText="rendimiento" SortExpression="rendimiento" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsParcialesExternas" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    SelectCommand="SELECT Ordenes.ano, 
Ordenes.consecutivo, 
viajes.num_viaje, 
dbo.empresas.nombre, 
dbo.llave_rutas.ruta, 
rendimientos.kms, 
rendimientos.lts, 
rendimientos.rendimiento 
FROM rendimientos INNER JOIN equipo_asignado ON rendimientos.idEquipoAsignado = equipo_asignado.id_equipo_asignado 
INNER JOIN viajes ON equipo_asignado.ViajeId = viajes.id_viaje 
INNER JOIN Ordenes ON viajes.id_orden = Ordenes.id_orden 
INNER JOIN precios ON viajes.id_relacion = precios.id_relacion 
INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa 
INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta
 WHERE (equipo_asignado.idEmpleado = @idEmpleado) AND 
 (equipo_asignado.id_equipo_asignado IN 
 (SELECT DISTINCT recargas_combustible.idEquipoAsignado 
 FROM RecargasParciales INNER JOIN  recargas_combustible ON RecargasParciales.RecargaId = recargas_combustible.id_recarga 
 WHERE  (RecargasParciales.GrupoId IN 
 (SELECT RecargasParciales_1.GrupoId FROM RecargasParciales AS RecargasParciales_1 
 INNER JOIN recargas_combustible AS recargas_combustible_1 ON RecargasParciales_1.RecargaId = recargas_combustible_1.id_recarga 
 INNER JOIN equipo_asignado AS equipo_asignado_1 ON recargas_combustible_1.idEquipoAsignado = equipo_asignado_1.id_equipo_asignado 
 AND recargas_combustible_1.idEquipoAsignado = equipo_asignado_1.id_equipo_asignado 
 INNER JOIN viajes AS viajes_1 ON equipo_asignado_1.ViajeId = viajes_1.id_viaje 
 WHERE (viajes_1.id_orden = @idOrden))
 )))">
                    <SelectParameters>
                        <asp:Parameter Name="idEmpleado" />
                        <asp:Parameter Name="idOrden" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td class="style31">
                &nbsp;</td>
        </tr>
    </table>
    <span class="style25">

    <strong>ARRIBOS</strong></span><br />
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
        DataSourceID="sqlArribos" EnableModelValidation="True" 
        EmptyDataText="Sin Seguimiento">
        <Columns>
            <asp:BoundField DataField="nombre" HeaderText="CLIENTE" 
                SortExpression="nombre" />
            <asp:BoundField DataField="ubicacion" HeaderText="UBICACIÓN" 
                SortExpression="ubicacion" />
            <asp:BoundField DataField="fecha" HeaderText="FECHA" SortExpression="fecha" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sqlArribos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"   
        
        
        SelectCommand="SELECT detalle_arrivos.nombre, ubicaciones.ubicacion, horas.fecha, equipo_asignado.idEmpleado FROM arrivos INNER JOIN seguimiento ON arrivos.id_seguimiento = seguimiento.id_seguimiento INNER JOIN viajes ON seguimiento.id_viaje = viajes.id_viaje INNER JOIN Ordenes ON viajes.id_orden = Ordenes.id_orden INNER JOIN detalle_arrivos ON arrivos.id_detalle = detalle_arrivos.id_detalle INNER JOIN ubicaciones ON detalle_arrivos.id_ubicacion = ubicaciones.id_principal INNER JOIN horas ON seguimiento.id_seguimiento = horas.id_seguimiento INNER JOIN equipo_asignado ON viajes.id_viaje = equipo_asignado.ViajeId WHERE (horas.llegada = 1) AND (Ordenes.id_orden = @id_orden) AND (equipo_asignado.idEmpleado = @idEmpleado) ORDER BY horas.fecha">
        <SelectParameters>
            <asp:Parameter Name="id_orden" />
            <asp:Parameter Name="idEmpleado" />
        </SelectParameters>
    </asp:SqlDataSource>

    <span class="style25">

    <strong>
                <asp:SqlDataSource ID="sqlSalida" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    
                    
                    
                                
                                
                                
                                
        
        
        
        
        SelectCommand="odometrosPorChofer" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="grupo" Type="Int32" />
                        <asp:Parameter Name="idEmpleado" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsRecargas" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    
                    
                    
        SelectCommand="SELECT lugares_recarga.lugar, recargas_combustible.lts, gastos.cantidad, comprobantes_fiscales.folio FROM recargas_combustible INNER JOIN recargas_externas ON recargas_combustible.id_recarga = recargas_externas.id_recarga INNER JOIN gastos ON recargas_externas.id_gasto = gastos.id_gasto INNER JOIN lugares_recarga ON recargas_combustible.id_lugar = lugares_recarga.id_lugar INNER JOIN comprobantes_fiscales ON gastos.id_gasto = comprobantes_fiscales.id_gasto WHERE (recargas_combustible.idEquipoAsignado = @idEquipoAsignado)">
                    <SelectParameters>
                        <asp:Parameter Name="idEquipoAsignado" />
                    </SelectParameters>
                </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsChofer" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            
        
        
        SelectCommand="SELECT DISTINCT CONVERT (nvarchar, personas.primer_nombre) + ' ' + CONVERT (nvarchar, personas.apellido_paterno) AS chofer, empleados.id_empleado FROM personas INNER JOIN empleados ON personas.id_persona = empleados.id_persona INNER JOIN equipo_asignado ON empleados.id_empleado = equipo_asignado.idEmpleado INNER JOIN Ordenes INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden ON equipo_asignado.ViajeId = viajes.id_viaje WHERE (Ordenes.id_orden = @id_orden)">
            <SelectParameters>
                <asp:QueryStringParameter Name="id_orden" QueryStringField="idOrden" />
            </SelectParameters>
        </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsRecargasInternas" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    
                    
                    
        SelectCommand="SELECT recargas_combustible.lts FROM recargas_combustible INNER JOIN recargas_internas ON recargas_combustible.id_recarga = recargas_internas.id_recarga WHERE (recargas_combustible.idEquipoAsignado = @idEquipoAsignado)">
                    <SelectParameters>
                        <asp:Parameter Name="idEquipoAsignado" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsRuta" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    
                    SelectCommand="viajesPorRecorrido" 
        SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter Name="idEmpleado" />
                        <asp:Parameter Name="recorrido" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </strong></span>
    <strong>
    <span class="style10">
    <br />
    </span>
    <span class="style25">OBSERVACIONES</span></strong><br />
   Registre cualquier anomalia que pudiera afectar la evaluación del chofer ya sea 
    alguna llegada tardía, falta de documentación, motivo de mal rendimiento, falta de 
    comunicación o cualquier otra acción no conveniente.<br />
    <asp:TextBox ID="txbObservaciones" runat="server" Height="74px" 
        TextMode="MultiLine" Width="604px"></asp:TextBox>
    <br />
    <br />
    <br />

    </form>
</body>
</html>
