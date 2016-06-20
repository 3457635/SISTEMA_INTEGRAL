<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlCfdiLineas.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlCfdiLineas" %>

<style type="text/css">
    .style1 {
        width: 638px;
    }

    .style4 {
        width: 100px;
    }

    .style6 {
        width: 128px;
    }

    .style7 {
        width: 63%;
    }

    .style8 {
        font-family: Arial, Helvetica, sans-serif;
    }

    .style10 {
        width: 178px;
    }

    .style11 {
        width: 82px;
        font-family: Arial, Helvetica, sans-serif;
    }

    .style16 {
        width: 646px;
    }

    .style17 {
        width: 550px;
        align-content:flex-end;
    }

    .style18 {
        width: 86px;
        font-family: Arial, Helvetica, sans-serif;
    }

    .style19 {
        width: 500px;
        font-family: Arial, Helvetica, sans-serif;
    }

    .style20 {
        width: 128px;
        font-family: Arial, Helvetica, sans-serif;
    }

    .style21 {
        width: 56px;
        font-family: Arial, Helvetica, sans-serif;
    }

    .style22 {
        width: 56px;
    }

    .style24 {
        font-family: Arial, Helvetica, sans-serif;
        width: 91px;
        text-align:right;
    }

    .style26 {
        width: 211px;
    }

    .style27 {
        width: 102px;
        align-content:flex-start;
    }

    .style28 {
        width: 83px;
    }

    .alinearDerecha {
        text-align: right;
        height: 19px;
        margin-top: 0px;
    }

    .alinearCentro {
        text-align:center;
    }

    .alinearIzquierda {
        text-align:left;
    }

    </style>

<div id="Encabezado"
    style="position: absolute; top: 19px; width: 661px; left: 18px; height: 81px;">
    <table class="style16">
        <tr>
            <td class="style18">NOMBRE</td>
            <td class="style17">
                <asp:Label ID="lblNombre" runat="server"
                    Style="font-family: Arial, Helvetica, sans-serif"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style18">DIRECCIÓN</td>
            <td class="style17">
                <asp:Label ID="lblDireccion" runat="server"
                    Style="font-family: Arial, Helvetica, sans-serif"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style18">CIUDAD</td>
            <td class="style17">
                <asp:Label ID="lblCiudad" runat="server"
                    Style="font-family: Arial, Helvetica, sans-serif"></asp:Label>
            </td>
        </tr>
    </table>
</div>
<div style="position: absolute; top: 24px; left: 702px; height: 65px;">
    <table class="style10">
        <tr>
            <td class="style11">TELÉFONO</td>
            <td class="style28">
                <asp:Label ID="lblTelefono" runat="server"
                    Style="font-family: Arial, Helvetica, sans-serif"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style11">RFC</td>
            <td class="style28">
                <asp:Label ID="lblRfc" runat="server"
                    Style="font-family: Arial, Helvetica, sans-serif"></asp:Label>
            </td>
        </tr>
    </table>
</div>
<div id="Detalle"
    style="position: absolute; top: 110px; left: 18px; width: 1006px; height: 559px;">
    <table class="style1">
        <tr>
            <td class="style19">CANT.</td>
            <td class="style19">S/RET.</td>
            <td class="style19">S/IVA</td>
            <td class="style19">DESCRIPCIÓN</td>
            <td class="style21">VALOR UNITARIO</td>
            <td class="style20">IMPORTE</td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txbCantidad1" runat="server" BorderStyle="Solid" width="40px" CssClass="alinearCentro"></asp:TextBox>
            </td>
            <td>
                <asp:CheckBox ID="chkFlete1" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td>
                <asp:CheckBox ID="ChkIva1" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td class="style4">
                <asp:TextBox ID="txbDescripcion1" runat="server" Width="500px"
                    BorderStyle="Solid" TextMode="MultiLine"></asp:TextBox>
            </td>
            <td class="style22">
                <asp:TextBox ID="txbPrecio1" runat="server" BorderStyle="Solid" CssClass="alinearDerecha" Width="100px"></asp:TextBox>
            </td>
            <td class="style6">
                <asp:Label ID="lblImporte1" runat="server" CssClass="alinearDerecha" Width="110px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txbCantidad2" runat="server" BorderStyle="Solid" width="40px" CssClass="alinearCentro"></asp:TextBox>
            </td>
            <td>
                <asp:CheckBox ID="chkFlete2" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td>
                <asp:CheckBox ID="ChkIva2" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td class="style4">
                <asp:TextBox ID="txbDescripcion2" runat="server" Width="500px"
                    BorderStyle="Solid" TextMode="MultiLine"></asp:TextBox>
            </td>
            <td class="style22">
                <asp:TextBox ID="txbPrecio2" runat="server" BorderStyle="Solid" CssClass="alinearDerecha" Width="100px"></asp:TextBox>
            </td>
            <td class="style6">
                <asp:Label ID="lblImporte2" runat="server" CssClass="alinearDerecha" Width="110px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txbCantidad3" runat="server" BorderStyle="Solid" width="40px" CssClass="alinearCentro"></asp:TextBox>
            </td>
            <td>
                <asp:CheckBox ID="chkFlete3" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td>
                <asp:CheckBox ID="ChkIva3" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td class="style4">
                <asp:TextBox ID="txbDescripcion3" runat="server" Width="500px"
                    BorderStyle="Solid" TextMode="MultiLine"></asp:TextBox>
            </td>
            <td class="style22">
                <asp:TextBox ID="txbPrecio3" runat="server" BorderStyle="Solid" CssClass="alinearDerecha" Width="100px"></asp:TextBox>
            </td>
            <td class="style6">
                <asp:Label ID="lblImporte3" runat="server" CssClass="alinearDerecha" Width="110px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txbCantidad4" runat="server" BorderStyle="Solid" width="40px" CssClass="alinearCentro"></asp:TextBox>
            </td>
            <td>
                <asp:CheckBox ID="chkFlete4" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td>
                <asp:CheckBox ID="ChkIva4" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td class="style4">
                <asp:TextBox ID="txbDescripcion4" runat="server" Width="500px"
                    BorderStyle="Solid"></asp:TextBox>
            </td>
            <td class="style22">
                <asp:TextBox ID="txbPrecio4" runat="server" BorderStyle="Solid" CssClass="alinearDerecha" Width="100px"></asp:TextBox>
            </td>
            <td class="style6">
                <asp:Label ID="lblImporte4" runat="server" CssClass="alinearDerecha" Width="110px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txbCantidad5" runat="server" BorderStyle="Solid" width="40px" CssClass="alinearCentro"></asp:TextBox>
            </td>
            <td>
                <asp:CheckBox ID="chkFlete5" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td>
                <asp:CheckBox ID="ChkIva5" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td class="style4">
                <asp:TextBox ID="txbDescripcion5" runat="server" Width="500px"
                    BorderStyle="Solid"></asp:TextBox>
            </td>
            <td class="style22">
                <asp:TextBox ID="txbPrecio5" runat="server" BorderStyle="Solid" CssClass="alinearDerecha" Width="100px"></asp:TextBox>
            </td>
            <td class="style6">
                <asp:Label ID="lblImporte5" runat="server" CssClass="alinearDerecha" Width="110px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txbCantidad6" runat="server" BorderStyle="Solid" width="40px" CssClass="alinearCentro"></asp:TextBox>
            </td>
            <td>
                <asp:CheckBox ID="chkFlete6" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td>
                <asp:CheckBox ID="ChkIva6" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td class="style4">
                <asp:TextBox ID="txbDescripcion6" runat="server" Width="500px"
                    BorderStyle="Solid"></asp:TextBox>
            </td>
            <td class="style22">
                <asp:TextBox ID="txbPrecio6" runat="server" BorderStyle="Solid" CssClass="alinearDerecha" Width="100px"></asp:TextBox>
            </td>
            <td class="style6">
                <asp:Label ID="lblImporte6" runat="server" CssClass="alinearDerecha" Width="110px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txbCantidad7" runat="server" BorderStyle="Solid" width="40px" CssClass="alinearCentro"></asp:TextBox>
            </td>
            <td>
                <asp:CheckBox ID="chkFlete7" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td>
                <asp:CheckBox ID="ChkIva7" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td class="style4">
                <asp:TextBox ID="txbDescripcion7" runat="server" Width="500px"
                    BorderStyle="Solid"></asp:TextBox>
            </td>
            <td class="style22">
                <asp:TextBox ID="txbPrecio7" runat="server" BorderStyle="Solid" CssClass="alinearDerecha" Width="100px"></asp:TextBox>
            </td>
            <td class="style6">
                <asp:Label ID="lblImporte7" runat="server" CssClass="alinearDerecha" Width="110px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txbCantidad8" runat="server" BorderStyle="Solid" width="40px" CssClass="alinearCentro"></asp:TextBox>
            </td>
            <td>
                <asp:CheckBox ID="chkFlete8" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td>
                <asp:CheckBox ID="ChkIva8" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td class="style4">
                <asp:TextBox ID="txbDescripcion8" runat="server" Width="500px"
                    BorderStyle="Solid"></asp:TextBox>
            </td>
            <td class="style22">
                <asp:TextBox ID="txbPrecio8" runat="server" BorderStyle="Solid" CssClass="alinearDerecha" Width="100px"></asp:TextBox>
            </td>
            <td class="style6">
                <asp:Label ID="lblImporte8" runat="server" CssClass="alinearDerecha" Width="110px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txbCantidad9" runat="server" BorderStyle="Solid" width="40px" CssClass="alinearCentro"></asp:TextBox>
            </td>
            <td>
                <asp:CheckBox ID="chkFlete9" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td>
                <asp:CheckBox ID="ChkIva9" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td class="style4">
                <asp:TextBox ID="txbDescripcion9" runat="server" Width="500px"
                    BorderStyle="Solid"></asp:TextBox>
            </td>
            <td class="style22">
                <asp:TextBox ID="txbPrecio9" runat="server" BorderStyle="Solid" CssClass="alinearDerecha" Width="100px"></asp:TextBox>
            </td>
            <td class="style6">
                <asp:Label ID="lblImporte9" runat="server" CssClass="alinearDerecha" Width="110px"></asp:Label>
            </td>
        </tr>
         <tr>
            <td>
                <asp:TextBox ID="txbCantidad10" runat="server" BorderStyle="Solid" width="40px" CssClass="alinearCentro"></asp:TextBox>
            </td>
            <td>
                <asp:CheckBox ID="chkFlete10" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td>
                <asp:CheckBox ID="ChkIva10" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td class="style4">
                <asp:TextBox ID="txbDescripcion10" runat="server" Width="500px"
                    BorderStyle="Solid"></asp:TextBox>
            </td>
            <td class="style22">
                <asp:TextBox ID="txbPrecio10" runat="server" BorderStyle="Solid" CssClass="alinearDerecha" Width="100px"></asp:TextBox>
            </td>
            <td class="style6">
                <asp:Label ID="lblImporte10" runat="server" CssClass="alinearDerecha" Width="110px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txbCantidad11" runat="server" BorderStyle="Solid" width="40px" CssClass="alinearCentro"></asp:TextBox>
            </td>
            <td>
                <asp:CheckBox ID="chkFlete11" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td>
                <asp:CheckBox ID="ChkIva11" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td class="style4">
                <asp:TextBox ID="txbDescripcion11" runat="server" Width="500px"
                    BorderStyle="Solid"></asp:TextBox>
            </td>
            <td class="style22">
                <asp:TextBox ID="txbPrecio11" runat="server" BorderStyle="Solid" CssClass="alinearDerecha" Width="100px"></asp:TextBox>
            </td>
            <td class="style6">
                <asp:Label ID="lblImporte11" runat="server" CssClass="alinearDerecha" Width="110px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txbCantidad12" runat="server" BorderStyle="Solid" width="40px" CssClass="alinearCentro"></asp:TextBox>
            </td>
            <td>
                <asp:CheckBox ID="chkFlete12" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td>
                <asp:CheckBox ID="ChkIva12" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td class="style4">
                <asp:TextBox ID="txbDescripcion12" runat="server" Width="500px"
                    BorderStyle="Solid"></asp:TextBox>
            </td>
            <td class="style22">
                <asp:TextBox ID="txbPrecio12" runat="server" BorderStyle="Solid" CssClass="alinearDerecha" Width="100px"></asp:TextBox>
            </td>
            <td class="style6">
                <asp:Label ID="lblImporte12" runat="server" CssClass="alinearDerecha" Width="110px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txbCantidad13" runat="server" BorderStyle="Solid" width="40px" CssClass="alinearCentro"></asp:TextBox>
            </td>
            <td>
                <asp:CheckBox ID="chkFlete13" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td>
                <asp:CheckBox ID="ChkIva13" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td class="style4">
                <asp:TextBox ID="txbDescripcion13" runat="server" Width="500px"
                    BorderStyle="Solid"></asp:TextBox>
            </td>
            <td class="style22">
                <asp:TextBox ID="txbPrecio13" runat="server" BorderStyle="Solid" CssClass="alinearDerecha" Width="100px"></asp:TextBox>
            </td>
            <td class="style6">
                <asp:Label ID="lblImporte13" runat="server" CssClass="alinearDerecha" Width="110px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txbCantidad14" runat="server" BorderStyle="Solid" width="40px" CssClass="alinearCentro"></asp:TextBox>
            </td>
            <td>
                <asp:CheckBox ID="chkFlete14" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td>
                <asp:CheckBox ID="ChkIva14" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td class="style4">
                <asp:TextBox ID="txbDescripcion14" runat="server" Width="500px"
                    BorderStyle="Solid"></asp:TextBox>
            </td>
            <td class="style22">
                <asp:TextBox ID="txbPrecio14" runat="server" BorderStyle="Solid" CssClass="alinearDerecha" Width="100px"></asp:TextBox>
            </td>
            <td class="style6">
                <asp:Label ID="lblImporte14" runat="server" CssClass="alinearDerecha" Width="110px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="txbCantidad15" runat="server" BorderStyle="Solid" width="40px" CssClass="alinearCentro"></asp:TextBox>
            </td>
            <td>
                <asp:CheckBox ID="chkFlete15" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td>
                <asp:CheckBox ID="ChkIva15" runat="server" TextAlign="Left" Width="25px"></asp:CheckBox>
            </td>
            <td class="style4">
                <asp:TextBox ID="txbDescripcion15" runat="server" Width="500px"
                    BorderStyle="Solid"></asp:TextBox>
            </td>
            <td class="style22">
                <asp:TextBox ID="txbPrecio15" runat="server" BorderStyle="Solid" CssClass="alinearDerecha" Width="100px"></asp:TextBox>
            </td>
            <td class="style6">
                <asp:Label ID="lblImporte15" runat="server" CssClass="alinearDerecha" Width="110px"></asp:Label>
            </td>
        </tr>
    </table>
</div>
<div id="Subtotal"
    style="position: absolute; top: 803px; left: 751px; height: 102px; margin-right: 5px;">
    <table class="style26">
        <tr>
            <td class="style24">SUBTOTAL&nbsp;</td>
            <td class="style27">
                <asp:Label ID="lblSubtotal" runat="server" CssClass="alinearDerecha" Width="110px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style24">IVA</td>
            <td class="style27">
                <asp:Label ID="lblIva" runat="server" CssClass="alinearDerecha" Width="110px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style24">RETENCIÓN</td>
            <td class="style27">
                 <asp:Label ID="lblRetencion" runat="server" CssClass="alinearDerecha" Width="110px"></asp:Label>
                 <%-- <asp:TextBox ID="txtRetencion" runat="server"></asp:TextBox>--%>
            </td>
        </tr>
        <tr>
            <td class="style24">TOTAL</td>
            <td class="style27">
                <asp:Label ID="lblTotal" runat="server" CssClass="alinearDerecha" Width="110px"></asp:Label>
            </td>
        </tr>
    </table>
</div>
<div style="position: absolute; top: 795px; left: 17px; width: 662px; height: 56px;">
    <span class="style8">IMPORTE CON LETRA</span>
    <asp:TextBox ID="txbCantidadLetra" runat="server" Width="482px" BorderStyle="Solid"
        Font-Bold="True" Font-Names="Arial"
        Height="42px" TextMode="MultiLine"></asp:TextBox>
</div>
<div style="position: absolute; top: 856px; left:18px; width: 662px;">
    <span class="style8">COMENTARIOS</span>
    <asp:TextBox ID="txbAnotaciones" runat="server" BorderStyle="Solid"
        Font-Bold="True" Width="529px" Height="42px" TextMode="MultiLine"></asp:TextBox>
</div>

<div style="position: absolute; top: 915px; left: 19px; width: 299px; height: 340px;">
    <table class="style7">
        <tr>
            <td class="style8">Forma de Pago</td>
            <td>
                <asp:DropDownList ID="ddlFormaPago" runat="server">
                    <asp:ListItem>Pago en una sola exhibición.</asp:ListItem>
                    <asp:ListItem>Pago en paricialidades.</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style8">Metodo de Pago</td>
            <td>
                <asp:DropDownList ID="ddlMetodoPago" runat="server">
                    <asp:ListItem Selected="True">Transferencia</asp:ListItem>
                    <asp:ListItem>Cheque Nominativo</asp:ListItem>
                    <asp:ListItem>Cheque Nominativo Banamex</asp:ListItem>
                    <asp:ListItem>Depósito en cuenta</asp:ListItem>
                    <asp:ListItem>Efectivo</asp:ListItem>
                    <asp:ListItem>Tarjeta de Credito</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style8">Cuenta de Pago</td>
            <td>
                <asp:TextBox ID="txbCtaPago" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style8">Tasa IVA </td>
            <td>
                <asp:TextBox ID="txbTasaIva" runat="server" Width="50px">16</asp:TextBox>
                %</td>
        </tr>
        <tr>
            <td class="style8">Tasa Retención</td>
            <td>
                <asp:TextBox ID="txbTasaRetencion" runat="server" Width="50px">4</asp:TextBox>
                %</td>
        </tr>
        <tr>
            <td class="style8">Moneda</td>
            <td>
                <asp:RadioButtonList ID="rbtnMoneda" runat="server">
                    <asp:ListItem Selected="True">Pesos</asp:ListItem>
                    <asp:ListItem>Dolares</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td class="style8">Tipo de comprobante</td>
            <td>
                <asp:DropDownList ID="ddlTipoComprobante" runat="server" Height="20px"
                    Width="164px">
                    <asp:ListItem Value="0">Factura</asp:ListItem>
                    <asp:ListItem Value="1">Nota de Crédito</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    <asp:Label ID="lblMensajeCFDI" runat="server" SkinID="lblMensaje"></asp:Label>
    <br />
    <asp:Label ID="lblMensajeCBB" runat="server" SkinID="lblMensaje"></asp:Label>
    <br />
    <asp:Label ID="lblMensajePdf" runat="server" SkinID="lblMensaje"></asp:Label>
    &nbsp;
</div>
