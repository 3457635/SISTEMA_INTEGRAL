<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="notaDeCredito.aspx.vb" Inherits="Sistema_Integral_TSE_v45.notaDeCredito" %>

<%@ Register Src="~/Controles_Usuario/ctlCfdiLineas.ascx" TagName="ctlCfdiLineas" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/Controles_Usuario/ctlMail.ascx" TagName="ctlMail" TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .style28 {
            width: 351px;
        }

        .style29 {
        }

        .style30 {
            width: 31px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="factura" style="position: absolute; top: 280px; left: 13px;">
        <uc1:ctlCfdiLineas ID="ctlCfdiLineas1" runat="server" />
    </div>

    <div id="control" style="position: absolute; top: 1300px; left: 69px;">
        <table class="style28">
            <tr>
                <td class="style29" colspan="4">&nbsp;</td>
            </tr>
            <tr>
                <td class="style29">Cliente</td>
                <td class="style6">
                    <asp:DropDownList ID="ddlCliente" runat="server" AutoPostBack="True"
                        DataSourceID="sdsClientes" DataTextField="razon_social"
                        DataValueField="id_dato" Height="22px" Width="140px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsClientes" runat="server"
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                        SelectCommand="SELECT datos_facturacion.razon_social, datos_facturacion.id_dato FROM datos_facturacion INNER JOIN dbo.empresas ON datos_facturacion.id_empresa = dbo.empresas.id_empresa WHERE (dbo.empresas.id_tipo_empresa = 1) AND (datos_facturacion.idEstatus = 5) AND (dbo.empresas.id_status = 5) ORDER BY datos_facturacion.razon_social"></asp:SqlDataSource>
                </td>
                <td class="style30">&nbsp;</td>
                <td class="style6">
                    <asp:HiddenField ID="hfldCantidadFacturas" runat="server" />
                    <asp:HiddenField ID="hfldIdFactura" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="style29">
                    <asp:Button ID="btnGenerar" runat="server" Text="Crear" Width="150px" />
                </td>
                <td class="style6">
                    <asp:Button ID="btnActualizarImporte" runat="server" Text="Actualizar Importe"
                        Width="150px" />
                </td>
                <td class="style30">
                    <asp:Button ID="btnTimbrar" runat="server" Text="Timbrar" Width="150px" />
                </td>
                <td class="style6">
                    <asp:Button ID="btnCorreo" runat="server" Text="Correo" Width="150px" />
                </td>
            </tr>
            <tr>
                <td class="style29" colspan="4">
                    <asp:CheckBoxList ID="ckbFacturas" runat="server" DataSourceID="sdsFacturas"
                        DataTextField="folio" DataValueField="id_factura">
                    </asp:CheckBoxList>
                    <asp:SqlDataSource ID="sdsFacturas" runat="server"
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                        SelectCommand="SELECT facturas.folio, facturas.id_factura FROM facturas INNER JOIN fechas_facturacion ON facturas.id_factura = fechas_facturacion.id_factura INNER JOIN fechas ON fechas_facturacion.id_fecha = fechas.id_fecha WHERE (facturas.Cancelada = @Cancelada) AND (facturas.id_dato_facturacion = @id_dato_facturacion) AND (fechas.tipo_fecha = 4) ORDER BY fechas.fecha DESC">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="False" Name="Cancelada" Type="Boolean" />
                            <asp:ControlParameter ControlID="ddlCliente" Name="id_dato_facturacion"
                                PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>

    </div>

    <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server"
        PopupControlID="Panel1" TargetControlID="btnCorreo">
    </asp:ModalPopupExtender>

    <div style="position: absolute; top: 1431px; left: 41px;">
        <asp:Panel ID="Panel1" runat="server">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <uc2:ctlMail ID="ctlMail1" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:Button ID="btnCerrar" runat="server"
                Text="Cerrar" />
        </asp:Panel>


    </div>
</asp:Content>
