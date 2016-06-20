<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Facturax1b2ASin_orden.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Facturax1b2ASin_orden" %>

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
                        Width="200px" AutoPostBack="True">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            
                        
                        
                        SelectCommand="SELECT nombre, id_empresa FROM dbo.empresas WHERE (id_tipo_empresa = 1) AND (id_status = 5)  ORDER BY nombre">
        </asp:SqlDataSource>
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
                    <asp:Button runat="server" ID="btnImprimir"  Text="Imprimir"  />
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
                    &nbsp;</td>
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
