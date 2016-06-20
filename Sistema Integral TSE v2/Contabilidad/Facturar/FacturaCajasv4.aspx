<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FacturaCajasv4.aspx.vb" MasterPageFile="~/Site.master" Inherits="Sistema_Integral_TSE_v45.FacturaCajasv4" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register Src="../../Controles_Usuario/ctlFormatoFactura.ascx" TagName="ctlFormatoFactura" TagPrefix="uc1" %>

<%@ Register Src="../../Controles_Usuario/barraFacturacion.ascx" TagName="barraFacturacion" TagPrefix="uc2" %>

<%@ Register Src="../../Controles_Usuario/ctlFormatoCFDI.ascx" TagName="ctlFormatoCFDI" TagPrefix="uc3" %>

<%@ Register Src="../../Controles_Usuario/ctlMail.ascx" TagName="ctlMail" TagPrefix="uc4" %>

<%@ Register Src="../../Controles_Usuario/ctlCancelarCFDI.ascx" TagName="ctlCancelarCFDI" TagPrefix="uc5" %>

<%@ Register Src="../../Controles_Usuario/ctlCfdiLineas.ascx" TagName="ctlCfdiLineas" TagPrefix="uc6" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="factura" style="position: absolute; top: 280px; left: 13px;">
        <uc6:ctlCfdiLineas ID="ctlCfdiLineas1" runat="server" />
    </div>

    <div id="hide" style="position: absolute; top: 1504px; left: 69px;">
        <table class="style7">
            <tr>
                <td class="style12">
                    <span class="style3"><strong>Factura:</strong></span></td>
                <td class="style12">
                    <asp:Label ID="lblFactura" runat="server" Text="-"></asp:Label>
                </td>
                <td class="style1">
                    <uc2:barraFacturacion ID="barraFacturacion1" runat="server" />
                </td>
                <td class="style1">&nbsp;</td>
            </tr>
            <tr>
                <td class="style12">

                    <span class="style3"><strong>Cliente:</strong></span>
                </td>
                <td class="style12">
                    <asp:DropDownList ID="ddlCliente" runat="server" DataSourceID="sdsCliente"
                        DataTextField="nombre" DataValueField="id_empresa"
                        AppendDataBoundItems="True" AutoPostBack="True">
                        <asp:ListItem Value="0">Seleccionar...</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="style1">&nbsp;</td>
                <td class="style1">&nbsp;</td>
            </tr>
            <tr>
                <td class="style12">

                    <span class="style3"><strong>Tipo de Cambio:</strong></span></td>
                <td class="style12">
                    <asp:TextBox ID="txbTc" runat="server"></asp:TextBox>
                    <asp:ImageButton ID="ImageButton1" runat="server" AlternateText="Refresh"
                        ImageUrl="~/imagenes/refresh.png" />
                </td>
                <td class="style1">
                    <asp:Label
                        ID="lblTC" runat="server" Text=""></asp:Label>
                </td>
                <td class="style1">&nbsp;</td>
            </tr>
            <tr>
                <td class="style12">
                    <span class="style3"><strong>Ordenes Abiertas:</strong></span>
                </td>
                <td class="style12">
                    <asp:RadioButtonList ID="rbtnOrdenesCajas" runat="server"
                        AutoPostBack="True" DataSourceID="sdsOrdenes" DataTextField="orden"
                        DataValueField="id_renta" ValidationGroup="caja">
                    </asp:RadioButtonList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                        ControlToValidate="rbtnOrdenesCajas" ErrorMessage="Campo Obligatorio"
                        ValidationGroup="caja">*</asp:RequiredFieldValidator>
                </td>
                <td class="style1">&nbsp;</td>
                <td class="style1">&nbsp;</td>
            </tr>
            <tr>
                <td class="style12">
                    <span class="style3"><strong>Facturar a:</strong></span></td>
                <td class="style12">

                    <asp:DropDownList ID="ddlFacturacion" runat="server"
                        DataSourceID="sdsFacturacion" DataTextField="razon_social"
                        DataValueField="id_dato">
                    </asp:DropDownList>

                </td>
                <td class="style1">&nbsp;</td>
                <td class="style1">&nbsp;</td>
            </tr>
            <tr>
                <td class="style12">Ultimo dia facturado:</td>
                <td class="style12">
                    <asp:Label ID="lblUltimaFecha" runat="server"
                        Style="color: #FF0000"></asp:Label>
                </td>
                <td class="style1">&nbsp;</td>
                <td class="style1">&nbsp;</td>
            </tr>
            <tr>
                <td class="style12">
                    <span class="style3"><strong>Fecha de Renta: </strong></span>
                </td>
                <td class="style12">&nbsp;</td>
                <td class="style1">&nbsp;</td>
                <td class="style1">&nbsp;</td>
            </tr>
            <tr>
                <td class="style12">Desde:<asp:TextBox ID="txbInicio" runat="server"></asp:TextBox>
                    <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy"
                        TargetControlID="txbInicio">
                    </asp:CalendarExtender>
                </td>
                <td class="style12">Hasta:<asp:TextBox ID="txbFin" runat="server"></asp:TextBox>
                </td>
                <td class="style1">&nbsp;</td>
                <td class="style1">&nbsp;</td>
            </tr>
            <tr>
                <td class="style12">
                    <asp:CheckBox ID="ckbPrecioMes" runat="server" Text="Precio por mes" />
                </td>
                <td class="style12">&nbsp;</td>
                <td class="style1">&nbsp;</td>
                <td class="style1">&nbsp;</td>
            </tr>
            <tr>
                <td class="style12">
                    <strong>Dias Transcurridos:</strong><asp:CalendarExtender ID="CalendarExtender2" runat="server"
                        Format="dd/MM/yyyy" TargetControlID="txbFin">
                    </asp:CalendarExtender>
                </td>
                <td class="style12">
                    <asp:Label ID="lblDias" runat="server"></asp:Label>
                </td>
                <td class="style1">&nbsp;</td>
                <td class="style1">&nbsp;</td>
            </tr>
            <tr>
                <td class="style12">
                    <strong>Precio por
                    <asp:Label ID="lblFrecuencia" runat="server"></asp:Label>
                        :</strong>
                </td>
                <td class="style12">
                    <asp:Label ID="lblPrecio" runat="server"></asp:Label>
                </td>
                <td class="style1">&nbsp;</td>
                <td class="style1">&nbsp;</td>
            </tr>
            <tr>
                <td class="style12">
                    <asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>
                </td>
                <td class="style12">&nbsp;</td>
                <td class="style1">&nbsp;</td>
                <td class="style1">&nbsp;</td>
            </tr>
            <tr>
                <td class="style12">
                    <asp:Label ID="lblFolioFiscal" runat="server"></asp:Label>
                </td>
                <td class="style12">&nbsp;</td>
                <td class="style1">&nbsp;</td>
                <td class="style1">&nbsp;</td>
            </tr>
            <tr>
                <td class="style12">
                    <asp:Button ID="btnGenerar" runat="server" Text="Generar CFDI"
                        ValidationGroup="caja" Style="margin-top: 1px" />
                </td>
                <td class="style12">&nbsp;<asp:Button ID="btnActualizar" runat="server"
                    Text="Actualizar Importes" />
                </td>
                <td class="style1">
                    <asp:Button ID="btnTimbrar" runat="server" Text="Timbrar CFDI"
                        ValidationGroup="caja" />
                </td>
                <td class="style1">
                    <asp:Button ID="btnCorreo" runat="server" Text="Correo CFDI" />
                </td>
            </tr>
            <tr>
                <td class="style12">&nbsp;&nbsp;&nbsp;
                    &nbsp;<asp:SqlDataSource ID="sdsCliente" runat="server"
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                        SelectCommand="SELECT DISTINCT dbo.empresas.nombre, dbo.empresas.id_empresa FROM precios_cajas INNER JOIN dbo.empresas ON precios_cajas.id_cliente = dbo.empresas.id_empresa INNER JOIN orden_cajas ON precios_cajas.id_precio_caja = orden_cajas.id_precio where orden_cajas.fin &lt;orden_cajas.inicio or orden_cajas.fin &lt;getdate()"></asp:SqlDataSource>

                </td>
                <td class="style12">
                    <asp:SqlDataSource
                        ID="sdsOrdenes" runat="server"
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                        SelectCommand="SELECT CONVERT (nvarchar, orden_cajas.ano) + '-' + CONVERT (nvarchar, orden_cajas.consecutivo) + ' Caja:' + equipo_operacion.economico AS orden, orden_cajas.id_renta FROM orden_cajas INNER JOIN equipo_operacion ON orden_cajas.id_equipo = equipo_operacion.id_equipo INNER JOIN precios_cajas ON orden_cajas.id_precio = precios_cajas.id_precio_caja WHERE (precios_cajas.id_cliente = @id_cliente) and  orden_cajas.fin&lt;orden_cajas.inicio order by orden_cajas.ano desc, orden_cajas.consecutivo desc">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlCliente" Name="id_cliente"
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                </td>
                <td class="style1">

                    <asp:SqlDataSource ID="sdsFacturacion" runat="server"
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                        SelectCommand="razonSocialPorEmpresa"
                        SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlCliente" Name="idEmpresa"
                                PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                </td>
                <td class="style1">&nbsp;</td>
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

</asp:Content>
