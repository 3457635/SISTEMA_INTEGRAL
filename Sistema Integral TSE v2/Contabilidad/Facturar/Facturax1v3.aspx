<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Facturax1v3.aspx.vb" MasterPageFile="~/Site.master" Inherits="Sistema_Integral_TSE_v45.Facturax1v3" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register Src="../../Controles_Usuario/barraFacturacion.ascx" TagName="barraFacturacion" TagPrefix="uc1" %>

<%@ Register Src="../../Controles_Usuario/ctlFormatoFactura.ascx" TagName="ctlFormatoFactura" TagPrefix="uc2" %>

<%@ Register Src="../../Controles_Usuario/ctlFormatoCFDI.ascx" TagName="ctlFormatoCFDI" TagPrefix="uc3" %>
<%@ Register Src="../../Controles_Usuario/ctlMail.ascx" TagName="ctlMail" TagPrefix="uc4" %>

<%@ Register Src="../../Controles_Usuario/ctlCancelarCFDI.ascx" TagName="ctlCancelarCFDI" TagPrefix="uc5" %>

<%@ Register Src="../../Controles_Usuario/ctlCfdiLineas.ascx" TagName="ctlFormatoCfdiLineas" TagPrefix="uc6" %>

<%@ Register Src="../../Controles_Usuario/ctrlUpLoads.ascx" TagName="ctrlUpLoads" TagPrefix="uc7" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="factura" style="position: absolute; top: 280px; left: 13px;">
        <uc6:ctlFormatoCfdiLineas ID="ctlFormatoCfdiLineas1" runat="server" />
    </div>

    <div id="hide" style="position: absolute; top: 1404px; left: 69px;">
        <table class="style7">
            <tr>
                <td class="style12">Factura: 
                </td>
                <td class="style1">
                    <asp:Label ID="lblFolio" runat="server">-</asp:Label>
                </td>
                <td class="style11">
                    <uc1:barraFacturacion
                        ID="barraFacturacion1" runat="server" />
                </td>
                <td class="style39">&nbsp;</td>
            </tr>
            <tr>
                <td class="style12">Empresa:&nbsp;
                </td>
                <td class="style1">
                    <asp:DropDownList ID="ddlEmpresa" runat="server"
                        DataSourceID="sdsEmpresa" DataTextField="nombre" DataValueField="id_empresa">
                    </asp:DropDownList>
                </td>
                <td class="style11">
                    <asp:Label
                        ID="lblTC" runat="server" Text=""></asp:Label>
                </td>
                <td class="style39">
                    <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True">
                        <asp:ListItem Value="true">No facturado</asp:ListItem>
                        <asp:ListItem Value="false">Facturado</asp:ListItem>
                        <asp:ListItem>Todas</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td class="style36">Facturar a:</td>
                <td class="style37">
                    <asp:DropDownList ID="ddlDatoFacturacion" runat="server"
                        DataSourceID="sdsDatosFacturacion" DataTextField="razon_social"
                        DataValueField="id_dato">
                    </asp:DropDownList>
                </td>
                <td class="style38">
                    <asp:Label ID="lblAnuncio"
                        runat="server" Text="Tipo de Cambio: "></asp:Label>
                </td>
                <td class="style40">
                    <asp:TextBox ID="txbTc" runat="server"></asp:TextBox>
                    <asp:ImageButton
                        ID="ImageButton1" runat="server" AlternateText="Refresh"
                        ImageUrl="~/imagenes/refresh.png" />
                </td>
            </tr>
            
            <tr>
                <td class="style12" colspan="2">
                    <asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>
                </td>
                <td class="style11">&nbsp;</td>
                <td class="style39">&nbsp;</td>
            </tr>
            <tr>
                <td class="style33">
                    <asp:Button ID="btnCrear" runat="server" Text="Crear CFDI" Width="150px" />
                </td>
                <td class="style34">
                    <asp:Button ID="btnActualizar" runat="server" Text="Actualizar Importe"
                        Width="150px" />
                </td>
                <td class="style35">
                    <asp:Button runat="server" ID="btnImprimir" Text="Timbrar CFDI"
                        Enabled="False" Width="150px" />
                </td>
                <td class="style41">
                    <asp:Button ID="btnEnviarCFDI" runat="server" Text="Correo CFDI"
                        Enabled="False" Width="150px" />
                </td>
            </tr>
            <tr>
                <td class="style12">
                    <asp:Button ID="Button2" runat="server" Text="Limpiar Factura" />
                </td>
                <td class="style1">
                    <asp:SqlDataSource ID="sdsOrdenes" runat="server"
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                        SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + CONVERT (nvarchar, viajes.num_viaje) + '(' + dbo.llave_rutas.ruta + ')' AS orden, viajes.id_viaje, Ordenes.consecutivo 
FROM Ordenes 
INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden 
INNER JOIN precios ON viajes.id_relacion = precios.id_relacion 
INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa 
INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta 
INNER JOIN fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje AND viajes.id_viaje = fechas_viaje.id_viaje AND viajes.id_viaje = fechas_viaje.id_viaje 
INNER JOIN fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha 
WHERE (DATEDIFF(day, fechas.fecha, GETDATE()) &lt; 180) and viajes.facturado=0 and remision=0 AND (viajes.id_viaje 
NOT IN 
(SELECT facturacion.id_viaje 
FROM fechas AS fechas_1 INNER JOIN fechas_facturacion ON fechas_1.id_fecha = fechas_facturacion.id_fecha 
INNER JOIN facturas ON fechas_facturacion.id_factura = facturas.id_factura 
INNER JOIN facturacion ON facturas.id_factura = facturacion.id_factura INNER JOIN viajes AS viajes_1 ON facturacion.id_viaje = viajes_1.id_viaje 
INNER JOIN precios AS precios_1 ON viajes_1.id_relacion = precios_1.id_relacion WHERE (DATEDIFF(day, fechas_1.fecha, GETDATE()) &gt; 180))) 
AND (fechas.tipo_fecha = 1) AND (dbo.empresas.id_empresa = @id_empresa) AND (viajes.facturado &lt;&gt; @facturado or viajes.facturado is null) and viajes.id_status &lt;&gt; 5 and viajes.id_status &lt;&gt; 3 
ORDER BY Ordenes.ano DESC, Ordenes.consecutivo DESC">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlEmpresa" Name="id_empresa"
                                PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="RadioButtonList1" DefaultValue="" Name="facturado" PropertyName="SelectedValue" Type="Boolean" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td class="style11">
                    <asp:Button ID="btnSubir" runat="server" Text="Subir XML y PDF"
                        Width="150px" Enabled="False"/>
                    <asp:SqlDataSource ID="sdsEmpresa" runat="server"
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                        SelectCommand="SELECT nombre, id_empresa FROM dbo.empresas WHERE (id_tipo_empresa = 1) AND (id_status = 5) ORDER BY nombre"></asp:SqlDataSource>
                </td>
                <td class="style39">
                    <asp:SqlDataSource ID="sdsDatosFacturacion" runat="server"
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                        SelectCommand="SELECT datos_facturacion.id_dato, datos_facturacion.razon_social FROM  datos_facturacion  WHERE id_empresa=@idEmpresa and idEstatus=5">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlEmpresa" Name="idEmpresa"
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td colspan="4" style="table-layout: auto">
                    <asp:Label ID="lblMensajeUL" runat="server" ForeColor="Red" CssClass="mensaje"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="style12" colspan="2">&nbsp;<asp:CheckBoxList ID="ckbOrdenes" runat="server"
                    DataSourceID="sdsOrdenes" DataTextField="orden"
                    DataValueField="id_viaje">
                </asp:CheckBoxList>
                </td>
                <td class="style11">
                    <asp:SqlDataSource ID="sdsOrdenes2" runat="server"
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                        SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + CONVERT (nvarchar, viajes.num_viaje) + '(' + dbo.llave_rutas.ruta + ')' AS orden, viajes.id_viaje, Ordenes.consecutivo 
FROM Ordenes 
INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden 
INNER JOIN precios ON viajes.id_relacion = precios.id_relacion 
INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa 
INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta 
INNER JOIN fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje AND viajes.id_viaje = fechas_viaje.id_viaje AND viajes.id_viaje = fechas_viaje.id_viaje 
INNER JOIN fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha 
WHERE (DATEDIFF(day, fechas.fecha, GETDATE()) &lt; 180) AND (viajes.id_viaje 
NOT IN 
(SELECT facturacion.id_viaje 
FROM fechas AS fechas_1 INNER JOIN fechas_facturacion ON fechas_1.id_fecha = fechas_facturacion.id_fecha 
INNER JOIN facturas ON fechas_facturacion.id_factura = facturas.id_factura 
INNER JOIN facturacion ON facturas.id_factura = facturacion.id_factura INNER JOIN viajes AS viajes_1 ON facturacion.id_viaje = viajes_1.id_viaje 
INNER JOIN precios AS precios_1 ON viajes_1.id_relacion = precios_1.id_relacion WHERE (DATEDIFF(day, fechas_1.fecha, GETDATE()) &gt; 180))) 
AND (fechas.tipo_fecha = 1) AND (dbo.empresas.id_empresa = @id_empresa) AND  viajes.id_status &lt;&gt; 5 and viajes.id_status &lt;&gt; 3 
ORDER BY Ordenes.ano DESC, Ordenes.consecutivo DESC">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlEmpresa" Name="id_empresa"
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td class="style39">&nbsp;</td>
            </tr>
            <tr>
                <td class="style28">&nbsp;</td>
                <td class="style29">&nbsp;</td>
                <td class="style32">&nbsp;</td>
                <td class="style42"></td>
            </tr>
        </table>
        &nbsp;&nbsp;&nbsp;     
        <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server"
            PopupControlID="Panel1" BackgroundCssClass="modalBackground"
            TargetControlID="btnEnviarCFDI">
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
        &nbsp;&nbsp;&nbsp; 
        <asp:ModalPopupExtender ID="ModalPopupExtender2" runat="server" PopupControlID="pnlUnloaded" BackgroundCssClass="modalBackground"
            TargetControlID="btnSubir">
        </asp:ModalPopupExtender>
        <asp:Panel runat="server" ID="pnlUnloaded">
            <uc7:ctrlUpLoads ID="ctrlUpLoads" runat="server" />
        </asp:Panel>
    </div>
</asp:Content>
