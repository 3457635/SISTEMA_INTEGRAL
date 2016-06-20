<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EvaluacionChofer.aspx.vb" ValidateRequest="false" Inherits="Sistema_Integral_TSE_v45.EvaluacionChofer" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../../Script/jquery-1.8.3.js" type="text/javascript"></script>
     <script src="../../Script/jQuery.printElement.js" type="text/javascript"></script>
    <script type="text/javascript">
        function hide() {
            document.poppedLayer = eval('document.getElementById("hide")');
            document.poppedLayer.style.visibility = "hidden";
            window.print();
        }
    </script> 
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnImprimir").click(function () {
                $("#imprimirDiv").printElement();
            });
        });
</script>
    <style type="text/css">
        .style1 {
            width: 349px;
        }

        .style2 {
            width: 130px;
        }

        .style6 {
            width: 321px;
        }

        .style7 {
            width: 364px;
        }

        .style8 {
            width: 128px;
        }

        .style10 {
            color: #009900;
        }

        .style11 {
            width: 39px;
        }

        .style12 {
            width: 904px;
        }

        .style13 {
            width: 225px;
        }

        .style14 {
            width: 200px;
        }

        .style15 {
            width: 148px;
        }

        .style16 {
            width: 662px;
        }

        .style17 {
            width: 168px;
        }

        .style18 {
            width: 187px;
        }

        .style21 {
            color: #009900;
            width: 464px;
        }

        .style22 {
            width: 470px;
        }

        .style25 {
            color: #000000;
            text-decoration: underline;
        }

        .style26 {
            color: #000000;
        }

        .style27 {
            width: 364px;
            height: 135px;
        }

        .style29 {
            width: 464px;
        }

        .style31 {
            width: 124px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="hide">
    
        &nbsp;&nbsp;<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Inspector/Cierre_Viaje.aspx">Regresar</asp:HyperLink>
&nbsp;&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="DropDownList1" runat="server" 
            DataSourceID="sdsChofer" DataTextField="chofer" 
            DataValueField="id_empleado" style="margin-right: 0px">
        </asp:DropDownList>
        &nbsp;&nbsp;<asp:ImageButton ID="ibtnActualizar" runat="server" 
            SkinID="ibtnActualizar" style="width: 14px" />
        &nbsp;&nbsp; 
        <asp:Button ID="btnImprimir" runat="server" Text="Imprimir" OnClientClick="hide();" />
        <asp:TextBox ID="txbIdOrden" runat="server" Visible="False"></asp:TextBox>
        <asp:HiddenField ID="hfdIdEquipo" runat="server" />
        <asp:HiddenField ID="hfldGrupo" runat="server" />
        </div>
        <div id="imprimirDiv">

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
                        <asp:BoundField DataField="id_viaje" InsertVisible="False" ReadOnly="True" 
                            SortExpression="id_orden">
                        <ItemStyle Font-Size="0pt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="idEmpleado" SortExpression="idEmpleado">
                        <ItemStyle Font-Size="0pt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="id_equipo_asignado" InsertVisible="False" ReadOnly="True" SortExpression="id_equipo_asignado" />
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
	ea.id_equipo_asignado=@idEquipoAsignado">
                                    <SelectParameters>
                                        <asp:Parameter Name="idEquipoAsignado" />
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
                        <asp:BoundField DataField="monto" DataFormatString="{0:c}" 
                            HeaderText="cantidad" SortExpression="cantidad" />
                        <asp:BoundField DataField="ticket" HeaderText="folio" SortExpression="folio" />
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
                &nbsp;</td>
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
                    
                    
                    
                    
        SelectCommand="SELECT 
lr.lugar, 
r.lts, 
r.monto, 
r.ticket
FROM 
recargas_combustible r
INNER JOIN 
lugares_recarga lr
ON r.id_lugar = lr.id_lugar 
WHERE (r.grupo = @grupo)
and r.id_lugar&lt;&gt;2">
                    <SelectParameters>
                        <asp:Parameter Name="grupo" />
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
                    
                    
                    
                    
        SelectCommand="SELECT 
r.lts
FROM 
recargas_combustible r
INNER JOIN 
lugares_recarga lr
ON r.id_lugar = lr.id_lugar 
WHERE (r.grupo = @grupo)
and r.id_lugar=2">
                    <SelectParameters>
                        <asp:Parameter Name="grupo" />
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
    <strong>FIRMAS:</strong><br />
    <br />
    <table class="style16">
        <tr>
            <td class="style8">
                Inspector:</td>
            <td class="style14">
                _________________________</td>
            <td class="style15">
                &nbsp;</td>
            <td class="style17">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style8">
                <br />
                Chofer:</td>
            <td class="style14">
                <br />
                _________________________</td>
            <td class="style15">
                &nbsp;</td>
            <td class="style17">
                &nbsp;</td>
        </tr>
        </table>
            <br />
            TSE-F-11&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REV. 01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ABRIL 2016&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <br />
            </div>
    </form>
</body>
</html>
