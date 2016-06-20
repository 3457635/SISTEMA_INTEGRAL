<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EvaluacionChofer2.aspx.vb" Inherits="Sistema_Integral_TSE_v45.EvaluacionChofer2" %>

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
            width: 425px;
        }
        .style8
        {
            width: 128px;
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
        .style14
        {
            width: 200px;
        }
        .style15
        {
            width: 148px;
        }
        .style16
        {
            width: 662px;
        }
        .style17
        {
            width: 168px;
        }
        .style18
        {
            width: 187px;
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
            width: 425px;
            height: 135px;
        }
        .style31
        {
            width: 124px;
        }
        .style32
        {
            width: 431px;
        }
        .style33
        {
            width: 425px;
            height: 21px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="hide">
    
        <asp:Button ID="Button1" runat="server" SkinID="btn" Text="Regresar" />
        &nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;<asp:DropDownList ID="DropDownList1" runat="server" 
            DataSourceID="sdsChofer" DataTextField="chofer" 
            DataValueField="id_empleado" style="margin-top: 0px">
        </asp:DropDownList>
        &nbsp;&nbsp;<asp:ImageButton ID="btnActualizar" runat="server" 
            SkinID="ibtnActualizar" />
        &nbsp;&nbsp; <asp:ImageButton ID="ImageButton2" runat="server" SkinID="ibtnImprimir"  OnClientClick="hide()" />
        <asp:TextBox ID="txbIdChofer" runat="server" Visible="False"></asp:TextBox>
        <asp:TextBox ID="txbIdUnidad" runat="server" Visible="False"></asp:TextBox>
        </div>
        <table class="style12">
            <tr>
                <td class="style11">
    
        <asp:Image ID="Image1" runat="server" ImageUrl="~/imagenes/logo2.jpg" Height="48px" 
                        Width="39px" />
                </td>
                <td class="style13">
        <strong><span class="style26">EVALUACIÓN VIAJE CHOFER</span></strong></td>
            </tr>
        </table>
        Chofer: 
                <asp:Label ID="lblChofer" runat="server" style="font-weight: 700"></asp:Label>
            
    <table class="style1">
        <tr>
            <td class="style2">
                <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="sdsRuta" EnableModelValidation="True" Width="500px">
                    <Columns>
                        <asp:BoundField DataField="id_orden" InsertVisible="False" ReadOnly="True" 
                            SortExpression="id_orden">
                        <ItemStyle Font-Size="0pt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="orden" HeaderText="ORDEN" ReadOnly="True" 
                            SortExpression="orden" />
                        <asp:BoundField DataField="nombre" HeaderText="CLIENTE" 
                            SortExpression="nombre" />
                        <asp:BoundField DataField="ruta" HeaderText="RUTA" SortExpression="ruta" />
                        <asp:BoundField DataField="fecha" HeaderText="FECHA" SortExpression="fecha" />
                        <asp:BoundField DataField="primer_nombre" HeaderText="CHOFER" />
                        <asp:BoundField DataField="apellido_paterno" />
                        <asp:TemplateField HeaderText="TRAYECTOS">
                            <ItemTemplate>
                                <asp:GridView ID="GridView8" runat="server" AutoGenerateColumns="False" 
                                    DataSourceID="sdsTrayectos" EnableModelValidation="True">
                                    <Columns>
                                        <asp:BoundField DataField="trayecto" HeaderText="trayecto" ShowHeader="False" 
                                            SortExpression="trayecto" />
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsTrayectos" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                    SelectCommand="SELECT llave_trayectos.trayecto FROM viajes INNER JOIN recursos_asignados ON viajes.id_viaje = recursos_asignados.id_viaje INNER JOIN trayectos_asignados ON recursos_asignados.id_asignacion = trayectos_asignados.id_asignacion INNER JOIN llave_trayectos ON trayectos_asignados.id_trayecto = llave_trayectos.id_trayecto WHERE (viajes.id_orden = @id_orden)">
                                    <SelectParameters>
                                        <asp:Parameter Name="id_orden" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>
   
                <table class="style32">
                    <tr>
                        <td class="style33">
                <strong>
                <span class="style25">INFORMACIÓN DE RENDIMIENTO</span></strong></td>
                    </tr>
                    <tr>
                        <td class="style27">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="sqlSalida" EnableModelValidation="True">
                    <Columns>
                        <asp:BoundField DataField="orden" HeaderText="ORDEN" SortExpression="orden" />
                        <asp:BoundField DataField="odometro" HeaderText="ODOMETRO" 
                            SortExpression="odometro" />
                        <asp:BoundField DataField="num_ejes" HeaderText="EJES" 
                            SortExpression="num_ejes" />
                        <asp:BoundField DataField="economico" HeaderText="UNIDAD" 
                            SortExpression="economico" />
                        <asp:BoundField DataField="equipo" HeaderText="EQUIPO" 
                            SortExpression="equipo" />
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
        
        
        
        SelectCommand="SELECT detalle_arrivos.nombre, ubicaciones.ubicacion, horas.fecha 
FROM 
arrivos INNER JOIN seguimiento ON arrivos.id_seguimiento = seguimiento.id_seguimiento 
INNER JOIN viajes ON seguimiento.id_viaje = viajes.id_viaje 
INNER JOIN Ordenes ON viajes.id_orden = Ordenes.id_orden 
INNER JOIN detalle_arrivos ON arrivos.id_detalle = detalle_arrivos.id_detalle 
INNER JOIN ubicaciones ON detalle_arrivos.id_ubicacion = ubicaciones.id_principal 
INNER JOIN horas ON seguimiento.id_seguimiento = horas.id_seguimiento 
INNER JOIN recursos_asignados ON viajes.id_viaje = recursos_asignados.id_viaje 
INNER JOIN fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje 
INNER JOIN fechas ON fechas_viaje.id_fecha = fechas.id_fecha 
WHERE (horas.llegada = 1) AND 
fechas.tipo_fecha=1 and 
(recursos_asignados.id_empleado = @id_empleado) AND 
(fechas.fecha BETWEEN @inicio AND @fin) 
ORDER BY seguimiento.fecha">
        <SelectParameters>
            <asp:Parameter Name="id_empleado" />
            <asp:Parameter Name="inicio" />
            <asp:Parameter Name="fin" />
        </SelectParameters>
    </asp:SqlDataSource>

    <span class="style25">

    <strong>
                <asp:SqlDataSource ID="sqlSalida" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    
                    
                    
                                
                                
                                
                                
        
        
        
        
        SelectCommand="SELECT DISTINCT equipo_operacion.economico, tipo_equipos.equipo, Odometros.odometro, Odometros.num_ejes, Odometros.inspector, CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) AS orden FROM Ordenes INNER JOIN Odometros ON Ordenes.id_orden = Odometros.idOrden RIGHT OUTER JOIN equipo_asignado INNER JOIN equipo_operacion ON equipo_asignado.id_equipo = equipo_operacion.id_equipo INNER JOIN tipo_equipos ON equipo_operacion.id_tipo_equipo = tipo_equipos.id_tipo_equipo ON Odometros.id_equipo = equipo_asignado.id_equipo WHERE (odometros.idEvaluacion = @idEvaluacion)">
                    <SelectParameters>
                        <asp:Parameter Name="idEvaluacion" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sqlTrayectos" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    
                                
                                SelectCommand="SELECT DISTINCT recursos_asignados.id_empleado, llave_trayectos.trayecto FROM Ordenes INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN recursos_asignados ON viajes.id_viaje = recursos_asignados.id_viaje INNER JOIN trayectos_asignados ON recursos_asignados.id_asignacion = trayectos_asignados.id_asignacion INNER JOIN llave_trayectos ON trayectos_asignados.id_trayecto = llave_trayectos.id_trayecto WHERE (ordenes.id_orden = @id_orden) and recursos_asignados.id_empleado=@id_empleado">
                    <SelectParameters>
                        <asp:Parameter Name="id_orden" />
                        <asp:Parameter Name="id_empleado" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsRecargas" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    
                    
                    
        
        SelectCommand="SELECT lugares_recarga.lugar, recargas_combustible.lts, gastos.cantidad, comprobantes_fiscales.folio FROM recargas_combustible INNER JOIN recargas_externas ON recargas_combustible.id_recarga = recargas_externas.id_recarga INNER JOIN gastos ON recargas_externas.id_gasto = gastos.id_gasto INNER JOIN liquidaciones ON gastos.id_gasto = liquidaciones.id_gasto INNER JOIN lugares_recarga ON recargas_combustible.id_lugar = lugares_recarga.id_lugar INNER JOIN comprobantes_fiscales ON gastos.id_gasto = comprobantes_fiscales.id_gasto WHERE (recargas_combustible.id_chofer = @id_chofer) AND (recargas_combustible.idEvaluacion = @idEvaluacion)">
                    <SelectParameters>
                        <asp:Parameter Name="id_chofer" />
                        <asp:Parameter Name="idEvaluacion" />
                    </SelectParameters>
                </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsChofer" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            
        
        SelectCommand="SELECT DISTINCT CONVERT (nvarchar, personas.primer_nombre) + ' ' + CONVERT (nvarchar, personas.apellido_paterno) AS chofer, empleados.id_empleado FROM empleados INNER JOIN recursos_asignados ON empleados.id_empleado = recursos_asignados.id_empleado INNER JOIN viajes ON recursos_asignados.id_viaje = viajes.id_viaje INNER JOIN Ordenes ON viajes.id_orden = Ordenes.id_orden INNER JOIN personas ON empleados.id_persona = personas.id_persona WHERE (Ordenes.id_orden = @id_orden)">
            <SelectParameters>
                <asp:QueryStringParameter Name="id_orden" QueryStringField="idOrden" />
            </SelectParameters>
        </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsRecargasInternas" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    
                    
                    
        
        SelectCommand="SELECT recargas_combustible.lts FROM recargas_combustible INNER JOIN recargas_internas ON recargas_combustible.id_recarga = recargas_internas.id_recarga WHERE (recargas_combustible.id_chofer = @id_chofer) AND (recargas_combustible.idEvaluacion = @id_evaluacion)">
                    <SelectParameters>
                        <asp:Parameter Name="id_chofer" />
                        <asp:Parameter Name="id_evaluacion" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsRuta" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    
                    
        
        SelectCommand="SELECT DISTINCT recursos_asignados.id_empleado, CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + CONVERT (nvarchar, viajes.num_viaje) AS orden, dbo.empresas.nombre, dbo.llave_rutas.ruta, CONVERT (nvarchar, fechas.fecha, 106) AS fecha, personas.primer_nombre, personas.apellido_paterno, Ordenes.id_orden FROM viajes INNER JOIN precios ON viajes.id_relacion = precios.id_relacion INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN recursos_asignados ON viajes.id_viaje = recursos_asignados.id_viaje INNER JOIN Ordenes ON viajes.id_orden = Ordenes.id_orden INNER JOIN fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha INNER JOIN equipo_asignado ON recursos_asignados.id_asignacion = equipo_asignado.id_asignacion AND recursos_asignados.id_asignacion = equipo_asignado.id_asignacion AND recursos_asignados.id_asignacion = equipo_asignado.id_asignacion INNER JOIN empleados ON recursos_asignados.id_empleado = empleados.id_empleado INNER JOIN personas ON empleados.id_persona = personas.id_persona AND empleados.id_persona = personas.id_persona AND empleados.id_persona = personas.id_persona WHERE (fechas.tipo_fecha = 1) AND (fechas.fecha BETWEEN @inicio AND @fin) AND (equipo_asignado.id_equipo = @id_equipo) AND (viajes.id_status &lt;&gt; 5) AND (viajes.id_status &lt;&gt; 3)">
                    <SelectParameters>
                        <asp:Parameter Name="inicio" />
                        <asp:Parameter Name="fin" />
                        <asp:Parameter Name="id_equipo" />
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
    <strong>FIRMAS:</strong><br />
    <br />
    <table class="style16">
        <tr>
            <td class="style8">
                Inspector:</td>
            <td class="style14">
                _________________________</td>
            <td class="style15">
                Jefe de Tráfico:</td>
            <td class="style17">
                ________________________</td>
        </tr>
        <tr>
            <td class="style8">
                <br />
                Chofer:</td>
            <td class="style14">
                <br />
                _________________________</td>
            <td class="style15">
                Auditor de Combustible:</td>
            <td class="style17">
                <br />
                ________________________</td>
        </tr>
        </table>
    <br />

    </form>
</body>
</html>
