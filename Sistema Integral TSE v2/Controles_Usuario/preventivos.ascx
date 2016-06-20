<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="preventivos.ascx.vb" Inherits="Sistema_Integral_TSE_v45.preventivos1" %>
<p>
    <br />
    <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" 
        DataSourceID="sdsPreventivos" EnableModelValidation="True" ForeColor="Red">
        <Columns>
            <asp:BoundField DataField="economico" HeaderText="Unidad" 
                SortExpression="economico" />
            <asp:BoundField DataField="diferencia" 
                HeaderText="kilometros restantes siguiente servicio." ReadOnly="True" 
                SortExpression="diferencia" />
        </Columns>
        <RowStyle ForeColor="Red" />
    </asp:GridView>
    </p>
    <asp:SqlDataSource ID="sdsPreventivos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand=" SELECT eo.economico,p1.proximoServicio- ds.odometro as diferencia from 
 preventivos  p1
 cross apply (
 select top 1 odometro
 from odometros 
 where odometros.id_equipo=p1.id_equipo
 order by id_odometro desc
 ) as ds
 inner join equipo_operacion eo on p1.id_equipo=eo.id_equipo
 where id in (select max(id) from preventivos p2 group by p2.id_equipo) and p1.proximoServicio- ds.odometro&lt;2000 and p1.proximoServicio&gt;0
  order by eo.economico"></asp:SqlDataSource>
    
