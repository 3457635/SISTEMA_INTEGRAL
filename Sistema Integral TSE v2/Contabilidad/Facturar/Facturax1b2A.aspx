<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Facturax1b2A.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Facturax1b2A" %>

<%@ Register src="../../Controles_Usuario/ctlFormatoFactura.ascx" tagname="ctlFormatoFactura" tagprefix="uc1" %>

<%@ Register src="../../Controles_Usuario/ctlFormatoFacturaAmerica.ascx" tagname="ctlFormatoFacturaAmerica" tagprefix="uc2" %>

<%@ Register src="../../Controles_Usuario/barraFacturacion.ascx" tagname="barraFacturacion" tagprefix="uc3" %>

<%@ Register src="../../Controles_Usuario/ctlFormatoFacturaAmericana.ascx" tagname="ctlFormatoFacturaAmericana" tagprefix="uc4" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../../Script/jquery-1.8.3.js" type="text/javascript"></script>
    <script src="../../Script/jQuery.printElement.js" type="text/javascript"></script>
   <script type="text/javascript">
       $(document).ready(function () {
           $("#btnConLineas").click(function () {
               $("input:text").css("border-style", "Solid");
               $("input:text").css("border-color", "black");
               $("input:text").css("border-width", "1px");
           });


           $("#btnQuitarLineas").click(function () {
               $("input:text").css("border-style", "none");
           });


       });
        
    </script>  

    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnImprimir").click(function () {
                $("#factura").printElement();
            });
        });
</script>

    <%--<script type="text/javascript">
        function imprSelec(factura)
        { var ficha = document.getElementById(factura); var ventimp = window.open(' ', 'popimpr'); ventimp.document.write(ficha.innerHTML); ventimp.document.close(); ventimp.print(); ventimp.close(); }
</script> --%>    <%--<script type="text/javascript">
        function hide() {
            document.poppedLayer = eval('document.getElementById("hide")');
            document.poppedLayer.style.visibility = "hidden";
            window.print();
        }
    </script>   --%>
   <style type="text/css">
        #hide
        {
            top: 803px;
            left: 32px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
   
    <div id="factura" style="width: 100%; text-align: left;">
         <uc4:ctlFormatoFacturaAmericana ID="ctlFormatoFacturaAmericana1" 
        runat="server" />
        
    </div>
    
    <div id="hide" style="position: absolute">
        <table class="style7">
            <tr>
                <td class="style12">
                    Factura: 
                    <asp:Label ID="lblFolio" runat="server"></asp:Label>
                    <br />
                    <br />
                    Viajes sin facturar:
                    <asp:LinkButton ID="lnkSinFactura" runat="server" CausesValidation="False"></asp:LinkButton>
                </td>
                <td class="style13">
                    &nbsp;</td>
                <td class="style11">
                    <uc3:barraFacturacion ID="barraFacturacion1" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="style12">
                    <asp:Label ID="Label1" runat="server" Text="Cliente"></asp:Label>
        <asp:DropDownList ID="ddlEmpresa" runat="server" 
            DataSourceID="SqlDataSource1" DataTextField="nombre" DataValueField="id_empresa" 
                        Width="200px">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            
                        
                        
                        SelectCommand="SELECT nombre, id_empresa FROM dbo.empresas WHERE (id_tipo_empresa = 1) AND (id_status = 5)  ORDER BY nombre">
        </asp:SqlDataSource>
                    <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" Height="16px">
                        <asp:ListItem Value="true">Facturado</asp:ListItem>
                        <asp:ListItem Value="false">No facturado</asp:ListItem>
                    </asp:RadioButtonList>
                &nbsp;<asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>
                &nbsp;<asp:LinkButton ID="lnkCancelarOrden" runat="server" Visible="False">Cancelar orden anterior.</asp:LinkButton>
                    <br />
                    <br />
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        
                        
                        
                        SelectCommand="SELECT datos_facturacion.id_dato, datos_facturacion.razon_social FROM datos_facturacion   WHERE datos_facturacion.id_empresa=@idEmpresa">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlEmpresa" Name="idEmpresa" 
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:DropDownList ID="ddlDatoFacturacion" runat="server" 
                        DataSourceID="SqlDataSource4" DataTextField="razon_social" 
                        DataValueField="id_dato" AutoPostBack="True">
                    </asp:DropDownList>
                    <br />
                    <br />
                    &nbsp;&nbsp;<asp:ImageButton 
                        ID="ImageButton1" runat="server" 
                        SkinID="ibtnActualizar" style="width: 14px" />
                    Generar factura<br /> &nbsp;
                    <br />
                    <asp:Button runat="server" ID="btnImprimir"  Text="Imprimir" 
                         Enabled="False"  />
                &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="Button2" runat="server" Text="Nueva Factura" />
                </td>
                <td class="style13">
                    <asp:Label
    ID="lblTC" runat="server" Text=""></asp:Label>
                </td>
                <td class="style11">
                    Tipo de Cambio:
        <asp:TextBox ID="txbTc" runat="server"></asp:TextBox> &nbsp;<asp:ImageButton
        ID="ibtnTC" runat="server" AlternateText="Refresh" 
            ImageUrl="~/imagenes/refresh.png" CausesValidation="False" />        
                    <br />
                </td>
            </tr>
            <tr>
                <td class="style12">
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        
                        
                        SelectCommand="SELECT     CONVERT(nvarchar, Ordenes.ano) + '-' + CONVERT(nvarchar, Ordenes.consecutivo) + '-' + CONVERT(nvarchar, viajes.num_viaje) 
                      + '(' + dbo.llave_rutas.ruta + ', ' + tipo_equipos.equipo + ')' AS orden, viajes.id_viaje
FROM         Ordenes INNER JOIN
                      viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN
                      precios ON viajes.id_relacion = precios.id_relacion INNER JOIN
                      dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN
                      dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN
                      tipo_equipos ON precios.id_tipo_recurso = tipo_equipos.id_tipo_equipo INNER JOIN
                      fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje AND viajes.id_viaje = fechas_viaje.id_viaje AND viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN
                      fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha
WHERE empresas.id_empresa=@id_empresa and viajes.facturado=@facturado and viajes.id_status &lt;&gt;5 and viajes.id_status &lt;&gt; 3 and datediff(day,fechas.fecha,getdate())&lt;300 and fechas.tipo_fecha=1 AND (viajes.id_viaje NOT IN
                          (SELECT     facturacion.id_viaje
                            FROM          fechas AS fechas_1 INNER JOIN
                                                   fechas_facturacion ON fechas_1.id_fecha = fechas_facturacion.id_fecha INNER JOIN
                                                   facturas ON fechas_facturacion.id_factura = facturas.id_factura INNER JOIN
                                                   facturacion ON facturas.id_factura = facturacion.id_factura INNER JOIN
                                                   viajes AS viajes_1 ON facturacion.id_viaje = viajes_1.id_viaje INNER JOIN
                                                   precios AS precios_1 ON viajes_1.id_relacion = precios_1.id_relacion
                            WHERE      (fechas_1.tipo_fecha = 4) AND (DATEDIFF(day, fechas_1.fecha, GETDATE()) &gt; 300) ))
ORDER BY ordenes.ano desc, Ordenes.consecutivo DESC">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlEmpresa" Name="id_empresa" 
                                PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="RadioButtonList1" Name="facturado" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:CheckBoxList ID="CheckBoxList1" runat="server" 
                        DataSourceID="SqlDataSource2" DataTextField="orden" 
                        DataValueField="id_viaje">
                    </asp:CheckBoxList>
                </td>
                <td class="style13">
                    &nbsp;</td>
                <td class="style11">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style12">
                    &nbsp;</td>
                <td class="style13">
                    &nbsp;</td>
                <td class="style11">
                    <asp:TextBox ID="txbRelacion1" runat="server" Height="21px" SkinID="txbFactura" 
                        Width="46px" Visible="False"></asp:TextBox>
                    <asp:TextBox ID="txbRelacion2" runat="server" Height="25px" SkinID="txbFactura" 
                        Width="44px" Visible="False"></asp:TextBox>
                    <asp:TextBox ID="txbRelacion3" runat="server" Height="25px" SkinID="txbFactura" 
                        Width="44px" Visible="False"></asp:TextBox>
                    <asp:TextBox ID="txbRelacion4" runat="server" Height="25px" SkinID="txbFactura" 
                        Width="44px" Visible="False"></asp:TextBox>
                    <asp:TextBox ID="txbRelacion5" runat="server" Height="25px" SkinID="txbFactura" 
                        Width="44px" Visible="False"></asp:TextBox>
                    <asp:TextBox ID="txbRelacion6" runat="server" Height="25px" SkinID="txbFactura" 
                        Width="44px" Visible="False"></asp:TextBox>
                    <asp:TextBox ID="txbIdViaje" runat="server" Visible="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style8" colspan="3">
                    &nbsp;</td>
            </tr>
        </table>
&nbsp;&nbsp;&nbsp;        
        <br />
        <br />
        <br />
</div>
    </form>
</body>
</html>
