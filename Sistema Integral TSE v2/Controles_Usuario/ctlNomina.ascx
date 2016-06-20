<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlNomina.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlNomina" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<p>
    
    &nbsp;</p>

<p>
        Desde:
        <asp:TextBox ID="txbFecha1" runat="server"></asp:TextBox><asp:CalendarExtender ID="CalendarExtender1"
            runat="server" TargetControlID="txbFecha1" Format="dd/MM/yyyy" >
        </asp:CalendarExtender>
&nbsp;-
        Hasta:
        <asp:TextBox ID="txbFecha2" runat="server"></asp:TextBox><asp:CalendarExtender ID="CalendarExtender2"
            runat="server" TargetControlID="txbFecha2" Format="dd/MM/yyyy" >
        </asp:CalendarExtender>
    &nbsp;<asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnActualizar" 
            style="width: 14px; height: 16px;" />
    </p>

<p>
    &nbsp;</p>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    EnableModelValidation="True" SkinID="GridView1" ShowFooter="True">
    <Columns>
        <asp:BoundField DataField="id_viaje">
        <ItemStyle Font-Size="0pt" Width="0px" />
        </asp:BoundField>
        <asp:BoundField DataField="orden" HeaderText="ORDEN" />
        <asp:BoundField DataField="nombre" HeaderText="CLIENTE" />
        <asp:BoundField DataField="ruta" HeaderText="RUTA" />
        <asp:TemplateField HeaderText="CHOFER">
            <ItemTemplate>
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="sdsChofer" EnableModelValidation="True" SkinID="grdAnidado">
                    <Columns>
                        <asp:BoundField DataField="Column1" HeaderText="Column1" ReadOnly="True" 
                            SortExpression="Column1" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsChofer" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    SelectCommand="SELECT personas.primer_nombre + ' ' + personas.apellido_paterno AS Expr1 FROM empleados INNER JOIN personas ON empleados.id_persona = personas.id_persona INNER JOIN equipo_asignado ON empleados.id_empleado = equipo_asignado.idEmpleado INNER JOIN viajes ON equipo_asignado.ViajeId = viajes.id_viaje WHERE (viajes.id_viaje = @id_viaje)">
                    <SelectParameters>
                        <asp:Parameter Name="id_viaje" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="VEHICULO">
            <ItemTemplate>
                <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="sdsVehiculo" EnableModelValidation="True" SkinID="grdAnidado">
                    <Columns>
                        <asp:BoundField DataField="equipo" HeaderText="equipo" 
                            SortExpression="equipo" />
                        <asp:BoundField DataField="economico" HeaderText="economico" 
                            SortExpression="economico" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsVehiculo" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    
                    SelectCommand="SELECT tipo_equipos.equipo, equipo_operacion.economico FROM equipo_asignado INNER JOIN equipo_operacion ON equipo_asignado.id_equipo = equipo_operacion.id_equipo INNER JOIN tipo_equipos ON equipo_operacion.id_tipo_equipo = tipo_equipos.id_tipo_equipo WHERE (equipo_asignado.ViajeId = @viajeId)">
                    <SelectParameters>
                        <asp:Parameter Name="viajeId" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="TARIFA">
            <ItemTemplate>
                <asp:GridView ID="grdTarifa" runat="server" AutoGenerateColumns="False" 
                    EnableModelValidation="True" GridLines="None" ShowHeader="False">
                    <Columns>
                        <asp:BoundField DataField="tarifa" DataFormatString="{0:c0}" />
                    </Columns>
                </asp:GridView>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="margen" HeaderText="MARGEN %" />
    </Columns>
</asp:GridView>


