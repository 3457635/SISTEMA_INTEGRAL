<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="salidaVehiculo2.aspx.vb" Inherits="Sistema_Integral_TSE_v45.salidaVehiculo2" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register src="../Controles_Usuario/ctlMapa.ascx" tagname="ctlMapa" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .style5
        {
            width: 458px;
        }
        .style6
        {
            width: 54px;
        }
        .style8
        {
            width: 275px;
        }
        .style9
        {
            width: 211px;
        }
        .style10
        {
            width: 176px;
        }
        .style12
        {
            width: 272px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <H1>Salida de Vehiculo</H1>

    <table class="style8">
        <tr>
            <td class="style6">
                &nbsp;</td>
            <td class="style9">
                <asp:LinkButton ID="lnkModificar" runat="server">Modificar unidad asignada.</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td class="style6">
                Chofer:</td>
            <td class="style9">
                <asp:DropDownList ID="ddlChofer" runat="server" DataSourceID="sdsChofer" 
                    DataTextField="chofer" DataValueField="id_empleado" Width="150px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsChofer" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    
                    SelectCommand="SELECT personas.primer_nombre + ' ' + personas.apellido_paterno AS chofer, empleados.id_empleado FROM empleados INNER JOIN personas ON empleados.id_persona = personas.id_persona WHERE (personas.id_status = 5) ORDER BY personas.primer_nombre, personas.apellido_materno">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style6">
                Unidad:</td>
            <td class="style9">
                <asp:DropDownList ID="ddlUnidad" runat="server" DataSourceID="sdsUnidad" 
                    DataTextField="economico" DataValueField="id_equipo" Width="150px" 
                    AutoPostBack="True">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsUnidad" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT [economico], [id_equipo] FROM [equipo_operacion] WHERE (([id_status] = @id_status) AND ([id_tipo_equipo] &lt; @id_tipo_equipo)) ORDER BY [economico]">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                        <asp:Parameter DefaultValue="107" Name="id_tipo_equipo" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style6">
                Ejes:</td>
            <td class="style9">
                <asp:DropDownList ID="ddlEjesSalida" runat="server">
                    <asp:ListItem Value="4">4 Ejes</asp:ListItem>
                    <asp:ListItem Value="5">5 Ejes</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style6">
                Odometro:</td>
            <td class="style9">
                <asp:TextBox ID="txbOdometro" runat="server"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txbOdometro" Display="Dynamic" ErrorMessage="*" 
                    SetFocusOnError="True" ValidationGroup="odometro">Campo Obligatorio</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style6">
                &nbsp;</td>
            <td class="style9">
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="id_odometro" DataSourceID="sdsOdometroSalida" 
                    EnableModelValidation="True">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" />
                        <asp:BoundField DataField="id_odometro" InsertVisible="False" ReadOnly="True" 
                            SortExpression="id_odometro">
                        <ItemStyle Font-Size="0pt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="odometro" HeaderText="Odometros registrados:" 
                            SortExpression="odometro" />
                        <asp:BoundField DataField="inspector" HeaderText="Inspector" 
                            SortExpression="inspector" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsOdometroSalida" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    DeleteCommand="DELETE FROM [Odometros] WHERE [id_odometro] = @id_odometro" 
                    InsertCommand="INSERT INTO [Odometros] ([odometro], [inspector]) VALUES (@odometro, @inspector)" 
                    SelectCommand="SELECT [odometro], [id_odometro], [inspector] FROM [Odometros] WHERE (([idOrden] = @idOrden) AND ([tipo_trayecto] = @tipo_trayecto)) AND id_equipo=@idEquipo" 
                    
                    UpdateCommand="UPDATE [Odometros] SET [odometro] = @odometro, [inspector] = @inspector WHERE [id_odometro] = @id_odometro">
                    <DeleteParameters>
                        <asp:Parameter Name="id_odometro" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="odometro" Type="Int32" />
                        <asp:Parameter Name="inspector" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:Parameter Name="idOrden" Type="Int32" />
                        <asp:Parameter DefaultValue="1" Name="tipo_trayecto" Type="Int32" />
                        <asp:Parameter Name="idEquipo" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="odometro" Type="Int32" />
                        <asp:Parameter Name="inspector" Type="String" />
                        <asp:Parameter Name="id_odometro" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style6">
                &nbsp;</td>
            <td class="style9">
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
            </td>
        </tr>
    </table>
    Se detecto alguna avería en la unidad antes de iniciar el viaje;

    <br />
    <asp:TextBox ID="txbAveria" runat="server" Height="150px" TextMode="MultiLine" 
        Width="688px"></asp:TextBox>
    <br />
    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" 
        ValidationGroup="odometro" />
    <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
    &nbsp;<br />
    <br />

    <asp:ModalPopupExtender ID="mdlOrdenes" runat="server" 
        BackgroundCssClass="modalBackground" BehaviorID="mdlOrdenes" 
        PopupControlID="Panel1" TargetControlID="Button1">
    </asp:ModalPopupExtender>
    <asp:Panel ID="Panel1" runat="server" BackColor="White" Height="300px" 
    ScrollBars="Vertical">
        <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
        <br />
        <asp:Button ID="btnCerrar" runat="server" Text="Cerrar" />
    </asp:Panel>
    <br />
     <asp:Button ID="Button1" runat="server" />
     Verifique los siguientes puntos:<br />
    <table class="style5">
        <tr class="style13">
            <td class="style10" bgcolor="#009900">
                Chofer</td>
            <td class="style12" bgcolor="#009900">
                Unidad</td>
        </tr>
        <tr>
            <td class="style10">
                Licencia Federal</td>
            <td class="style12">
                Tarjetas de Circulación (Caja y Unidad)</td>
        </tr>
        <tr>
            <td class="style10">
                Licencia Estatal</td>
            <td class="style12">
                Seg. Mexicano</td>
        </tr>
        <tr>
            <td class="style10">
                Gafete Aduana Mexicana</td>
            <td class="style12">
                Seg. Americano</td>
        </tr>
        <tr>
            <td class="style10">
                Visa Laser</td>
            <td class="style12">
                Carta Porte</td>
        </tr>
        <tr>
            <td class="style10">
                &nbsp;</td>
            <td class="style12">
                3 Triángulos</td>
        </tr>
        <tr>
            <td class="style10">
                &nbsp;</td>
            <td class="style12">
                Focos y fusibles de respuesto</td>
        </tr>
        <tr>
            <td class="style10">
                &nbsp;</td>
            <td class="style12">
                Herramientas</td>
        </tr>
    </table>
</asp:Content>
