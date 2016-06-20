<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Margen.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Margen" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">

    <style type="text/css">
        .style5
        {
            width: 100%;
        }
        .style6
        {
            width: 92px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Costeo</h1>
    <p>Fecha de Cierre de Viaje;</p>
    <p>Desde:
        <asp:TextBox ID="txbDesde" runat="server"></asp:TextBox>
        <asp:CalendarExtender ID="txbDesde_CalendarExtender" runat="server" 
            Enabled="True" Format="yyyy/MM/dd" TargetControlID="txbDesde">
        </asp:CalendarExtender>
&nbsp;&nbsp; Hasta:<asp:TextBox ID="txbHasta" runat="server"></asp:TextBox>
        <asp:CalendarExtender ID="txbHasta_CalendarExtender" runat="server" Format="yyyy/MM/dd" 
            Enabled="True" TargetControlID="txbHasta">
        </asp:CalendarExtender>
        </p>
    <p>
        <asp:Button ID="btnBuscar" runat="server" SkinID="btn" Text="Buscar" />
    </p>
    <p>
        PrecPrecios cotizados dolares;</p>
    <p>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
            DataSourceID="sdsOrdenesDls" 
            SkinID="GridView1" AllowPaging="True">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="id_viaje" InsertVisible="False" 
                    SortExpression="id_viaje">
                <ItemStyle Font-Size="0pt" />
                </asp:BoundField>
                <asp:BoundField DataField="ano" 
                    SortExpression="ano" HeaderText="ORDEN">
                </asp:BoundField>
                <asp:BoundField DataField="consecutivo" SortExpression="consecutivo" />
                <asp:BoundField DataField="num_viaje" 
                    SortExpression="num_viaje" />
                <asp:BoundField DataField="nombre" HeaderText="EMPRESA" 
                    SortExpression="nombre" />
                <asp:BoundField DataField="ruta" HeaderText="RUTA" SortExpression="ruta" />
                <asp:BoundField DataField="fechaInicio" DataFormatString="{0:d}" 
                    HeaderText="INICIO" />
                <asp:BoundField DataField="fecha" DataFormatString="{0:d}" HeaderText="FIN" />
                <asp:BoundField DataField="equipo" HeaderText="EQUIPO SOLICITADO" 
                    SortExpression="equipo" />
                <asp:TemplateField HeaderText="EQUIPO UTILIZADO">
                    <ItemTemplate>
                        <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" 
                            DataSourceID="sdsEquipo" EnableModelValidation="True" SkinID="grdAnidado">
                            <Columns>
                                <asp:BoundField DataField="economico" HeaderText="economico" 
                                    SortExpression="economico" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsEquipo" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                            
                            SelectCommand="SELECT equipo_operacion.economico FROM equipo_asignado INNER JOIN equipo_operacion ON equipo_asignado.id_equipo = equipo_operacion.id_equipo WHERE (equipo_asignado.ViajeId = @idViaje)
ORDER BY equipo_asignado.id_equipo">
                            <SelectParameters>
                                <asp:Parameter Name="idViaje" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="TRAYECTO">
                    <ItemTemplate>
                        <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" 
                            DataSourceID="sdsTrayectos" EnableModelValidation="True" SkinID="grdAnidado">
                            <Columns>
                                <asp:BoundField DataField="trayecto" HeaderText="trayecto" 
                                    SortExpression="trayecto" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsTrayectos" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT llave_trayectos.trayecto FROM trayectos_asignados INNER JOIN llave_trayectos ON trayectos_asignados.id_trayecto = llave_trayectos.id_trayecto INNER JOIN equipo_asignado ON trayectos_asignados.EquipoAsignadoId = equipo_asignado.id_equipo_asignado WHERE (equipo_asignado.ViajeId = @viajeId)
ORDER BY equipo_asignado.id_equipo">
                            <SelectParameters>
                                <asp:Parameter Name="viajeId" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="precio" DataFormatString="{0:c}" HeaderText="PRECIO" 
                    SortExpression="precio" />
                <asp:BoundField DataField="casetas" DataFormatString="{0:c}" 
                    HeaderText="CASETAS" SortExpression="casetas" />
                <asp:BoundField DataField="choferes" DataFormatString="{0:c}" 
                    HeaderText="TARIFA CHOFER" SortExpression="choferes" />
                <asp:BoundField DataField="combustible" DataFormatString="{0:c}" 
                    HeaderText="COMBUSTIBLE" SortExpression="combustible" />
                <asp:BoundField DataField="otros" DataFormatString="{0:c}" HeaderText="CRUCES" 
                    SortExpression="otros" />
                <asp:BoundField DataField="monto" DataFormatString="{0:c2}" HeaderText="UTILIDAD" SortExpression="monto" />
                <asp:BoundField DataField="margen" HeaderText="PORCENTAJE" SortExpression="margen" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsOrdenesDls" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            
            
            SelectCommand="SELECT     
O.ano, 
O.consecutivo, 
v.num_viaje, 
e.nombre, 
ll.ruta, 
f.fecha, 
te.equipo, 
p.precio * 15 AS precio,
(SELECT     f2.fecha
FROM          fechas AS f2 
INNER JOIN
fechas_viaje AS fV2 
ON f2.id_fecha = fV2.id_fecha
WHERE      (f2.tipo_fecha = 1) AND (fV2.id_viaje = v.id_viaje)) 
AS FechaInicio, 
v.id_viaje, 
m.casetas, 
m.choferes, 
m.combustible, 
m.otros, 
m.margen, 
m.monto
FROM         
viajes v 
INNER JOIN
Ordenes o 
ON v.id_orden = O.id_orden 
INNER JOIN
precios p 
ON v.id_relacion = p.id_relacion 
INNER JOIN
dbo.empresas e
ON p.id_empresa = e.id_empresa 
INNER JOIN
llave_rutas ll
ON p.id_ruta = ll.id_ruta 
INNER JOIN
tipo_equipos te 
ON p.id_tipo_recurso = te.id_tipo_equipo 
INNER JOIN
fechas_viaje fv 
ON v.id_viaje = fv.id_viaje 
INNER JOIN
fechas f 
ON fv.id_fecha = f.id_fecha LEFT OUTER JOIN
margen m
ON m.idViaje = v.id_viaje
WHERE      
(f.tipo_fecha = 2) 
AND (p.id_moneda = 5) 
AND (f.fecha BETWEEN @inicio AND @fin) 
AND (v.id_status = 4)
ORDER BY f.fecha DESC" 
            DeleteCommand="DELETE FROM [margen] WHERE [idMargen] = @idMargen" 
            InsertCommand="INSERT INTO [margen] ([monto], [margen], [casetas], [choferes], [combustible], [idViaje]) VALUES (@monto, @margen, @casetas, @choferes, @combustible, @idViaje)" 
            
            
            
            
            
            
            UpdateCommand="UPDATE [margen] SET [monto] = @monto, [margen] = @margen, [casetas] = @casetas, [choferes] = @choferes, [combustible] = @combustible, [idViaje] = @idViaje WHERE [idMargen] = @idMargen" 
            CancelSelectOnNullParameter="False">
            <DeleteParameters>
                <asp:Parameter Name="idMargen" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="monto" Type="Decimal" />
                <asp:Parameter Name="margen" Type="Decimal" />
                <asp:Parameter Name="casetas" Type="Decimal" />
                <asp:Parameter Name="choferes" Type="Decimal" />
                <asp:Parameter Name="combustible" Type="Decimal" />
                <asp:Parameter Name="idViaje" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="txbDesde" Name="inicio" PropertyName="Text" />
                <asp:ControlParameter ControlID="txbHasta" Name="fin" PropertyName="Text" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="monto" Type="Decimal" />
                <asp:Parameter Name="margen" Type="Decimal" />
                <asp:Parameter Name="casetas" Type="Decimal" />
                <asp:Parameter Name="choferes" Type="Decimal" />
                <asp:Parameter Name="combustible" Type="Decimal" />
                <asp:Parameter Name="idViaje" Type="Int32" />
                <asp:Parameter Name="idMargen" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        Precios M.N.
        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
            DataSourceID="sdsOrdenesMx" EnableModelValidation="True" 
            SkinID="GridView1" AllowPaging="True">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="id_viaje" InsertVisible="False" 
                    SortExpression="id_viaje">
                <ItemStyle Font-Size="0pt" />
                </asp:BoundField>
                <asp:BoundField DataField="ano" 
                    SortExpression="ano" HeaderText="ORDEN">
                </asp:BoundField>
                <asp:BoundField DataField="consecutivo" SortExpression="consecutivo" />
                <asp:BoundField DataField="num_viaje" 
                    SortExpression="num_viaje" />
                <asp:BoundField DataField="nombre" HeaderText="EMPRESA" 
                    SortExpression="nombre" />
                <asp:BoundField DataField="ruta" HeaderText="RUTA" SortExpression="ruta" />
                <asp:BoundField DataField="FechaInicio" DataFormatString="{0:d}" HeaderText="INICIO" 
                    SortExpression="FechaInicio" />
                <asp:BoundField DataField="fecha" DataFormatString="{0:d}" HeaderText="FIN" 
                    SortExpression="fecha" />
                <asp:BoundField DataField="equipo" HeaderText="EQUIPO SOLICITADO" 
                    SortExpression="equipo" />
                <asp:TemplateField HeaderText="EQUIPO UTILIZADO">
                    <ItemTemplate>
                        <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" 
                            DataSourceID="sdsEquipos" EnableModelValidation="True" SkinID="grdAnidado">
                            <Columns>
                                <asp:BoundField DataField="economico" HeaderText="economico" 
                                    SortExpression="economico" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsEquipos" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                            
                            SelectCommand="SELECT equipo_operacion.economico FROM equipo_operacion INNER JOIN equipo_asignado ON equipo_operacion.id_equipo = equipo_asignado.id_equipo WHERE (equipo_asignado.ViajeId = @idViaje)
ORDER BY equipo_asignado.id_equipo">
                            <SelectParameters>
                                <asp:Parameter Name="idViaje" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="TRAYECTO">
                    <ItemTemplate>
                        <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" 
                            DataSourceID="sdsTrayectos" EnableModelValidation="True" SkinID="grdAnidado">
                            <Columns>
                                <asp:BoundField DataField="trayecto" HeaderText="trayecto" 
                                    SortExpression="trayecto" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsTrayectos" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT llave_trayectos.trayecto FROM trayectos_asignados INNER JOIN llave_trayectos ON trayectos_asignados.id_trayecto = llave_trayectos.id_trayecto INNER JOIN equipo_asignado ON trayectos_asignados.EquipoAsignadoId = equipo_asignado.id_equipo_asignado WHERE (equipo_asignado.ViajeId = @viajeId)
ORDER BY equipo_asignado.id_equipo">
                            <SelectParameters>
                                <asp:Parameter Name="viajeId" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="precio" DataFormatString="{0:c}" HeaderText="PRECIO" 
                    SortExpression="precio" />
                <asp:BoundField DataField="casetas" DataFormatString="{0:C}" 
                    HeaderText="CASETAS" SortExpression="casetas" />
                <asp:BoundField DataField="choferes" DataFormatString="{0:C}" 
                    HeaderText="CHOFERES" SortExpression="choferes" />
                <asp:BoundField DataField="combustible" DataFormatString="{0:C}" 
                    HeaderText="COMBUSTIBLE" SortExpression="combustible" />
                <asp:BoundField DataField="otros" DataFormatString="{0:C}" HeaderText="CRUCES" 
                    SortExpression="otros" />
                <asp:BoundField DataField="monto" DataFormatString="{0:c2}" HeaderText="UTILIDAD" SortExpression="monto" />
                <asp:BoundField DataField="margen" HeaderText="PORCENTAJE" SortExpression="margen" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsOrdenesMx" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            
        
        
        
        SelectCommand="SELECT     
O.ano, 
O.consecutivo, 
v.num_viaje, 
e.nombre, 
ll.ruta, 
f.fecha, 
te.equipo, 
p.precio,
(SELECT     f2.fecha
FROM          fechas AS f2 
INNER JOIN
fechas_viaje AS fV2 
ON f2.id_fecha = fV2.id_fecha
WHERE      (f2.tipo_fecha = 1) AND (fV2.id_viaje = v.id_viaje)) 
AS FechaInicio, 
v.id_viaje, 
m.casetas, 
m.choferes, 
m.combustible, 
m.otros, 
m.margen, 
m.monto
FROM         
viajes v 
INNER JOIN
Ordenes o 
ON v.id_orden = O.id_orden 
INNER JOIN
precios p 
ON v.id_relacion = p.id_relacion 
INNER JOIN
dbo.empresas e
ON p.id_empresa = e.id_empresa 
INNER JOIN
llave_rutas ll
ON p.id_ruta = ll.id_ruta 
INNER JOIN
tipo_equipos te 
ON p.id_tipo_recurso = te.id_tipo_equipo 
INNER JOIN
fechas_viaje fv 
ON v.id_viaje = fv.id_viaje 
INNER JOIN
fechas f 
ON fv.id_fecha = f.id_fecha LEFT OUTER JOIN
margen m
ON m.idViaje = v.id_viaje
WHERE      
(f.tipo_fecha = 2) 
AND (p.id_moneda = 4) 
AND (f.fecha BETWEEN @inicio AND @fin) 
AND (v.id_status = 4)
ORDER BY f.fecha DESC">
            <SelectParameters>
                <asp:ControlParameter ControlID="txbDesde" Name="inicio" PropertyName="Text" />
                <asp:ControlParameter ControlID="txbHasta" Name="fin" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
         <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
         <br />
    <asp:Button ID="btnShow" runat="server" />
    <br />
    <asp:Panel ID="Panel1" runat="server" BackColor="White" title="Margen*">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:TextBox ID="txbIdMargen" runat="server" Visible="False"></asp:TextBox>
                <br />
                <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="sdsViaje" EnableModelValidation="True">
                    <Columns>
                        <asp:BoundField DataField="ano" SortExpression="ano" />
                        <asp:BoundField DataField="consecutivo" HeaderText="ORDEN" 
                            SortExpression="consecutivo" />
                        <asp:BoundField DataField="num_viaje" 
                            SortExpression="num_viaje" />
                        <asp:BoundField DataField="casetas" HeaderText="CASETAS" 
                            SortExpression="casetas" />
                        <asp:BoundField DataField="choferes" HeaderText="TARIFA CHOFERES" 
                            SortExpression="choferes" />
                        <asp:BoundField DataField="combustible" HeaderText="COMBUSTIBLE" 
                            SortExpression="combustible" />
                        <asp:BoundField DataField="margen" HeaderText="MARGEN" 
                            SortExpression="margen" />
                        <asp:BoundField DataField="monto" HeaderText="MONTO" SortExpression="monto" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsViaje" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    SelectCommand="SELECT Ordenes.ano, Ordenes.consecutivo, viajes.num_viaje, margen.casetas, margen.choferes, margen.combustible, margen.margen, margen.monto FROM Ordenes INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN margen ON viajes.id_viaje = margen.idViaje WHERE margen.idMargen=@idMargen">
                    <SelectParameters>
                        <asp:Parameter Name="idMargen" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <br />
                <table class="style5">
                    <tr>
                        <td class="style6">
                            Casetas:</td>
                        <td>
                            <asp:TextBox ID="txbCasetas" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style6">
                            Combustible:</td>
                        <td>
                            <asp:TextBox ID="txbCombustible" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style6">
                            Tarifa Chofer:</td>
                        <td>
                            <asp:TextBox ID="txbTarifa" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="style6">
                            &nbsp;</td>
                        <td>
                            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
                        </td>
                    </tr>
                </table>

            </ContentTemplate>
            
        </asp:UpdatePanel>
<asp:Button runat="server" Text="Cerrar" ID="btnCerrar" />
    </asp:Panel>
    <asp:ModalPopupExtender ID="mdlMargen" runat="server" 
        DynamicServicePath="" Enabled="True" TargetControlID="btnShow" 
        PopupControlID="Panel1" Drag="True" PopupDragHandleControlID="Panel1" >
    </asp:ModalPopupExtender>
    <br />
    <br />
         </asp:Content>
