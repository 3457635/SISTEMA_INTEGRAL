<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="registroEgreso.aspx.vb" Inherits="Sistema_Integral_TSE_v45.registroEgreso" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .style5 {
            width: 100%;
        }

        .style6 {
            height: 22px;
        }

        .style12 {
            height: 22px;
            width: 140px;
        }

        .style13 {
            width: 140px;
        }

        .style15 {
            width: 245px;
        }

        .style16 {
            width: 468px;
        }

        .style17 {
            width: 213px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Registro de pagos</h1>

    <table class="style5">
        <tr>
            <td class="style12">
                <strong>FILTROS</strong></td>
            <td class="style6">&nbsp;</td>
        </tr>
        <tr>
            <td class="style12">&nbsp;</td>
            <td class="style6">
                <asp:RadioButtonList ID="rbtnOpciones" runat="server">
                    <asp:ListItem Value="1" Selected="True">Ver adeudos atrasados</asp:ListItem>
                    <asp:ListItem Value="2">Ver adeudos</asp:ListItem>
                    <asp:ListItem Value="3">Ver pagos realizados</asp:ListItem>
                    <asp:ListItem Value="4">Ver pagos realizados a destiempo</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td class="style12">Consulta por fecha:</td>
            <td class="style6">
                <strong>Desde</strong>
                <asp:TextBox ID="txbInicio" runat="server"></asp:TextBox>
                <asp:CalendarExtender ID="txbInicio_CalendarExtender" runat="server"
                    Enabled="True" TargetControlID="txbInicio" Format="dd/MM/yyyy">
                </asp:CalendarExtender>
                &nbsp;<strong>Hasta</strong><asp:TextBox ID="txbFin" runat="server"></asp:TextBox>
                <asp:CalendarExtender ID="txbFin_CalendarExtender" runat="server"
                    Enabled="True" Format="dd/MM/yyyy" TargetControlID="txbFin">
                </asp:CalendarExtender>
            </td>
        </tr>
        <tr>
            <td class="style12">Proveedor:
            </td>
            <td class="style6">
                <asp:DropDownList ID="ddlProveedor" runat="server" Height="16px" Width="135px"
                    DataSourceID="sdsProveedores" DataTextField="nombre"
                    DataValueField="id_empresa">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsProveedores" runat="server"
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                    SelectCommand="SELECT id_empresa, nombre FROM dbo.empresas WHERE (id_tipo_empresa = @id_tipo_empresa) AND (id_status = 5) ORDER BY nombre">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="2" Name="id_tipo_empresa" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style13">Consulta por folio de factura:</td>
            <td>
                <asp:TextBox ID="txbFolio" runat="server"></asp:TextBox>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style13">&nbsp;</td>
            <td>
                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" SkinID="btn" />
            </td>
        </tr>
    </table>
    <br />
    <hr />

    <br />
    <br />
    <strong>REGISTRO DE PAGO<br />
    </strong>
    <br />
    <table class="style16">
        <tr>
            <td class="style15">Fecha de pago</td>
            <td class="style17">
                <asp:TextBox ID="txbFechaPago" runat="server"></asp:TextBox>
                <asp:CalendarExtender ID="txbFechaPago_CalendarExtender" runat="server" TargetControlID="txbFechaPago"
                    Enabled="True" Format="dd/MM/yyyy">
                </asp:CalendarExtender>
            </td>
        </tr>
        <tr>
            <td class="style15">Medio de pago</td>
            <td class="style17">
                <asp:DropDownList ID="ddlMedioPago" runat="server" Height="21px" Width="146px"
                    DataSourceID="sdsMedioPago" DataTextField="forma_pago"
                    DataValueField="id_forma_pago">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsMedioPago" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                    SelectCommand="SELECT [id_forma_pago], [forma_pago] FROM [formas_pago]"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style15">Numero de cheque o comprobante</td>
            <td class="style17">
                <asp:TextBox ID="txbReferencia" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style15">Cuenta bancaria</td>
            <td class="style17">
                <asp:DropDownList ID="ddlCuentaBancaria" runat="server" Height="16px"
                    Width="144px" DataSourceID="sdsCuentasBancarias" DataTextField="cuenta"
                    DataValueField="id_cuenta">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsCuentasBancarias" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                    SelectCommand="SELECT [cuenta], [id_cuenta] FROM [conta_cuentas] WHERE (([id_padre] = @id_padre) Or ([id_cuenta] = @id_cuenta))">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="27" Name="id_padre" Type="Int32" />
                        <asp:Parameter DefaultValue="34" Name="id_cuenta" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style15">&nbsp;</td>
            <td class="style17">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" SkinID="btn" />
                <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
            </td>
        </tr>
    </table>
    <hr />
    <h1>Resultados de búsqueda</h1>
    <br />
    <asp:GridView ID="grdEgresos" runat="server" DataSourceID="sdsEgresos"
        EnableModelValidation="True" AutoGenerateColumns="False"
        DataKeyNames="id_pago">
        <Columns>
            <asp:BoundField DataField="id_pago" InsertVisible="False" ReadOnly="True"
                SortExpression="id_pago">
                <ItemStyle Font-Size="0pt" />
            </asp:BoundField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:CheckBox ID="ckbEgreso" runat="server"
                        OnCheckedChanged="CheckBox1_CheckedChanged" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="folio" HeaderText="FOLIO" SortExpression="folio" />
            <asp:BoundField DataField="nombre" HeaderText="PROVEEDOR"
                SortExpression="nombre" />
            <asp:BoundField DataField="descripcion" HeaderText="CONCEPTO"
                SortExpression="descripcion" />
            <asp:BoundField DataField="cantidad" DataFormatString="{0:c2}"
                HeaderText="IMPORTE" SortExpression="cantidad" />
            <asp:BoundField DataField="iva" DataFormatString="{0:c2}" HeaderText="IVA"
                SortExpression="iva" />
            <asp:BoundField DataField="total" DataFormatString="{0:c2}" HeaderText="TOTAL"
                SortExpression="total" />
            <asp:BoundField DataField="fecha_programacion_pago" DataFormatString="{0:d}"
                HeaderText="PROGRAMACION PAGO" SortExpression="fecha_programacion_pago" />
            <asp:BoundField DataField="fecha_pago" DataFormatString="{0:d}"
                HeaderText="PAGO" SortExpression="fecha_pago" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsEgresos" runat="server"
        CancelSelectOnNullParameter="False"
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
        SelectCommand="listaDeEgresos" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="tipoConsulta" Type="Int32" />
            <asp:ControlParameter ControlID="txbInicio" DbType="Date" Name="inicio"
                PropertyName="Text" />
            <asp:ControlParameter ControlID="txbFin" DbType="Date" Name="fin"
                PropertyName="Text" />
            <asp:Parameter Name="idProveedor" Type="Int32" />
            <asp:ControlParameter ControlID="txbFolio" Name="folio" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
