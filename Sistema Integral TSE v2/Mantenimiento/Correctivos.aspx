<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Correctivos.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Correctivos" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Charting" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .style5
        {
            width: 156px;
        }
        .style7
        {
            width: 142px;
        }
        .style9
        {
            width: 4px;
        }
        .style10
        {
            width: 142px;
            height: 38px;
        }
        .style11
        {
            width: 4px;
            height: 38px;
        }
        .style12
        {
            width: 142px;
            height: 24px;
        }
        .style13
        {
            width: 4px;
            height: 24px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Mantenimientos Correctivos</h1>
    <p><strong>Reportes de Fallas<asp:WebPartManager ID="WebPartManager1" 
            runat="server">
        </asp:WebPartManager>
        </strong></p>
    <asp:WebPartZone ID="WebPartZone1" runat="server" SkinID="wprtProfesional">
    </asp:WebPartZone>
    <p>
        <asp:GridView ID="GridView2" runat="server" DataSourceID="sdsCorrectivos" AutoGenerateColumns="False" 
            DataKeyNames="ReporteId" AllowPaging="True" SkinID="GridViewGreen">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:CommandField ShowDeleteButton="True" />
                <asp:BoundField DataField="ReporteId" SortExpression="ReporteId" 
                    InsertVisible="False" ReadOnly="True" >
                <ItemStyle Font-Size="0pt" Width="0px" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="FECHA">
                    <ItemTemplate>
                        <asp:Label ID="lblFecha" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CheckBoxField DataField="salida" HeaderText="FALLA AL SALIR?" 
                    SortExpression="salida" />
                <asp:BoundField DataField="falla" HeaderText="FALLA" 
                    SortExpression="falla" />
                <asp:TemplateField HeaderText="CHOFER">
                    <ItemTemplate>
                        <asp:Label ID="lblChofer" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="TIPO EQUIPO">
                    <ItemTemplate>
                        <asp:Label ID="lblTipoEquipo" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="ENONOMICO">
                    <ItemTemplate>
                        <asp:Label ID="lblEconomico" runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsCorrectivos" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            
            
            
            
            
            SelectCommand="SELECT 
	reportes_fallas.ReporteId, 
	reportes_fallas.falla, 
	reportes_fallas.salida,
	 reportes_fallas.idEquipo,
	 reportes_fallas.idOrden, 
	reportes_fallas.idChofer
 FROM 
	reportes_fallas
where (idEstatus is null or idEstatus=5) and fecha &gt; dateadd(m,-6, getdate())

order by ReporteId desc" DeleteCommand="DELETE FROM reportes_fallas WHERE (ReporteId = @id)">
            <DeleteParameters>
                <asp:Parameter Name="id" />
            </DeleteParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:TextBox ID="txbIdReporte" runat="server" Visible="False"></asp:TextBox>
    </p>
    
    <hr /><h1>Registrar correctivos</h1>
    <table class="style5">
        <tr>
            <td class="style12">
                &nbsp;</td>
            <td class="style13">
                <asp:Button ID="btnNuevo" runat="server" SkinID="btn" Text="Nuevo" />
            </td>
        </tr>
        <tr>
            <td class="style12">
                Reporte:</td>
            <td class="style13">
                <asp:Label ID="lblFalla" runat="server" Text="Sin Reporte"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style12">
                Vehiculo:</td>
            <td class="style13">
                <asp:DropDownList ID="ddlVehiculo" runat="server" DataSourceID="sdsVehiculo" 
                    DataTextField="economico" DataValueField="id_equipo">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsVehiculo" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT [economico], [id_equipo] FROM [equipo_operacion] WHERE (([id_status] = @id_status) AND ([id_tipo_equipo] &lt;= @id_tipo_equipo)) ORDER BY [economico]">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                        <asp:Parameter DefaultValue="106" Name="id_tipo_equipo" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style10">
                Caja:</td>
            <td class="style11">
                <asp:DropDownList ID="ddlCaja" runat="server" DataSourceID="sdsCaja" 
                    DataTextField="economico" DataValueField="id_equipo">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsCaja" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT [economico], [id_equipo] FROM [equipo_operacion] WHERE (([id_status] = @id_status) AND ([id_tipo_equipo] &gt; @id_tipo_equipo)) ORDER BY [economico]">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                        <asp:Parameter DefaultValue="106" Name="id_tipo_equipo" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style10">
                Costo:</td>
            <td class="style11">
                <asp:TextBox ID="txbCosto" runat="server"></asp:TextBox>
                <asp:Label ID="lblCosto" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style7">
                Odometro:</td>
            <td class="style9">
                <asp:TextBox ID="txbOdometro" runat="server"></asp:TextBox>
                <asp:Label ID="lblOdometro" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style7">
                Fecha:</td>
            <td class="style9">
                <asp:TextBox ID="txbFecha" runat="server"></asp:TextBox>
                <asp:CalendarExtender ID="txbFecha_CalendarExtender" runat="server" 
                    Enabled="True" Format="dd/MM/yyyy" TargetControlID="txbFecha">
                </asp:CalendarExtender>
                <asp:Label ID="lblFecha" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style7">
                Lugar:</td>
            <td class="style9">
                <asp:DropDownList ID="ddlLugar" runat="server" Height="16px" Width="133px">
                    <asp:ListItem>x-56</asp:ListItem>
                    <asp:ListItem>Externo</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style7">
                Tipo de Reparación:</td>
            <td class="style9">
                <asp:DropDownList ID="ddlReparacion" runat="server" 
                    DataSourceID="sdsReparacion" DataTextField="reparacion" DataValueField="id" 
                    Height="16px" Width="132px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsReparacion" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    SelectCommand="SELECT [reparacion], [id] FROM [Tipo_reparacion] WHERE ([correctivo] = @correctivo)">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="True" Name="correctivo" Type="Boolean" />
                    </SelectParameters>
                </asp:SqlDataSource>

                </td>
            </tr>
        <tr><td></td><td>
                <asp:Panel ID="Panel1" runat="server" BackColor="White">
                
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                        <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                    </ContentTemplate> 
                    </asp:UpdatePanel>
                    <asp:Button ID="btnCerrar" runat="server" Text="Cerrar" />
                </asp:Panel>
                
               

                <asp:LinkButton ID="lnkReparaciones" runat="server">+ Reparaciones</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td class="style7">
                Comentarios:</td>
            <td class="style9">
                <asp:TextBox ID="txbComentarios" runat="server" Height="139px" 
                    TextMode="MultiLine" Width="453px"></asp:TextBox>
                <asp:Label ID="lblComentarios" runat="server" ForeColor="Red"></asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" SkinID="btnGuardar" />
&nbsp;<asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
    
    
    <hr /><h1>Consultar correctivos</h1>
&nbsp;<p>
        Equipo:
        <asp:DropDownList ID="ddlEquipo" runat="server" DataSourceID="sds" 
            DataTextField="equipo" DataValueField="id_equipo" Height="16px" Width="133px">
        </asp:DropDownList>
        <asp:SqlDataSource ID="sds" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="SELECT equipo_operacion.id_equipo, equipo_operacion.economico + '(' + tipo_equipos.equipo + ')' AS equipo FROM equipo_operacion INNER JOIN tipo_equipos ON equipo_operacion.id_tipo_equipo = tipo_equipos.id_tipo_equipo WHERE (equipo_operacion.id_status = 5)">
        </asp:SqlDataSource>
        &nbsp;</p>
    <p>
        <asp:Button ID="btnBuscar" runat="server" SkinID="btn" Text="Buscar" />
    </p>
    <p>
        <strong>Reparaciones Realizadas</strong></p>
    <asp:GridView ID="GridView3" runat="server" AllowPaging="True" 
        AutoGenerateColumns="False" DataKeyNames="idReparacion" 
        DataSourceID="sdsReparacionesHechas" SkinID="GridViewGreen">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" />
            <asp:BoundField DataField="idReparacion" 
                InsertVisible="False" ReadOnly="True" SortExpression="idReparacion" >
            <ItemStyle Font-Size="0pt" />
            </asp:BoundField>
            <asp:BoundField DataField="odometro" HeaderText="ODOMETRO" 
                SortExpression="odometro" />
            <asp:BoundField DataField="fecha" HeaderText="FECHA" SortExpression="fecha" />
            <asp:BoundField DataField="lugar" HeaderText="LUGAR" SortExpression="lugar" />
            <asp:BoundField DataField="comentarios" HeaderText="COMENTARIOS" 
                SortExpression="comentarios" />
            <asp:BoundField DataField="costo" HeaderText="COSTO" SortExpression="costo" />
            <asp:BoundField DataField="tipo_reparacion" HeaderText="TIPO REPARACION" 
                SortExpression="tipo_reparacion" Visible="False" />
            <asp:TemplateField HeaderText="TIPO REPARACION">
                <ItemTemplate>
                    <asp:Label ID="lblTipoReparacion" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="TIPO EQUIPO">
                <ItemTemplate>
                    <asp:Label ID="lblTipoEquipo" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="EQUIPO" SortExpression="idEquipo">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("idEquipo") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblEquipo" runat="server" Text='<%# Bind("idEquipo") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="REPORTE" SortExpression="idReporte">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("idReporte") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblFalla" runat="server" Text='<%# Bind("idReporte") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsReparacionesHechas" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        DeleteCommand="DELETE FROM [reparaciones] WHERE [idReparacion] = @idReparacion" 
        InsertCommand="INSERT INTO [reparaciones] ([odometro], [fecha], [lugar], [comentarios], [costo], [tipo_reparacion], [idEquipo], [idReporte]) VALUES (@odometro, @fecha, @lugar, @comentarios, @costo, @tipo_reparacion, @idEquipo, @idReporte)" 
        SelectCommand="SELECT * FROM [reparaciones] WHERE idEquipo=isnull(@idEquipo,idEquipo) order by idReporte desc" 
        
        UpdateCommand="UPDATE [reparaciones] SET [odometro] = @odometro, [fecha] = @fecha, [lugar] = @lugar, [comentarios] = @comentarios, [costo] = @costo, [tipo_reparacion] = @tipo_reparacion, [idEquipo] = @idEquipo, [idReporte] = @idReporte WHERE [idReparacion] = @idReparacion" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:Parameter Name="idEquipo" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="idReparacion" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="odometro" Type="Int32" />
            <asp:Parameter Name="fecha" Type="DateTime" />
            <asp:Parameter Name="lugar" Type="String" />
            <asp:Parameter Name="comentarios" Type="String" />
            <asp:Parameter Name="costo" Type="Decimal" />
            <asp:Parameter Name="tipo_reparacion" Type="Int32" />
            <asp:Parameter Name="idEquipo" Type="Int32" />
            <asp:Parameter Name="idReporte" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="odometro" Type="Int32" />
            <asp:Parameter Name="fecha" Type="DateTime" />
            <asp:Parameter Name="lugar" Type="String" />
            <asp:Parameter Name="comentarios" Type="String" />
            <asp:Parameter Name="costo" Type="Decimal" />
            <asp:Parameter Name="tipo_reparacion" Type="Int32" />
            <asp:Parameter Name="idEquipo" Type="Int32" />
            <asp:Parameter Name="idReporte" Type="Int32" />
            <asp:Parameter Name="idReparacion" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <p>
        &nbsp;</p>
</asp:Content>
