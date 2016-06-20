<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlFacturasSinPago.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlFacturasSinPago" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<p>
    <br />
    <asp:DropDownList ID="ddlCliente" runat="server" DataSourceID="sdsClientes" 
        DataTextField="razon_social" DataValueField="id_dato">
    </asp:DropDownList>
    <asp:SqlDataSource ID="sdsClientes" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        SelectCommand="SELECT datos_facturacion.razon_social, datos_facturacion.id_dato FROM dbo.empresas INNER JOIN datos_facturacion ON dbo.empresas.id_empresa = datos_facturacion.id_empresa WHERE (dbo.empresas.id_tipo_empresa = 1) AND (dbo.empresas.id_status = 5) ORDER BY datos_facturacion.razon_social">
    </asp:SqlDataSource>
</p>
<p>
    Desde
    <asp:TextBox ID="txbInicio" runat="server"></asp:TextBox>
    <asp:CalendarExtender ID="txbInicio_CalendarExtender" runat="server" 
        Enabled="True" Format="dd/MM/yyyy" TargetControlID="txbInicio">
    </asp:CalendarExtender>
&nbsp;Hasta<asp:TextBox ID="txbFin" runat="server"></asp:TextBox>
    <asp:CalendarExtender ID="txbFin_CalendarExtender" runat="server" 
        Enabled="True" Format="dd/MM/yyyy" TargetControlID="txbFin">
    </asp:CalendarExtender>
</p>
<p>
    <asp:RadioButtonList ID="RadioButtonList1" runat="server">
        <asp:ListItem Selected="True" Value="1">Facturas Sin ingreso</asp:ListItem>
        <asp:ListItem Value="2">Facturas Con Ingreso</asp:ListItem>
    </asp:RadioButtonList>
</p>
<p>
    <asp:Button ID="btnBuscar" runat="server" SkinID="btn" Text="Buscar" />
</p>
<p>
    Lote:
    <asp:TextBox ID="txbLote" runat="server"></asp:TextBox>
    <asp:Button ID="btnBuscarLote" runat="server" SkinID="btn" Text="Buscar" />
</p>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    DataSourceID="sdsFacturas" EnableModelValidation="True">
    <Columns>
        <asp:BoundField DataField="folio" HeaderText="FACTURA" />
        <asp:BoundField DataField="importe" DataFormatString="{0:c}" 
            HeaderText="IMPORTE" />
        <asp:BoundField DataField="retencion" DataFormatString="{0:c}" 
            HeaderText="RETENCION" />
        <asp:BoundField DataField="iva" DataFormatString="{0:c}" HeaderText="IVA" />
        <asp:BoundField DataField="total" DataFormatString="{0:c}" HeaderText="TOTAL" />
        <asp:TemplateField HeaderText="FECHA INGRESO">
            <ItemTemplate>
                <asp:Label ID="lblPago" runat="server"></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
<asp:SqlDataSource ID="sdsFacturas" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
    SelectCommand="listarFacturasPagadasYNoPagadas" 
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter DefaultValue="01/01/2013" Name="inicio" />
        <asp:Parameter DefaultValue="01/01/2013" Name="fin" />
        <asp:Parameter DefaultValue="1" Name="tipoConsulta" Type="Int32" />
        <asp:Parameter DefaultValue="0" Name="idDato" />
        <asp:Parameter DefaultValue="1" Name="idLote" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

