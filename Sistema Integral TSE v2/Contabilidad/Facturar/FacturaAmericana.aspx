﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FacturaAmericana.aspx.vb" Inherits="Sistema_Integral_TSE_v45.FacturaAmericana" %>

<%@ Register src="../../Controles_Usuario/barraFacturacion.ascx" tagname="barraFacturacion" tagprefix="uc1" %>

<%@ Register src="../../Controles_Usuario/ctlFormatoFacturaAmericana.ascx" tagname="ctlFormatoFacturaAmericana" tagprefix="uc2" %>

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
        function hide() {
            document.poppedLayer = eval('document.getElementById("hide")');
            document.poppedLayer.style.visibility = "hidden";
            window.print();
        }
    </script>   
     <script type="text/javascript">
         $(document).ready(function () {
             $("#btnImprimir").click(function () {
                 $("#factura").printElement();
             });
         });
</script> 
    <style type="text/css">
        #hide
        {
            height: 311px;
            top: 798px;
            left: 21px;
        }
        .style24
        {
            width: 185px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="factura" style="width: 1098px; height: 639px;">
        <br />
    <br />
    <br />
        <uc2:ctlFormatoFacturaAmericana ID="ctlFormatoFacturaAmericana1" 
            runat="server" />
    <br />
       
    <br />
    </div>
    <div>
    </div>
    <div id="hide" style="position: absolute">
        <table class="style7">
            <tr>
                <td class="style24">
                    Factura: 
                    <asp:Label ID="lblFolioA" runat="server"></asp:Label>
                </td>
                <td class="style12">
                    Viajes sin facturar:
                    <asp:LinkButton ID="lnkSinFactura" runat="server" CausesValidation="False"></asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td class="style24">
        <asp:DropDownList ID="ddlOrden" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource1" DataTextField="orden" DataValueField="id_viaje">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="SELECT     CONVERT(nvarchar, Ordenes.ano) + '-' + CONVERT(nvarchar, Ordenes.consecutivo) + '-' + CONVERT(nvarchar, viajes.num_viaje) 
                      + ' ' + dbo.empresas.nombre AS orden, viajes.id_viaje
FROM         viajes INNER JOIN
                      Ordenes ON viajes.id_orden = Ordenes.id_orden INNER JOIN
                      precios ON viajes.id_relacion = precios.id_relacion INNER JOIN
                      dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN
                      dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN
                      fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje AND viajes.id_viaje = fechas_viaje.id_viaje AND viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN
                      fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha
WHERE fechas.tipo_fecha=1 and  datediff(day,fechas.fecha,getdate())&lt;200 and   (viajes.id_viaje NOT IN
                          (SELECT     facturacion.id_viaje
                            FROM          fechas AS fechas_1 INNER JOIN
                                                   fechas_facturacion ON fechas_1.id_fecha = fechas_facturacion.id_fecha INNER JOIN
                                                   facturas ON fechas_facturacion.id_factura = facturas.id_factura INNER JOIN
                                                   facturacion ON facturas.id_factura = facturacion.id_factura INNER JOIN
                                                   viajes AS viajes_1 ON facturacion.id_viaje = viajes_1.id_viaje INNER JOIN
                                                   precios AS precios_1 ON viajes_1.id_relacion = precios_1.id_relacion
                            WHERE      (fechas_1.tipo_fecha = 4) AND (DATEDIFF(day, fechas_1.fecha, GETDATE()) &gt;200)))
ORDER BY ordenes.ano desc, Ordenes.consecutivo DESC">
        </asp:SqlDataSource>
                    <br />
                    Facturar a:
                    <asp:DropDownList ID="ddlEmpresa" runat="server" 
                        DataSourceID="SqlDataSource2" DataTextField="razon_social" 
                        DataValueField="id_dato" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT datos_facturacion.id_dato, datos_facturacion.razon_social FROM viajes INNER JOIN precios ON viajes.id_relacion = precios.id_relacion INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN datos_facturacion ON dbo.empresas.id_empresa = datos_facturacion.id_empresa WHERE (viajes.id_viaje = @id_viaje)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlOrden" Name="id_viaje" 
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                    <asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnActualizar" 
                        style="height: 16px; width: 14px;" />
&nbsp;Crear Factura</td>
                <td class="style12">
                    <uc1:barraFacturacion ID="barraFacturacion1" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="style24">
                    <asp:Button runat="server" ID="btnImprimir"  Text="Imprimir" 
                        onclientclick="hide();" Enabled="False"  />
                &nbsp;
                    <asp:Button ID="btnNueva" runat="server" Text="Nueva" />
                </td>
                <td class="style12">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style24">
                    <asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>
                &nbsp;<asp:LinkButton ID="lnkCancelarOrden" runat="server" Visible="False">Cancelar Orden</asp:LinkButton>
                </td>
                <td class="style8">
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
