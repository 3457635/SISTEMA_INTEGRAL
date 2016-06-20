<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="registroFalla.aspx.vb" Inherits="Sistema_Integral_TSE_v45.registroFalla" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
    <style type="text/css">

        .style5
        {
            width: 156px;
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
        .style7
        {
            width: 142px;
        }
        .style9
        {
            width: 4px;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<h1>Registro de Reparaciones</h1>
    <table class="style5">
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
&nbsp;</td>
        </tr>
        <tr>
            <td class="style12">
                Caja:</td>
            <td class="style13">
                <asp:DropDownList ID="ddlCaja" runat="server" DataSourceID="sdsCaja" 
                    DataTextField="economico" DataValueField="id_equipo">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsCaja" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT [economico], [id_equipo] FROM [equipo_operacion] WHERE (([id_tipo_equipo] &gt; @id_tipo_equipo) AND ([id_status] = @id_status)) ORDER BY [economico]">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="106" Name="id_tipo_equipo" Type="Int32" />
                        <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style10">
                Costo:</td>
            <td class="style11">
                <asp:TextBox ID="txbCosto" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style7">
                Odometro:</td>
            <td class="style9">
                <asp:TextBox ID="txbOdometro" runat="server"></asp:TextBox>
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
            </td>
        </tr>
        <tr>
            <td class="style7">
                &nbsp;</td>
            <td class="style9">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
            &nbsp;<asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
            </td>
        </tr>
    </table>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="idReparacion" DataSourceID="sdsReparaciones" 
        EnableModelValidation="True">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            <asp:BoundField DataField="idReparacion" InsertVisible="False" ReadOnly="True" 
                SortExpression="idReparacion" />
            <asp:BoundField DataField="fecha" DataFormatString="{0:d}" HeaderText="FECHA" 
                SortExpression="fecha" />
            <asp:BoundField DataField="odometro" HeaderText="ODOMETRO" 
                SortExpression="odometro" />
            <asp:BoundField DataField="lugar" HeaderText="LUGAR" SortExpression="lugar" />
            <asp:BoundField DataField="costo" HeaderText="COSTO" SortExpression="costo" />
            <asp:TemplateField HeaderText="TIPO REPARACION" 
                SortExpression="tipo_reparacion">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlTipoReparaciones" runat="server" 
                        DataSourceID="sdsTipoReparacion" DataTextField="reparacion" DataValueField="id" 
                        SelectedValue='<%# Bind("tipo_reparacion") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsTipoReparacion" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [reparacion], [id] FROM [Tipo_reparacion]">
                    </asp:SqlDataSource>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server" 
                        DataSourceID="sdsTipoReparacion" DataTextField="reparacion" DataValueField="id" 
                        Enabled="False" SelectedValue='<%# Bind("tipo_reparacion") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsTipoReparacion" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [reparacion], [id] FROM [Tipo_reparacion] WHERE ([correctivo] = @correctivo)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="true" Name="correctivo" Type="Boolean" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="comentarios" HeaderText="COMENTARIOS" 
                SortExpression="comentarios" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsReparaciones" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        DeleteCommand="DELETE FROM [reparaciones] WHERE [idReparacion] = @idReparacion" 
        InsertCommand="INSERT INTO [reparaciones] ([odometro], [fecha], [lugar], [comentarios], [costo], [tipo_reparacion]) VALUES (@odometro, @fecha, @lugar, @comentarios, @costo, @tipo_reparacion)" 
        SelectCommand="SELECT reparaciones.idReparacion, reparaciones.odometro, reparaciones.fecha, reparaciones.lugar, reparaciones.comentarios, reparaciones.costo, reparaciones.tipo_reparacion FROM reparaciones INNER JOIN fallasSinReporte ON reparaciones.idReparacion = fallasSinReporte.idReparacion" 
        UpdateCommand="UPDATE [reparaciones] SET [odometro] = @odometro, [fecha] = @fecha, [lugar] = @lugar, [comentarios] = @comentarios, [costo] = @costo, [tipo_reparacion] = @tipo_reparacion WHERE [idReparacion] = @idReparacion">
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
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="odometro" Type="Int32" />
            <asp:Parameter Name="fecha" Type="DateTime" />
            <asp:Parameter Name="lugar" Type="String" />
            <asp:Parameter Name="comentarios" Type="String" />
            <asp:Parameter Name="costo" Type="Decimal" />
            <asp:Parameter Name="tipo_reparacion" Type="Int32" />
            <asp:Parameter Name="idReparacion" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
