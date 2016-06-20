<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="ReporteFacturacion.aspx.vb" Inherits="Sistema_Integral_TSE_v45.ReporteFacturacion" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register Src="../Controles_Usuario/ctlUnfactured.ascx" TagName="ctlUnfactured" TagPrefix="uc1" %>

<%@ Register Src="../Controles_Usuario/ctlContrarecibo.ascx" TagName="ctlContrarecibo" TagPrefix="uc2" %>

<%@ Register Src="../Controles_Usuario/ctlCajasSinCobro.ascx" TagName="ctlCajasSinCobro" TagPrefix="uc3" %>

<%@ Register Src="../Controles_Usuario/ctlGraficaSinFactura.ascx" TagName="ctlGraficaSinFactura" TagPrefix="uc4" %>

<%@ Register Src="../Controles_Usuario/ctlMail.ascx" TagName="ctlMail" TagPrefix="uc5" %>

<%@ Register Src="../Controles_Usuario/ctlViajesSinFactura.ascx" TagName="ctlViajesSinFactura" TagPrefix="uc6" %>

<%@ Register Src="~/Controles_Usuario/ctlCancelarCFDI.ascx" TagName="ctlCancelarCFDI" TagPrefix="uc7" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Reporte de Facturación<asp:WebPartManager ID="WebPartManager1" runat="server">
    </asp:WebPartManager>
    </h1>
    <p>
        <asp:WebPartZone ID="WebPartZone1" runat="server" SkinID="wprtProfesional"
            Width="753px">
            <ZoneTemplate>
                <asp:TabContainer ID="TabContainer1" runat="server" title="Viajes Sin Factura" ActiveTabIndex="0" Height="459px" ScrollBars="Auto">
                    <asp:TabPanel ID="TabPanel1" runat="server" HeaderText="Gráfica" Title="Viajes Sin Facturar">
                        <ContentTemplate>

                            <uc4:ctlGraficaSinFactura ID="ctlGraficaSinFactura1" runat="server" />
                        </ContentTemplate>

                    </asp:TabPanel>
                    <asp:TabPanel ID="TabPanel2" runat="server" HeaderText="Detalle">
                        <ContentTemplate>
                            <uc6:ctlViajesSinFactura ID="ctlViajesSinFactura1" runat="server" />

                        </ContentTemplate>

                    </asp:TabPanel>
                    <asp:TabPanel ID="TabPanel3" runat="server" HeaderText="Renta de Cajas">
                        <ContentTemplate>
                            <uc3:ctlCajasSinCobro ID="ctlCajasSinCobro1" title="Cajas Alquiladas" runat="server" />
                        </ContentTemplate>
                    </asp:TabPanel>
                </asp:TabContainer>

            </ZoneTemplate>
        </asp:WebPartZone>
        <hr />
        <h1>Consulta de facturas</h1>
        <asp:RadioButtonList ID="rbtnTipoFactura" runat="server">
            <asp:ListItem Selected="True" Value="0">Factura Mexicana</asp:ListItem>
            <asp:ListItem Value="1">Factura Americana</asp:ListItem>
        </asp:RadioButtonList>
        <p>
            Fecha de Facturación;
        </p>
        <p>
            Desde:<asp:TextBox ID="txbFechaInicio" runat="server"></asp:TextBox>
            <asp:CalendarExtender ID="txbFechaInicio_CalendarExtender" runat="server"
                TargetControlID="txbFechaInicio" Format="yyyy/MM/dd">
            </asp:CalendarExtender>
            &nbsp;Hasta:<asp:TextBox ID="txbFechaFin" runat="server"></asp:TextBox>
            <asp:CalendarExtender ID="txbFechaFin_CalendarExtender" runat="server"
                Enabled="True" TargetControlID="txbFechaFin" Format="yyyy/MM/dd">
            </asp:CalendarExtender>
            &nbsp;
        </p>
        <p>
            Cliente:
            <asp:DropDownList ID="ddlCliente" runat="server" AppendDataBoundItems="True"
                DataSourceID="SqlDataSource2" DataTextField="nombre"
                DataValueField="id_empresa">
            </asp:DropDownList>
            &nbsp;<asp:ImageButton ID="ibtnActualizar0" runat="server"
                ImageUrl="~/imagenes/refresh.png" SkinID="ibtnActualizar" />
            <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                SelectCommand="SELECT * FROM [empresas] WHERE (([id_tipo_empresa] = @id_tipo_empresa) AND ([id_status] = @id_status)) ORDER BY [nombre]">
                <SelectParameters>
                    <asp:Parameter DefaultValue="1" Name="id_tipo_empresa" Type="Int32" />
                    <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
        </p>
        <p>
            Buscar Factura:
        </p>
        <table class="style8">
            <tr>
                <td class="style10">Folio:</td>
                <td class="style12">
                    <asp:TextBox ID="txbBuscarFactura" runat="server"></asp:TextBox>
                </td>
                <td class="style14">
                    <asp:ImageButton ID="ibtnActualizar1" runat="server"
                        ImageUrl="~/imagenes/refresh.png" SkinID="ibtnActualizar" />
                </td>
            </tr>
            <tr>
                <td class="style10">Serie:</td>
                <td class="style12">
                    <asp:TextBox ID="txbSerie" runat="server"></asp:TextBox>
                </td>
                <td class="style14">&nbsp;</td>
            </tr>
        </table>
        <hr />


        <uc7:ctlCancelarCFDI ID="ctlCancelarCFDI1" runat="server" />
        <hr />
        <h1>Cancelar facturas americanas
            
    </h1><asp:Label ID="Label1" runat="server" Text="Folio de la factura americana"></asp:Label><asp:TextBox ID="txtFolioFactAmericana" runat="server" Width="179px"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" Text="Cancelar" />
    <asp:Label ID="lblMensajeFactAmericana" runat="server" ForeColor="Red"></asp:Label>
        <hr />
        <p>
            <span style="color: #FF0000">Viajes sin facturar:</span>
            <asp:LinkButton ID="lnkSinFactura" runat="server"></asp:LinkButton>
        </p>
        <hr />
        <h1>Contrarecibos</h1>
        <p>
            <asp:ImageButton ID="ibtnPrint" runat="server" SkinID="ibtnImprimir"
                Height="35px" Width="41px" />
            &nbsp;
        </p>
        <table style="width: 100%">
            <tr>
                <td style="width: 134px">
                    <asp:RadioButtonList ID="RadioButtonList1" runat="server">
                        <asp:ListItem Selected="True" Value="0">Con Importe</asp:ListItem>
                        <asp:ListItem Value="1">Sin Importe</asp:ListItem>
                        <asp:ListItem Value="2">Reporte TRW</asp:ListItem>
                        <asp:ListItem Value="3">Renta de Cajas</asp:ListItem>
                        <asp:ListItem Value="4">Global</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
                <td>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server"
                        CancelSelectOnNullParameter="False"
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                        DeleteCommand="DELETE FROM [facturas] WHERE [id_factura] = @id_factura"
                        InsertCommand="INSERT INTO [facturas] ([folio], [importe], [iva], [retencion], [total], [Cancelada], [id_dato_facturacion], [facturada_dolares], [Contrarecibo]) VALUES (@folio, @importe, @iva, @retencion, @total, @Cancelada, @id_dato_facturacion, @facturada_dolares, @Contrarecibo)"
                        SelectCommand="mostrarFacturacion" SelectCommandType="StoredProcedure"
                        UpdateCommand="UPDATE [facturas] SET [folio] = @folio, [Cancelada] = @Cancelada,   [Contrarecibo] = @Contrarecibo WHERE [id_factura] = @id_factura">
                        <DeleteParameters>
                            <asp:Parameter Name="id_factura" Type="Int32" />
                        </DeleteParameters>

                        <InsertParameters>
                            <asp:Parameter Name="folio" />
                            <asp:Parameter Name="importe" />
                            <asp:Parameter Name="iva" />
                            <asp:Parameter Name="retencion" />
                            <asp:Parameter Name="total" />
                            <asp:Parameter Name="Cancelada" />
                            <asp:Parameter Name="id_dato_facturacion" />
                            <asp:Parameter Name="facturada_dolares" />
                            <asp:Parameter Name="Contrarecibo" />
                        </InsertParameters>

                        <SelectParameters>
                            <asp:Parameter Name="idEmpresa" Type="Int32" />
                            <asp:Parameter Name="folio" Type="Int32" />
                            <asp:Parameter Name="inicio" Type="DateTime" />
                            <asp:Parameter Name="fin" Type="DateTime" />
                            <asp:Parameter Name="serie" Type="Int32" />
                            <asp:Parameter DefaultValue="4" Name="tipoFecha" Type="Int32" />
                            <asp:Parameter Name="tipoConsulta" Type="Int32" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="folio" Type="Int32" />
                            <asp:Parameter Name="Cancelada" Type="Boolean" />
                            <asp:Parameter Name="Contrarecibo" Type="Boolean" />
                            <asp:Parameter Name="id_factura" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
        <hr />
        <h1>Detalle de facturas</h1>
        <asp:GridView
            ID="grd" runat="server" CssClass="Grid"
            BackColor="White" BorderColor="#CCCCCC" BorderStyle="None"
            BorderWidth="1px"
            RowStyle-VerticalAlign="Bottom"
            CellPadding="3" EnableModelValidation="True" AutoGenerateColumns="False"
            Width="1500px" ShowFooter="True" AllowPaging="True" PageSize="50"
            DataKeyNames="id_factura" DataSourceID="SqlDataSource3">


            <Columns>
                <asp:BoundField DataField="id_factura" InsertVisible="False" ReadOnly="True"
                    SortExpression="id_factura">
                    <ItemStyle Font-Size="0pt" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="CANCELADAS">
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/imagenes/cancel.png"
                            Visible='<%# Bind("Cancelada") %>' />
                    </ItemTemplate>
                    <ItemStyle VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="CONTRARECIBO">
                    <ItemTemplate>
                        <asp:CheckBox ID="ckbContrarecibo" runat="server" AutoPostBack="True"
                            Checked="<%# Bind('Contrarecibo')%>"
                            OnCheckedChanged="ckbContrarecibo_CheckedChanged" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="folioFiscal" HeaderText="FOLIO FISCAL"
                    ReadOnly="True" />
                <asp:BoundField DataField="serie" HeaderText="SERIE" ReadOnly="True" />
                <asp:BoundField DataField="fecha" DataFormatString="{0:d}"
                    HeaderText="FECHA FACTURA" />
                <asp:BoundField DataField="folio" HeaderText="FACTURA" ReadOnly="True">

                    <ItemStyle VerticalAlign="Middle" />

                </asp:BoundField>
                <asp:BoundField DataField="importe" HeaderText="IMPORTE"
                    DataFormatString="{0:c}" ReadOnly="True">

                    <ItemStyle VerticalAlign="Middle" />

                </asp:BoundField>
                <asp:BoundField DataField="iva" DataFormatString="{0:c}" HeaderText="IVA"
                    ReadOnly="True">
                    <ItemStyle VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="total" DataFormatString="{0:c}" HeaderText="TOTAL"
                    ReadOnly="True">
                    <ItemStyle VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="SERVICIO">
                    <ItemTemplate>
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                            DataSourceID="SqlDataSource1"
                            EnableModelValidation="True" BorderStyle="None"
                            ShowHeader="False" GridLines="Vertical">
                            <Columns>
                                <asp:BoundField DataField="orden" HeaderText="orden" SortExpression="orden"
                                    ReadOnly="True">
                                    <ItemStyle Width="100px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="nombre" HeaderText="nombre" SortExpression="nombre">
                                    <ItemStyle Width="150px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ruta" HeaderText="ruta" SortExpression="ruta">
                                    <ItemStyle Width="200px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="equipo" HeaderText="equipo" SortExpression="equipo">
                                    <ItemStyle Width="70px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="fecha_viaje" HeaderText="fecha_viaje"
                                    ReadOnly="True" SortExpression="fecha_viaje">
                                    <ItemStyle Width="50px" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>

                        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                            SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) AS orden, dbo.empresas.nombre, dbo.llave_rutas.ruta, tipo_equipos.equipo, CONVERT (nvarchar, fechas.fecha, 3) AS fecha_viaje FROM Ordenes INNER JOIN viajes ON Ordenes.id_orden = viajes.id_orden INNER JOIN facturacion ON viajes.id_viaje = facturacion.id_viaje INNER JOIN precios ON viajes.id_relacion = precios.id_relacion AND viajes.id_relacion = precios.id_relacion AND viajes.id_relacion = precios.id_relacion INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN tipo_equipos ON precios.id_tipo_recurso = tipo_equipos.id_tipo_equipo INNER JOIN fechas_viaje ON viajes.id_viaje = fechas_viaje.id_viaje INNER JOIN fechas ON fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha AND fechas_viaje.id_fecha = fechas.id_fecha INNER JOIN facturas ON facturacion.id_factura = facturas.id_factura 
WHERE 
facturas.id_factura=@idFactura
and
fechas.tipo_fecha=1">
                            <SelectParameters>
                                <asp:Parameter Name="idFactura" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <br />
                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False"
                            BorderStyle="None" DataSourceID="sdsCajas" EnableModelValidation="True"
                            GridLines="Vertical">
                            <Columns>
                                <asp:BoundField DataField="nombre" HeaderText="CLIENTE" SortExpression="nombre"></asp:BoundField>
                                <asp:BoundField DataField="economico" HeaderText="CAJA"
                                    SortExpression="economico"></asp:BoundField>
                                <asp:BoundField DataField="inicio" DataFormatString="{0:d}" HeaderText="DESDE"
                                    SortExpression="inicio"></asp:BoundField>
                                <asp:BoundField DataField="fin" DataFormatString="{0:d}" HeaderText="HASTA"
                                    SortExpression="fin"></asp:BoundField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsCajas" runat="server"
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                            SelectCommand="SELECT dbo.empresas.nombre, equipo_operacion.economico, facturas_cajas.inicio, facturas_cajas.fin FROM facturas_cajas INNER JOIN facturas ON facturas_cajas.id_factura = facturas.id_factura INNER JOIN orden_cajas ON facturas_cajas.id_renta = orden_cajas.id_renta INNER JOIN equipo_operacion ON orden_cajas.id_equipo = equipo_operacion.id_equipo INNER JOIN precios_cajas ON orden_cajas.id_precio = precios_cajas.id_precio_caja INNER JOIN dbo.empresas ON precios_cajas.id_cliente = dbo.empresas.id_empresa WHERE (facturas.id_factura = @idFactura)">
                            <SelectParameters>
                                <asp:Parameter Name="idFactura" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
                        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="sdsOtros" EnableModelValidation="True" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="concepto" HeaderText="concepto" SortExpression="concepto" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsOtros" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="SELECT 
facturasOtros.concepto 
FROM 
facturasOtros 
INNER JOIN 
facturas 
ON 
facturasOtros.idFactura = facturas.id_factura 
WHERE (facturasOtros.idFactura = @idFactura)">
                            <SelectParameters>
                                <asp:Parameter Name="idFactura" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
                        <br />
                        <br />

                    </ItemTemplate>

                    <ItemStyle VerticalAlign="Middle" Width="400px" />

                </asp:TemplateField>
                <asp:TemplateField HeaderText="PDF">
                    <ItemTemplate>
                        <asp:ImageButton ID="ibtnPdf" runat="server"
                            CommandName="descargarPdf"
                            CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>"
                            ImageUrl="~/imagenes/pdf.png" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="XML">
                    <ItemTemplate>
                        <asp:ImageButton ID="ibtnXml"
                            runat="server"
                            CommandName="descargarXml"
                            CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>"
                            ImageUrl="~/imagenes/xml.png" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="ibtnCorreo" runat="server"
                            CommandName="enviarMail"
                            CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>"
                            ImageUrl="~/imagenes/mail.png" />

                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="enviadoA" HeaderText="ENVIADO A"
                    SortExpression="enviadoA" />
            </Columns>
            <FooterStyle BackColor="#003366" ForeColor="White" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White"
                CssClass="DataGridFixedHeader" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <RowStyle ForeColor="#000066" />
            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
        </asp:GridView>
        <br />
        <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server"
            BackgroundCssClass="modalBackground" PopupControlID="Panel1"
            TargetControlID="btn">
        </asp:ModalPopupExtender>
        <asp:Button ID="btn" runat="server" />
        <asp:Panel ID="Panel1" runat="server" BackColor="White">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>

                    <uc5:ctlMail ID="ctlMail1" runat="server" />

                </ContentTemplate>
            </asp:UpdatePanel>

            <br />
            <asp:Button ID="btnCerrar" runat="server" Text="Cerrar" />
        </asp:Panel>
        <br />
        <br />
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Head">
    <style type="text/css">
        .style8 {
            width: 205px;
        }

        .style10 {
            width: 39px;
        }

        .style12 {
            width: 128px;
        }

        .style14 {
            width: 24px;
        }
    </style>
</asp:Content>

