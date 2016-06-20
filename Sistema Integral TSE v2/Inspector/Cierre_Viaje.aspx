<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Cierre_Viaje.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Cierre_Viaje" 
     %>

<%@ Register assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.WebControls" tagprefix="asp" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Cierre de viajes</h1><br />
                <br />
                <table class="style6">
                    <tr>
                        <td style="width: 60px">
                Año:</td>
                        <td class="style7">
                <asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
                        </td>
                        <td class="style8">
                Consecutivo:</td>
                        <td class="style7">
                <asp:TextBox ID="txbConsecutivo" runat="server"></asp:TextBox>
                        </td>
                        <td class="style5">
                <asp:ImageButton ID="ibtnActualizar" runat="server" SkinID="ibtnActualizar" 
                                style="height: 16px;" />
                        </td>
                    </tr>
                    </table>
    <asp:HiddenField ID="hflOdometroInicio" runat="server" />
    <br />
&nbsp;
                &nbsp;
                <asp:TextBox ID="txbIdOrden" runat="server" Visible="False"></asp:TextBox>
    
    <asp:TextBox ID="txbIdEquipoAsignado" runat="server" Visible="False"></asp:TextBox>
    
    <asp:HiddenField ID="hfldGrupo" runat="server" />
    
    <br />
                <span class="style13"><strong>Unidades de Cd. Juárez recargan en 
    Chihuahua pero se cierran hasta que regresan a Juárez. El odometro final tiene 
    que ser con el que regresa.</strong></span><br />
                <asp:GridView ID="grdViaje" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="sdsOrden" EnableModelValidation="True" 
        SkinID="GridViewGreen" 
        DataKeyNames="id_orden,id_equipo_asignado">
                    <Columns>
                        <asp:CommandField ShowSelectButton="True" />
                        <asp:BoundField DataField="id_orden" InsertVisible="False" 
                            SortExpression="id_orden">
                        <ItemStyle Font-Size="0pt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="id_equipo_asignado" InsertVisible="False" 
                            SortExpression="id_equipo_asignado">
                        <ItemStyle Font-Size="0pt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="orden" HeaderText="ORDEN" />
                        <asp:BoundField DataField="nombre" HeaderText="CLIENTE" />
                        <asp:BoundField DataField="ruta" HeaderText="RUTA" />
                        <asp:TemplateField HeaderText="TRAYECTO">
                            <ItemTemplate>
                                <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
                                    DataSourceID="sdsTrayecto" EnableModelValidation="True" SkinID="grdAnidado">
                                    <Columns>
                                        <asp:BoundField DataField="trayecto" HeaderText="trayecto" 
                                            SortExpression="trayecto" />
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsTrayecto" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                    SelectCommand="SELECT 
llave_trayectos.trayecto 
FROM 
trayectos_asignados 
INNER JOIN 
llave_trayectos 
ON trayectos_asignados.id_trayecto = llave_trayectos.id_trayecto where trayectos_asignados.EquipoAsignadoId=@idEquipoAsignado">
                                    <SelectParameters>
                                        <asp:Parameter Name="idEquipoAsignado" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="chofer" HeaderText="CHOFER" />
                        <asp:BoundField DataField="economico" HeaderText="UNIDAD" />
                        <asp:TemplateField HeaderText="ODOMETRO SALIDA">
                            <ItemTemplate>
                                <asp:Label ID="lblOdometro" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ODOMETRO REGRESO">
                            <ItemTemplate>
                                <asp:Label ID="lblOdometroRegreso" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="EJES SALIDA">
                            <ItemTemplate>
                                <asp:Label ID="lblEjes" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="EJES REGRESO">
                            <ItemTemplate>
                                <asp:Label ID="lblEjesRegreso" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="INSPECTOR">
                            <ItemTemplate>
                                <asp:Label ID="lblInspector" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsOrden" runat="server" 
                    
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        
        
        
        
        
        SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + CONVERT (nvarchar, viajes.num_viaje) AS orden, 
dbo.empresas.nombre, 
dbo.llave_rutas.ruta, 
personas.primer_nombre + ' ' + personas.apellido_paterno AS chofer, 
equipo_operacion.economico, 
empleados.id_empleado, 
equipo_operacion.id_equipo, 
Ordenes.id_orden, 
equipo_asignado.id_equipo_asignado 
FROM viajes
 INNER JOIN 
Ordenes 
ON viajes.id_orden = Ordenes.id_orden 
INNER JOIN precios 
ON viajes.id_relacion = precios.id_relacion 
INNER JOIN dbo.empresas 
ON precios.id_empresa = dbo.empresas.id_empresa 
INNER JOIN dbo.llave_rutas 
ON precios.id_ruta = dbo.llave_rutas.id_ruta 
INNER JOIN equipo_operacion 
INNER JOIN personas 
INNER JOIN empleados 
ON personas.id_persona = empleados.id_persona AND 
personas.id_persona = empleados.id_persona AND 
personas.id_persona = empleados.id_persona 
INNER JOIN equipo_asignado 
ON empleados.id_empleado = equipo_asignado.idEmpleado 
ON equipo_operacion.id_equipo = equipo_asignado.id_equipo 
ON viajes.id_viaje = equipo_asignado.ViajeId 
WHERE viajes.id_status&lt;&gt;3 and viajes.id_status&lt;&gt;5 and (Ordenes.consecutivo = @consecutivo) AND (Ordenes.ano = @ano)">
                    <SelectParameters>
                        <asp:Parameter Name="consecutivo" />
                        <asp:Parameter Name="ano" />
                    </SelectParameters>
                </asp:SqlDataSource>
    <br />
    Recorrido adicional de la unidad seleccionada:<br />
    <asp:GridView ID="grdOrdenComplementaria" runat="server" 
        AutoGenerateColumns="False" DataSourceID="sdsOrdenComplementario" 
        EnableModelValidation="True" SkinID="GridViewGreen">
        <Columns>
            <asp:BoundField DataField="orden" HeaderText="orden" ReadOnly="True" 
                SortExpression="orden" />
            <asp:BoundField DataField="nombre" HeaderText="nombre" 
                SortExpression="nombre" />
            <asp:BoundField DataField="ruta" HeaderText="ruta" SortExpression="ruta" />
            <asp:BoundField DataField="chofer" HeaderText="chofer" ReadOnly="True" 
                SortExpression="chofer" />
            <asp:BoundField DataField="economico" HeaderText="economico" 
                SortExpression="economico" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsOrdenComplementario" runat="server" 
        CancelSelectOnNullParameter="False" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + CONVERT (nvarchar, viajes.num_viaje) AS orden, 
dbo.empresas.nombre, 
dbo.llave_rutas.ruta, 
personas.primer_nombre + ' ' + personas.apellido_paterno AS chofer, 
equipo_operacion.economico, 
empleados.id_empleado, 
equipo_operacion.id_equipo, 
Ordenes.id_orden, 
equipo_asignado.id_equipo_asignado 
FROM 
	viajes
 INNER JOIN 
	Ordenes 
	ON viajes.id_orden = Ordenes.id_orden 
INNER JOIN 
	precios 
	ON viajes.id_relacion = precios.id_relacion 
INNER JOIN 
	dbo.empresas 
	ON precios.id_empresa = dbo.empresas.id_empresa 
INNER JOIN 
	dbo.llave_rutas 
	ON precios.id_ruta = dbo.llave_rutas.id_ruta 
INNER JOIN 
	equipo_operacion 
INNER JOIN 
	personas 
INNER JOIN 
	empleados 
ON personas.id_persona = empleados.id_persona AND 
personas.id_persona = empleados.id_persona AND 
personas.id_persona = empleados.id_persona 
INNER JOIN 
	equipo_asignado 
	ON empleados.id_empleado = equipo_asignado.idEmpleado 
	ON equipo_operacion.id_equipo = equipo_asignado.id_equipo 
	ON viajes.id_viaje = equipo_asignado.ViajeId 
WHERE 
id_equipo_asignado in 
(
SELECT     idEquipoAsignado
FROM         recorridoEquipo
WHERE     (grupo =@grupo) and
idEquipoAsignado&lt;&gt;@idEquipoAsignado
)">
        <SelectParameters>
            <asp:Parameter Name="grupo" />
            <asp:Parameter Name="idEquipoAsignado" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
                <br />
&nbsp;
<span 
                    style="color: #FF0000" __designer:mapid="5d">
                <asp:Label ID="lblMensaje2" runat="server" ForeColor="Red"></asp:Label>
                </span>
<asp:ValidationSummary ID="ValidationSummary1" runat="server" /> 

    <asp:Panel ID="Panel2" runat="server">
<table style="width: 100%">
        <tr>
            <td colspan="2">
               
                <br />
            </td>
        </tr>
                                <tr>
                                    <td class="auto-style4">
                                        Chofer:</td>
                                    <td class="auto-style5">
                                        <asp:Label ID="lblChofer" runat="server"></asp:Label>
                                    </td>
        </tr>
                                <tr>
                                    <td class="style14">
                                        Unidad:</td>
                                    <td class="style9">
                                        <asp:Label ID="lblUnidad" runat="server"></asp:Label>
                                    </td>
        </tr>
        <tr>
            <td class="style14">
                Eje de Regreso:</td>
            <td class="style9">
                <asp:DropDownList ID="ddlEjesRegreso" runat="server">
                    <asp:ListItem>2</asp:ListItem>
                    <asp:ListItem>3</asp:ListItem>
                    <asp:ListItem Selected="True">4</asp:ListItem>
                    <asp:ListItem>5</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
                                <tr>
                                    <td class="style14">
                                        Odometro Regreso:       <td class="style9">
                <asp:TextBox ID="txbOdometro" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"  Enabled="false"
                    ControlToValidate="txbOdometro" ErrorMessage="Ingrese el Odometro." ValidationGroup="odometro">*</asp:RequiredFieldValidator>
                <asp:RangeValidator ID="RangeValidator2" runat="server" Enabled="false"
                    ControlToValidate="txbOdometro" ErrorMessage="Solo se permiten numeros." 
                    MaximumValue="999999999999" MinimumValue="1" ValidationGroup="odometro">*</asp:RangeValidator>
            &nbsp;<asp:Label ID="lblOdometroSalida" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="btnGuardarOdometro" runat="server" Text="Guardar" 
                    SkinID="btnGuardar" ValidationGroup="odometro" />
            &nbsp;&nbsp;<asp:Label ID="lblAnuncio" runat="server" style="font-weight: 700" 
                    SkinID="lblMensaje"></asp:Label>
            &nbsp;
            </td>
        </tr>
        </table>
        <hr />
            <div>
                <br />
                Combustible<br /> <strong>Recarga en Base</strong><asp:GridView 
                    ID="grdRecargasInternas" runat="server" 
                    AutoGenerateColumns="False" DataKeyNames="id_recarga" 
                    DataSourceID="sdsRecargasInternas" SkinID="GridViewGreen">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" />
                        <asp:BoundField DataField="lts" SortExpression="lts" HeaderText="lts">
                        </asp:BoundField>
                        <asp:BoundField DataField="lugar" HeaderText="lugar" SortExpression="lugar" />
                        <asp:BoundField DataField="id_recarga" 
                            SortExpression="id_recarga" HeaderText="id_recarga" InsertVisible="False" ReadOnly="True">
                        </asp:BoundField>
                        <asp:BoundField DataField="fechaRecarga" HeaderText="fechaRecarga" SortExpression="fechaRecarga" />
                        <asp:CheckBoxField DataField="Parcial" HeaderText="Parcial" SortExpression="Parcial" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsRecargasInternas" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    DeleteCommand="DELETE FROM [recargas_combustible] WHERE [id_recarga] = @id_recarga" 
                    InsertCommand="INSERT INTO [recargas_combustible] ([id_orden], [id_lugar], [cantidad], [lts], [medio_pago], [ticket]) VALUES (@id_orden, @id_lugar, @cantidad, @lts, @medio_pago, @ticket)" 
                    SelectCommand="SELECT r.lts, l.lugar, r.id_recarga, r.fechaRecarga, r.Parcial FROM recargas_combustible AS r INNER JOIN lugares_recarga AS l ON r.id_lugar = l.id_lugar WHERE (r.grupo = @grupo) AND (l.id_lugar = 2)" 
                    
                    
                    
                    
                    
                    
                    UpdateCommand="UPDATE [recargas_combustible] SET [id_orden] = @id_orden, [id_lugar] = @id_lugar, [cantidad] = @cantidad, [lts] = @lts, [medio_pago] = @medio_pago, [ticket] = @ticket WHERE [id_recarga] = @id_recarga">
                    <DeleteParameters>
                        <asp:Parameter Name="id_recarga" Type="Int32" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hfldGrupo" Name="grupo" PropertyName="Value" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="id_orden" Type="Int32" />
                        <asp:Parameter Name="id_lugar" Type="Int32" />
                        <asp:Parameter Name="cantidad" Type="Double" />
                        <asp:Parameter Name="lts" Type="Double" />
                        <asp:Parameter Name="medio_pago" Type="Int32" />
                        <asp:Parameter Name="ticket" Type="String" />
                        <asp:Parameter Name="id_recarga" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="id_orden" Type="Int32" />
                        <asp:Parameter Name="id_lugar" Type="Int32" />
                        <asp:Parameter Name="cantidad" Type="Double" />
                        <asp:Parameter Name="lts" Type="Double" />
                        <asp:Parameter Name="medio_pago" Type="Int32" />
                        <asp:Parameter Name="ticket" Type="String" />
                    </InsertParameters>
                </asp:SqlDataSource><br />
                <strong>Recargas Externas</strong><asp:GridView ID="grdRecargasExternas" runat="server" 
                    AutoGenerateColumns="False" DataKeyNames="id_recarga" 
                    DataSourceID="sdsRecargasExternas" EnableModelValidation="True" SkinID="GridViewGreen">
                    <Columns>
                        <asp:CommandField SelectText="Delete" ShowSelectButton="True" />
                        <asp:BoundField DataField="id_recarga" InsertVisible="False" ReadOnly="True" SortExpression="id_recarga">
                        <ItemStyle Font-Size="0pt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="lts" HeaderText="lts" SortExpression="lts" />
                        <asp:BoundField DataField="lugar" HeaderText="lugar" SortExpression="lugar" />
                        <asp:BoundField DataField="monto" HeaderText="monto" 
                            SortExpression="monto" DataFormatString="{0:c2}" />
                        <asp:BoundField DataField="ticket" HeaderText="ticket" SortExpression="ticket" />
                        <asp:BoundField DataField="fechaRecarga" 
                            SortExpression="fechaRecarga" HeaderText="fecha">
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsRecargasExternas" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    
                    
                    
                    
                    
                    SelectCommand="SELECT 
r.lts, 
l.lugar, 
r.monto, 
r.ticket,
r.id_recarga,
r.fechaRecarga 
FROM 
recargas_combustible r
INNER JOIN 
lugares_recarga l
ON r.id_lugar = l.id_lugar 
WHERE r.grupo=@grupo
and l.id_lugar&lt;&gt;2">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hfldGrupo" Name="grupo" PropertyName="Value" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <hr />
                <div>
                    <strong>RECARGAS PARCIALES<br />
                    <br />
                    <marquee><span class="auto-style6">SI VA A CAPTURAR RECARGAS PARCIALES FAVOR DE MARCAR LA CASILLA DE RECARGA PARCIAL</span></marquee></strong></div>
                <br />
                Estación:<asp:DropDownList ID="ddlEstacion" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSource1" DataTextField="lugar" DataValueField="id_lugar">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT [id_lugar], [lugar] FROM [lugares_recarga]">
                </asp:SqlDataSource>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <table style="width: 270px; height: 422px;" id="mskVPesosCombustible">
                            <tr>
                                <td style="width: 96px">
                                    <strong>Recarga Parcial:</strong></td>
                                <td class="style7">
                                    <asp:CheckBox ID="ckbRecargaParcial" runat="server" />
                                    <asp:Label ID="lblParciales" runat="server" SkinID="lblMensaje"></asp:Label>
                                    <br />
                                    <asp:SqlDataSource ID="sqlUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:DataSourceConnectionString1 %>" SelectCommand="SELECT top 1 *
FROM recargas_combustible order by id_recarga desc" UpdateCommand="UPDATE recargas_combustible SET Parcial = '1' where id_recarga in (select top 1 id_recarga from recargas_combustible order by id_recarga desc)"></asp:SqlDataSource>
                                    <asp:SqlDataSource ID="sqlUpdate0" runat="server" ConnectionString="<%$ ConnectionStrings:DataSourceConnectionString1 %>" SelectCommand="SELECT top 1 *
FROM recargas_combustible order by id_recarga desc" UpdateCommand="UPDATE recargas_combustible SET Parcial = '0' where id_recarga in (select top 1 id_recarga from recargas_combustible order by id_recarga desc)"></asp:SqlDataSource>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 96px">
                                    Fecha</td>
                                <td class="style7">
                                    <asp:TextBox ID="txbFechaCarga" runat="server" ValidationGroup="recargas"></asp:TextBox>
                                    <asp:CalendarExtender ID="clrFechaCarga" format="yyyy/MM/dd" runat="server" TargetControlID="txbFechaCarga">
                                    </asp:CalendarExtender>
                                    <asp:RequiredFieldValidator ID="rfvFechaCarga" runat="server" ErrorMessage="Campo Obligatorio" ValidationGroup="recargas" ControlToValidate="txbFechaCarga"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 96px">Hora</td>
                                <td class="style7">
                                    <asp:TextBox ID="txbHoraCarga" runat="server" ValidationGroup="recargas" Width="138px" Height="16px" TextMode="Time"></asp:TextBox>
                                    hrs.
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvHoraCarga" runat="server" ErrorMessage="Campo Obligatorio" ValidationGroup="recargas" ControlToValidate="txbHoraCarga"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 96px">
                                    <asp:RadioButtonList ID="radioLitros" runat="server" Width="98px">
                                        <asp:ListItem Selected="True" Value="0">Litros</asp:ListItem>
                                        <asp:ListItem Value="1">Galones</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <td class="style7">
                                    <asp:TextBox ID="txbLitros" runat="server">0</asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 96px">
                                    Odometro</td>
                                <td class="style7">
                                    <asp:TextBox ID="txbOdometroRecarga" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvOdometroRecarga" runat="server" ValidationGroup="recargas" ErrorMessage="Campo Obligatorio" ControlToValidate="txbOdometroRecarga"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 96px">Cantidad:$</td>
                                <td class="style7">
                                    <asp:TextBox ID="txbPesosCombustible" runat="server">0</asp:TextBox>
                                      </td>
                            </tr>
                            <tr>
                                <td style="width: 96px">
                                    Ticket:</td>
                                <td class="style7">
                                    <asp:TextBox ID="txbTicketCombustible" runat="server">0</asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                    <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlEstacion" EventName="SelectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
                <br />
            </div>
            <div>
                &nbsp;<asp:Button ID="btnGuardarRecargas" runat="server" Text="Guardar" 
                    SkinID="btnGuardar" ValidationGroup="recargas" style="height: 26px" />
                                         
                                         &nbsp;<table border="1" cellspacing="0" class="style10">
                    <tr>
                        <td class="style11">
                            &nbsp;</td>
                        <td class="style12">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td class="style11">
                            Kms:</td>
                        <td class="style12">
                            <asp:Label ID="lblKms" runat="server" Text="0"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="style11">
                            Litros:&nbsp;&nbsp;</td>
                        <td class="style12">
                            <asp:Label ID="lblTotalLitros" runat="server" Text="0"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="style11">
                            Costo:&nbsp;
                        </td>
                        <td class="style12">
                            <asp:Label ID="lblPesosRecarga" runat="server" Text="0"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="style11">
                            Rendimiento:
                        </td>
                        <td class="style12">
                            <asp:Label ID="lblRendimiento" runat="server" Text="0"></asp:Label>
                            &nbsp;kms/lt
                        </td>
                    </tr>
                </table>
                <hr />
                
                
                <h1>Reporte de fallas:</h1><br />
                <asp:RadioButtonList ID="rbtnVehiculo" runat="server">
                    <asp:ListItem Selected="True" Value="0">Vehiculo</asp:ListItem>
                    <asp:ListItem Value="1">Caja</asp:ListItem>
                </asp:RadioButtonList>
                <br />&nbsp;<asp:TextBox ID="txbFalla" runat="server" 
                    Height="136px" TextMode="MultiLine" Width="659px"></asp:TextBox>
                <br />
                <br />
                <asp:Button ID="btnGuardarAveria" runat="server" Text="Registrar Falla" 
                    SkinID="btn" />
                <br />
                <br />
                <br />
                <asp:Button ID="txbFin" runat="server" SkinID="btn" Text="Evaluación Chofer" />
                &nbsp;
                <asp:Button ID="btnLiquidacion" runat="server" Text="Liquidación" SkinID="btn" />
                <br />
                <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
                <br />
                <br />
    </asp:Panel>

            </div>
            
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="Head">
    <style type="text/css">
        .style5
        {
            width: 14px;
        }
        .style6
        {
            width: 442px;
        }
        .style7
        {
            width: 128px;
        }
        .style8
        {
            width: 90px;
        }
        .style9
        {
            width: 84%;
        }
        .style10
        {
            width: 155px;
        }
        .style11
        {
            width: 92px;
        }
        .style12
        {
            width: 53px;
        }
        .style13
        {
            color: #009900;
        }
        .style14
        {
            width: 138px;
        }
        .auto-style4 {
            width: 138px;
            height: 22px;
        }
        .auto-style5 {
            width: 84%;
            height: 22px;
        }
        .auto-style6 {
            font-size: small;
            color: #FF0000;
            text-decoration: underline;
        }
    </style>
</asp:Content>

