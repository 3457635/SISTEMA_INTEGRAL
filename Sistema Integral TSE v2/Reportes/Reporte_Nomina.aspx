<%@ Page Title="" Language="vb" AutoEventWireup="false" CodeBehind="Reporte_Nomina.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Reporte_Nomina" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
        .style1
        {
            width: 183px;
        }
        .style2
        {
            width: 45px;
        }
        .style3
        {
            font-family: Arial, Helvetica, sans-serif;
        }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div>

    <img alt="" src="../imagenes/logo.jpg" style="width: 34px; height: 45px" />
        <span class="style3"><strong>Reporte de Nomina

</strong></span>

<table style="width: 100%"> 

    <tr>
        <td style="width: 157px">
            Correspondiente:</td>
        <td class="style1">
            Del
            <asp:Label ID="lblFechas" runat="server"></asp:Label>
            &nbsp;al&nbsp;
            <asp:Label ID="lblFecha2" runat="server"></asp:Label>
        </td>
        <td class="style2">
            &nbsp;Chofer:</td>
        <td>
            <asp:Label ID="lblChofer" runat="server"></asp:Label>
        </td>
    </tr>
    </table>
            <asp:TextBox ID="txbInicio" runat="server" Visible="False"></asp:TextBox>
            <asp:TextBox ID="txbFin" runat="server" Visible="False"></asp:TextBox>
            <asp:TextBox ID="txbIdChofer" runat="server" Visible="False"></asp:TextBox>
    <br />

    
            <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" 
                DataKeyNames="id_viaje" EnableModelValidation="True" ShowFooter="True" 
            CellSpacing="1">
                <Columns>
                    <asp:BoundField DataField="id_viaje">
                    <ItemStyle Font-Size="0pt" Width="0px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="orden" HeaderText="ORDEN" />
                    <asp:BoundField DataField="nombre" HeaderText="CLIENTE" />
                    <asp:BoundField DataField="ruta" HeaderText="RUTA" />
                    <asp:BoundField DataField="fecha" DataFormatString="{0:dd/MMM/yyyy}" 
                        HeaderText="FECHA SERVICIO" />
                    <asp:TemplateField HeaderText="FECHA CIERRE">
                        <ItemTemplate>
                            <asp:Label ID="lblFechaCierre" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="TRAYECTOS">
                        <ItemTemplate>
                            <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" 
                                DataSourceID="sdsTrayectos" EnableModelValidation="True" GridLines="None" 
                                ShowHeader="False" SkinID="grdAnidado">
                                <AlternatingRowStyle ForeColor="Blue" />
                                <Columns>
                                    <asp:BoundField DataField="trayecto" HeaderText="trayecto" 
                                        SortExpression="trayecto" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsTrayectos" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                SelectCommand="SELECT llave_trayectos.trayecto FROM trayectos_asignados INNER JOIN llave_trayectos ON trayectos_asignados.id_trayecto = llave_trayectos.id_trayecto INNER JOIN equipo_asignado ON trayectos_asignados.EquipoAsignadoId = equipo_asignado.id_equipo_asignado WHERE (equipo_asignado.ViajeId = @ViajeId) ORDER BY equipo_asignado.id_equipo_asignado">
                                <SelectParameters>
                                    <asp:Parameter Name="ViajeId" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="CHOFER">
                        <ItemTemplate>
                            <asp:GridView ID="grdChofer" runat="server" BorderStyle="None" 
                                DataSourceID="sdsChofer" EnableModelValidation="True" GridLines="None" 
                                ShowHeader="False" AutoGenerateColumns="False">
                                <AlternatingRowStyle ForeColor="Blue" />
                                <Columns>
                                    <asp:BoundField DataField="primer_nombre" HeaderText="primer_nombre" 
                                        SortExpression="primer_nombre" />
                                    <asp:BoundField DataField="apellido_paterno" HeaderText="apellido_paterno" 
                                        SortExpression="apellido_paterno" />
                                </Columns>
                                <RowStyle BorderStyle="None" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsChofer" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                
                                
                                
                                SelectCommand="SELECT personas.primer_nombre, personas.apellido_paterno FROM empleados INNER JOIN personas ON empleados.id_persona = personas.id_persona INNER JOIN equipo_asignado ON empleados.id_empleado = equipo_asignado.idEmpleado WHERE (equipo_Asignado.ViajeId = @id_viaje) ORDER BY equipo_asignado.id_equipo_asignado">
                                <SelectParameters>
                                    <asp:Parameter Name="id_viaje" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="RENDIMIENTO (Fisico)">
                        <ItemTemplate>
                            <asp:Literal ID="ltlRendimiento" runat="server"></asp:Literal>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="INSITE"></asp:TemplateField>
                    <asp:TemplateField HeaderText="REC.">
                        <ItemTemplate>
                            <asp:Label ID="lblRecoleciones" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="TARIFA">
                        <ItemTemplate>
                            <asp:SqlDataSource ID="sdsTarifaMultichofer" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                
                                
                                
                                SelectCommand="SELECT     tarifas_trayectos.tarifa
FROM         tipo_equipos INNER JOIN
                      tarifas_trayectos INNER JOIN
                      llave_trayectos ON tarifas_trayectos.id_trayecto = llave_trayectos.id_trayecto INNER JOIN
                      trayectos_asignados ON llave_trayectos.id_trayecto = trayectos_asignados.id_trayecto ON tipo_equipos.id_tipo_equipo = tarifas_trayectos.id_tipo_vehiculo AND 
                      tipo_equipos.id_tipo_equipo = tarifas_trayectos.id_tipo_vehiculo INNER JOIN
                      equipo_operacion INNER JOIN
                      equipo_asignado ON equipo_operacion.id_equipo = equipo_asignado.id_equipo ON tipo_equipos.id_tipo_equipo = equipo_operacion.id_tipo_equipo
WHERE     (equipo_asignado.ViajeId = @id_viaje) AND (equipo_asignado.idEmpleado = @id_chofer)">
                                <SelectParameters>
                                    <asp:Parameter Name="id_viaje" />
                                    <asp:Parameter Name="id_chofer" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="grdTarifa" runat="server" AutoGenerateColumns="False" 
                                DataSourceID="sdsTarifaUnichofer" EnableModelValidation="True" GridLines="None" 
                                ShowHeader="False">
                                <AlternatingRowStyle ForeColor="Blue" />
                                <Columns>
                                    <asp:BoundField DataField="tarifa" DataFormatString="{0:c0}" />
                                </Columns>
                            </asp:GridView>
                            <asp:GridView ID="Multichofer" runat="server" AutoGenerateColumns="False" 
                                DataSourceID="sdsTarifaMultichofer" EnableModelValidation="True" 
                                GridLines="None" ShowHeader="False">
                                <AlternatingRowStyle ForeColor="Blue" />
                                <Columns>
                                    <asp:BoundField DataField="tarifa" DataFormatString="{0:c0}" />
                                </Columns>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsTarifaUnichofer" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                SelectCommand="SELECT tarifas_choferes.tarifa FROM viajes 
INNER JOIN precios ON viajes.id_relacion = precios.id_relacion 
INNER JOIN equipo_asignado ON viajes.id_viaje = equipo_asignado.viajeId
INNER JOIN equipo_operacion ON equipo_asignado.id_equipo = equipo_operacion.id_equipo 
INNER JOIN tipo_equipos ON equipo_operacion.id_tipo_equipo = tipo_equipos.id_tipo_equipo 
INNER JOIN tarifas_choferes ON tipo_equipos.id_tipo_equipo = tarifas_choferes.id_tipo_vehiculo 
INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta AND tarifas_choferes.id_ruta = dbo.llave_rutas.id_ruta 
INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa AND tarifas_choferes.id_cliente = dbo.empresas.id_empresa 
WHERE (viajes.id_viaje = @id_viaje) AND 
(viajes.id_viaje NOT IN 
(SELECT ea.ViajeId FROM trayectos_asignados ta INNER JOIN 
equipo_asignado ea ON ta.EquipoAsignadoId =ea.id_equipo_asignado)) 
ORDER BY equipo_asignado.idEmpleado">
                                <SelectParameters>
                                    <asp:Parameter Name="id_viaje" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("tarifa") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText=" %">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("margen") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Literal ID="ltlMargen" runat="server"></asp:Literal>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        
            


            </div>
    <br />
    </form>
</body>
</html>