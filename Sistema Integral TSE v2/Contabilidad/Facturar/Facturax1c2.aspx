<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Facturax1c2.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Facturax1c2" %>

<%@ Register src="../../Controles_Usuario/ctlFormatoFactura.ascx" tagname="ctlFormatoFactura" tagprefix="uc1" %>

<%@ Register src="../../Controles_Usuario/barraFacturacion.ascx" tagname="barraFacturacion" tagprefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title></title>
     <script src="../../Script/jquery-1.8.3.js" type="text/javascript"></script>
    <script src="../../Script/jQuery.printElement.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnConLineas").click(function () {
                $("input:text").css("border-style", "Solid")
                $("input:text").css("border-color", "black")
                $("input:text").css("border-width", "1px")
                $("input:textarea").css("border-style", "Solid")
                $("input:textarea").css("border-color", "black")
                $("input:textarea").css("border-width", "1px")
            });


            $("#btnQuitarLineas").click(function () {
$("input:text").css("border-style", "none")
                $("input:textarea").css("border-style", "none")
                
            });


        });
        
    </script>   
   <%-- <script type="text/javascript">
        function imprimirFac(factura) 
        {
            var ficha = document.getElementById(factura);
            var ventimp = window.open(' ', 'popimpr');
            ventimp.document.write(ficha.innerHTML);
            ventimp.document.close();
            ventimp.print();
            ventimp.close();
            
         }
</script>--%>


<script type="text/javascript">
$(document).ready(function () {
    $("#btnImprimir").click(function () {
        $("#factura").printElement();
    });
});
</script>

<%--<script type="text/javascript">
    function imprimirFac2(factura) {
        //Get the HTML of div
        var divElements = document.getElementById(factura).innerHTML;
        //Get the HTML of whole page
        var oldPage = document.body.innerHTML;

        //Reset the page's HTML with div's HTML only
        document.body.innerHTML = divElements ;

        //Print Page
        window.print();

        //Restore orignal HTML
        document.body.innerHTML = oldPage;
    }
</script>--%>

   <%-- <script type="text/javascript">
        function hide() {
            document.poppedLayer = eval('document.getElementById("hide")');
            document.poppedLayer.style.visibility = "hidden";
            window.print();
        }
        function btnConLineas_onclick() {

        }

    </script>   --%>
    <style type="text/css">
        .style1
        {
            width: 40px;
        }
        #hide
        {
            top: 745px;
            left: 47px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
   <div id="factura" style="width:100%; position: absolute;">
       <uc1:ctlFormatoFactura ID="ctlFormatoFactura1" runat="server" />  
       </div>     
    <div id="hide" style="position: absolute">
        <table class="style7">
            <tr>
                <td class="style12">
                    Factura: <asp:TextBox ID="txbFolio" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ErrorMessage="RequiredFieldValidator" ControlToValidate="txbFolio"></asp:RequiredFieldValidator>
                    <br />
                    <br />
                    Viajes sin facturar:
                    <asp:LinkButton ID="lnkSinFactura" runat="server" CausesValidation="False"></asp:LinkButton>
                    <br />
                    <asp:DropDownList ID="ddlDatoFacturacion" runat="server" 
                        DataSourceID="SqlDataSource3" DataTextField="razon_social" 
                        DataValueField="id_dato">
                    </asp:DropDownList>
                    <br />
                    Crear Factura
                    <asp:ImageButton ID="ImageButton2" runat="server" SkinID="ibtnActualizar" 
                        style="height: 16px" />
                &nbsp;
                    <input id="btnConLineas" type="button" value="Mostrar Lineas"  onclick="return btnConLineas_onclick()" />&nbsp;&nbsp;
                    <input id="btnQuitarLineas" type="button" value="Quitar Lineas" /> <asp:SqlDataSource 
                        ID="SqlDataSource3" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        
                        
                        SelectCommand="SELECT id_dato, razon_social FROM datos_facturacion WHERE (id_empresa = @idEmpresa)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlEmpresa" Name="idEmpresa" 
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    </td>
                <td class="style1">
                    &nbsp;</td>
                <td class="style11">
                    &nbsp;         
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False">Datos de facturación</asp:LinkButton>
                    <br />
                    <br />
                    <uc2:barraFacturacion ID="barraFacturacion1" runat="server" />
                    <br />
                    <br />
                    <asp:Label
    ID="lblTC" runat="server" Text=""></asp:Label>
                    <br />
                    <br />
                    <asp:Label ID="lblAnuncio" 
            runat="server" Text="Tipo de Cambio: " Visible="False"></asp:Label>
        <asp:TextBox ID="txbTc" runat="server"></asp:TextBox> &nbsp;<asp:ImageButton
        ID="ImageButton1" runat="server" AlternateText="Refresh" 
            ImageUrl="~/imagenes/refresh.png" />        
                    <br />
                    <br />
                    <br />
                    <asp:Button ID="Button1" runat="server" CausesValidation="False" 
                        Text="Regresar" SkinID="btn" />
                </td>
            </tr>
            <tr>
                <td class="style12">
        <asp:DropDownList ID="ddlEmpresa" runat="server" AutoPostBack="True" 
            DataSourceID="SqlDataSource1" DataTextField="nombre" DataValueField="id_empresa">
        </asp:DropDownList>
        &nbsp;&nbsp;
                    &nbsp;<asp:Button runat="server" ID="btnImprimir"  Text="Imprimir" 
                        OnClick="btnImprimir_Click"  Enabled="False" SkinID="btn"  />
        &nbsp;&nbsp;&nbsp;
                    <asp:Button ID="Button2" runat="server" Text="Limpiar Factura" SkinID="btn" />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            
                        
                        
                        SelectCommand="SELECT nombre, id_empresa FROM dbo.empresas WHERE (id_tipo_empresa = 1) AND (id_status = 5) ORDER BY nombre">
        </asp:SqlDataSource>
                    <asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>
                    <asp:LinkButton ID="lnkCancelarOrden" runat="server" Visible="False">Cancelar factura anterior. </asp:LinkButton>
                    &nbsp;<asp:CheckBoxList ID="CheckBoxList1" runat="server" 
                        DataSourceID="SqlDataSource2" DataTextField="orden" 
                        DataValueField="id_viaje">
                    </asp:CheckBoxList>
                </td>
                <td class="style1">
                    &nbsp;</td>
                <td class="style11">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style12">
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        
                        
                        
                        
                        
                        
                        SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + CONVERT (nvarchar, viajes.num_viaje) + '(' + dbo.llave_rutas.ruta + ')' AS orden, viajes.id_viaje, Ordenes.consecutivo FROM Ordenes INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN precios ON viajes.id_relacion = precios.id_relacion INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje AND viajes.id_viaje = fechas_viaje.id_viaje AND viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha WHERE (DATEDIFF(day, fechas.fecha, GETDATE()) &lt; 300) AND (fechas.tipo_fecha = 1) AND (viajes.id_viaje NOT IN (SELECT facturacion.id_viaje FROM fechas AS fechas_1 INNER JOIN fechas_facturacion ON fechas_1.id_fecha = fechas_facturacion.id_fecha INNER JOIN facturas ON fechas_facturacion.id_factura = facturas.id_factura INNER JOIN facturacion ON facturas.id_factura = facturacion.id_factura INNER JOIN viajes AS viajes_1 ON facturacion.id_viaje = viajes_1.id_viaje INNER JOIN precios AS precios_1 ON viajes_1.id_relacion = precios_1.id_relacion WHERE (DATEDIFF(day, fechas_1.fecha, GETDATE()) &gt; 300))) AND (dbo.empresas.id_empresa = @id_empresa) ORDER BY Ordenes.ano DESC, Ordenes.consecutivo DESC">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlEmpresa" Name="id_empresa" 
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td class="style1">
                    &nbsp;</td>
                <td class="style11">
                    <asp:TextBox ID="txbIdViaje" runat="server" Visible="False"></asp:TextBox>
                </td>
            </tr>
            </table>
&nbsp;&nbsp;&nbsp;        
        </div>
    </form>
</body>
</html>
