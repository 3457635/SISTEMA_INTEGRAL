<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="RevisionViajes.aspx.vb" Inherits="Sistema_Integral_TSE_v45.RevisionViajes" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register src="../Controles_Usuario/ctlViajesHechos.ascx" tagname="ctlViajesHechos" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
<h1>Revisión de Bitacora</h1>
    <br />
    Año:
    <asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
&nbsp;Consecutivo:
    <asp:TextBox ID="txbOrden" runat="server"></asp:TextBox>
&nbsp;<br />
    <hr /><br />
    Por Fecha.<br />
    Desde: 
    <asp:TextBox ID="txbFechaInicio" runat="server"></asp:TextBox><asp:CalendarExtender
        ID="CalendarExtender1" TargetControlID="txbFechaInicio" Format="yyyy/MM/dd" runat="server">
    </asp:CalendarExtender>
&nbsp; Hasta:
    <asp:TextBox ID="txbFechaFin" runat="server"></asp:TextBox><asp:CalendarExtender
        ID="CalendarExtender2"  TargetControlID="txbFechaFin" Format="yyyy/MM/dd" runat="server">
    </asp:CalendarExtender>
&nbsp;<br />
    <br />
    Por cliente:
    <asp:DropDownList ID="ddlEmpresa" runat="server" AppendDataBoundItems="True" 
        DataSourceID="sdsClientes" DataTextField="nombre" DataValueField="id_empresa">
        <asp:ListItem Value="0">Todos...</asp:ListItem>
    </asp:DropDownList>
    &nbsp;<asp:SqlDataSource ID="sdsClientes" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        SelectCommand="SELECT id_empresa, nombre FROM dbo.empresas WHERE (id_status = 5) AND (id_tipo_empresa = 1) ORDER BY nombre">
    </asp:SqlDataSource>
    <asp:Button ID="btnBuscar" runat="server" SkinID="btn" Text="Buscar" />
    <asp:Button ID="btnDescargar" runat="server" Text="Descargar" SkinID="btnGuardar" />
    <asp:WebPartManager ID="WebPartManager1" runat="server">
    </asp:WebPartManager>
    <asp:WebPartZone ID="WebPartZone1" runat="server" SkinID="wprtProfesional" >
    </asp:WebPartZone>
    <asp:Label ID="lblMensaje" runat="server"></asp:Label>
    <br />
    <br />
    <asp:TextBox ID="txbQuery" runat="server" Visible="False"></asp:TextBox>
    <hr />
    <h1>Observaciones a ordenes</h1>
    <table>
        <tr>
            <td>No. Orden</td><td>Año</td><td align="center">Observación</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txtOrden" runat="server" Width="151px"></asp:TextBox>
            </td><td>
                <asp:TextBox ID="txtAnoObservacion" runat="server"></asp:TextBox>
            </td><td>
                <asp:TextBox ID="txtComentario" runat="server" Width="656px"></asp:TextBox>
            </td>
        </tr>
        <tr><td colspan="2" align="center">
            <asp:Label ID="Label2" runat="server"></asp:Label>
            <asp:Button ID="Button1" runat="server" Text="Guardar observación" />
            </td></tr>
    </table>
    <hr />
    
    <br />
    <br />
    <br />
    <h1>Resultados de búsqueda</h1>
    <asp:GridView ID="GridView1" runat="server"  SkinID="GridViewGreen"
        AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="id_viaje" emptydatatext="No data available." 
         PageSize="50" DataSourceID="SqlDataSource1" >
        
        <Columns>
            <asp:TemplateField InsertVisible="False" 
                SortExpression="id_viaje">
                <EditItemTemplate>
                    <asp:Label ID="Label1" Visible="false" runat="server" Text='<%# Eval("id_viaje") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblIdViaje" Visible="False" runat="server" 
                        Text='<%# Bind("id_viaje") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="REMISIÓN">
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox2" runat="server" OnCheckedChanged="CheckBox2_CheckedChanged" AutoPostBack="True" Checked='<%# Bind("remision") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="observaciones" HeaderText="OBSERVACIÓN" />
            <asp:TemplateField HeaderText="CANCELADAS">
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/imagenes/cancel.png" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="FACTURA">
                <ItemTemplate>
                    <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" 
                        DataSourceID="sdsFactura" EnableModelValidation="True" GridLines="None" 
                        ShowHeader="False">
                        <Columns>
                            <asp:BoundField DataField="folio" HeaderText="folio" SortExpression="folio" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsFactura" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        
                        SelectCommand="SELECT facturas.folio FROM facturas INNER JOIN facturacion ON facturas.id_factura = facturacion.id_factura INNER JOIN viajes ON facturacion.id_viaje = viajes.id_viaje WHERE (facturas.Cancelada = 0) AND (viajes.id_viaje = @id_viaje)">
                        <SelectParameters>
                            <asp:Parameter Name="id_viaje" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="VERIFICACIÓN">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("verificado") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    
                    <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="True" 
                        Checked='<%# Bind("verificado") %>' 
                        oncheckedchanged="CheckBox1_CheckedChanged1" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="orden" HeaderText="ORDEN" ReadOnly="True" 
                SortExpression="orden" />
            <asp:BoundField DataField="nombre" HeaderText="CLIENTE" 
                SortExpression="nombre" />
            <asp:BoundField DataField="ruta" HeaderText="RUTA" SortExpression="ruta" />
            <asp:BoundField DataField="fecha" 
                HeaderText="FECHA SERVICIO" SortExpression="fecha" 
                DataFormatString="{0:d}" />
            <asp:TemplateField HeaderText="CHOFER">
                <ItemTemplate>
                    <asp:GridView ID="GridView2" runat="server" EnableModelValidation="True" 
                        ShowHeader="False" BorderStyle="None" GridLines="None" 
                        AutoGenerateColumns="False" DataSourceID="sdsChoferes">
                        <Columns>
                            <asp:BoundField DataField="chofer" HeaderText="Expr1" ReadOnly="True" 
                                SortExpression="Expr1" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsChoferes" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="choferesPorViaje" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter Name="id_viaje" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ItemTemplate>
                <ItemStyle Width="10%" />
            </asp:TemplateField>
            <asp:BoundField DataField="equipo" HeaderText="EQUIPO SOLICITADO" />
            <asp:TemplateField HeaderText="UNIDAD">
                <ItemTemplate>
                    <asp:GridView ID="GridView3" runat="server" BorderStyle="None" GridLines="None" 
                        ShowHeader="False">
                    </asp:GridView>
                </ItemTemplate>
                <ItemStyle Width="10%" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="CAJA">
                <ItemTemplate>
                    <asp:GridView ID="GridView4" runat="server" GridLines="None" ShowHeader="False">
                    </asp:GridView>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="TRAYECTO">
                <ItemTemplate>
                    <asp:GridView ID="GridView5" runat="server" GridLines="None" ShowHeader="False">
                    </asp:GridView>
                </ItemTemplate>
                <ItemStyle Width="20%" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="RECOLECCIONES">
                <ItemTemplate>
                    <asp:Label ID="lblRecolecciones" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
        
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        
        
        SelectCommand="listarViajes" SelectCommandType="StoredProcedure" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:Parameter DefaultValue="" Name="ano" Type="Int32" />
            <asp:Parameter DefaultValue="" Name="consecutivo" Type="Int32" />
            <asp:Parameter DbType="Date" Name="inicio" />
            <asp:Parameter DbType="Date" Name="fin" />
            <asp:Parameter DefaultValue="" Name="idCliente" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    </asp:Content>
  
