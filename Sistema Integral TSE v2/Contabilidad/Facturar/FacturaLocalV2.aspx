<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="FacturaLocalV2.aspx.vb" Inherits="Sistema_Integral_TSE_v45.FacturaLocalV2" %>

<%@ Register Src="../../Controles_Usuario/barraFacturacion.ascx" TagName="barraFacturacion" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register Src="../../Controles_Usuario/ctlFormatoFactura.ascx" TagName="ctlFormatoFactura" TagPrefix="uc2" %>

<%@ Register Src="../../Controles_Usuario/ctlCFDILineas.ascx" TagName="ctlFormatoCFDI" TagPrefix="uc3" %>

<%@ Register Src="../../Controles_Usuario/ctlMail.ascx" TagName="ctlMail" TagPrefix="uc4" %>

<%@ Register Src="../../Controles_Usuario/ctlCancelarCFDI.ascx" TagName="ctlCancelarCFDI" TagPrefix="uc5" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="factura" style="position: absolute; top: 280px; left: 13px; right: 1198px;">
        <uc3:ctlFormatoCFDI ID="ctlCFDILineas1" runat="server" />
    </div>
    <div id="hide" style="position: absolute; top: 1526px; left: 48px; margin-top: 4px;">
        <table class="style7">
            <tr>
                <td class="style10">Factura: 
                    <asp:Label ID="lblFolio" runat="server">-</asp:Label>
                </td>
                <td class="style10">&nbsp;</td>
                <td class="style11">&nbsp;&nbsp;<br />
                    <uc1:barraFacturacion ID="barraFacturacion1" runat="server" />
                    <br />
                </td>
                <td class="style11">&nbsp;</td>
            </tr>
            <tr>
                <td class="style10">Facturar a:</td>
                <td class="style10">
                    <asp:DropDownList ID="ddlDatoFacturacion" runat="server"
                        DataSourceID="SqlDataSource2" DataTextField="razon_social"
                        DataValueField="id_dato">
                    </asp:DropDownList>
                </td>
                <td class="style11">
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                        SelectCommand="SELECT datos_facturacion.razon_social, datos_facturacion.id_dato FROM datos_facturacion INNER JOIN dbo.empresas ON datos_facturacion.id_empresa = dbo.empresas.id_empresa WHERE (dbo.empresas.id_tipo_empresa = 1) AND (datos_facturacion.idEstatus = 5) AND (dbo.empresas.id_status = 5) ORDER BY datos_facturacion.razon_social"></asp:SqlDataSource>
                </td>
                <td class="style11">&nbsp;</td>
            </tr>
            <tr>
                <td class="style10">
                    <asp:Button ID="btnCrear" runat="server" Text="Crear CFDI" Width="150px" />
                </td>
                <td class="style10">
                    <asp:Button ID="btnActualizarImporte" runat="server" Text="Actualizar Importe"
                        Width="150px" />
                </td>
                <td class="style11">
                    <asp:Button ID="btnTimbrar" runat="server" Text="Timbrar CFDI"
                        Enabled="False" Width="150px" />
                </td>
                <td class="style11">
                    <asp:Button ID="btnCorreo" runat="server" Text="Correo CFDI" Enabled="False"
                        Width="150px" />
                </td>
            </tr>
            <tr>
                <td class="style10">
                    <asp:Button ID="btnNueva" runat="server" Text="Nueva Factura" />
                </td>
                <td class="style10" colspan="3">Folio Fiscal : 
                    <asp:Label ID="lblFolioFiscal" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="style29" colspan="4">&nbsp;
                    <asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="style8" colspan="3">&nbsp;</td>
                <td class="style8">&nbsp;</td>
            </tr>
        </table>
        &nbsp;&nbsp;&nbsp;        
        <br />
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
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Head">
    <style type="text/css">
        #hide {
            top: 1281px;
            left: 75px;
        }
    </style>
</asp:Content>
