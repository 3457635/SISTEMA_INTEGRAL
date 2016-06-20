<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="recargasSinOrden.aspx.vb" Inherits="Sistema_Integral_TSE_v45.recargasSinOrden" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 256px;
        }
        .auto-style2 {
            width: 50px;
        }
        .auto-style6 {
            width: 40px;
        }
        .auto-style8 {
            width: 107px;
        }
        .auto-style9 {
            width: 50px;
            height: 26px;
        }
        .auto-style13 {
            width: 518px;
        }
        .auto-style15 {
            width: 39px;
        }
        .auto-style17 {
            width: 128px;
        }
        .auto-style19 {
            width: 42px;
        }
        .auto-style20 {
            width: 4px;
        }
        .auto-style21 {
            width: 128px;
            height: 26px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Recargas Sin Orden</h1>
    <br />
    <hr />
    <table class="auto-style13">
        <tr>
            <td class="auto-style15">Litros</td>
            <td class="auto-style17">
                <asp:TextBox ID="txbLitros" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvLitros" runat="server" ControlToValidate="txbLitros" ErrorMessage="Campo Obligatorio" ValidationGroup="insertar"></asp:RequiredFieldValidator>
            </td>
            <td class="auto-style6">Lugar</td>
            <td class="auto-style8">
                <asp:DropDownList ID="ddlLugar" runat="server" Height="16px" Width="107px" DataSourceID="sdsLugarRecarga" DataTextField="lugar" DataValueField="id_lugar">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsLugarRecarga" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="SELECT lugar, id_lugar FROM lugares_recarga"></asp:SqlDataSource>
            </td>
            <td class="auto-style19">Monto</td>
            <td class="auto-style19">
                <asp:TextBox ID="txbMonto" runat="server"></asp:TextBox>
            </td>
            <td class="auto-style19">Ticket</td>
            <td class="auto-style17">
                <asp:TextBox ID="txbTicket" runat="server"></asp:TextBox>
            </td>
            <td class="auto-style20">&nbsp;</td>
        </tr>
    </table>
    </br>
    <table class="auto-style1">
        <tr>
            <td class="auto-style9">Odometro</td>
            <td class="auto-style21">
                <asp:TextBox ID="txbOdometro" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvOdometro" runat="server" ControlToValidate="txbOdometro" ErrorMessage="Campo Obligatorio" ValidationGroup="insertar"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style9">Fecha:</td>
            <td class="auto-style21">
                <asp:TextBox ID="txbFecha" runat="server"></asp:TextBox>
                
                <asp:CalendarExtender ID="clrFecha" runat="server" Format="yyyy/MM/dd" TargetControlID="txbFecha">
                </asp:CalendarExtender>
                
                <asp:RequiredFieldValidator ID="rfvFecha" runat="server" ControlToValidate="txbFecha" ErrorMessage="Campo Obligatorio" ValidationGroup="insertar"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style9">Hora:</td>
            <td class="auto-style21">
                <asp:TextBox ID="txbHora" runat="server"></asp:TextBox>
                <asp:MaskedEditExtender ID="txbHora_MaskedEditExtender" runat="server" TargetControlID="txbHora" BehaviorID="mskHora" Mask="99:99" MaskType="Time">
                </asp:MaskedEditExtender>
                <asp:RequiredFieldValidator ID="rfvHora" runat="server" ControlToValidate="txbHora" ErrorMessage="Campo Obligatorio" ValidationGroup="insertar"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="auto-style9">Equipo</td>
            <td class="auto-style21">
                <asp:DropDownList ID="ddlEquipo" runat="server" Height="16px" Width="115px" DataSourceID="sdsEquipo" DataTextField="economico" DataValueField="id_equipo">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsEquipo" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="SELECT [economico], [id_equipo] FROM [equipo_operacion] WHERE (([id_tipo_equipo] &lt; @id_tipo_equipo) AND ([id_status] = @id_status)) ORDER BY [economico]">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="106" Name="id_tipo_equipo" Type="Int32" />
                        <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="auto-style2">Chofer</td>
            <td class="auto-style17">
                <asp:DropDownList ID="ddlChofer" runat="server" Height="16px" Width="109px" DataSourceID="sdsChofer" DataTextField="chofer" DataValueField="id_empleado">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsChofer" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="SELECT p.primer_nombre + ' ' + p.apellido_paterno AS chofer, e.id_empleado FROM empleados AS e INNER JOIN personas AS p ON e.id_persona = p.id_persona WHERE (p.id_status = 5) ORDER BY p.primer_nombre, p.apellido_paterno"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="auto-style2">&nbsp;</td>
            <td class="auto-style17">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" ValidationGroup="insertar" />
            </td>
            
        </tr>
    </table>
    <hr />
<br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />

<asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
<br />
<br />
Año<asp:TextBox ID="txbAño" runat="server"></asp:TextBox>
&nbsp;Mes:
<asp:DropDownList ID="ddlMes" runat="server" SkinID="ddlMes">
</asp:DropDownList>
&nbsp;Unidad:&nbsp;
    <asp:DropDownList ID="ddlUnidadConsulta" runat="server" DataSourceID="sdsEquipo" DataTextField="economico" DataValueField="id_equipo">
    </asp:DropDownList>
&nbsp; <asp:Button ID="btnConsultar" runat="server" Text="Consultar" />
&nbsp;<br />
    <br />
    <br />
    <asp:GridView ID="grdRecargas" runat="server" DataSourceID="sdsRecargas" EnableModelValidation="True" AutoGenerateColumns="False" DataKeyNames="id_recarga">
        <Columns>
            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
            <asp:BoundField DataField="id_recarga" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="id_recarga" />
            <asp:TemplateField HeaderText="LUGAR" SortExpression="id_lugar">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlEditLugar" runat="server" DataSourceID="sdsLugarRecarga" DataTextField="lugar" DataValueField="id_lugar" SelectedValue='<%# Bind("id_lugar") %>'>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:DropDownList ID="ddlLugar" runat="server" DataSourceID="sdsLugarRecarga" DataTextField="lugar" DataValueField="id_lugar" Enabled="False" SelectedValue='<%# Bind("id_lugar") %>'>
                    </asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="lts" HeaderText="LITROS" SortExpression="lts" />
            <asp:TemplateField HeaderText="EQUIPO" SortExpression="id_equipo">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlEditEquipo" runat="server" DataSourceID="sdsEquipo" DataTextField="economico" DataValueField="id_equipo" SelectedValue='<%# Bind("id_equipo") %>'>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:DropDownList ID="ddlEquipo" runat="server" DataSourceID="sdsEquipo" DataTextField="economico" DataValueField="id_equipo" Enabled="False" SelectedValue='<%# Bind("id_equipo") %>'>
                    </asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="CHOFER" SortExpression="id_chofer">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlEditChofer" runat="server" DataSourceID="sdsChofer" DataTextField="chofer" DataValueField="id_empleado" SelectedValue='<%# Bind("id_chofer") %>'>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:DropDownList ID="ddlItemChofer" runat="server" DataSourceID="sdsChoferes2" DataTextField="chofer" DataValueField="id_empleado" Enabled="False" SelectedValue='<%# Bind("id_chofer") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsChoferes2" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="SELECT p.primer_nombre + ' ' + p.apellido_paterno AS chofer, e.id_empleado FROM empleados AS e INNER JOIN personas AS p ON e.id_persona = p.id_persona  ORDER BY p.primer_nombre, p.apellido_paterno"></asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="monto" HeaderText="MONTO" SortExpression="monto" />
            <asp:BoundField DataField="ticket" HeaderText="TICKET" SortExpression="ticket" />
            <asp:BoundField DataField="odometro" HeaderText="ODOMETRO" SortExpression="odometro" />
            <asp:BoundField DataField="fechaRecarga" HeaderText="FECHA" SortExpression="fechaRecarga" />
            <asp:BoundField DataField="responsable" HeaderText="INSPECTOR" SortExpression="responsable" />
        </Columns>
            </asp:GridView>
<asp:SqlDataSource ID="sdsRecargas" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" 
    DeleteCommand="DELETE FROM [recargas_combustible] WHERE [id_recarga] = @id_recarga" 
    SelectCommand="SELECT * FROM 
[recargas_combustible] 
WHERE 
([recargaSinOrden] = @recargaSinOrden) 
and datepart(month,fechaRecarga)=@mes
and datepart(year,fechaRecarga)=@ano
and id_equipo=isnull(@idEquipo,id_equipo)
ORDER BY [fechaRecarga] DESC" 
    UpdateCommand="UPDATE [recargas_combustible] SET [id_lugar] = @id_lugar, [lts] = @lts, [id_equipo] = @id_equipo, [id_chofer] = @id_chofer,  [monto] = @monto, [ticket] = @ticket, [odometro] = @odometro,  [fechaRecarga] = @fechaRecarga WHERE [id_recarga] = @id_recarga" CancelSelectOnNullParameter="False">
    <DeleteParameters>
        <asp:Parameter Name="id_recarga" Type="Int32" />
    </DeleteParameters>
    <SelectParameters>
        <asp:Parameter DefaultValue="True" Name="recargaSinOrden" Type="Boolean" />
        <asp:Parameter Name="mes" DefaultValue="" />
        <asp:Parameter Name="ano" />
        <asp:Parameter DefaultValue="" Name="idEquipo" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="id_lugar" Type="Int32" />
        <asp:Parameter Name="lts" Type="Double" />
        <asp:Parameter Name="id_equipo" Type="Int32" />
        <asp:Parameter Name="id_chofer" Type="Int32" />
        <asp:Parameter Name="monto" Type="Double" />
        <asp:Parameter Name="ticket" Type="String" />
        <asp:Parameter Name="odometro" Type="Int32" />
        <asp:Parameter Name="fechaRecarga" Type="DateTime" />
        <asp:Parameter Name="id_recarga" Type="Int32" />
    </UpdateParameters>
    </asp:SqlDataSource>
<br />
</asp:Content>
