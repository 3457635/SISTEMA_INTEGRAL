<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="prepago.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Pagos" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register src="../../../../Controles_Usuario/ctlGraficaEgresos.ascx" tagname="ctlGraficaEgresos" tagprefix="uc1" %>
<%@ Register src="../../../../Controles_Usuario/ctlGraficaDistribucionEgresos.ascx" tagname="ctlGraficaDistribucionEgresos" tagprefix="uc2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<br />
    <div id="header">
      <h1> Registro de cuentas por pagar.</h1>
        </div>
       
        <asp:WebPartManager ID="WebPartManager1" runat="server">
    </asp:WebPartManager>
    <asp:WebPartZone ID="WebPartZone1" runat="server" SkinID="wprtProfesional">
        <ZoneTemplate>
            <uc1:ctlGraficaEgresos ID="ctlGraficaEgresos1" runat="server" title="Egresos" />
        </ZoneTemplate>
    </asp:WebPartZone>
    <asp:WebPartZone ID="WebPartZone2" runat="server" SkinID="wprtProfesional">
        <ZoneTemplate>
            <uc2:ctlGraficaDistribucionEgresos ID="ctlGraficaDistribucionEgresos1" title="Distribucion de Egresos"
        runat="server" />
        </ZoneTemplate>
    </asp:WebPartZone>
       
        <br />
    <div id="main">

     <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
    <table style="width: 715px">
        <tr>
            <td class="style5">
                Proveedor:</td>
            <td class="style6">
                <asp:DropDownList ID="ddlProveedor" runat="server" 
                    DataSourceID="SqlDataSource1" DataTextField="nombre" 
                    DataValueField="id_empresa" Width="167px" Font-Bold="True" 
                    Font-Names="Arial" ForeColor="Black">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    
                    SelectCommand="SELECT id_empresa, nombre FROM dbo.empresas WHERE (id_tipo_empresa = @id_tipo_empresa) AND (id_status = 5) ORDER BY nombre">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="2" Name="id_tipo_empresa" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:LinkButton ID="lnkProveedores" runat="server" CausesValidation="False">Catalogo de Proveedores</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td class="style5">
                Descripción del Producto o servicio:</td>
            <td class="style6">
                <asp:TextBox ID="txbDescripcion" runat="server" Height="88px" TextMode="MultiLine" 
                    Width="391px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style5">
                Fecha de Pago:
            </td>
            <td class="style6">
                <asp:TextBox ID="txbProPago" runat="server"></asp:TextBox>
                <asp:CalendarExtender ID="CalendarExtender1"
                    runat="server" TargetControlID="txbProPago" Format="dd/MM/yyyy">
                </asp:CalendarExtender>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txbProPago" ErrorMessage="Campo Obligatorio" 
                    ValidationGroup="prepago"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style5">
                Factura:</td>
            <td class="style6">
                <asp:TextBox ID="txbFactura" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="txbFactura" ErrorMessage="Campo Obligatorio" 
                    ValidationGroup="prepago"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style5">
                Importe:</td>
            <td class="style6">
                <asp:TextBox ID="txbImporte" runat="server" Height="22px" Width="145px"></asp:TextBox>
                
            </td>
        </tr>
        <tr>
            <td class="style5">
                IVA:</td>
            <td class="style6">
                <asp:DropDownList ID="ddlIva" runat="server" AutoPostBack="True" Height="17px" 
                    Width="55px">
                    <asp:ListItem Value=".16" Selected="True">16%</asp:ListItem>
                    <asp:ListItem Value=".11">11%</asp:ListItem>
                    <asp:ListItem Value="0">0%</asp:ListItem>
                </asp:DropDownList>
&nbsp;<asp:TextBox ID="txbIdGasto" runat="server" Visible="False"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style5">
                <asp:Button ID="btnGuardar" runat="server" skinid="btnGuardar" 
                    ValidationGroup="prepago" />
            </td>
            <td class="style6">
                <asp:Label ID="lblMensaje" runat="server" skinid="lblMensaje"></asp:Label>
            </td>
        </tr>
    </table>
            
    <br />
    </div>
    <br />
    </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
             <table style="width: 100%">
                    <tr>
                        <td>
                            Mes:
                            <asp:DropDownList ID="ddlMes" runat="server">
                                <asp:ListItem Selected="True" Value="0">Seleccionar...</asp:ListItem>
                                <asp:ListItem Value="1">Enero</asp:ListItem>
                                <asp:ListItem Value="2">Febrero</asp:ListItem>
                                <asp:ListItem Value="3">Marzo</asp:ListItem>
                                <asp:ListItem Value="4">Abril</asp:ListItem>
                                <asp:ListItem Value="5">Mayo</asp:ListItem>
                                <asp:ListItem Value="6">Junio</asp:ListItem>
                                <asp:ListItem Value="7">Julio</asp:ListItem>
                                <asp:ListItem Value="8">Agosto</asp:ListItem>
                                <asp:ListItem Value="9">Septiembre</asp:ListItem>
                                <asp:ListItem Value="10">Octubre</asp:ListItem>
                                <asp:ListItem Value="11">Noviembre</asp:ListItem>
                                <asp:ListItem Value="12">Diciembre</asp:ListItem>
                            </asp:DropDownList>
                            &nbsp; Año:
                            <asp:TextBox ID="txbAno" runat="server" Text=""></asp:TextBox>
                            <asp:MaskedEditExtender ID="MaskedEditExtender2" runat="server" Century="2012" 
                                Mask="9999" MaskType="Number" TargetControlID="txbAno">
                            </asp:MaskedEditExtender>
                            &nbsp;<asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" 
                                SkinID="ibtnActualizar" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Proveedor:
                            <asp:DropDownList ID="ddlEmpresa" runat="server" AppendDataBoundItems="True" 
                                DataSourceID="SqlDataSource2" DataTextField="nombre" 
                                DataValueField="id_empresa" Height="19px" Width="171px">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                SelectCommand="SELECT * FROM [empresas] WHERE ([id_tipo_empresa] = @id_tipo_empresa) and id_status=5 ORDER BY [nombre]">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="2" Name="id_tipo_empresa" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:ImageButton ID="ImageButton2" runat="server" CausesValidation="False" 
                                SkinID="ibtnActualizar" style="width: 14px" />
                        </td>
                    </tr>
                    <tr>
                        <td class="style7">
                            <asp:Label ID="lblMensaje2" runat="server" SkinID="lblMensaje"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;</td>
                    </tr>
                </table>
            </ContentTemplate>
            </asp:UpdatePanel>
   
    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnlHistorialEgresos" runat="server" GroupingText="*Historial de Egresos" 
                Width="724px">
                
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="id_gasto" EmptyDataText="No hay resultados." 
                    EnableModelValidation="True" SkinID="GridView1" 
                    AutoGenerateSelectButton="True">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="ImageButton3" runat="server" CausesValidation="False" 
                                    CommandName="delete" onclick="ImageButton3_Click" SkinID="ibtnBorrar" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="APROBADO">
                            <ItemTemplate>
                                <asp:Image ID="imgAprovado" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="nombre" HeaderText="PROVEEDOR" />
                        <asp:BoundField DataField="folio" HeaderText="FACTURA" />
                        <asp:BoundField DataField="descripcion" HeaderText="DESCRIPCIÓN" />
                        <asp:BoundField DataField="cantidad" DataFormatString="{0:c}" 
                            HeaderText="IMPORTE" />
                        <asp:BoundField DataField="iva" DataFormatString="{0:c}" HeaderText="IVA" />
                        <asp:BoundField DataField="total" DataFormatString="{0:c}" HeaderText="TOTAL" />
                        <asp:BoundField DataField="fecha_programacion_pago" DataFormatString="{0:d}" 
                            HeaderText="FECHA PAGO" />
                        <asp:BoundField DataField="id_gasto">
                        <ItemStyle Font-Size="0pt" Width="0px" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
            </asp:Panel>
        </ContentTemplate>
       
    </asp:UpdatePanel>
    <br />
   
    <br />
    </div>
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="Head">
    <style type="text/css">
        .style5
        {
            width: 251px;
        }
        .style6
        {
            width: 454px;
        }
        .style7
        {
            height: 22px;
        }
    </style>
</asp:Content>

