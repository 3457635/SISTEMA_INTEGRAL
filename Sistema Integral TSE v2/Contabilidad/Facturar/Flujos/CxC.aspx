<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="CxC.aspx.vb" Inherits="Sistema_Integral_TSE_v45.CxC" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <br />
    Servicios facturados
    
&nbsp;en M.N.
     <div style =" background-color:Green;  
        height:30px;width:715px; margin:0;padding:0">
<table cellspacing="0" cellpadding = "0" rules="all" border="1" id="tblHeader"
 style="font-family:Arial;font-size:10pt;width:600px;color:white;
 border-collapse:collapse;height:100%;">
    <tr>
       <td style ="width:14px; text-align:center">FACTURA</td>
       <td style ="width:60px; text-align:center">IMPORTE</td>
       <td style ="width:182px; text-align:center">ORDEN</td>       
    </tr>
</table>
</div>
<div style ="height:619px; width:745px; overflow:auto;">
    <asp:GridView 
        ID="grd" runat="server" CssClass="Grid"
        BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" 
        BorderWidth="1px" ShowHeader="False"
        RowStyle-VerticalAlign="Bottom" 
        CellPadding="3" EnableModelValidation="True" AutoGenerateColumns="False" 
        Width="717px">
        

        <Columns>
            <asp:BoundField DataField="id_factura" ShowHeader="False">
            
            <ItemStyle BorderStyle="Solid" ForeColor="White" />
            </asp:BoundField>
            <asp:BoundField DataField="folio" HeaderText="FACTURA" >
            
            <ItemStyle VerticalAlign="Middle" />
            
            </asp:BoundField>
            <asp:BoundField DataField="importe" HeaderText="IMPORTE" 
                DataFormatString="{0:c}" >
            
            <ItemStyle VerticalAlign="Middle" />
            
            </asp:BoundField>
            <asp:TemplateField HeaderText="ORDEN">
                <ItemTemplate>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  
                         DataSourceID="SqlDataSource1" 
                        EnableModelValidation="True" BorderStyle="None" 
                        ShowHeader="False" GridLines="None">
                        <Columns>
                            <asp:BoundField DataField="orden" HeaderText="orden" SortExpression="orden" 
                                ReadOnly="True" >
                            <ItemStyle Width="100px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="nombre" HeaderText="nombre" SortExpression="nombre">
                            <ItemStyle Width="200px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ruta" HeaderText="ruta" SortExpression="ruta">
                            <ItemStyle Width="200px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="equipo" HeaderText="equipo" SortExpression="equipo">
                            <ItemStyle Width="100px" />
                            </asp:BoundField>
                        </Columns>
                    </asp:GridView>
                   
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        
                        
                        SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) AS orden, dbo.empresas.nombre, dbo.llave_rutas.ruta, tipo_equipos.equipo FROM Ordenes INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN facturacion ON viajes.id_viaje = facturacion.id_viaje INNER JOIN precios ON viajes.id_relacion = precios.id_relacion AND viajes.id_relacion = precios.id_relacion AND viajes.id_relacion = precios.id_relacion INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN tipo_equipos ON precios.id_tipo_recurso = tipo_equipos.id_tipo_equipo WHERE (facturacion.id_factura = @id_factura)">
                        <SelectParameters>
                            <asp:Parameter Name="id_factura" DefaultValue="" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                   
                </ItemTemplate>
                
                <ItemStyle VerticalAlign="Middle" />
                
            </asp:TemplateField>
        </Columns>
        <FooterStyle BackColor="White" ForeColor="#000066" />
        <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" 
            CssClass="DataGridFixedHeader" />
        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
        <RowStyle ForeColor="#000066" />
        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
    </asp:GridView></div>
    <br />
    <br />
    <br />
    </asp:Content>
