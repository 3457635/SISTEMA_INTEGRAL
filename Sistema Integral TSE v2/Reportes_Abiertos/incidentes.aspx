<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="incidentes.aspx.vb" Inherits="Sistema_Integral_TSE_v45.incidentes" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <script type="text/javascript">

        var UpdatePanel1 = '<%=UpdatePanel1.ClientID%>';

        function ShowItems() {
            if (UpdatePanel1 != null) {
                __doPostBack(UpdatePanel1, '');
            }
        }

    </script>
    <style type="text/css">
        .style5 {
            width: 887px;
            height: 348px;
        }

        .style6 {
        }

        .style9 {
            width: 221px;
        }

        .style10 {
            width: 656px;
        }

        .auto-style1 {
            height: 15.0pt;
            width: 237pt;
            color: black;
            font-size: 11.0pt;
            font-weight: 700;
            font-style: normal;
            text-decoration: none;
            font-family: Calibri, sans-serif;
            text-align: center;
            vertical-align: bottom;
            white-space: nowrap;
            border-style: none;
            border-color: inherit;
            border-width: medium;
            padding-left: 1px;
            padding-right: 1px;
            padding-top: 1px;
        }

        .auto-style2 {
            height: 15.0pt;
            color: black;
            font-size: 11.0pt;
            font-weight: 400;
            font-style: normal;
            text-decoration: none;
            font-family: Calibri, sans-serif;
            text-align: center;
            vertical-align: bottom;
            white-space: nowrap;
            border-style: none;
            border-color: inherit;
            border-width: medium;
            padding-left: 1px;
            padding-right: 1px;
            padding-top: 1px;
        }

        .gridTexto {
            text-align: center;
            margin-left: 50%;
        }

        .auto-style3 {
            color: black;
            font-size: 11.0pt;
            font-weight: 400;
            font-style: normal;
            text-decoration: none;
            font-family: Calibri, sans-serif;
            text-align: left;
            vertical-align: bottom;
            white-space: nowrap;
            border-style: none;
            border-color: inherit;
            border-width: medium;
            padding-left: 1px;
            padding-right: 1px;
            padding-top: 1px;
        }
        .auto-style6 {
            width: 241px;
        }
        .auto-style7 {
            width: 317px;
        }
        .auto-style8 {
            width: 239px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Registro de Incidentes</h1>
    <p>
        <asp:Label ID="lblFechaSer" runat="server"></asp:Label>
    </p>
    <asp:HiddenField runat="server" ID="hflIdRole"></asp:HiddenField>


    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:DataGrid ID="dgCuadrantes" runat="server" DataSourceID="sdsTabla" CellPadding="4" ForeColor="#333333" GridLines="None" Visible="False">
                <AlternatingItemStyle BackColor="White" />
                <EditItemStyle BackColor="#7C6F57" />
                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                <ItemStyle BackColor="#E3EAEB" />
                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                <SelectedItemStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
            </asp:DataGrid>
            <asp:SqlDataSource ID="sdsTabla" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString %>" SelectCommand="Cuadrante_Por_Roles" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:Parameter Name="cRoleId" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>



    <table class="sample">
        <tr>
            <th></th>
            <th>Urgente</th>
            <th>No Urgente</th>
            <tr>
                <td>Importante</td>
                <td>
                    <asp:Label ID="cd1" runat="server"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="cd2" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>No importante</td>
                <td>
                    <asp:Label ID="cd3" runat="server"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="cd4" runat="server"></asp:Label>
                </td>
            </tr>
        </tr>
    </table>

    <a href="http://es.zimagez.com/zimage/cuadrantes.php" target="_blank" title="Foto alojada por zimagez.com">
        <img src="http://es.zimagez.com/miniature/cuadrantes.jpg" alt="Foto alojada por zimagez.com" />
    </a>
    <asp:SqlDataSource ID="sdsIncidente" runat="server" SelectCommand="SELECT (SELECT	COUNT(cuadrante) from incidentes i join aspnet_roles r ON i.Roleid = r.Roleid  where fechaRespuesta IS NULL AND r.rolename = 'Administrador' AND idestatus =1 and cuadrante = 1) as C1,
	(SELECT	COUNT(cuadrante) from incidentes i join aspnet_roles r ON i.Roleid = r.Roleid  where fechaRespuesta IS NULL AND r.rolename = 'Administrador' AND idestatus =1 and cuadrante = 2) as C2,
	(SELECT	COUNT(cuadrante) from incidentes i join aspnet_roles r ON i.Roleid = r.Roleid  where fechaRespuesta IS NULL AND r.rolename = 'Administrador' AND idestatus =1 and cuadrante = 3) as C3,
	(SELECT	COUNT(cuadrante) from incidentes i join aspnet_roles r ON i.Roleid = r.Roleid  where fechaRespuesta IS NULL AND r.rolename = 'Administrador' AND idestatus =1 and cuadrante = 4) as C4"></asp:SqlDataSource>
    <br />





    <br />
    <br />
    <br />
    <asp:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="1">

        <asp:TabPanel ID="nuevo" runat="server" HeaderText="Nuevo Incidente">
            <ContentTemplate>
                <br />
                <table class="style5">
                    <tr>
                        <td class="style9">Incidente</td>
                        <td class="style10">
                            <asp:TextBox ID="txbIncidente" runat="server" Height="24px" Width="367px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="style9">Fecha de Incidente</td>
                        <td class="style10">
                            <asp:TextBox ID="txbFechaIncidente" runat="server"></asp:TextBox><asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy"
                                TargetControlID="txbFechaIncidente" Enabled="True">
                            </asp:CalendarExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="style9">Fecha Propuesta de Respuesta</td>
                        <td class="style10">
                            <asp:TextBox ID="txbFechaPropuesta" runat="server"></asp:TextBox><asp:CalendarExtender ID="txbFechaPropuesta_CalendarExtender" runat="server" Format="dd/MM/yyyy"
                                Enabled="True" TargetControlID="txbFechaPropuesta">
                            </asp:CalendarExtender>
                        </td>
                    </tr>
                    <tr>
                        <td class="style9">Departamento</td>
                        <td class="style10">
                            <asp:DropDownList ID="ddlDepartamento" runat="server" Height="18px"
                                Width="201px" DataSourceID="sdsRoles" DataTextField="RoleName"
                                DataValueField="RoleId">
                            </asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td>Tipo de incidente</td>
                        <td>
                            <asp:DropDownList ID="comboTipoIncidente" runat="server" DataSourceID="sdsTipoIncidente" DataTextField="tipo_incidente" DataValueField="id_tipo_incidente"></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td class="style9">Tiempo estimado (hrs)</td>
                        <td class="style10">
                            <asp:TextBox ID="txtTiempoEstimado" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="style9">Importancia</td>
                        <td class="style10">
                            <asp:DropDownList ID="ddlImportancia" runat="server">
                                <asp:ListItem Value="1"></asp:ListItem>
                                <asp:ListItem Value="2"></asp:ListItem>
                                <asp:ListItem Value="3"></asp:ListItem>
                                <asp:ListItem Value="4"></asp:ListItem>
                            </asp:DropDownList><table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse; width: 237pt"
                                width="317">
                                <colgroup>
                                    <col style="mso-width-source: userset; mso-width-alt: 3474; width: 71pt" width="95" />
                                    <col style="mso-width-source: userset; mso-width-alt: 4205; width: 86pt" width="115" />
                                    <col style="mso-width-source: userset; mso-width-alt: 3913; width: 80pt" width="107" />
                                </colgroup>
                                <tr height="20">
                                    <td class="auto-style1" colspan="2" height="20" width="317">Criterios de Importancia</td>
                                </tr>
                                <tr height="20">
                                    <td class="auto-style2" height="20">1</td>
                                    <td class="auto-style3">Afecta al cliente</td>
                                </tr>
                                <tr height="20">
                                    <td class="auto-style2" height="20">2</td>
                                    <td class="auto-style3">Permite fugas</td>
                                </tr>
                                <tr height="20">
                                    <td class="auto-style2" height="20">3</td>
                                    <td class="auto-style3">No permite tomar decisiones</td>
                                </tr>
                                <tr height="20">
                                    <td class="auto-style2" height="20">4</td>
                                    <td class="auto-style3">Muestra información errónea</td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="style9">Comentarios</td>
                        <td class="style10">
                            <asp:TextBox ID="txbComentarios" runat="server" Height="117px" TextMode="MultiLine"
                                Width="374px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="style9">&nbsp;</td>
                        <td class="style10">
                            <asp:Button ID="btnGuardar" runat="server" Text="Guardar" /></td>
                    </tr>
                    <tr>
                        <td class="style6" colspan="2">
                            <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label></td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:TabPanel>
        <asp:TabPanel ID="administrar" runat="server" HeaderText="Administrar Incidentes">
            <ContentTemplate>
                <br />
                <table>
                    <tr>
                        <td>
                            <asp:DropDownList ID="ddlEstatus" runat="server"
                                Height="16px" Width="191px">
                                <asp:ListItem Value="0" Selected="True">Todos</asp:ListItem>
                                <asp:ListItem Value="1">Abiertos</asp:ListItem>
                                <asp:ListItem Value="3">Cerrados</asp:ListItem>
                                <asp:ListItem Value="2">Pendiente</asp:ListItem>
                                <asp:ListItem Value="4">Cancelado</asp:ListItem>
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="ddlRoles" runat="server"
                                Height="16px" Width="191px" DataSourceID="sdsRolesFilter" DataTextField="RoleName" DataValueField="RoleId">
                            </asp:DropDownList></td>
                        <td>
                            <asp:DropDownList ID="ddlCuadraCon" runat="server">
                                <asp:ListItem Value="0">Todos</asp:ListItem>
                                <asp:ListItem>1</asp:ListItem>
                                <asp:ListItem>2</asp:ListItem>
                                <asp:ListItem>3</asp:ListItem>
                                <asp:ListItem>4</asp:ListItem>
                            </asp:DropDownList></td>
                        <td>


                            <asp:DropDownList ID="ddlTipo" runat="server">
                                <asp:ListItem Value="0">Todos</asp:ListItem>
                                <asp:ListItem Value="1">Operativo</asp:ListItem>
                                <asp:ListItem Value="2">Gestión de calidad</asp:ListItem>
                            </asp:DropDownList>


                        </td>
                        <td>
                            <asp:ImageButton ID="btnBuscar" runat="server" SkinID="ibtnActualizar" Width="16px" /></td>
                    </tr>
                    
                </table>
                <br />

                <table style="width: 661px">
                    <tr>
                        <td class="auto-style8">
                            <asp:Label ID="Label5" runat="server" Text="Fecha desde:"></asp:Label>&nbsp;<asp:TextBox ID="txtDesde" runat="server"></asp:TextBox>
                            <asp:CalendarExtender ID="CalendarExtender2" runat="server" Enabled="True" Format="yyyy/MM/dd" TargetControlID="txtDesde">
                            </asp:CalendarExtender>
                        </td>
                        <td class="auto-style6">
                            <asp:Label ID="Label6" runat="server" Text="Fecha hasta:"></asp:Label>
                            <asp:TextBox ID="txtHasta" runat="server"></asp:TextBox><asp:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtHasta" Format="yyyy/MM/dd" Enabled="True"></asp:CalendarExtender>                            
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style8">
                            <asp:RadioButton ID="rbFInci" runat="server" GroupName="Fechas" Text="Fecha Incidente" />
                            <br />
                            <asp:RadioButton ID="rbFPro" runat="server" GroupName="Fechas" Text="Fecha propuesta" />
                            <br />
                            <asp:RadioButton ID="rbFResp" runat="server" GroupName="Fechas" Text="Fecha respuesta" />
                            <br />
                            <asp:RadioButton ID="rbSFecha" runat="server" GroupName="Fechas" Text="Sin Fecha" />
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <br />
                <asp:GridView ID="grdIncidentes" runat="server" AllowPaging="True"
                    AutoGenerateColumns="False" DataKeyNames="id" DataSourceID="sdsIncidentes" SkinID="GridViewGreen" AllowSorting="True">
                    <Columns>
                        <asp:CommandField ShowEditButton="True" CancelText="Cancelar" DeleteText="Borrar" EditText="Editar" UpdateText="Actualizar" />
                        <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False"
                            ReadOnly="True" SortExpression="id" Visible="False" />
                        <asp:BoundField DataField="incidente" HeaderText="Incidente"
                            SortExpression="incidente">
                            <ItemStyle Font-Bold="True" />
                        </asp:BoundField>
                        <asp:BoundField DataField="fechaIncidente" HeaderText="Fecha incidente"
                            SortExpression="fechaIncidente" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="fechaPropuesta" HeaderText="Fecha propuesta"
                            SortExpression="fechaPropuesta" DataFormatString="{0:d}" />
                        <asp:BoundField DataField="fechaRespuesta" HeaderText="Fecha respuesta"
                            SortExpression="fechaRespuesta" DataFormatString="{0:d}" />
                        <asp:TemplateField HeaderText="Descripción" SortExpression="comentarios">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox5" runat="server" Height="136px" ReadOnly="True" Text='<%# Bind("comentarios") %>' TextMode="MultiLine" Width="303px"></asp:TextBox></EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Height="45px" ReadOnly="True" Text='<%# Bind("comentarios") %>' TextMode="MultiLine" Width="239px"></asp:TextBox></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Acción" SortExpression="accion">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Height="69px" Text='<%# Bind("accion") %>' TextMode="MultiLine" Width="261px"></asp:TextBox></EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Height="58px" ReadOnly="True" Text='<%# Bind("accion") %>' TextMode="MultiLine" Width="305px"></asp:TextBox></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Estatus" SortExpression="idEstatus">
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlEstatus" runat="server" DataSourceID="sdsEstatus"
                                    DataTextField="Estatus" DataValueField="id" Height="21px"
                                    SelectedValue='<%# Bind("idEstatus") %>' Width="140px">
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:DropDownList ID="ddlEstatus" runat="server" DataSourceID="sdsEstatus"
                                    DataTextField="Estatus" DataValueField="id" Enabled="False" Height="28px"
                                    SelectedValue='<%# Bind("idEstatus") %>' Width="161px">
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Depto." SortExpression="RoleId">
                            <EditItemTemplate>
                                <asp:DropDownList ID="Role" runat="server" DataSourceID="sdsRoles"
                                    DataTextField="RoleName" DataValueField="RoleId" Height="22px"
                                    SelectedValue='<%# Bind("RoleId") %>' Width="159px">
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:DropDownList ID="ddlDepa" runat="server" DataSourceID="sdsRoles"
                                    DataTextField="RoleName" DataValueField="RoleId" Enabled="False" Height="17px"
                                    SelectedValue='<%# Bind("RoleId") %>' Width="100px">
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="cuadrante" HeaderText="Cuadrante" SortExpression="cuadrante">
                            <ItemStyle CssClass="gridTexto" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Actual">
                            <EditItemTemplate>
                                <asp:Label ID="lblACuadrante" runat="server" Class="gridTexto" Text=' <%# Bind("cuadrante_actual")%>'></asp:Label></EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblACuadrante" runat="server" Class="gridTexto" Text=' <%# Bind("cuadrante_actual")%>'></asp:Label></ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="urgencia" HeaderText="Urgencia" SortExpression="urgencia">
                            <ItemStyle CssClass="gridTexto" />
                        </asp:BoundField>
                        <asp:BoundField DataField="importancia" HeaderText="Importancia" SortExpression="importancia">
                            <ItemStyle CssClass="gridTexto" />
                        </asp:BoundField>
                        <asp:BoundField DataField="estimado" HeaderText="Estimado" SortExpression="estimado">
                            <ItemStyle CssClass="gridTexto" />
                        </asp:BoundField>
                        
                        <asp:TemplateField HeaderText="Tipo" SortExpression="Tipo">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" Enabled="false" runat="server" Text='<%# Bind("id_tipo_incidente") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" enable="false" runat="server" Text='<%# Bind("id_tipo_incidente")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsIncidentes" runat="server"
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                    SelectCommand="Trae_Incidentes"
                    CancelSelectOnNullParameter="False"
                    DeleteCommand="DELETE FROM [incidentes] WHERE [id] = @id"
                    InsertCommand="INSERT INTO [incidentes] ([RoleId], [incidente], [fechaIncidente], [fechaPropuesta], [fechaRespuesta], [comentarios], [idEstatus], [accion], [prioridad]) VALUES (@RoleId, @incidente, @fechaIncidente, @fechaPropuesta, @fechaRespuesta, @comentarios, @idEstatus, @accion, @prioridad)"
                    UpdateCommand="UPDATE [incidentes] SET [RoleId] = @RoleId, [incidente] = @incidente, [fechaIncidente] = @fechaIncidente, [fechaPropuesta] = @fechaPropuesta, [fechaRespuesta] = @fechaRespuesta, [comentarios] = @comentarios, [idEstatus] = @idEstatus, [accion] = @accion,  cuadrante = @cuadrante, urgencia = @urgencia, importancia = @importancia, estimado = @estimado  WHERE [id] = @id" SelectCommandType="StoredProcedure">
                    <DeleteParameters>
                        <asp:Parameter Name="id" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="RoleId" Type="Object" />
                        <asp:Parameter Name="incidente" Type="String" />
                        <asp:Parameter Name="fechaIncidente" Type="DateTime" />
                        <asp:Parameter Name="fechaPropuesta" Type="DateTime" />
                        <asp:Parameter Name="fechaRespuesta" Type="DateTime" />
                        <asp:Parameter Name="comentarios" Type="String" />
                        <asp:Parameter Name="idEstatus" Type="Int32" />
                        <asp:Parameter Name="accion" Type="String" />
                        <asp:Parameter Name="prioridad" Type="String" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" DefaultValue="" />
                        <asp:Parameter Name="nIdEstatus" Type="Int32" />
                        <asp:Parameter Name="cRoleId" Type="String" />
                        <asp:ControlParameter ControlID="txtDesde" Name="dfechaInicio" PropertyName="Text" Type="DateTime" />
                        <asp:ControlParameter ControlID="txtHasta" Name="dfechaFin" PropertyName="Text" Type="DateTime" />
                        <asp:ControlParameter ControlID="ddlCuadraCon" Name="nCuadrante_Actual" PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="ddlTipo" DefaultValue="" Name="idtipoIncidente" PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter DefaultValue="0" Name="tipoFecha" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="RoleId" Type="String" />
                        <asp:Parameter Name="incidente" Type="String" />
                        <asp:Parameter Name="fechaIncidente" Type="DateTime" />
                        <asp:Parameter Name="fechaPropuesta" Type="DateTime" />
                        <asp:Parameter Name="fechaRespuesta" Type="DateTime" />
                        <asp:Parameter Name="comentarios" Type="String" />
                        <asp:Parameter Name="idEstatus" Type="Int32" />
                        <asp:Parameter Name="accion" Type="String" />
                        <asp:Parameter Name="cuadrante" />
                        <asp:Parameter Name="urgencia" />
                        <asp:Parameter Name="importancia" />
                        <asp:Parameter Name="estimado" />
                        <asp:Parameter Name="id" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </ContentTemplate>
        </asp:TabPanel>
    </asp:TabContainer>
    <br />
    <br />
    <asp:SqlDataSource ID="sdsTipoIncidente" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT [id_tipo_incidente], [tipo_incidente] FROM [tipo_incidente]"></asp:SqlDataSource>
    <br />

    <asp:SqlDataSource ID="sdsEstatus" runat="server"
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
        SelectCommand="SELECT [Estatus], [id] FROM [estatusIncidente]"></asp:SqlDataSource>

    <br />
    <asp:SqlDataSource ID="sdsRoles" runat="server"
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
        SelectCommand="SELECT [RoleName], [RoleId] FROM [vw_aspnet_Roles]"></asp:SqlDataSource>
    <br />
    <asp:SqlDataSource ID="sdsRolesFilter" runat="server"
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
        SelectCommand="SELECT ' Todos' as RoleName, '00000000-0000-0000-0000-000000000000' as RoleId UNION SELECT [RoleName], [RoleId] FROM [vw_aspnet_Roles] ORDER BY RoleName ASC"></asp:SqlDataSource>
</asp:Content>
