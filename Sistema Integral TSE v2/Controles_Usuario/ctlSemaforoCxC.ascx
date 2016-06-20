<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlSemaforoCxC.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlSemaforoCxC" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="1" 
    Height="342px" Width="789px" >
<asp:TabPanel ID="TabPanel1" runat="server" HeaderText="Indicadores"> 
    <ContentTemplate>
        <asp:GridView 
                ID="GridView1" runat="server" AutoGenerateColumns="False" 
                DataSourceID="sdsResumen" EnableModelValidation="True"><Columns><asp:BoundField 
                    DataField="viajes" HeaderText="VIAJES" ReadOnly="True" 
                    SortExpression="viajes" /><asp:BoundField DataField="rango" 
                    HeaderText="RANGO" ReadOnly="True" SortExpression="rango" /></Columns></asp:GridView><asp:SqlDataSource 
                ID="sdsResumen" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                SelectCommand="select count(*) viajes,'0 a 20 dias' as rango from semaforoCuentasXCobrar() where diferencia between 0 and 20
        union all
        select count(*) viajes,'21 a 30 dias' as rango from semaforoCuentasXCobrar() where diferencia between 21 and 30
        union all
        select count(*) viajes,'31 a 60 dias' as rango from semaforoCuentasXCobrar() where diferencia between 31 and 60
        union all
        select count(*) viajes,'mas de 61 dias' as rango from semaforoCuentasXCobrar() where diferencia &gt;61">
        </asp:SqlDataSource>
    </ContentTemplate>
    </asp:TabPanel>
    <asp:TabPanel ID="TabPanel2" runat="server" HeaderText="Detalle">
        <ContentTemplate>
            
        <br />Rango <asp:DropDownList ID="ddlRango" runat="server" Height="18px" 
                Width="159px"></asp:DropDownList><asp:Button ID="btnConsultar" 
                runat="server" Text="Consultar" /><br /><br />
            <asp:GridView ID="GridView2" 
                runat="server" AutoGenerateColumns="False" DataSourceID="sdsDetalles" 
                EnableModelValidation="True" Width="635px"><Columns><asp:BoundField DataField="folio" 
                        HeaderText="FACTURA" SortExpression="folio" /><asp:BoundField 
                        DataField="fechaFactura" HeaderText="FECHA FACTURACION" 
                        SortExpression="fechaFactura" /><asp:BoundField DataField="total" 
                        DataFormatString="{0:c0}" HeaderText="IMPORTE" SortExpression="total" /><asp:BoundField 
                        DataField="cliente" HeaderText="CLIENTE" SortExpression="cliente" /><asp:BoundField 
                        DataField="diferencia" HeaderText="DIAS TRANSCURRIDO" 
                        SortExpression="diferencia" /></Columns></asp:GridView><asp:SqlDataSource 
                ID="sdsDetalles" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="select * from semaforoCuentasXCobrar() where diferencia
                 between @inicio and @fin
                order by 
                diferencia
                desc">
                <SelectParameters><asp:Parameter Name="inicio" />
                <asp:Parameter Name="fin" />
                </SelectParameters>
                </asp:SqlDataSource>
                </ContentTemplate>
    </asp:TabPanel>
</asp:TabContainer>

