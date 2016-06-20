<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="comprasDiesel.aspx.vb" Inherits="Sistema_Integral_TSE_v45.comprasDiesel" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 480px;
        }
        .auto-style2 {
            width: 126px;
        }
        .auto-style5 {
            width: 344px;
        }
        .auto-style6 {
            width: 297px;
        }
        .auto-style8 {
            width: 103px;
        }
        .auto-style10 {
            width: 90px;
        }
        .auto-style13 {
            width: 103px;
            color: #FFFFFF;
        }
        .auto-style15 {
        width: 90px;
        color: #FFFFFF;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
</telerik:RadAjaxManager>
<h1>Compras de Diesel</h1>

    <table class="auto-style6">
        <tr>
            <td bgcolor="#336600" class="auto-style13"><strong>Existencia</strong></td>
            <td bgcolor="#336600" class="auto-style15"><strong>Consumo</strong></td>
            <td bgcolor="#336600" class="auto-style15"><strong>Lts. al Inicio</strong></td>
        </tr>
        <tr>
            <td class="auto-style8">
                <asp:Label ID="lblExcistencia" runat="server"></asp:Label>
            </td>
            <td class="auto-style10">
                <asp:Label ID="lblConsumo" runat="server"></asp:Label>
            </td>
            <td class="auto-style10">
                <asp:Label ID="lblLtsInicio" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <br />

   
    <hr />
    <div>

        <table class="auto-style1">
            <tr>
                <td class="auto-style2">Fecha</td>
                <td class="auto-style5">
                    <asp:TextBox ID="txbFecha" runat="server"></asp:TextBox>
                    <asp:CalendarExtender ID="clrFecha" runat="server" Enabled="True" TargetControlID="txbFecha" Format="yyyy/MM/dd">
                    </asp:CalendarExtender>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Hora</td>
                <td class="auto-style5">
                    <asp:TextBox ID="txbHora" runat="server" AutoPostBack="True"></asp:TextBox>
                    <asp:MaskedEditExtender ID="txbHora_MaskedEditExtender" runat="server" MaskType="Time" TargetControlID="txbHora" Mask="99:99">
                    </asp:MaskedEditExtender>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Litros Comprados</td>
                <td class="auto-style5" culturename="es-Mx">
                    <asp:TextBox ID="txbLitrosComprados" runat="server" AutoPostBack="True"></asp:TextBox>
                    <asp:MaskedEditExtender ID="txbLitrosComprados_MaskedEditExtender" runat="server" MaskType="Number" TargetControlID="txbLitrosComprados" DisplayMoney="Left" Mask="99,999">
                    </asp:MaskedEditExtender>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Litros en Tanque</td>
                <td class="auto-style5">
                    <asp:TextBox ID="txbLitrosTanque" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Factura</td>
                <td class="auto-style5">
                    <asp:TextBox ID="txbFactura" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Proveedor</td>
                <td class="auto-style5">
                    <asp:SqlDataSource ID="sdsProveedores" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="SELECT [nombre], [id_empresa] FROM [empresas] WHERE ([id_tipo_empresa] = @id_tipo_empresa) ORDER BY [nombre]">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="2" Name="id_tipo_empresa" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:DropDownList ID="ddlProveedor" runat="server" DataSourceID="sdsProveedores" DataTextField="nombre" DataValueField="id_empresa">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">Comentarios</td>
                <td class="auto-style5">
                    <asp:TextBox ID="txbComentarios" runat="server" Height="81px" TextMode="MultiLine" Width="338px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style2">&nbsp;</td>
                <td class="auto-style5">
                    <asp:Button ID="btnGuardar" runat="server" SkinID="btn" Text="Guardar" />
                &nbsp;<asp:Label ID="lblMensaje" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
        <hr />
        <h2>Consultar</h2>
    </div>
    <br />
Año
<asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
&nbsp;<asp:Button ID="btnConsultar" runat="server" SkinID="btn" Text="Consultar" />
    <br />
    <asp:GridView ID="grdCompras" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="sdsCompras" EnableModelValidation="True">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" />
            <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" SortExpression="Id" />
            <asp:BoundField DataField="fecha" HeaderText="FECHA" SortExpression="fecha" />
            <asp:BoundField DataField="litrosComprados" HeaderText="Lts. Comprados" SortExpression="litrosComprados" />
            <asp:BoundField DataField="litrosEnTanque" HeaderText="Lts. En Tanque" SortExpression="litrosEnTanque" />
            <asp:BoundField DataField="comprobante" HeaderText="FACTURA" SortExpression="comprobante" />
            <asp:BoundField DataField="comentarios" HeaderText="COMENTARIOS" SortExpression="comentarios" />
            <asp:TemplateField HeaderText="PROVEEDOR" SortExpression="idProveedor">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("idProveedor") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:DropDownList ID="ddlProveedor" runat="server" DataSourceID="sdsProveedores" DataTextField="nombre" DataValueField="id_empresa" SelectedValue='<%# Bind("idProveedor") %>'>
                    </asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsCompras" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" DeleteCommand="DELETE FROM [comprasDiesel] WHERE [Id] = @Id" InsertCommand="INSERT INTO [comprasDiesel] ([Id], [fecha], [litrosComprados], [litrosEnTanque], [comprobante], [comentarios], [idProveedor]) VALUES (@Id, @fecha, @litrosComprados, @litrosEnTanque, @comprobante, @comentarios, @idProveedor)" SelectCommand="SELECT * FROM [comprasDiesel] where datepart(year,fecha)=@ano ORDER BY [fecha] DESC" UpdateCommand="UPDATE [comprasDiesel] SET [fecha] = @fecha, [litrosComprados] = @litrosComprados, [litrosEnTanque] = @litrosEnTanque, [comprobante] = @comprobante, [comentarios] = @comentarios, [idProveedor] = @idProveedor WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="fecha" Type="DateTime" />
            <asp:Parameter Name="litrosComprados" Type="Int32" />
            <asp:Parameter Name="litrosEnTanque" Type="Int32" />
            <asp:Parameter Name="comprobante" Type="String" />
            <asp:Parameter Name="comentarios" Type="Boolean" />
            <asp:Parameter Name="idProveedor" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="txbAno" Name="ano" PropertyName="Text" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="fecha" Type="DateTime" />
            <asp:Parameter Name="litrosComprados" Type="Int32" />
            <asp:Parameter Name="litrosEnTanque" Type="Int32" />
            <asp:Parameter Name="comprobante" Type="String" />
            <asp:Parameter Name="comentarios" Type="Boolean" />
            <asp:Parameter Name="idProveedor" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
