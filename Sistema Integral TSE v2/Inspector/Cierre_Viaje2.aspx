<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Cierre_Viaje2.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Cierre_Viaje2" 
     %>

<%@ Register assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.WebControls" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    Cierre de Viajes.<br />
&nbsp;
                &nbsp;
                <br />
                <asp:LinkButton ID="lnkCierreViaje" runat="server" 
    Visible="False">Cerrar Viaje Local</asp:LinkButton>
&nbsp;
<span 
                    style="color: #FF0000" __designer:mapid="5d">
                <asp:Label ID="lblMensaje2" runat="server" ForeColor="Red"></asp:Label>
                </span>

    <asp:Panel ID="Panel2" runat="server">
<table style="width: 100%">
        <tr>
            <td colspan="2" class="style6">
               
                <br />
            </td>
        </tr>
                                <tr>
                                    <td style="width: 160px">
                                        Chofer:</td>
                                    <td class="style5">
                                        <asp:DropDownList ID="ddlChofer" runat="server" DataSourceID="sdsChoferes" 
                                            DataTextField="chofis" DataValueField="id_empleado">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="sdsChoferes" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                            SelectCommand="SELECT personas.primer_nombre + ' ' + personas.apellido_paterno AS chofis, empleados.id_empleado FROM empleados INNER JOIN personas ON empleados.id_persona = personas.id_persona WHERE (personas.id_status = 5) ORDER BY personas.primer_nombre, personas.apellido_paterno">
                                        </asp:SqlDataSource>
                                    </td>
        </tr>
                                <tr>
                                    <td style="width: 160px">
                                        Unidad:</td>
                                    <td class="style5">
                                        <asp:DropDownList ID="ddlUnidad" runat="server" DataSourceID="sdsUnidades" 
                                            DataTextField="economico" DataValueField="id_equipo" AutoPostBack="True">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="sdsUnidades" runat="server" 
                                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                            SelectCommand="SELECT economico, id_equipo FROM equipo_operacion WHERE (id_tipo_equipo &lt; 107) AND (id_status = 5) ORDER BY economico">
                                        </asp:SqlDataSource>
                                        &nbsp;</td>
        </tr>
        <tr>
            <td style="width: 160px">
                Eje de Regreso:</td>
            <td class="style5">
                <asp:DropDownList ID="ddlEjesRegreso" runat="server">
                    <asp:ListItem>2</asp:ListItem>
                    <asp:ListItem>3</asp:ListItem>
                    <asp:ListItem Selected="True">4</asp:ListItem>
                    <asp:ListItem>5</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
                                <tr>
                                    <td style="width: 160px">
                                        Odometro Regreso:       <td class="style5">
                <asp:TextBox ID="txbOdometro" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"  Enabled="false"
                    ControlToValidate="txbOdometro" ErrorMessage="Ingrese el Odometro." ValidationGroup="odometro">*</asp:RequiredFieldValidator>
                <asp:RangeValidator ID="RangeValidator2" runat="server" Enabled="false"
                    ControlToValidate="txbOdometro" ErrorMessage="Solo se permiten numeros." 
                    MaximumValue="999999999999" MinimumValue="1" ValidationGroup="odometro">*</asp:RangeValidator>
            &nbsp;<asp:Label ID="lblOdometroSalida" runat="server"></asp:Label>
                                            <asp:TextBox ID="txbIdOrdenRegreso" runat="server" Visible="False"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 160px">
                &nbsp;<td class="style5">
                    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
                        DataKeyNames="id_odometro" DataSourceID="sdsOdometros" 
                        EnableModelValidation="True">
                        <Columns>
                            <asp:CommandField ShowDeleteButton="True"></asp:CommandField>
                            <asp:BoundField DataField="id_odometro" InsertVisible="False" ReadOnly="True" 
                                SortExpression="id_odometro">
                                <ItemStyle Font-Size="0pt" />
                            </asp:BoundField>
                            <asp:BoundField DataField="odometro" HeaderText="Odometros Registrados:" 
                                SortExpression="odometro"></asp:BoundField>
                            <asp:BoundField DataField="inspector" HeaderText="Inspector" 
                                SortExpression="inspector"></asp:BoundField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsOdometros" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        DeleteCommand="DELETE FROM [Odometros] WHERE [id_odometro] = @id_odometro" 
                        InsertCommand="INSERT INTO [Odometros] ([odometro], [inspector]) VALUES (@odometro, @inspector)" 
                        SelectCommand="SELECT [odometro], [id_odometro], [inspector] FROM [Odometros] WHERE (([idEvaluacion] = @idEvaluacion) AND ([tipo_trayecto] = @tipo_trayecto))" 
                        UpdateCommand="UPDATE [Odometros] SET [odometro] = @odometro, [inspector] = @inspector WHERE [id_odometro] = @id_odometro">
                        <DeleteParameters>
                            <asp:Parameter Name="id_odometro" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="odometro" Type="Int32" />
                            <asp:Parameter Name="inspector" Type="String" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:Parameter Name="idEvaluacion" Type="Int32" />
                            <asp:Parameter DefaultValue="2" Name="tipo_trayecto" Type="Int32" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="odometro" Type="Int32" />
                            <asp:Parameter Name="inspector" Type="String" />
                            <asp:Parameter Name="id_odometro" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </td>
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

            <div>
                <br />
                Combustible<br /> Recarga en Base<asp:GridView ID="GridView1" runat="server" 
                    AutoGenerateColumns="False" DataKeyNames="id_recarga" 
                    DataSourceID="sdsRecargasInternas" EnableModelValidation="True">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" />
                        <asp:BoundField DataField="lts" HeaderText="lts" SortExpression="lts" />
                        <asp:BoundField DataField="id_recarga" InsertVisible="False" ReadOnly="True" 
                            SortExpression="id_recarga">
                        <ItemStyle Font-Size="0pt" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsRecargasInternas" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    DeleteCommand="DELETE FROM [recargas_combustible] WHERE [id_recarga] = @id_recarga" 
                    InsertCommand="INSERT INTO [recargas_combustible] ([id_orden], [id_lugar], [cantidad], [lts], [medio_pago], [ticket]) VALUES (@id_orden, @id_lugar, @cantidad, @lts, @medio_pago, @ticket)" 
                    SelectCommand="SELECT recargas_combustible.lts, recargas_combustible.id_recarga FROM recargas_combustible INNER JOIN recargas_internas ON recargas_combustible.id_recarga = recargas_internas.id_recarga WHERE (recargas_combustible.idEvaluacion = @idEvaluacion)" 
                    
                    
                    
                    
                    
                    
                    
                    UpdateCommand="UPDATE [recargas_combustible] SET [id_orden] = @id_orden, [id_lugar] = @id_lugar, [cantidad] = @cantidad, [lts] = @lts, [medio_pago] = @medio_pago, [ticket] = @ticket WHERE [id_recarga] = @id_recarga">
                    <DeleteParameters>
                        <asp:Parameter Name="id_recarga" Type="Int32" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:Parameter Name="idEvaluacion" />
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
                Recargas Externas<asp:GridView ID="GridView2" runat="server" 
                    AutoGenerateColumns="False" DataKeyNames="id_recarga" 
                    DataSourceID="sdsRecargasExternas" EnableModelValidation="True">
                    <Columns>
                        <asp:CommandField SelectText="Delete" ShowDeleteButton="True" />
                        <asp:BoundField DataField="lts" HeaderText="lts" SortExpression="lts" />
                        <asp:BoundField DataField="lugar" HeaderText="lugar" SortExpression="lugar" />
                        <asp:BoundField DataField="cantidad" HeaderText="cantidad" 
                            SortExpression="cantidad" />
                        <asp:BoundField DataField="id_recarga" InsertVisible="False" ReadOnly="True" 
                            SortExpression="id_recarga">
                        <ItemStyle Font-Size="0pt" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsRecargasExternas" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"                                    
                    
                    SelectCommand="SELECT recargas_combustible.lts, lugares_recarga.lugar, gastos.cantidad, recargas_combustible.id_recarga FROM recargas_combustible INNER JOIN recargas_externas ON recargas_combustible.id_recarga = recargas_externas.id_recarga INNER JOIN gastos ON recargas_externas.id_gasto = gastos.id_gasto INNER JOIN lugares_recarga ON recargas_combustible.id_lugar = lugares_recarga.id_lugar WHERE (recargas_combustible.idEvaluacion = @idEvaluacion)" 
                    DeleteCommand="DELETE FROM [recargas_combustible] WHERE [id_recarga] = @id_recarga" 
                    InsertCommand="INSERT INTO [recargas_combustible] ([id_lugar], [lts], [id_equipo], [id_asignacion], [id_chofer], [idEvaluacion]) VALUES (@id_lugar, @lts, @id_equipo, @id_asignacion, @id_chofer, @idEvaluacion)" 
                    
                    UpdateCommand="UPDATE [recargas_combustible] SET [id_lugar] = @id_lugar, [lts] = @lts, [id_equipo] = @id_equipo, [id_asignacion] = @id_asignacion, [id_chofer] = @id_chofer, [idEvaluacion] = @idEvaluacion WHERE [id_recarga] = @id_recarga">
                    <DeleteParameters>
                        <asp:Parameter Name="id_recarga" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="id_lugar" Type="Int32" />
                        <asp:Parameter Name="lts" Type="Double" />
                        <asp:Parameter Name="id_equipo" Type="Int32" />
                        <asp:Parameter Name="id_asignacion" Type="Int32" />
                        <asp:Parameter Name="id_chofer" Type="Int32" />
                        <asp:Parameter Name="idEvaluacion" Type="Int32" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:Parameter Name="idEvaluacion" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="id_lugar" Type="Int32" />
                        <asp:Parameter Name="lts" Type="Double" />
                        <asp:Parameter Name="id_equipo" Type="Int32" />
                        <asp:Parameter Name="id_asignacion" Type="Int32" />
                        <asp:Parameter Name="id_chofer" Type="Int32" />
                        <asp:Parameter Name="idEvaluacion" Type="Int32" />
                        <asp:Parameter Name="id_recarga" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource><br />
                Estación:<asp:DropDownList ID="ddlEstacion" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSource1" DataTextField="lugar" DataValueField="id_lugar">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT [id_lugar], [lugar] FROM [lugares_recarga]">
                </asp:SqlDataSource>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <table style="width: 234px">
                            <tr>
                                <td style="width: 96px">
                                    Recarga Parcial:</td>
                                <td style="width: 128px">
                                    <asp:CheckBox ID="ckbRecargaParcial" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 96px">
                                    Litros:</td>
                                <td style="width: 128px">
                                    <asp:TextBox ID="txbLitros" runat="server">0</asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                        ControlToValidate="txbLitros" ErrorMessage="*" ValidationGroup="litros">Campo Obligatorio</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 96px">
                                    Cantidad:$</td>
                                <td style="width: 128px">
                                    <asp:TextBox ID="txbPesosCombustible" runat="server">0</asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 96px">
                                    Ticket:</td>
                                <td style="width: 128px">
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
                    SkinID="btnGuardar" ValidationGroup="litros" />
                                         
                                         <br />
                Kms:
                            <asp:Label ID="lblKms" runat="server" Text="0"></asp:Label>
                            <br />
                            Litros:&nbsp;
                            <asp:Label ID="lblTotalLitros" runat="server" Text="0"></asp:Label>
&nbsp;<br />
                            Costo:&nbsp; <asp:Label ID="lblPesosRecarga" runat="server" Text="0"></asp:Label>
                            <br />
                            Rendimiento:                             <asp:Label ID="lblRendimiento" runat="server" Text="0"></asp:Label>
&nbsp;kms/lt
                <br />
                <br />
                Reporte de fallas:<br />&nbsp;<asp:TextBox ID="txbFalla" runat="server" 
                    Height="136px" TextMode="MultiLine" Width="659px"></asp:TextBox>
                <br />
                <br />
                <asp:Button ID="btnGuardarAveria" runat="server" Text="Guardar" SkinID="btn" />
                <br />
                <br />
                <br />
                <asp:Button ID="txbFin" runat="server" SkinID="btn" Text="Evaluación Chofer" />
                &nbsp;<asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
                <br />
                <br />
    </asp:Panel>

            </div>
            
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="Head">
    <style type="text/css">
        .style5
        {
            width: 84%;
        }
        .style6
        {
            height: 22px;
        }
    </style>
    </asp:Content>

