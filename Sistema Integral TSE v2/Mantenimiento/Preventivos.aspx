<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Preventivos.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Preventivos" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
   
    
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Mantenimientos Preventivos    </h1>
    <p>&nbsp;</p>
    <p>Tipo de Equipo:<asp:DropDownList ID="DropDownList1" runat="server" 
            AutoPostBack="True" DataSourceID="sqlTiposEquipos" DataTextField="equipo" 
            DataValueField="id_tipo_equipo">
        </asp:DropDownList>
        <asp:SqlDataSource ID="sqlTiposEquipos" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="SELECT [id_tipo_equipo], [equipo] FROM [tipo_equipos]">
        </asp:SqlDataSource>
    </p>
    <p>Unidad:<asp:DropDownList ID="ddlUnidad" runat="server" 
            DataSourceID="sqlUnidades" DataTextField="unidad" 
            DataValueField="id_equipo" AutoPostBack="True">
        </asp:DropDownList>
        <asp:SqlDataSource ID="sqlUnidades" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="SELECT equipo_operacion.id_equipo, equipo_operacion.economico + ' ' + marcas.marca AS unidad FROM equipo_operacion INNER JOIN marcas ON equipo_operacion.id_marca = marcas.id_marca WHERE (equipo_operacion.id_tipo_equipo = @id_tipo_equipo) order by equipo_operacion.economico">
            <SelectParameters>
                <asp:ControlParameter ControlID="DropDownList1" Name="id_tipo_equipo" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" 
        DataSourceID="sdsPreventivos" EnableModelValidation="True" ForeColor="Red" Visible="False">
        <Columns>
            <asp:BoundField DataField="economico" HeaderText="Unidad" 
                SortExpression="economico" />
            <asp:BoundField DataField="diferencia" 
                HeaderText="kilometros restantes siguiente servicio." ReadOnly="True" 
                SortExpression="diferencia" />
        </Columns>
        <RowStyle ForeColor="Red" />
    </asp:GridView>
    <asp:SqlDataSource ID="sdsPreventivos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand=" SELECT eo.economico,p1.proximoServicio- ds.odometro as diferencia from 
 preventivos  p1
 cross apply (
 select top 1 odometro
 from odometros 
 where odometros.id_equipo=p1.id_equipo
 order by id_odometro desc
 ) as ds
 inner join equipo_operacion eo on p1.id_equipo=eo.id_equipo
 where id in (select max(id) from preventivos p2 group by p2.id_equipo) and p1.proximoServicio- ds.odometro&lt;2000
  order by eo.economico"></asp:SqlDataSource>
    <p>&nbsp;</p>
    <hr />
    <h1>Registrar preventivo</h1>
    <p>Para la unidad
        <asp:Label ID="lblEconomico" runat="server"></asp:Label>
&nbsp;</p>
    <table cellpadding="0" cellspacing="0" border="1" class="style2">
        <tr>
            <td>
                Fecha</td>
            <td>
                Lugar</td>
            <td class="style5">
                Tipo de Reparación</td>
            <td>
                Odometro</td>
            <td>
                Siguiente Servicio:</td>
            <td>
                Costo</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txbFecha" runat="server" Width="200px"></asp:TextBox>
                <asp:CalendarExtender ID="CalendarExtender1" runat="server" 
                    TargetControlID="txbFecha" Format="dd/MM/yyyy">
                </asp:CalendarExtender>
            </td>
            <td>
                <asp:TextBox ID="txbLugar" runat="server"></asp:TextBox>
            </td>
            <td class="style5">
                <asp:DropDownList ID="ddlTipoReparacion" runat="server" 
                    DataSourceID="sqlTipoReparacion" DataTextField="reparacion" 
                    DataValueField="id" AutoPostBack="True">
                </asp:DropDownList>
                <asp:LinkButton ID="lnkAgregar" runat="server">+ Agregar</asp:LinkButton>
                <asp:SqlDataSource ID="sqlTipoReparacion" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    SelectCommand="SELECT [reparacion], [id] FROM [Tipo_reparacion] WHERE ([correctivo] = @correctivo)">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="false" Name="correctivo" Type="Boolean" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
                <asp:TextBox ID="txbOdometro" runat="server" ValidationGroup="preventivos"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="txbOdometro" ErrorMessage="*" ValidationGroup="Preventivos">Campo Requerido</asp:RequiredFieldValidator>
            </td>
            <td>
                <asp:TextBox ID="txbSiguienteServicio" runat="server"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txbSiguienteServicio" ErrorMessage="*" 
                    ValidationGroup="Preventivos">Campos Requeridos</asp:RequiredFieldValidator>
            </td>
            <td>
                <asp:TextBox ID="txbCosto" runat="server"></asp:TextBox>
            </td>
        </tr>
    </table>
    <table class="style4">
        <tr>
            <td class="style3">
                Comentarios:</td>
        </tr>
        <tr>
            <td class="style3">
                <asp:TextBox ID="txbComentarios" runat="server" Height="109px" TextMode="MultiLine" 
                    Width="424px" MaxLength="250"></asp:TextBox>
            </td>
        </tr>
    </table>
    <asp:Button ID="btnGuadar" runat="server" Text="Guardar" 
        ValidationGroup="Preventivos" />
    <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
    <br />
    <hr />
    <h1>Consulta de preventivos</h1>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        DataSourceID="sqlPreventivos" EnableModelValidation="True" PageSize="50" 
        AutoGenerateColumns="False" DataKeyNames="idReparacion" SkinID="GridViewGreen">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" DeleteText="Eliminar" 
                EditText="Modificar" ShowEditButton="True" />
            <asp:BoundField DataField="idReparacion" SortExpression="idReparacion" ReadOnly="True" >
            <ItemStyle Font-Size="0pt" />
            </asp:BoundField>
            <asp:BoundField DataField="fecha" HeaderText="FECHA" 
                SortExpression="fecha" />
            <asp:BoundField DataField="lugar" HeaderText="LUGAR" 
                SortExpression="lugar" />
            <asp:BoundField DataField="odometro" HeaderText="ODOMETRO" 
                SortExpression="odometro" />
            <asp:TemplateField HeaderText="TIPO REPARACION" 
                SortExpression="tipo_reparacion">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList3" runat="server" 
                        DataSourceID="sdsREparaciones" DataTextField="reparacion" DataValueField="id" 
                        Height="18px" SelectedValue='<%# Bind("tipo_reparacion") %>' Width="186px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsREparaciones" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [reparacion], [id] FROM [Tipo_reparacion] WHERE (([idEstatus] = @idEstatus) AND ([correctivo] = @correctivo))">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="5" Name="idEstatus" Type="Int32" />
                            <asp:Parameter DefaultValue="False" Name="correctivo" Type="Boolean" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:DropDownList ID="DropDownList2" runat="server" 
                        DataSourceID="sdsReparaciones" DataTextField="reparacion" DataValueField="id" 
                        Enabled="False" Height="19px" 
                        SelectedValue='<%# Bind("tipo_reparacion") %>' Width="197px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsReparaciones" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT * FROM [Tipo_reparacion]"></asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="comentarios" HeaderText="COMENTARIOS" 
                SortExpression="comentarios" />
            <asp:BoundField DataField="costo" DataFormatString="{0:c}" HeaderText="COSTO" 
                SortExpression="costo" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sqlPreventivos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        
        
        SelectCommand="SELECT 
reparaciones.odometro, 
reparaciones.fecha, 
reparaciones.costo,
reparaciones.lugar, 
reparaciones.comentarios, 
equipo_operacion.economico, 
reparaciones.idReparacion, reparaciones.tipo_reparacion FROM equipo_operacion INNER JOIN preventivos ON equipo_operacion.id_equipo = preventivos.id_equipo INNER JOIN reparaciones ON preventivos.id_reparacion = reparaciones.idReparacion WHERE (equipo_operacion.id_equipo = @id_equipo) ORDER BY reparaciones.fecha DESC" 
        DeleteCommand="DELETE FROM [reparaciones] WHERE [idReparacion] = @idReparacion" 
        InsertCommand="INSERT INTO [reparaciones] ([idReparacion], [odometro], [fecha], [lugar], [comentarios], [id_equipo], [tipo_reparacion]) VALUES (@id, @odometro, @fecha, @lugar, @comentarios, @id_equipo, @tipo_reparacion)" 
                       
        
        
        
        UpdateCommand="UPDATE [reparaciones] SET [odometro] = @odometro, [fecha] = @fecha, [lugar] = @lugar, [comentarios] = @comentarios,  [tipo_reparacion] = @tipo_reparacion, [costo]=@costo WHERE [idReparacion] = @idReparacion">
        <DeleteParameters>
            <asp:Parameter Name="idReparacion" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="id" />
            <asp:Parameter Name="odometro" Type="Int32" />
            <asp:Parameter Name="fecha" Type="DateTime" />
            <asp:Parameter Name="lugar" Type="String" />
            <asp:Parameter Name="comentarios" Type="String" />
            <asp:Parameter Name="id_equipo" />
            <asp:Parameter Name="tipo_reparacion" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlUnidad" Name="id_equipo" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="odometro" Type="Int32" />
            <asp:Parameter Name="fecha" Type="DateTime" />
            <asp:Parameter Name="lugar" Type="String" />
            <asp:Parameter Name="comentarios" Type="String" />
            <asp:Parameter Name="tipo_reparacion" Type="Int32" />
            <asp:Parameter Name="idReparacion" Type="Int32" />           
            <asp:Parameter Name="coston" Type="decimal" />       
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:Button ID="btnPrueba" runat="server" />

    <br />
    <asp:ModalPopupExtender ID="mdlPopup" runat="server" 
        TargetControlID="btnPrueba" PopupControlID="Panel1" 
        BackgroundCssClass="modalBackground" Drag="True">
    </asp:ModalPopupExtender>
    <asp:Panel ID="Panel1" runat="server" BackColor="White">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>

            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Button ID="btnCerrar" runat="server" Text="Cerrar" 
            CausesValidation="False" />
    </asp:Panel>
    <br />

</asp:Content>
