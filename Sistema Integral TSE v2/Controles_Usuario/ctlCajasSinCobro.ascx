<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlCajasSinCobro.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlCajasSinCobro" %>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    DataSourceID="sdsCajas" EnableModelValidation="True">
    <Columns>
        <asp:BoundField DataField="id_renta" InsertVisible="False" ReadOnly="True" 
            SortExpression="id_renta">
        <ItemStyle Font-Size="0pt" Width="0px" />
        </asp:BoundField>
        <asp:BoundField DataField="orden" HeaderText="ORDEN" SortExpression="ano" />
        <asp:BoundField DataField="economico" HeaderText="CAJA" 
            SortExpression="economico" />
        <asp:BoundField DataField="nombre" HeaderText="CLIENTE" 
            SortExpression="nombre" />
        <asp:TemplateField HeaderText="Dias Transcurridos">
            <ItemTemplate>
                <asp:Label ID="lblDias" runat="server"></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
<asp:SqlDataSource ID="sdsCajas" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
    
    
    SelectCommand="SELECT dbo.empresas.nombre, equipo_operacion.economico, convert(nvarchar,orden_cajas.ano)+'-'+ convert(nvarchar,orden_cajas.consecutivo) as orden, orden_cajas.id_renta FROM orden_cajas INNER JOIN equipo_operacion ON orden_cajas.id_equipo = equipo_operacion.id_equipo INNER JOIN precios_cajas ON orden_cajas.id_precio = precios_cajas.id_precio_caja INNER JOIN dbo.empresas ON precios_cajas.id_cliente = dbo.empresas.id_empresa
where orden_cajas.fin&lt;orden_cajas.inicio">
</asp:SqlDataSource>




