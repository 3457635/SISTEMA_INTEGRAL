<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Seguimientos.aspx.vb" Inherits="Sistema_Integral_TSE_v45.WebForm2" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>

<%@ Register Src="../Controles_Usuario/ctlEvaluacionesPendientes.ascx" TagName="ctlEvaluacionesPendientes" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Seguimiento de Viajes<asp:Timer ID="Timer1" runat="server" Interval="9000000" />
    </h1>
    <p>
        Ver seguimientos anteriores;
    </p>
    <p>
        Año:<asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
        &nbsp;Consecutivo:
        <asp:TextBox ID="txbConsecutivo" runat="server"></asp:TextBox>
        &nbsp;Numero de Viaje:
        <asp:TextBox ID="txbNumViaje" runat="server">1</asp:TextBox>
        &nbsp;<asp:ImageButton ID="ibtnActualizar" runat="server" SkinID="ibtnActualizar"
            Style="height: 16px;" />
        &nbsp;<asp:Label ID="lblAnuncio3" runat="server"></asp:Label>
    </p>
    <p class="style5">
        &nbsp;
    </p>
    <b>
        <br />
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True"
            AutoGenerateColumns="False" DataKeyNames="id_viaje" DataSourceID="SqlViajes"
            EnableModelValidation="True" PageSize="30" SkinID="GridViewGreen">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="id_viaje" InsertVisible="False" ReadOnly="True"
                    SortExpression="id_viaje">
                    <ItemStyle Font-Size="0pt" Width="0px" />
                </asp:BoundField>
                <asp:BoundField DataField="ORDEN" HeaderText="ORDEN" ReadOnly="True"
                    SortExpression="ORDEN" />
                <asp:BoundField DataField="fecha" DataFormatString="{0:dd/MMM/yyyy}"
                    HeaderText="FECHA INICIO" SortExpression="fecha" />
                <asp:BoundField DataField="nombre" HeaderText="CLIENTE"
                    SortExpression="nombre" />
                <asp:BoundField DataField="ruta" HeaderText="RUTA" SortExpression="ruta" />
                <asp:TemplateField HeaderText="TRAYECTO">
                    <ItemTemplate>
                        <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False"
                            DataSourceID="sdsTrayecto" EnableModelValidation="True" SkinID="grdAnidado">
                            <Columns>
                                <asp:BoundField DataField="trayecto" HeaderText="trayecto"
                                    SortExpression="trayecto" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsTrayecto" runat="server"
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                            SelectCommand="SELECT llave_trayectos.trayecto FROM trayectos_asignados INNER JOIN llave_trayectos ON trayectos_asignados.id_trayecto = llave_trayectos.id_trayecto INNER JOIN equipo_asignado ON trayectos_asignados.EquipoAsignadoId = equipo_asignado.id_equipo_asignado WHERE (equipo_asignado.ViajeId = @id_viaje)">
                            <SelectParameters>
                                <asp:Parameter Name="id_viaje" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="CHOFER">
                    <ItemTemplate>
                        <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False"
                            DataSourceID="sdsChofer" EnableModelValidation="True" ShowHeader="False"
                            SkinID="grdAnidado">
                            <Columns>
                                <asp:BoundField DataField="primer_nombre" SortExpression="primer_nombre" />
                                <asp:BoundField DataField="apellido_paterno"
                                    SortExpression="apellido_paterno" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsChofer" runat="server"
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                            SelectCommand="SELECT personas.primer_nombre, personas.apellido_paterno FROM personas INNER JOIN empleados ON personas.id_persona = empleados.id_persona INNER JOIN equipo_asignado ON empleados.id_empleado = equipo_asignado.idEmpleado WHERE (equipo_asignado.ViajeId = @id_viaje)">
                            <SelectParameters>
                                <asp:Parameter Name="id_viaje" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="UNIDAD">
                    <ItemTemplate>
                        <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False"
                            DataSourceID="sdsUnidad" EnableModelValidation="True" SkinID="grdAnidado">
                            <Columns>
                                <asp:BoundField DataField="economico" HeaderText="economico"
                                    SortExpression="economico" />
                                <asp:BoundField DataField="equipo" HeaderText="equipo"
                                    SortExpression="equipo" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsUnidad" runat="server"
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                            SelectCommand="SELECT equipo_operacion.economico, tipo_equipos.equipo FROM equipo_asignado INNER JOIN equipo_operacion ON equipo_asignado.id_equipo = equipo_operacion.id_equipo INNER JOIN tipo_equipos ON equipo_operacion.id_tipo_equipo = tipo_equipos.id_tipo_equipo WHERE (equipo_asignado.ViajeId = @id_viaje)">
                            <SelectParameters>
                                <asp:Parameter Name="id_viaje" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="CAJA">
                    <ItemTemplate>
                        <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False"
                            DataSourceID="sdsCaja" EnableModelValidation="True" SkinID="grdAnidado">
                            <Columns>
                                <asp:BoundField DataField="economico" HeaderText="economico"
                                    SortExpression="economico" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsCaja" runat="server"
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                            SelectCommand="SELECT equipo_operacion.economico FROM equipo_asignado INNER JOIN cajaAsignada ON equipo_asignado.id_equipo_asignado = cajaAsignada.EquipoAsignadoId INNER JOIN equipo_operacion ON cajaAsignada.CajaId = equipo_operacion.id_equipo WHERE (equipo_asignado.ViajeId = @id_viaje)">
                            <SelectParameters>
                                <asp:Parameter Name="id_viaje" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ULTIMO SEGUIMIENTO">
                    <ItemTemplate>
                        <asp:Label ID="lblSeguimiento" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <br />
        Viajes Abiertos</b>

    <p>
        <asp:SqlDataSource ID="SqlViajes" runat="server"
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
            SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + CONVERT (nvarchar, viajes.num_viaje) AS ORDEN,
 viajes.id_viaje, dbo.llave_rutas.ruta, dbo.empresas.nombre, fechas.fecha
 FROM Ordenes INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden 
INNER JOIN precios ON viajes.id_relacion = precios.id_relacion 
INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta 
INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa
 INNER JOIN fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje 
INNER JOIN fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha 
WHERE (viajes.id_status = 2) 
AND (fechas.tipo_fecha = 1) ORDER BY fechas.fecha,ordenes.consecutivo"></asp:SqlDataSource>
        <asp:Button ID="btnGancho" runat="server" Enabled="False" />
    </p>



    <asp:ModalPopupExtender ID="mdlHolder" runat="server" TargetControlID="btnGancho"
        PopupControlID="pnlSeguimiento" BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>


    <asp:Panel ID="pnlSeguimiento" runat="server" BackColor="White" ScrollBars="Vertical" Height="95%">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>



                <table style="width: 100%">
                    <tr>
                        <td style="height: 22px">
                            <br />
                            <asp:SqlDataSource ID="sdsInfoViaje" runat="server"
                                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                                SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + 
CONVERT (nvarchar, viajes.num_viaje) AS ORDEN, 
Ordenes.id_orden, 
dbo.empresas.nombre, 
dbo.llave_rutas.ruta, 
personas.primer_nombre + ' ' + personas.apellido_paterno AS chofer 
FROM Ordenes INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN 
precios ON viajes.id_relacion = precios.id_relacion INNER JOIN 
dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN 
dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN 
equipo_asignado ON viajes.id_viaje = equipo_asignado.ViajeId INNER JOIN 
empleados ON equipo_asignado.idEmpleado = empleados.id_empleado INNER JOIN 
personas ON empleados.id_persona = personas.id_persona 
WHERE (viajes.id_viaje = @id_viaje)">
                                <SelectParameters>
                                    <asp:Parameter Name="id_viaje" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False"
                                DataKeyNames="id_orden" DataSourceID="sdsInfoViaje"
                                EnableModelValidation="True">
                                <Columns>
                                    <asp:BoundField DataField="ORDEN" HeaderText="ORDEN" ReadOnly="True"
                                        SortExpression="ORDEN" />
                                    <asp:BoundField DataField="nombre" HeaderText="CLIENTE"
                                        SortExpression="nombre" />
                                    <asp:BoundField DataField="ruta" HeaderText="RUTA" SortExpression="ruta" />
                                    <asp:BoundField DataField="chofer" HeaderText="CHOFER" ReadOnly="True"
                                        SortExpression="chofer" />
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 22px">Seguimiento</td>
                    </tr>
                    <tr>
                        <td>
                            <asp:SqlDataSource ID="SqlSeguimiento" runat="server"
                                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                                SelectCommand="SELECT seguimiento.observacion, seguimiento.inspector, seguimiento.id_seguimiento, horas.fecha, horas.llegada FROM seguimiento INNER JOIN horas ON seguimiento.id_seguimiento = horas.id_seguimiento WHERE (seguimiento.id_viaje = @id_viaje)"
                                DeleteCommand="DELETE FROM [seguimiento] WHERE [id_seguimiento] = @id_seguimiento"
                                InsertCommand="INSERT INTO [seguimiento] ([id_ubicacion], [fecha], [observacion], [inspector], [id_viaje], [id_arrivo]) VALUES (@id_ubicacion, @fecha, @observacion, @inspector, @id_viaje, @id_arrivo)"
                                UpdateCommand="UPDATE [seguimiento] SET [id_ubicacion] = @id_ubicacion, [fecha] = @fecha, [observacion] = @observacion, [inspector] = @inspector, [id_viaje] = @id_viaje, [id_arrivo] = @id_arrivo WHERE [id_seguimiento] = @id_seguimiento">
                                <DeleteParameters>
                                    <asp:Parameter Name="id_seguimiento" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="id_ubicacion" Type="Int32" />
                                    <asp:Parameter Name="fecha" Type="DateTime" />
                                    <asp:Parameter Name="observacion" Type="String" />
                                    <asp:Parameter Name="inspector" Type="String" />
                                    <asp:Parameter Name="id_viaje" Type="Int32" />
                                    <asp:Parameter Name="id_arrivo" Type="Int32" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:Parameter Name="id_viaje" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="id_ubicacion" Type="Int32" />
                                    <asp:Parameter Name="fecha" Type="DateTime" />
                                    <asp:Parameter Name="observacion" Type="String" />
                                    <asp:Parameter Name="inspector" Type="String" />
                                    <asp:Parameter Name="id_viaje" Type="Int32" />
                                    <asp:Parameter Name="id_arrivo" Type="Int32" />
                                    <asp:Parameter Name="id_seguimiento" Type="Int32" />
                                </UpdateParameters>
                            </asp:SqlDataSource>


                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False"
                                CellPadding="4" DataKeyNames="id_seguimiento" DataSourceID="SqlSeguimiento"
                                EnableModelValidation="True" ForeColor="#333333" GridLines="None">
                                <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                                <Columns>
                                    <asp:BoundField DataField="id_seguimiento">
                                        <ItemStyle Font-Size="0pt" Width="0px" />
                                    </asp:BoundField>
                                    <asp:CommandField DeleteImageUrl="/imagenes/delete.png"
                                        ShowDeleteButton="True" />
                                    <asp:TemplateField HeaderText="UBICACIÓN">
                                        <ItemTemplate>
                                            <asp:Label ID="lblUbicacion" runat="server"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="fecha" DataFormatString="{0:R}" HeaderText="FECHA"
                                        SortExpression="fecha" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Image ID="imgArribo" runat="server" Visible="False" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="observacion" HeaderText="OBSERVACIÓN"
                                        SortExpression="OBSERVACIÓN" />
                                    <asp:BoundField DataField="INSPECTOR" HeaderText="INSPECTOR"
                                        SortExpression="INSPECTOR" />
                                </Columns>
                                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                <AlternatingRowStyle BackColor="White" />
                            </asp:GridView>
                            <br />
                            <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                                AssociatedUpdatePanelID="UpdatePanel1">
                                <ProgressTemplate>
                                    <asp:Image ID="Image1" runat="server"
                                        ImageUrl="~/imagenes/updateProgress.gif" />
                                    Por favor espere...
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                            <br />
                            <br />


                            <table border="1" style="width: 100%">
                                <tr>
                                    <td colspan="6">
                                        <b>
                                            <asp:Label ID="lblAnuncio" runat="server"></asp:Label>
                                            &nbsp;</b></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="width: 196px">
                                        <asp:RadioButton ID="rbtnUbicacion" runat="server" AutoPostBack="True"
                                            Checked="True" GroupName="Ubicacion" Text="UBICACIÓN" />
                                        &nbsp;</td>
                                    <td style="width: 196px">
                                        <asp:RadioButton ID="rbtnArrivo" runat="server" AutoPostBack="True"
                                            GroupName="Ubicacion" Text="ARRIBO" />
                                        &nbsp;</td>
                                    <td style="width: 196px">
                                        <asp:RadioButton ID="rbtnPausas" runat="server" AutoPostBack="True"
                                            GroupName="Ubicacion" Text="PAUSAS" />
                                        &nbsp;</td>
                                    <td style="width: 105px">
                                        <asp:RadioButton ID="rbtLlegada" runat="server" AutoPostBack="True"
                                            Checked="True" Text="LLEGADA" />
                                    </td>
                                    <td style="width: 105px">
                                        <asp:RadioButton ID="rbtnSalida" runat="server" AutoPostBack="True"
                                            Text="SALIDA" />
                                    </td>
                                    <td style="width: 193px">
                                        <b>OBSERVACIÓN</b></td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td style="width: 196px">
                                        <asp:Label ID="Label1" runat="server"></asp:Label>
                                    </td>
                                    <td style="width: 196px">
                                        <asp:DropDownList ID="ddlArrivos" runat="server" DataSourceID="sdsArrivos"
                                            DataTextField="Expr1" DataValueField="id_detalle" Enabled="False">
                                        </asp:DropDownList>
                                        <br />
                                        <asp:LinkButton ID="lnkCatalogoArrivos" runat="server" Enabled="False"
                                            ForeColor="Gray">+ Catalogo de Arrivos</asp:LinkButton>
                                        <asp:SqlDataSource ID="sdsArrivos" runat="server"
                                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                                            SelectCommand="SELECT detalle_arrivos.nombre + ' (' + ubicaciones.ubicacion + ')' AS Expr1, detalle_arrivos.id_detalle FROM detalle_arrivos INNER JOIN ubicaciones ON detalle_arrivos.id_ubicacion = ubicaciones.id_principal 
WHERE (detalle_arrivos.id_status = 5) AND (detalle_arrivos.id_empresa = @id_empresa)
order by detalle_arrivos.nombre">
                                            <SelectParameters>
                                                <asp:Parameter Name="id_empresa" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                    <td style="width: 196px">
                                        <asp:DropDownList ID="ddlPausas" runat="server" DataSourceID="sdsPausas"
                                            DataTextField="pausa" DataValueField="id_tipo_pausa" Enabled="False">
                                        </asp:DropDownList>
                                        <br />
                                        <asp:LinkButton ID="lnkTiposPausas" runat="server" Enabled="False"
                                            ForeColor="Gray">+ Catalogo Pausas</asp:LinkButton>
                                        <asp:SqlDataSource ID="sdsPausas" runat="server"
                                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                                            SelectCommand="SELECT [id_tipo_pausa], [pausa] FROM [tipos_pausas] WHERE ([id_status] = @id_status)">
                                            <SelectParameters>
                                                <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                    <td style="width: 105px">&nbsp;<asp:Image ID="Image2" runat="server" ImageUrl="~/imagenes/llegada.png" />
                                        <asp:TextBox ID="TextBox1" runat="server" MaxLength="5" Width="49px"></asp:TextBox>
                                        <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server"
                                            AutoComplete="true" Mask="99:99" MaskType="Time" TargetControlID="TextBox1">
                                        </asp:MaskedEditExtender>
                                        <asp:TextBox ID="txbIdUbicacion1" runat="server" Visible="False" Width="50px"></asp:TextBox>
                                        <asp:Label ID="lblHora" runat="server"></asp:Label>
                                        <br />
                                        <asp:Label ID="lblSiguientePunto" runat="server"></asp:Label>
                                        <br />
                                        <br />
                                        <br />
                                    </td>
                                    <td style="width: 105px">
                                        <asp:Image ID="Image3" runat="server" ImageUrl="~/imagenes/salida.png" />
                                        <asp:TextBox ID="txbSalida" runat="server" Enabled="False" Width="49px"></asp:TextBox>
                                        <asp:MaskedEditExtender ID="MaskedEditExtender2" runat="server"
                                            AutoComplete="true" Mask="99:99" MaskType="Time" TargetControlID="txbSalida">
                                        </asp:MaskedEditExtender>
                                    </td>
                                    <td style="width: 193px">
                                        <asp:TextBox ID="txbObservacion1" runat="server" TextMode="MultiLine"></asp:TextBox>
                                        <br />
                                    </td>
                                    <td>
                                        <asp:Button ID="btnGuardar1" runat="server"
                                            OnClientClick="this.value = 'Espere...';" SkinID="btn" Text="Guardar" />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="7">&nbsp;&nbsp;<asp:GridView ID="grdPuntosPendientes" runat="server"
                                        AutoGenerateColumns="False" DataSourceID="sdsPuntoPendientes"
                                        EnableModelValidation="True" ShowHeader="False">
                                        <Columns>
                                            <asp:BoundField DataField="ubicacion" HeaderText="ubicacion"
                                                SortExpression="ubicacion" />
                                            <asp:BoundField DataField="hora" HeaderText="hora" SortExpression="hora" />
                                        </Columns>
                                    </asp:GridView>
                                        <asp:SqlDataSource ID="sdsPuntoPendientes" runat="server"
                                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                                            SelectCommand="SELECT [ubicacion], [hora] FROM [seguimientoPorRecorrer] WHERE ([idViaje] = @idViaje)">
                                            <SelectParameters>
                                                <asp:Parameter Name="idViaje" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <br />
                                        <asp:TextBox ID="txbIdViaje" runat="server" Visible="False"></asp:TextBox>
                                        <asp:Label ID="lblAnuncio2" runat="server" SkinID="lblMensaje"></asp:Label>
                                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                            <ContentTemplate>
                                                <asp:PlaceHolder ID="phrSeguimiento" runat="server"></asp:PlaceHolder>
                                                &nbsp;<asp:Button ID="btnCerrarPanel" runat="server" SkinID="btn"
                                                    Text="Cerrar Puntos de Arrivo" Visible="False" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>

                            <br />
                            <br />

                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>

        <asp:Button ID="btnCerrar" runat="server" Text="Cerrar" SkinID="btn" />
    </asp:Panel>


</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Head">
    <style type="text/css">
        .style5 {
            color: #FF0000;
        }
    </style>
</asp:Content>

