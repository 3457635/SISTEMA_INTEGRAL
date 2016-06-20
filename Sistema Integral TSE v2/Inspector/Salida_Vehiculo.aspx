<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Salida_Vehiculo.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Salida_Vehículo" 
     %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Salida de viaje</h1>
    <p>
        Año:<asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
&nbsp;Consecutivo:
        <asp:TextBox ID="txbConsecutivo" runat="server"></asp:TextBox>
&nbsp; <asp:ImageButton ID="ibtnActualizar" runat="server" SkinID="ibtnActualizar" 
            style="height: 16px" ValidationGroup="orden" />
        &nbsp;<asp:TextBox ID="txbIdOrden" runat="server" Visible="False"></asp:TextBox>
        <asp:TextBox ID="txbEquipoAsignadoId" runat="server" Visible="False"></asp:TextBox>
        <asp:HiddenField ID="hfldGrupo" runat="server" />
        <asp:RequiredFieldValidator ID="rfvAño" runat="server" ControlToValidate="txbAno" ErrorMessage="Ingrese el Año" ValidationGroup="orden"></asp:RequiredFieldValidator>
&nbsp;<asp:RequiredFieldValidator ID="rfvConsecutivo" runat="server" ControlToValidate="txbConsecutivo" ErrorMessage="Ingrese el Consecutivo" ValidationGroup="orden"></asp:RequiredFieldValidator>
    </p>
    <p>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="id_equipo_asignado" DataSourceID="sdsOrden" 
            EnableModelValidation="True" SkinID="GridViewGreen">
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                            CommandName="Select" Text="Seleccionar"></asp:LinkButton>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                            CommandName="Update" Text="Update"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                            CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="id_equipo_asignado" InsertVisible="False" 
                    ReadOnly="True" SortExpression="id_equipo_asignado">
                <ItemStyle Font-Size="0pt" />
                </asp:BoundField>
                <asp:BoundField DataField="ano" HeaderText="ORDEN" InsertVisible="False" 
                    ReadOnly="True" SortExpression="ano" />
                <asp:BoundField DataField="consecutivo" InsertVisible="False" ReadOnly="True" 
                    SortExpression="consecutivo" />
                <asp:BoundField DataField="num_viaje" ReadOnly="True" 
                    SortExpression="num_viaje" />
                <asp:BoundField DataField="nombre" HeaderText="EMPRESA" ReadOnly="True" 
                    SortExpression="nombre" />
                <asp:BoundField DataField="ruta" HeaderText="RUTA" ReadOnly="True" 
                    SortExpression="ruta" />
                <asp:TemplateField HeaderText="TRAYECTO" SortExpression="Column1">
                    <ItemTemplate>
                        <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" 
                            DataSourceID="sdsTrayecto" EnableModelValidation="True" SkinID="grdAnidado">
                            <Columns>
                                <asp:BoundField DataField="trayecto" HeaderText="trayecto" 
                                    SortExpression="trayecto" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsTrayecto" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                            SelectCommand="SELECT llave_trayectos.trayecto FROM trayectos_asignados INNER JOIN llave_trayectos ON trayectos_asignados.id_trayecto = llave_trayectos.id_trayecto WHERE (trayectos_asignados.EquipoAsignadoId = @idEquipoAsignado)">
                            <SelectParameters>
                                <asp:Parameter Name="idEquipoAsignado" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="primer_nombre" HeaderText="CHOFER" ReadOnly="True" 
                    SortExpression="primer_nombre" />
                <asp:BoundField DataField="apellido_paterno" ReadOnly="True" 
                    SortExpression="apellido_paterno" />
                <asp:TemplateField HeaderText="UNIDAD" SortExpression="id_equipo">
                    <ItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" 
                            DataSourceID="SqlDataSource1" DataTextField="economico" 
                            DataValueField="id_equipo" Enabled="False" 
                            SelectedValue='<%# Bind("id_equipo") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                            SelectCommand="SELECT [economico], [id_equipo] FROM [equipo_operacion]">
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList2" runat="server" 
                            DataSourceID="SqlDataSource1" DataTextField="economico" 
                            DataValueField="id_equipo" SelectedValue='<%# Bind("id_equipo") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                            SelectCommand="SELECT [economico], [id_equipo] FROM [equipo_operacion] WHERE (([id_status] = @id_status) AND ([id_tipo_equipo] &lt; @id_tipo_equipo)) ORDER BY [economico]">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                                <asp:Parameter DefaultValue="107" Name="id_tipo_equipo" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </EditItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsOrden" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"             
            UpdateCommand="UPDATE [equipo_asignado] SET [id_equipo] = @id_equipo WHERE [id_equipo_asignado] = @id_equipo_asignado"
            SelectCommand="SELECT 
	Ord.ano, 
	Ord.consecutivo, 
	vi.num_viaje, 
	emp.nombre, 
	llr.ruta, 
	pe.primer_nombre, 
	pe.apellido_paterno, 
	ea.id_equipo_asignado, 
	ea.id_equipo 
	FROM 
		personas pe
	INNER JOIN 
		empleados em
		ON pe.id_persona = em.id_persona 
	INNER JOIN 
		equipo_asignado ea
		ON em.id_empleado = ea.idEmpleado 
	INNER JOIN 
		equipo_operacion eo
		ON ea.id_equipo = eo.id_equipo 
	INNER JOIN 
		Ordenes ord
	INNER JOIN 
		viajes vi
		ON Ord.id_orden = vi.id_orden 
	INNER JOIN 
		precios pr
		ON vi.id_relacion = pr.id_relacion 
	INNER JOIN 
		dbo.llave_rutas llr
		ON pr.id_ruta = llr.id_ruta 
	INNER JOIN 
		dbo.empresas emp
		ON pr.id_empresa = emp.id_empresa 
		ON ea.ViajeId = vi.id_viaje 
	WHERE 
	ord.ano=@ano and
	ord.consecutivo=@consecutivo" 
                       >
            <SelectParameters>
                <asp:ControlParameter ControlID="txbAno" Name="ano" PropertyName="Text" />
                <asp:ControlParameter ControlID="txbConsecutivo" Name="consecutivo" 
                    PropertyName="Text" />
            </SelectParameters>

            <UpdateParameters>
            <asp:Parameter Name="id_equipo" Type="Int32" />               
            <asp:Parameter Name="id_equipo_asignado" Type="Int32" />
            </UpdateParameters>

        </asp:SqlDataSource>
       
    </p>
    <p>
        <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
    </p>
    <div>
        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="id_equipo_asignado" DataSourceID="sdsChoferes" 
            EnableModelValidation="True" SkinID="GridViewGreen">
            <Columns>
                <asp:CommandField ShowEditButton="True" EditText="Modificar" />
                <asp:BoundField DataField="id_equipo_asignado" InsertVisible="False" ReadOnly="True" 
                    SortExpression="id_asignacion">
                <ItemStyle Font-Size="0pt" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="CHOFER" SortExpression="id_empleado">
                    <ItemTemplate>
                        <asp:DropDownList ID="ddlChoferes" runat="server" DataSourceID="sdsChoferesI" 
                            DataTextField="chofer" DataValueField="id_empleado" 
                            SelectedValue='<%# Bind("idEmpleado") %>' Enabled="False">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsChoferesI" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT personas.primer_nombre+' '+personas.apellido_paterno  as chofer, empleados.id_empleado FROM empleados INNER JOIN personas ON empleados.id_persona = personas.id_persona 
order by primer_nombre, apellido_paterno"></asp:SqlDataSource>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList4" runat="server" 
                            DataSourceID="sdsChoferesEdit" DataTextField="chofer" 
                            DataValueField="id_empleado" SelectedValue='<%# Bind("idEmpleado") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsChoferesEdit" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                            SelectCommand="SELECT personas.primer_nombre + ' ' + personas.apellido_paterno AS chofer, empleados.id_empleado FROM empleados INNER JOIN personas ON empleados.id_persona = personas.id_persona
where personas.id_status=5
order by primer_nombre, apellido_paterno 
">
                        </asp:SqlDataSource>
                    </EditItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsChoferes" runat="server" 
            CancelSelectOnNullParameter="False" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
             SelectCommand="SELECT equipo_asignado.id_equipo_asignado, equipo_asignado.idEmpleado, equipo_asignado.ViajeId FROM personas INNER JOIN empleados ON personas.id_persona = empleados.id_persona INNER JOIN equipo_asignado ON empleados.id_empleado = equipo_asignado.idEmpleado INNER JOIN viajes INNER JOIN Ordenes ON viajes.id_orden = Ordenes.id_orden ON equipo_asignado.ViajeId = viajes.id_viaje WHERE (Ordenes.ano = @ano) AND (Ordenes.consecutivo = @consecutivo) ORDER BY personas.primer_nombre" 
            
            
            UpdateCommand="UPDATE [equipo_asignado] SET [idEmpleado] = @idEmpleado WHERE [id_equipo_asignado] = @id_equipo_asignado">
            
            <SelectParameters>
                <asp:Parameter Name="ano" />
                <asp:Parameter Name="consecutivo" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="idEmpleado" Type="Int32" />
                <asp:Parameter Name="id_equipo_asignado" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="sdsUltimoOdometro" EnableModelValidation="True" 
            ShowHeader="False">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text="Ultimo Odometro"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="odometro" HeaderText="odometro" 
                    SortExpression="odometro" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsUltimoOdometro" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            
            
            
            SelectCommand="SELECT TOP (1) odometro FROM Odometros WHERE (id_equipo = @idEquipo) order by odometro desc">
            <SelectParameters>
                <asp:Parameter Name="idEquipo" />
            </SelectParameters>
        </asp:SqlDataSource>
        
    </p><hr />
        <h1>Datos de salida</h1>
    <table style="width: 100%">
        <tr>
            <td class="style11">
                Chofer:</td>
            <td class="style12">
                <asp:Label ID="lblChofer" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style11">
                Unidad:</td>
            <td class="style12">
                <asp:Label ID="lblUnidad" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style11">
                Ejes al salir:</td>
            <td class="style12">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Always">
                    <ContentTemplate>
                        <asp:DropDownList ID="ddlEjesSalida" runat="server">
                            <asp:ListItem>2</asp:ListItem>
                            <asp:ListItem>3</asp:ListItem>
                            <asp:ListItem Selected="True">4</asp:ListItem>
                            <asp:ListItem>5</asp:ListItem>
                        </asp:DropDownList>
                    </ContentTemplate>
                   
                </asp:UpdatePanel>

            </td>
        </tr>
        <tr>
            <td class="style11">
                Odometro de salida:</td>
            <td class="style12">
                <asp:TextBox ID="txbOdometro" runat="server"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;<asp:RequiredFieldValidator ID="rfvOdometro" runat="server" ControlToValidate="txbOdometro" ErrorMessage="Campo Obligatorio" ValidationGroup="odometro"></asp:RequiredFieldValidator>
            </td>
        </tr>
        </table>
    <asp:Button ID="btnGuardar" runat="server" Text="Guardar Salida" ValidationGroup="odometro" />
    <hr />
    <h1>Registro de fallas</h1>
    
    <asp:Button ID="btnGuardarFalla" runat="server" Text="Registrar Falla" />
    <br />
    Se detecto alguna avería antes de iniciar el viaje;<br />
    <asp:RadioButtonList ID="RadioButtonList1" runat="server">
        <asp:ListItem Selected="True" Value="0">Vehiculo</asp:ListItem>
        <asp:ListItem Value="1">Caja</asp:ListItem>
    </asp:RadioButtonList>
    <asp:Label ID="lblMensajeFallas" runat="server" SkinID="lblMensaje"></asp:Label>
    <br />
    <asp:TextBox ID="txbAveria" runat="server" Height="131px" TextMode="MultiLine" 
        Width="612px"></asp:TextBox>
    <br />
    <br />
    <br />
    <br />
    Verifique los siguientes puntos:
        </tr>
        <tr>
            <td class="style6">
                Visa Laser</td>
            <td class="style8">
                Carta Porte</td>
        </tr>
        <tr>
            <td class="style6">
                &nbsp;</td>
            <td class="style8">
                3 Triángulos</td>
        </tr>
        <tr>
            <td class="style6">
                &nbsp;</td>
            <td class="style8">
                Focos y fusibles de respuesto</td>
        </tr>
        <tr>
            <td class="style6">
                &nbsp;</td>
            <td class="style8">
                Herramientas</td>
        </tr>
    </table>
    </asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="Head">
    <style type="text/css">
        .style11
        {
            width: 142px;
        }
        .style12
        {
            width: 86%;
        }
        </style>
</asp:Content>

