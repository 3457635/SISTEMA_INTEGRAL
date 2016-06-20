<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="facturaCajas.aspx.vb" Inherits="Sistema_Integral_TSE_v45.facturaCajas1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Reporte de Facturación de Cajas</h1>
    Caja:
    <asp:DropDownList ID="ddlCajas" runat="server" DataSourceID="sdsCajas" 
        DataTextField="economico" DataValueField="id_equipo">
    </asp:DropDownList>
    <asp:SqlDataSource ID="sdsCajas" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        SelectCommand="SELECT [economico], [id_equipo] FROM [equipo_operacion] WHERE ([id_tipo_equipo] &gt;= @id_tipo_equipo) ORDER BY [economico]">
        <SelectParameters>
            <asp:Parameter DefaultValue="107" Name="id_tipo_equipo" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <br />
    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" />
    <br />
    <asp:GridView ID="GridView2" runat="server" AllowPaging="True" 
        AutoGenerateColumns="False" DataSourceID="sdsFacturas" 
        EnableModelValidation="True" PageSize="50" SkinID="GridView1">
        <Columns>
            <asp:BoundField DataField="nombre" HeaderText="EMPRESA" 
                SortExpression="nombre" />
            <asp:BoundField DataField="ano" HeaderText="ORDEN" SortExpression="ano" />
            <asp:BoundField DataField="consecutivo" SortExpression="consecutivo" />
            <asp:BoundField DataField="Inicio" DataFormatString="{0:d}" HeaderText="RENTA" 
                SortExpression="Inicio" />
            <asp:BoundField DataField="Fin" DataFormatString="{0:d}" HeaderText="ENTREGA" 
                SortExpression="Fin" />
            <asp:BoundField DataField="folio" HeaderText="FACTURA" SortExpression="folio" />
            <asp:BoundField DataField="importe" DataFormatString="{0:c}" 
                HeaderText="IMPORTE" SortExpression="importe" />
            <asp:BoundField DataField="iva" DataFormatString="{0:c}" HeaderText="IVA" 
                SortExpression="iva" />
            <asp:BoundField DataField="retencion" DataFormatString="{0:c}" 
                HeaderText="RETENCIÓN" SortExpression="retencion" />
            <asp:BoundField DataField="total" DataFormatString="{0:c}" HeaderText="TOTAL" 
                SortExpression="total" />
            <asp:BoundField DataField="facturaInicio" DataFormatString="{0:d}" 
                HeaderText="FACTURA DESDE" SortExpression="facturaInicio" />
            <asp:BoundField DataField="facturaFin" DataFormatString="{0:d}" 
                HeaderText="FACTURA HASTA" SortExpression="facturaFin" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsFacturas" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        SelectCommand="SELECT dbo.empresas.nombre, orden_cajas.ano, orden_cajas.consecutivo, orden_cajas.Inicio, orden_cajas.Fin, facturas.folio, facturas.importe, facturas.iva, facturas.retencion, facturas.total, facturas_cajas.inicio AS facturaInicio, facturas_cajas.fin AS facturaFin FROM facturas_cajas INNER JOIN orden_cajas ON facturas_cajas.id_renta = orden_cajas.id_renta INNER JOIN precios_cajas ON orden_cajas.id_precio = precios_cajas.id_precio_caja INNER JOIN dbo.empresas ON precios_cajas.id_cliente = dbo.empresas.id_empresa INNER JOIN facturas ON facturas_cajas.id_factura = facturas.id_factura AND facturas_cajas.id_factura = facturas.id_factura WHERE (orden_cajas.id_equipo = @id_equipo) and facturas.cancelada=0 ORDER BY facturaFin DESC">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlCajas" Name="id_equipo" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
