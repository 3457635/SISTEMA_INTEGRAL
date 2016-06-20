<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FacturaCajasv3.aspx.vb" Inherits="Sistema_Integral_TSE_v45.FacturaCajasv3" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register src="../../Controles_Usuario/ctlFormatoFactura.ascx" tagname="ctlFormatoFactura" tagprefix="uc1" %>

<%@ Register src="../../Controles_Usuario/barraFacturacion.ascx" tagname="barraFacturacion" tagprefix="uc2" %>

<%@ Register src="../../Controles_Usuario/ctlFormatoCFDI.ascx" tagname="ctlFormatoCFDI" tagprefix="uc3" %>

<%@ Register src="../../Controles_Usuario/ctlMail.ascx" tagname="ctlMail" tagprefix="uc4" %>

<%@ Register src="../../Controles_Usuario/ctlCancelarCFDI.ascx" tagname="ctlCancelarCFDI" tagprefix="uc5" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../Styles.css" rel="stylesheet" type="text/css" />
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
    <script type="text/javascript">
        function hide() {
            document.poppedLayer = eval('document.getElementById("hide")');
            document.poppedLayer.style.visibility = "hidden";
            window.print();
        }
    </script>   
    <style type="text/css">
        .style1
        {
            width: 40px;
        }
        .style3
        {
            color: #000066;
        }
        #hide
        {
            top: 792px;
            left: 77px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <uc3:ctlFormatoCFDI ID="ctlFormatoCFDI1" runat="server" />
    <div id="factura">
    
        
    
    </div>
    
    <div id="hide" style="position: absolute">
                                                     
                   
                    
                    
        <table class="style7">
            <tr>
                <td class="style12">
                    <span class="style3"><strong>Factura:</strong></span>
                    <asp:Label ID="lblFactura" runat="server" Text="-"></asp:Label>
                    <br />
<br />
                    <span class="style3"><strong>Viajes sin facturar:</strong></span>
                    <asp:LinkButton ID="lnkSinFactura" runat="server" CausesValidation="False"></asp:LinkButton>
                    <br />

                    <span class="style3"><strong>Cliente:</strong></span>
                    <asp:DropDownList ID="ddlCliente" runat="server" DataSourceID="sdsCliente" 
                        DataTextField="nombre" DataValueField="id_empresa" 
                        AppendDataBoundItems="True" AutoPostBack="True">
                        <asp:ListItem Value="0">Seleccionar...</asp:ListItem>
                    </asp:DropDownList>
<asp:SqlDataSource ID="sdsCliente" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT DISTINCT dbo.empresas.nombre, dbo.empresas.id_empresa FROM precios_cajas INNER JOIN dbo.empresas ON precios_cajas.id_cliente = dbo.empresas.id_empresa INNER JOIN orden_cajas ON precios_cajas.id_precio_caja = orden_cajas.id_precio where orden_cajas.fin &lt;orden_cajas.inicio or orden_cajas.fin &lt;getdate()">
                    </asp:SqlDataSource>

                    <span class="style3"><strong>Tipo de Cambio:</strong></span>
                        <asp:TextBox ID="txbTc" runat="server"></asp:TextBox>
                        <asp:ImageButton ID="ImageButton1" runat="server" AlternateText="Refresh" 
                            ImageUrl="~/imagenes/refresh.png" />
                        <br />
                        <br />
                        <span class="style3"><strong>Ordenes Abiertas:</strong></span>
  <asp:RadioButtonList ID="rbtnOrdenesCajas" runat="server" 
                        AutoPostBack="True" DataSourceID="sdsOrdenes" DataTextField="orden" 
                        DataValueField="id_renta" ValidationGroup="caja">
                    </asp:RadioButtonList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="rbtnOrdenesCajas" ErrorMessage="Campo Obligatorio" 
                        ValidationGroup="caja">*</asp:RequiredFieldValidator>
                        <br />
                        <span class="style3"><strong>Facturar a:</strong></span><asp:SqlDataSource 
                            ID="sdsOrdenes" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        
                            
                        SelectCommand="SELECT CONVERT (nvarchar, orden_cajas.ano) + '-' + CONVERT (nvarchar, orden_cajas.consecutivo) + ' Caja:' + equipo_operacion.economico AS orden, orden_cajas.id_renta FROM orden_cajas INNER JOIN equipo_operacion ON orden_cajas.id_equipo = equipo_operacion.id_equipo INNER JOIN precios_cajas ON orden_cajas.id_precio = precios_cajas.id_precio_caja WHERE (precios_cajas.id_cliente = @id_cliente) and  orden_cajas.fin&lt;orden_cajas.inicio order by orden_cajas.ano desc, orden_cajas.consecutivo desc">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlCliente" Name="id_cliente" 
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                        <asp:DropDownList ID="ddlFacturacion" runat="server" 
                            DataSourceID="sdsFacturacion" DataTextField="razon_social" 
                            DataValueField="id_dato">
                        </asp:DropDownList>

                        <asp:SqlDataSource ID="sdsFacturacion" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                            SelectCommand="razonSocialPorEmpresa" 
                        SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlCliente" Name="idEmpresa" 
                                    PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <br />

                        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
                    </asp:ToolkitScriptManager>

                        <br />
                        Ultimo dia facturado:<asp:Label ID="lblUltimaFecha" runat="server" 
                            style="color: #FF0000"></asp:Label>
                        <br />
                        <span class="style3"><strong>Fecha de Renta: </strong></span>
                        <br />
                        Desde:<asp:TextBox ID="txbInicio" runat="server"></asp:TextBox>
                        <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" 
                            TargetControlID="txbInicio">
                        </asp:CalendarExtender>
                        Hasta:
                        <asp:TextBox ID="txbFin" runat="server"></asp:TextBox>
                        <br />
                    <br />
                    <asp:CheckBox ID="ckbPrecioMes" runat="server" Text="Precio por mes" />
                        <br />
                        <strong>Dias Transcurridos:</strong><asp:CalendarExtender ID="CalendarExtender2" runat="server" 
                            Format="dd/MM/yyyy" TargetControlID="txbFin">
                        </asp:CalendarExtender>
                        &nbsp;<asp:Label ID="lblDias" runat="server"></asp:Label>
                        <br />
                        <strong>Precio por
                    <asp:Label ID="lblFrecuencia" runat="server"></asp:Label>
                    :</strong>
                        <asp:Label ID="lblPrecio" runat="server"></asp:Label>
                        <br />
                        <br />
                    Forma de Pago:<asp:DropDownList ID="ddlFormaPago" runat="server">
                        <asp:ListItem>Pago en una sola exhibición.</asp:ListItem>
                        <asp:ListItem>Pago en paricialidades.</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    Metodo de Pago:<asp:DropDownList ID="ddlMetodoPago" runat="server">
                        <asp:ListItem Selected="True">Transferencia</asp:ListItem>
                        <asp:ListItem>Cheque Nominativo</asp:ListItem>
                        <asp:ListItem>Depósito en cuenta</asp:ListItem>
                        <asp:ListItem>Efectivo</asp:ListItem>
                        <asp:ListItem>Tarjeta de Credito</asp:ListItem>
                    </asp:DropDownList>
                        <br />

                           
                                                     
                    
                        <br />
                    <asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>
                    <br />
                    <br />
                    <asp:Button ID="btnGenerar" runat="server" Text="Generar CFDI" 
                        ValidationGroup="caja" style="margin-top: 1px" />
                    <br />
                    <br />
                    <asp:Button ID="btnTimbrar" runat="server" Text="Timbrar CFDI" 
                        ValidationGroup="caja" />
                    <br />
                    <asp:Label ID="lblFolioFiscal" runat="server"></asp:Label>
                    <br />
                    <asp:Button ID="btnCorreo" runat="server" Text="Correo CFDI" />
                    <br />
                </td>
                <td class="style1">
                    <uc5:ctlCancelarCFDI ID="ctlCancelarCFDI1" runat="server" />
                </td>
                <td class="style11">
                    &nbsp;         
                    <br />
                    <uc2:barraFacturacion ID="barraFacturacion1" runat="server" />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <asp:Label
    ID="lblTC" runat="server" Text=""></asp:Label>
                    <br />
                    <br />
                    &nbsp;<br />
                    <br />
                    <br />
                    <asp:Button ID="Button1" runat="server" CausesValidation="False" 
                        Text="Regresar" />
                </td>
            </tr>
            <tr>
                <td class="style12">
        &nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;</td>
                <td class="style1">
                    &nbsp;</td>
                <td class="style11">
                    &nbsp;</td>
            </tr>
            </table>
&nbsp;&nbsp;&nbsp;
        <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" 
            PopupControlID="Panel1" BackgroundCssClass="modalBackground" 
            TargetControlID="btnCorreo">
        </asp:ModalPopupExtender>
        <asp:Panel ID="Panel1" runat="server" BackColor="White">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
<uc4:ctlMail ID="ctlMail1" runat="server" />
            </ContentTemplate>
 
            </asp:UpdatePanel>
           
            <br />
            <asp:Button ID="btnCerrar" runat="server" 
    Text="Cerrar" />
        </asp:Panel>
        <br />
        <br />
</div>
    </form>
</body>
</html>
