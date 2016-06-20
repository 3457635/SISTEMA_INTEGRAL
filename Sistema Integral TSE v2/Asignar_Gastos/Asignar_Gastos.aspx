<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Asignar_Gastos.aspx.vb"
    Inherits="Sistema_Integral_TSE_v45.Asignar_Gastos" Title="Untitled Page" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        Asignar Gastos
    </div>
    <div>
        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" AutoGenerateColumns="False"
            DataKeyNames="id_orden" CellPadding="4" ForeColor="#333333" 
            GridLines="None" EnableModelValidation="True">
            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="ORDEN" HeaderText="ORDEN" ReadOnly="True" SortExpression="ORDEN" />
                <asp:BoundField DataField="RUTA" HeaderText="RUTA" SortExpression="RUTA" />
                <asp:BoundField DataField="TRAYECTO" HeaderText="TRAYECTO" 
                    SortExpression="TRAYECTO" />
                <asp:BoundField DataField="CLIENTE" HeaderText="CLIENTE" 
                    SortExpression="CLIENTE" />
                <asp:BoundField DataField="CHOFER" HeaderText="CHOFER" ReadOnly="True" 
                    SortExpression="CHOFER" />
                <asp:BoundField DataField="ECONOMICO" HeaderText="ECONOMICO" 
                    SortExpression="ECONOMICO" />
                <asp:BoundField DataField="EQUIPO" HeaderText="EQUIPO" 
                    SortExpression="EQUIPO" />
                <asp:BoundField DataField="id_orden" HeaderText="id_orden" 
                    InsertVisible="False" ReadOnly="True" SortExpression="id_orden" />
            </Columns>
            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#999999" />
            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
            
            SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + CONVERT (nvarchar, viajes.num_viaje) AS ORDEN, dbo.llave_rutas.ruta AS RUTA, llave_trayectos.trayecto AS TRAYECTO, dbo.empresas.nombre AS CLIENTE, personas.primer_nombre + ' ' + personas.apellido_paterno AS CHOFER, equipo_operacion.economico AS ECONOMICO, tipo_equipos.equipo AS EQUIPO, Ordenes.id_orden FROM Ordenes INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN recursos_asignados ON viajes.id_viaje = recursos_asignados.id_viaje INNER JOIN llave_trayectos ON recursos_asignados.id_trayecto = llave_trayectos.id_trayecto INNER JOIN equipo_asignado ON recursos_asignados.id_asignacion = equipo_asignado.id_asignacion INNER JOIN equipo_operacion ON equipo_asignado.id_equipo = equipo_operacion.id_equipo INNER JOIN empleados ON recursos_asignados.id_empleado = empleados.id_empleado INNER JOIN personas ON empleados.id_persona = personas.id_persona INNER JOIN precios ON viajes.id_relacion = precios.id_relacion INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN dbo.llave_rutas ON llave_trayectos.id_ruta = dbo.llave_rutas.id_ruta AND llave_trayectos.id_ruta = dbo.llave_rutas.id_ruta AND precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN tipo_equipos ON equipo_operacion.id_tipo_equipo = tipo_equipos.id_tipo_equipo AND equipo_operacion.id_tipo_equipo = tipo_equipos.id_tipo_equipo AND equipo_operacion.id_tipo_equipo = tipo_equipos.id_tipo_equipo WHERE (Ordenes.id_status = 2) ">
        </asp:SqlDataSource>
    </div>
    <asp:Label ID="lblOrden" runat="server" Text=""></asp:Label>
    <div>
        <asp:Button ID="btnGancho" runat="server" Enabled="False" Text="" />
       
        <asp:ModalPopupExtender ID="mdlGastos" runat="server" TargetControlID="btnGancho"
            PopupControlID="pnlGastos" BackgroundCssClass="modalBackground">
        </asp:ModalPopupExtender>
        <asp:Panel ID="pnlGastos" runat="server" BackColor="white" ScrollBars="vertical" >
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                <asp:GridView ID="grdOrdenDetalle" runat="server" 
                        DataSourceID="DataSourceOrdenDetalle" AutoGenerateColumns="False" 
                        DataKeyNames="id_orden" EnableModelValidation="True" >
                    <Columns>
                        <asp:BoundField DataField="ORDEN" HeaderText="ORDEN" ReadOnly="True" 
                            SortExpression="ORDEN" />
                        <asp:BoundField DataField="RUTA" HeaderText="RUTA" 
                            SortExpression="RUTA" />
                        <asp:BoundField DataField="TRAYECTO" HeaderText="TRAYECTO" 
                            SortExpression="TRAYECTO" />
                        <asp:BoundField DataField="CLIENTE" HeaderText="CLIENTE" 
                            SortExpression="CLIENTE" />
                        <asp:BoundField DataField="CHOFER" HeaderText="CHOFER" ReadOnly="True" 
                            SortExpression="CHOFER" />
                        <asp:BoundField DataField="ECONOMICO" HeaderText="ECONOMICO" 
                            SortExpression="ECONOMICO" />
                        <asp:BoundField DataField="EQUIPO" HeaderText="EQUIPO" 
                            SortExpression="EQUIPO" />
                        <asp:BoundField DataField="id_orden" HeaderText="id_orden" 
                            InsertVisible="False" ReadOnly="True" SortExpression="id_orden" />
                    </Columns>
                    </asp:GridView>
                <asp:SqlDataSource ID="DataSourceOrdenDetalle" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                
                        
                        SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + CONVERT (nvarchar, viajes.num_viaje) AS ORDEN, dbo.llave_rutas.ruta AS RUTA, llave_trayectos.trayecto AS TRAYECTO, dbo.empresas.nombre AS CLIENTE, personas.primer_nombre + ' ' + personas.apellido_paterno AS CHOFER, equipo_operacion.economico AS ECONOMICO, tipo_equipos.equipo AS EQUIPO, Ordenes.id_orden FROM Ordenes INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN recursos_asignados ON viajes.id_viaje = recursos_asignados.id_viaje INNER JOIN llave_trayectos ON recursos_asignados.id_trayecto = llave_trayectos.id_trayecto INNER JOIN equipo_asignado ON recursos_asignados.id_asignacion = equipo_asignado.id_asignacion INNER JOIN equipo_operacion ON equipo_asignado.id_equipo = equipo_operacion.id_equipo INNER JOIN empleados ON recursos_asignados.id_empleado = empleados.id_empleado INNER JOIN personas ON empleados.id_persona = personas.id_persona INNER JOIN precios ON viajes.id_relacion = precios.id_relacion INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN dbo.llave_rutas ON llave_trayectos.id_ruta = dbo.llave_rutas.id_ruta AND llave_trayectos.id_ruta = dbo.llave_rutas.id_ruta AND precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN tipo_equipos ON equipo_operacion.id_tipo_equipo = tipo_equipos.id_tipo_equipo AND equipo_operacion.id_tipo_equipo = tipo_equipos.id_tipo_equipo AND equipo_operacion.id_tipo_equipo = tipo_equipos.id_tipo_equipo WHERE ordenes.id_orden=@id_orden">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" Name="id_orden" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                    </asp:SqlDataSource>
                
                
                    <table style="width: 221px">
                        <tr>
                            <td style="width: 6px">
                                Cantidad:
                            </td>
                            <td style="width: 128px">
                                <asp:TextBox ID="txbCantidad" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvCantidad" runat="server" ErrorMessage="El campo cantidad es obligatorio"
                                    Text="*" ControlToValidate="txbCantidad" Display="Dynamic">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 6px">
                                Moneda:
                            </td>
                            <td style="width: 128px">
                                <asp:DropDownList ID="ddlMoneda" runat="server" DataSourceID="SqlDataSourceMoneda"
                                    DataTextField="moneda" DataValueField="id_moneda">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSourceMoneda" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                                    SelectCommand="Select id_moneda,moneda From Moneda"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 6px">
                                &nbsp;
                            </td>
                            <td style="width: 128px">
                                <asp:Button ID="btnGuardarGastos" runat="server" Text="Guardar" />
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div>
                        <asp:GridView ID="grdGastos" runat="server" AutoGenerateColumns="False" DataKeyNames="id_gasto"
                            DataSourceID="SqlDataSource2">
                            <Columns>
                                <asp:CommandField ShowDeleteButton="True" />
                                <asp:BoundField DataField="id_gasto" HeaderText="id_gasto" InsertVisible="False"
                                    ReadOnly="True" SortExpression="id_gasto" />
                                <asp:BoundField DataField="concepto" HeaderText="concepto" SortExpression="concepto" />
                                <asp:BoundField DataField="cantidad" HeaderText="cantidad" SortExpression="cantidad" />
                                <asp:BoundField DataField="moneda" HeaderText="moneda" SortExpression="moneda" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                            DeleteCommand="DELETE FROM [gastos_asignados] WHERE [id_gasto] = @id_gasto" SelectCommand="SELECT gastos_asignados.id_gasto, gastos_asignados.concepto, gastos_asignados.cantidad, Moneda.moneda FROM gastos_asignados INNER JOIN Moneda ON gastos_asignados.id_moneda = Moneda.id_moneda WHERE gastos_asignados.id_orden=@id_orden">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="GridView1" Name="id_orden" PropertyName="SelectedValue" />
                            </SelectParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="id_gasto" Type="Int32" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                        <asp:Button ID="btnCerrar" runat="server" Text="Cerrar" ValidationGroup="false" />
                </ContentTemplate>
            </asp:UpdatePanel>
            
        </asp:Panel>
    </div>
    
</asp:Content>
