<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlUnfactured.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlTablaCxC" %>

    <style type="text/css">
        .style1
        {
            width: 189px;
        }
    </style>

    Días transcurridos de viajes sin factura.<asp:RadioButtonList 
    ID="rbtnSinFactura" runat="server">
    <asp:ListItem Selected="True" Value="0">Todos</asp:ListItem>
    <asp:ListItem Value="1">Sin Soportes</asp:ListItem>
</asp:RadioButtonList>
<asp:ImageButton ID="ImageButton2" runat="server" SkinID="ibtnActualizar" />
<div>
               <div style="text-align: right" />

                   <table class="style1">
                       <tr>
                           <td class="style7">
                               <table border="1" cellspacing="0" class="style5">
    <tr>
        <td class="style2">
            &nbsp;</td>
        <td class="style4">
            Días</td>
        <td class="style9">
            No.Viajes</td>
        <td class="style1">
            Total de Viajes Sin Facturar</td>
        <td class="style9">
            Viajes Cerrados </td>
        <td class="style9">
            Viajes Con Bitacora </td>
    </tr>
    <tr>
        <td class="style2">
            &nbsp;</td>
        <td class="style4">
            Viajes Por Salir</td>
        <td class="style9">
            <asp:LinkButton ID="lnkRango5" runat="server">0</asp:LinkButton>
        </td>
        <td class="style1">
            &nbsp;</td>
        <td class="style9">
            &nbsp;</td>
        <td class="style9">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style2">
            <img alt="" class="style2" src="../imagenes/GREEN.png" /></td>
        <td class="style4">
            1-3</td>
        <td class="style9">
            <asp:LinkButton ID="lnkRango1" runat="server">0</asp:LinkButton>
        </td>
        <td class="style1">
            <asp:GridView ID="grdVerdeMx" runat="server" AutoGenerateColumns="False" 
                DataSourceID="sdsVerdeMN" EnableModelValidation="True" SkinID="grdAnidado">
                <AlternatingRowStyle BackColor="#FFFF66" />
                <Columns>
                    <asp:BoundField DataField="nombre" HeaderText="nombre" 
                        SortExpression="nombre" />
                    <asp:BoundField DataField="Column1" DataFormatString="{0:c}" 
                        HeaderText="Column1" ReadOnly="True" SortExpression="Column1" />
                </Columns>
            </asp:GridView>
            <br />
            <asp:GridView ID="grdVerdeDlls" runat="server" AutoGenerateColumns="False" 
                DataSourceID="sdsVerdeDlls" EnableModelValidation="True" 
                SkinID="grdAnidado">
                <AlternatingRowStyle BackColor="#FFFF66" />
                <Columns>
                    <asp:BoundField DataField="nombre" HeaderText="nombre" 
                        SortExpression="nombre" />
                    <asp:BoundField DataField="Column1" DataFormatString="{0:c}" 
                        HeaderText="Column1" ReadOnly="True" SortExpression="Column1" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsVerdeDlls" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT     dbo.empresas.nombre, convert(money,sum(precios.precio*12))
FROM         viajes INNER JOIN
                      precios ON viajes.id_relacion = precios.id_relacion INNER JOIN
                      dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN
                      fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN
                      fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha INNER JOIN
                      Ordenes ON viajes.id_orden = Ordenes.id_orden
WHERE     (fechas.tipo_fecha = 1) AND 
(viajes.id_status &lt;&gt; 5) AND 
precios.id_moneda=5 and
(viajes.id_status &lt;&gt; 3) AND 
(DATEDIFF(day, convert(date,fechas.fecha), GETDATE()) &gt;= 1) AND 
(DATEDIFF(day, convert(date,fechas.fecha), GETDATE()) &lt;= 3) AND 
                      (viajes.id_viaje NOT IN
                          (SELECT     id_viaje
                            FROM          facturacion))
                            group by nombre"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsVerdeMN" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="
SELECT     dbo.empresas.nombre, convert(money,sum(precios.precio))
FROM         viajes INNER JOIN
                      precios ON viajes.id_relacion = precios.id_relacion INNER JOIN
                      dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN
                      fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN
                      fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha INNER JOIN
                      Ordenes ON viajes.id_orden = Ordenes.id_orden
WHERE     (fechas.tipo_fecha = 1) AND 
(viajes.id_status &lt;&gt; 5) AND 
precios.id_moneda=4 and
(viajes.id_status &lt;&gt; 3) AND 
(DATEDIFF(day,   convert(date,fechas.fecha), GETDATE()) &gt;= 1) AND 
(DATEDIFF(day,  convert(date,fechas.fecha), GETDATE()) &lt;= 3) AND 
                      (viajes.id_viaje NOT IN
                          (SELECT     id_viaje
                            FROM          facturacion))
                            group by nombre"></asp:SqlDataSource>
        </td>
        <td class="style9">
            <asp:GridView ID="grdVerdeCerradosMx" runat="server" AutoGenerateColumns="False" 
                DataSourceID="sdsVerdeMNCerrados" EnableModelValidation="True" 
                SkinID="grdAnidado">
                <AlternatingRowStyle BackColor="#FFFF66" />
                <Columns>
                    <asp:BoundField DataField="nombre" HeaderText="nombre" 
                        SortExpression="nombre" />
                    <asp:BoundField DataField="Column1" DataFormatString="{0:c}" 
                        HeaderText="Column1" ReadOnly="True" SortExpression="Column1" />
                </Columns>
            </asp:GridView>
            <asp:GridView ID="grdVerdeCerradoDlls" runat="server" AutoGenerateColumns="False" 
                DataSourceID="sdsVerdeDllsCerrados" EnableModelValidation="True" 
                SkinID="grdAnidado">
                <AlternatingRowStyle BackColor="#FFFF66" />
                <Columns>
                    <asp:BoundField DataField="nombre" HeaderText="nombre" 
                        SortExpression="nombre" />
                    <asp:BoundField DataField="Column1" DataFormatString="{0:c}" 
                        HeaderText="Column1" ReadOnly="True" SortExpression="Column1" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsVerdeDllsCerrados" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="
SELECT     dbo.empresas.nombre, convert(money,sum(precios.precio*12))
FROM         viajes INNER JOIN
                      precios ON viajes.id_relacion = precios.id_relacion INNER JOIN
                      dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN
                      fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN
                      fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha INNER JOIN
                      Ordenes ON viajes.id_orden = Ordenes.id_orden
WHERE    ordenes.id_status=4 ANd
 (fechas.tipo_fecha = 1) AND 
(viajes.id_status &lt;&gt; 5) AND 
precios.id_moneda=5 and
(viajes.id_status &lt;&gt; 3) AND 
(DATEDIFF(day,  convert(date,fechas.fecha), GETDATE()) &gt;= 1) AND 
(DATEDIFF(day,  convert(date,fechas.fecha), GETDATE()) &lt;= 3) AND 
                      (viajes.id_viaje NOT IN
                          (SELECT     id_viaje
                            FROM          facturacion))
                            group by nombre"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsVerdeMNCerrados" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="
SELECT     dbo.empresas.nombre, convert(money,sum(precios.precio))
FROM         viajes INNER JOIN
                      precios ON viajes.id_relacion = precios.id_relacion INNER JOIN
                      dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN
                      fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN
                      fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha INNER JOIN
                      Ordenes ON viajes.id_orden = Ordenes.id_orden
WHERE    ordenes.id_status=4 ANd
 (fechas.tipo_fecha = 1) AND 
(viajes.id_status &lt;&gt; 5) AND 
precios.id_moneda=4 and
(viajes.id_status &lt;&gt; 3) AND 
(DATEDIFF(day,   convert(date,fechas.fecha), GETDATE()) &gt;= 1) AND 
(DATEDIFF(day,  convert(date,fechas.fecha), GETDATE()) &lt;= 3) AND 
                      (viajes.id_viaje NOT IN
                          (SELECT     id_viaje
                            FROM          facturacion))
                            group by nombre"></asp:SqlDataSource>
        </td>
        <td class="style9">
            <asp:SqlDataSource ID="sdsVerdeDllsBitacora" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="
SELECT     dbo.empresas.nombre, convert(money,sum(precios.precio*12))
FROM         viajes INNER JOIN
                      precios ON viajes.id_relacion = precios.id_relacion INNER JOIN
                      dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN
                      fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN
                      fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha INNER JOIN
                      Ordenes ON viajes.id_orden = Ordenes.id_orden
WHERE    ordenes.id_status=4 ANd
 (fechas.tipo_fecha = 1) AND 
(viajes.id_status &lt;&gt; 5) AND 
precios.id_moneda=5 and
viajes.verificado=1 and
(viajes.id_status &lt;&gt; 3) AND 
(DATEDIFF(day,   convert(date,fechas.fecha), GETDATE()) &gt;= 1) AND 
(DATEDIFF(day,  convert(date,fechas.fecha), GETDATE()) &lt;= 3) AND 
                      (viajes.id_viaje NOT IN
                          (SELECT     id_viaje
                            FROM          facturacion))
                            group by nombre"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsVerdeMNBitacora" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="
SELECT     dbo.empresas.nombre, convert(money,sum(precios.precio))
FROM         viajes INNER JOIN
                      precios ON viajes.id_relacion = precios.id_relacion INNER JOIN
                      dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN
                      fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN
                      fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha INNER JOIN
                      Ordenes ON viajes.id_orden = Ordenes.id_orden
WHERE    ordenes.id_status=4 ANd
 (fechas.tipo_fecha = 1) AND 
(viajes.id_status &lt;&gt; 5) AND 
precios.id_moneda=4 and
(viajes.id_status &lt;&gt; 3) AND 
viajes.verificado=1 and
(DATEDIFF(day,   convert(date,fechas.fecha), GETDATE()) &gt;= 1) AND 
(DATEDIFF(day,  convert(date,fechas.fecha), GETDATE()) &lt;= 3) AND 
                      (viajes.id_viaje NOT IN
                          (SELECT     id_viaje
                            FROM          facturacion))
                            group by nombre"></asp:SqlDataSource>
            <asp:GridView ID="grdVerdeBitacoraMx" runat="server" AutoGenerateColumns="False" 
                DataSourceID="sdsVerdeMNBitacora" EnableModelValidation="True" 
                SkinID="grdAnidado">
                <AlternatingRowStyle BackColor="#FFFF66" />
                <Columns>
                    <asp:BoundField DataField="nombre" HeaderText="nombre" 
                        SortExpression="nombre" />
                    <asp:BoundField DataField="Column1" DataFormatString="{0:c}" 
                        HeaderText="Column1" ReadOnly="True" SortExpression="Column1" />
                </Columns>
            </asp:GridView>
            <asp:GridView ID="grdVerdeBitacoraDlls" runat="server" AutoGenerateColumns="False" 
                DataSourceID="sdsVerdeDllsBitacora" EnableModelValidation="True" 
                SkinID="grdAnidado">
                <AlternatingRowStyle BackColor="#FFFF66" />
                <Columns>
                    <asp:BoundField DataField="nombre" HeaderText="nombre" 
                        SortExpression="nombre" />
                    <asp:BoundField DataField="Column1" DataFormatString="{0:c}" 
                        HeaderText="Column1" ReadOnly="True" SortExpression="Column1" />
                </Columns>
            </asp:GridView>
        </td>
    </tr>
    <tr>
        <td class="style2">
            <img alt="" class="style2" src="../imagenes/YELLOW.png" /></td>
        <td class="style4">
            4-7</td>
        <td class="style9">
            <asp:LinkButton ID="lnkRango2" runat="server">0</asp:LinkButton>
        </td>
        <td class="style1">
            <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" 
                DataSourceID="sdsAmarilloMN" EnableModelValidation="True" SkinID="grdAnidado">
                <AlternatingRowStyle BackColor="#FFFF66" />
                <Columns>
                    <asp:BoundField DataField="nombre" HeaderText="nombre" 
                        SortExpression="nombre" />
                    <asp:BoundField DataField="Column1" DataFormatString="{0:c}" 
                        HeaderText="Column1" ReadOnly="True" SortExpression="Column1" />
                </Columns>
            </asp:GridView>
            <br />
            <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" 
                DataSourceID="sdsAmarilloDlls" EnableModelValidation="True" SkinID="grdAnidado">
                <AlternatingRowStyle BackColor="#FFFF66" />
                <Columns>
                    <asp:BoundField DataField="nombre" HeaderText="nombre" 
                        SortExpression="nombre" />
                    <asp:BoundField DataField="Column1" DataFormatString="{0:c}" 
                        HeaderText="Column1" ReadOnly="True" SortExpression="Column1" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsAmarilloDlls" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT     dbo.empresas.nombre, convert(money,sum(precios.precio*12))
FROM         viajes INNER JOIN
                      precios ON viajes.id_relacion = precios.id_relacion INNER JOIN
                      dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN
                      fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN
                      fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha INNER JOIN
                      Ordenes ON viajes.id_orden = Ordenes.id_orden
WHERE     (fechas.tipo_fecha = 1) AND 
(viajes.id_status &lt;&gt; 5) AND 
precios.id_moneda=5 and
(viajes.id_status &lt;&gt; 3) AND 
(DATEDIFF(day, convert(date,fechas.fecha), GETDATE()) &gt;= 4) AND 
(DATEDIFF(day, convert(date,fechas.fecha), GETDATE()) &lt;= 7) AND 
                      (viajes.id_viaje NOT IN
                          (SELECT     id_viaje
                            FROM          facturacion))
                            group by nombre"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsAmarilloMN" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="
SELECT     dbo.empresas.nombre, convert(money,sum(precios.precio))
FROM         viajes INNER JOIN
                      precios ON viajes.id_relacion = precios.id_relacion INNER JOIN
                      dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN
                      fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN
                      fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha INNER JOIN
                      Ordenes ON viajes.id_orden = Ordenes.id_orden
WHERE     (fechas.tipo_fecha = 1) AND 
(viajes.id_status &lt;&gt; 5) AND 
precios.id_moneda=4 and
(viajes.id_status &lt;&gt; 3) AND 
(DATEDIFF(day,   convert(date,fechas.fecha), GETDATE()) &gt;= 4) AND 
(DATEDIFF(day,  convert(date,fechas.fecha), GETDATE()) &lt;= 7) AND 
                      (viajes.id_viaje NOT IN
                          (SELECT     id_viaje
                            FROM          facturacion))
                            group by nombre"></asp:SqlDataSource>
        </td>
        <td class="style9">
            <asp:GridView ID="GridView13" runat="server" AutoGenerateColumns="False" 
                DataSourceID="sdsAmarilloMNCerrados" EnableModelValidation="True" 
                SkinID="grdAnidado">
                <AlternatingRowStyle BackColor="#FFFF66" />
                <Columns>
                    <asp:BoundField DataField="nombre" HeaderText="nombre" 
                        SortExpression="nombre" />
                    <asp:BoundField DataField="Column1" DataFormatString="{0:c}" 
                        HeaderText="Column1" ReadOnly="True" SortExpression="Column1" />
                </Columns>
            </asp:GridView>
            <asp:GridView ID="GridView17" runat="server" AutoGenerateColumns="False" 
                DataSourceID="sdsAmarilloDllsCerrados" EnableModelValidation="True" 
                SkinID="grdAnidado">
                <AlternatingRowStyle BackColor="#FFFF66" />
                <Columns>
                    <asp:BoundField DataField="nombre" HeaderText="nombre" 
                        SortExpression="nombre" />
                    <asp:BoundField DataField="Column1" DataFormatString="{0:c}" 
                        HeaderText="Column1" ReadOnly="True" SortExpression="Column1" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsAmarilloDllsCerrados" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="
SELECT     dbo.empresas.nombre, convert(money,sum(precios.precio)*12)
FROM         viajes INNER JOIN
                      precios ON viajes.id_relacion = precios.id_relacion INNER JOIN
                      dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN
                      fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN
                      fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha INNER JOIN
                      Ordenes ON viajes.id_orden = Ordenes.id_orden
WHERE    ordenes.id_status=4 ANd
 (fechas.tipo_fecha = 1) AND 
(viajes.id_status &lt;&gt; 5) AND 
precios.id_moneda=5 and
(viajes.id_status &lt;&gt; 3) AND 
(DATEDIFF(day,   convert(date,fechas.fecha), GETDATE()) &gt;= 4) AND 
(DATEDIFF(day,  convert(date,fechas.fecha), GETDATE()) &lt;= 7) AND 
                      (viajes.id_viaje NOT IN
                          (SELECT     id_viaje
                            FROM          facturacion))
                            group by nombre"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsAmarilloMNCerrados" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="
SELECT     dbo.empresas.nombre, convert(money,sum(precios.precio))
FROM         viajes INNER JOIN
                      precios ON viajes.id_relacion = precios.id_relacion INNER JOIN
                      dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN
                      fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN
                      fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha INNER JOIN
                      Ordenes ON viajes.id_orden = Ordenes.id_orden
WHERE    ordenes.id_status=4 ANd
 (fechas.tipo_fecha = 1) AND 
(viajes.id_status &lt;&gt; 5) AND 
precios.id_moneda=4 and
(viajes.id_status &lt;&gt; 3) AND 
(DATEDIFF(day,   convert(date,fechas.fecha), GETDATE()) &gt;= 4) AND 
(DATEDIFF(day,  convert(date,fechas.fecha), GETDATE()) &lt;= 7) AND 
                      (viajes.id_viaje NOT IN
                          (SELECT     id_viaje
                            FROM          facturacion))
                            group by nombre"></asp:SqlDataSource>
        </td>
        <td class="style9">
            <asp:SqlDataSource ID="sdsAmarilloDllsCerradosBitacora" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="
SELECT     dbo.empresas.nombre, convert(money,sum(precios.precio)*12)
FROM         viajes INNER JOIN
                      precios ON viajes.id_relacion = precios.id_relacion INNER JOIN
                      dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN
                      fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN
                      fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha INNER JOIN
                      Ordenes ON viajes.id_orden = Ordenes.id_orden
WHERE    ordenes.id_status=4 ANd
 (fechas.tipo_fecha = 1) AND 
(viajes.id_status &lt;&gt; 5) AND 
precios.id_moneda=5 and
(viajes.id_status &lt;&gt; 3) AND 
viajes.verificado=1 AND
(DATEDIFF(day,   convert(date,fechas.fecha), GETDATE()) &gt;= 4) AND 
(DATEDIFF(day,  convert(date,fechas.fecha), GETDATE()) &lt;= 7) AND 
                      (viajes.id_viaje NOT IN
                          (SELECT     id_viaje
                            FROM          facturacion))
                            group by nombre"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsAmarilloMNCerradosBitacora" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="
SELECT     dbo.empresas.nombre, convert(money,sum(precios.precio))
FROM         viajes INNER JOIN
                      precios ON viajes.id_relacion = precios.id_relacion INNER JOIN
                      dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN
                      fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN
                      fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha INNER JOIN
                      Ordenes ON viajes.id_orden = Ordenes.id_orden
WHERE    ordenes.id_status=4 ANd
 (fechas.tipo_fecha = 1) AND 
(viajes.id_status &lt;&gt; 5) AND 
precios.id_moneda=4 and
viajes.verificado=1 and
(viajes.id_status &lt;&gt; 3) AND 
(DATEDIFF(day,   convert(date,fechas.fecha), GETDATE()) &gt;= 4) AND 
(DATEDIFF(day,  convert(date,fechas.fecha), GETDATE()) &lt;= 7) AND 
                      (viajes.id_viaje NOT IN
                          (SELECT     id_viaje
                            FROM          facturacion))
                            group by nombre"></asp:SqlDataSource>
            <asp:GridView ID="GridView21" runat="server" AutoGenerateColumns="False" 
                DataSourceID="sdsAmarilloMNCerradosBitacora" EnableModelValidation="True" 
                SkinID="grdAnidado">
                <AlternatingRowStyle BackColor="#FFFF66" />
                <Columns>
                    <asp:BoundField DataField="nombre" HeaderText="nombre" 
                        SortExpression="nombre" />
                    <asp:BoundField DataField="Column1" DataFormatString="{0:c}" 
                        HeaderText="Column1" ReadOnly="True" SortExpression="Column1" />
                </Columns>
            </asp:GridView>
            <asp:GridView ID="GridView19" runat="server" AutoGenerateColumns="False" 
                DataSourceID="sdsAmarilloDllsCerradosBitacora" EnableModelValidation="True" 
                SkinID="grdAnidado">
                <AlternatingRowStyle BackColor="#FFFF66" />
                <Columns>
                    <asp:BoundField DataField="nombre" HeaderText="nombre" 
                        SortExpression="nombre" />
                    <asp:BoundField DataField="Column1" DataFormatString="{0:c}" 
                        HeaderText="Column1" ReadOnly="True" SortExpression="Column1" />
                </Columns>
            </asp:GridView>
        </td>
    </tr>
    <tr>
        <td class="style2">
            <img alt="" class="style2" src="../imagenes/AMBER.png" /></td>
        <td class="style4">
            8-14</td>
        <td class="style9">
            <asp:LinkButton ID="lnkRango3" runat="server">0</asp:LinkButton>
        </td>
        <td class="style1">
            <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" 
                DataSourceID="sdsNaranjaMN" EnableModelValidation="True" SkinID="grdAnidado">
                <AlternatingRowStyle BackColor="#FFFF66" />
                <Columns>
                    <asp:BoundField DataField="nombre" HeaderText="nombre" 
                        SortExpression="nombre" />
                    <asp:BoundField DataField="Column1" DataFormatString="{0:c}" 
                        HeaderText="Column1" ReadOnly="True" SortExpression="Column1" />
                </Columns>
            </asp:GridView>
            <br />
            <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" 
                DataSourceID="sdsNaranjaDolares" EnableModelValidation="True" 
                SkinID="grdAnidado">
                <AlternatingRowStyle BackColor="#FFFF66" />
                <Columns>
                    <asp:BoundField DataField="nombre" HeaderText="nombre" 
                        SortExpression="nombre" />
                    <asp:BoundField DataField="Column1" DataFormatString="{0:c}" 
                        HeaderText="Column1" ReadOnly="True" SortExpression="Column1" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsNaranjaDolares" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="                            SELECT     dbo.empresas.nombre, convert(money,sum(precios.precio*12))
FROM         viajes INNER JOIN
                      precios ON viajes.id_relacion = precios.id_relacion INNER JOIN
                      dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN
                      fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN
                      fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha INNER JOIN
                      Ordenes ON viajes.id_orden = Ordenes.id_orden
WHERE     (fechas.tipo_fecha = 1) AND 
(viajes.id_status &lt;&gt; 5) AND 
precios.id_moneda=5 and
(viajes.id_status &lt;&gt; 3) AND 
(DATEDIFF(day, convert(date,fechas.fecha), GETDATE()) &gt;= 8) AND 
(DATEDIFF(day, convert(date,fechas.fecha), GETDATE()) &lt;= 14) AND 
                      (viajes.id_viaje NOT IN
                          (SELECT     id_viaje
                            FROM          facturacion))
                            group by nombre"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sdsNaranjaMN" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="
SELECT     dbo.empresas.nombre, convert(money,sum(precios.precio))
FROM         viajes INNER JOIN
                      precios ON viajes.id_relacion = precios.id_relacion INNER JOIN
                      dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN
                      fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN
                      fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha INNER JOIN
                      Ordenes ON viajes.id_orden = Ordenes.id_orden
WHERE     (fechas.tipo_fecha = 1) AND 
(viajes.id_status &lt;&gt; 5) AND 
precios.id_moneda=4 and
(viajes.id_status &lt;&gt; 3) AND 
(DATEDIFF(day,   convert(date,fechas.fecha), GETDATE()) &gt;= 8) AND (DATEDIFF(day,  convert(date,fechas.fecha), GETDATE()) &lt;= 14) AND 
                      (viajes.id_viaje NOT IN
                          (SELECT     id_viaje
                            FROM          facturacion))
                            group by nombre"></asp:SqlDataSource>
        </td>
        <td class="style9">
            &nbsp;</td>
        <td class="style9">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style2">
            <img alt="" class="style2" src="../imagenes/RED.png" /></td>
        <td class="style4">
            14+</td>
        <td class="style9">
            <asp:LinkButton ID="lnkRango4" runat="server">0</asp:LinkButton>
        </td>
        <td class="style1">
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                DataSourceID="sdsRojo" EnableModelValidation="True" SkinID="grdAnidado">
                <AlternatingRowStyle BackColor="#FFFF66" />
                <Columns>
                    <asp:BoundField DataField="nombre" HeaderText="nombre" 
                        SortExpression="nombre" />
                    <asp:BoundField DataField="Column1" DataFormatString="{0:c}" 
                        HeaderText="Column1" ReadOnly="True" SortExpression="Column1" />
                </Columns>
            </asp:GridView>
            <br />
            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
                DataSourceID="SdsRojoDolares" EnableModelValidation="True" SkinID="grdAnidado">
                <AlternatingRowStyle BackColor="#FFFF66" />
                <Columns>
                    <asp:BoundField DataField="nombre" HeaderText="nombre" 
                        SortExpression="nombre" />
                    <asp:BoundField DataField="Column1" DataFormatString="{0:c}" 
                        HeaderText="Column1" ReadOnly="True" SortExpression="Column1" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsRojo" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT     dbo.empresas.nombre, convert(money,sum(precios.precio))
FROM         viajes INNER JOIN
                      precios ON viajes.id_relacion = precios.id_relacion INNER JOIN
                      dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN
                      fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN
                      fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha INNER JOIN
                      Ordenes ON viajes.id_orden = Ordenes.id_orden
WHERE     (fechas.tipo_fecha = 1) AND 
(viajes.id_status &lt;&gt; 5) AND 
precios.id_moneda=4 and
(viajes.id_status &lt;&gt; 3) AND 
(DATEDIFF(day,  convert(date,fechas.fecha), GETDATE()) &gt;= 14) AND 
(DATEDIFF(day, convert(date,fechas.fecha), GETDATE()) &lt;=1000) AND 
                      (viajes.id_viaje NOT IN
                          (SELECT     id_viaje
                            FROM          facturacion))
                            group by nombre"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SdsRojoDolares" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT     dbo.empresas.nombre, convert(money,sum(precios.precio*12))
FROM         viajes INNER JOIN
                      precios ON viajes.id_relacion = precios.id_relacion INNER JOIN
                      dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN
                      fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN
                      fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha INNER JOIN
                      Ordenes ON viajes.id_orden = Ordenes.id_orden
WHERE     (fechas.tipo_fecha = 1) AND 
(viajes.id_status &lt;&gt; 5) AND 
precios.id_moneda=5 and
(viajes.id_status &lt;&gt; 3) AND 
(DATEDIFF(day, convert(date,fechas.fecha), GETDATE()) &gt;= 14) AND 
(DATEDIFF(day, convert(date,fechas.fecha), GETDATE()) &lt;= 1000) AND 
                      (viajes.id_viaje NOT IN
                          (SELECT     id_viaje
                            FROM          facturacion))
                            group by nombre"></asp:SqlDataSource>
        </td>
        <td class="style9">
            &nbsp;</td>
        <td class="style9">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style2">
            &nbsp;</td>
        <td class="style4">
            Total</td>
        <td class="style9">
            <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label>
        </td>
        <td class="style1">
            &nbsp;</td>
        <td class="style9">
            &nbsp;</td>
        <td class="style9">
            &nbsp;</td>
    </tr>
</table>
                           </td>
                           <td class="style10">
                               <br />
                               <asp:ImageButton ID="ImageButton1" runat="server" Height="26px" 
                                   ImageUrl="~/imagenes/close.png" Width="27px" />
         <asp:GridView ID="grdDetalle" 
                 runat="server" AutoGenerateColumns="False" EnableModelValidation="True" 
                 SkinID="GridView1">
             <Columns>
                 <asp:BoundField DataField="id_orden">
                 <ItemStyle Font-Size="0pt" Width="0px" />
                 </asp:BoundField>
                 <asp:TemplateField HeaderText="FECHA CIERRE">
                     <ItemTemplate>
                         <asp:Label ID="lblCierre" runat="server"></asp:Label>
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:TemplateField HeaderText="VERIFICADO">
                     <ItemTemplate>
                         <asp:Image ID="Image1" runat="server" ImageUrl="~/imagenes/ok.png" 
                             Visible="<%# bind('verificado') %>" />
                     </ItemTemplate>
                 </asp:TemplateField>
                 <asp:BoundField DataField="orden" HeaderText="ORDEN" />
                 <asp:BoundField DataField="nombre" HeaderText="CLIENTE" />
                 <asp:BoundField DataField="ruta" HeaderText="RUTA" />
                 <asp:BoundField DataField="fecha" DataFormatString="{0:d}" 
                     HeaderText="FECHA VIAJE" />
                 <asp:BoundField DataField="diferencia" HeaderText="DIAS" />
             </Columns>
</asp:GridView>
                           </td>
                       </tr>
                   </table>

        <div id="col1" style="float:left; text-align: left;">
        </div>
        <div id="col3" style="float:left; text-align: left;">        
        </div>
         <div id="col2" style="float:left; text-align: left;">
        </div>

        </div>












