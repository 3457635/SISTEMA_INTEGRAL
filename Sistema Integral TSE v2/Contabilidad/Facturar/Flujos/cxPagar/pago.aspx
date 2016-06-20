<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master"
    CodeBehind="pago.aspx.vb" Inherits="Sistema_Integral_TSE_v45.pago" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        Facturas Pagadas.</p>
    <p>
        Buscar por fecha de promesa de pago</p>
    <p>
        Desde:
    <asp:TextBox ID="txbFecha1" runat="server"></asp:TextBox><asp:CalendarExtender ID="CalendarExtender3"
            runat="server" TargetControlID="txbFecha1" Format="dd/MM/yyyy" >
        </asp:CalendarExtender>
&nbsp;-
        Hasta:
        <asp:TextBox ID="txbFecha2" runat="server"></asp:TextBox><asp:CalendarExtender ID="CalendarExtender4"
            runat="server" TargetControlID="txbFecha2" Format="dd/MM/yyyy" >
        </asp:CalendarExtender>
    &nbsp;<asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnActualizar" 
            ValidationGroup="fecha" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
            ControlToValidate="txbFecha1" ErrorMessage="Ingrese la fecha" 
            ValidationGroup="fecha"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
            ControlToValidate="txbFecha2" ErrorMessage="Ingrese la fecha." 
            ValidationGroup="fecha"></asp:RequiredFieldValidator>
    </p>
    <p>
        Buscar por Proveedor<br />
        Proveedor:
        <asp:DropDownList ID="ddlProveedor" runat="server" Height="16px" Width="212px" 
            AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="SqlDataSource3" 
            DataTextField="nombre" DataValueField="id_empresa">
            <asp:ListItem Value="0">Seleccionar...</asp:ListItem>
        </asp:DropDownList>
        &nbsp;<asp:ImageButton ID="ImageButton3" runat="server" 
            SkinID="ibtnActualizar" ValidationGroup="fecha" />
&nbsp;</p>
    <p>
    &nbsp;<asp:SqlDataSource ID="SqlDataSource3" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            
            SelectCommand="SELECT [id_empresa], [nombre] FROM [empresas] WHERE ([id_tipo_empresa] = @id_tipo_empresa) ORDER BY nombre">
            <SelectParameters>
                <asp:Parameter DefaultValue="2" Name="id_tipo_empresa" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        &nbsp;Buscar por&nbsp;factura:
        <asp:TextBox ID="txbFacturaBuscar" runat="server"></asp:TextBox>
        &nbsp;&nbsp;
        <asp:Button ID="btnBuscar" runat="server" Text="Buscar" 
            ValidationGroup="factura" />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
            ControlToValidate="txbFacturaBuscar" 
            ErrorMessage="Ingrese el numero de factura." ValidationGroup="factura"></asp:RequiredFieldValidator>
    </p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        <asp:Button ID="Button1" runat="server" Enabled="False" />
    </p>
    <p>
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="id_gasto" OnSelectedIndexChanging="Listview1_SelectedIndexChanging">
            <ItemTemplate>
                <tr bgcolor="#979700">
                    <td valign="top">
                        <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/imagenes/edit.png"
                            CommandName="Select" Height="30" Width="30" />
                    </td>
                    <td><asp:Image ID="Image1" runat="server" ImageUrl="" AlternateText="sin pagar" /></td>
                    
                    <td>
                        <asp:Label ID="lblFactura" runat="server" Text='<%#Eval("folio") %>' Font-Bold="True" />
                    </td>
                    <td>
                        <asp:Label ID="lblProveedor" runat="server" Text='<%#obtener_proveedor(Eval("id_gasto")) %>'
                            Font-Bold="True" />
                    </td>
                    <td>
                        <asp:Label ID="lblDescripcion" runat="server" Text='<%#Eval("descripcion") %>' Font-Bold="True" />
                    </td>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text='<%#Eval("forma_pago") %>' Font-Bold="True" />
                    </td>
                    <td>
                        <asp:Label ID="lblReferencia" runat="server" Text='<%#obtener_referencia(Eval("id_gasto")) %>'
                            Font-Bold="True" />
                    </td>
                    <td>
                        <asp:Label ID="lblImporte" runat="server" Text='<%#Eval("cantidad") %>' Font-Bold="True" />
                    </td>
                    <td>
                        <asp:Label ID="lblIva" runat="server" Text='<%#Eval("iva") %>' Font-Bold="True" />
                    </td>
                    <td>
                        <asp:Label ID="lblNeto" runat="server" Text='<%#obtener_neto(Eval("id_gasto")) %>'
                            Font-Bold="True" />
                    </td>
                    <td>
                        <asp:Label ID="lblPropago" runat="server" Text='<%#programacion_pago(Eval("id_gasto")) %>'
                            Font-Bold="True" />
                    </td>
                    <td>
                        <asp:Label ID="lblPago" runat="server" Text='<%#pago(Eval("id_gasto")) %>' Font-Bold="True" />
                    </td>
                    <td>
                        <asp:Label ID="lblIdGasto" runat="server" Text='<%#Eval("id_gasto") %>' Font-Bold="True" />
                    </td>
                </tr>
            </ItemTemplate>
            <AlternatingItemTemplate>
                <tr bgcolor="White">
                    <td valign="top">
                        <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/imagenes/edit.png"
                            CommandName="Select" Height="30" Width="30" />
                    </td>
                    <td><asp:Image ID="Image1" runat="server" ImageUrl="" /></td>
                    <td>
                        <asp:Label ID="lblFactura" runat="server" Text='<%#Eval("folio") %>' Font-Bold="True" />
                    </td>
                    <td>
                        <asp:Label ID="lblProveedor" runat="server" Text='<%#obtener_proveedor(Eval("id_gasto")) %>'
                            Font-Bold="True" />
                    </td>
                    <td>
                        <asp:Label ID="lblDescripcion" runat="server" Text='<%#Eval("descripcion") %>' Font-Bold="True" />
                    </td>
                    <td>
                        <asp:Label ID="lblFormaPago" runat="server" Text='<%#Eval("forma_pago") %>' Font-Bold="True" />
                    </td>
                    <td>
                        <asp:Label ID="lblReferencia" runat="server" Text='<%#obtener_referencia(Eval("id_gasto")) %>'
                            Font-Bold="True" />
                    </td>
                    <td>
                        <asp:Label ID="lblImporte" runat="server" Text='<%#Eval("cantidad") %>' Font-Bold="True" />
                    </td>
                    <td>
                        <asp:Label ID="lblIva" runat="server" Text='<%#Eval("iva") %>' Font-Bold="True" />
                    </td>
                    <td>
                        <asp:Label ID="lblNeto" runat="server" Text='<%#obtener_neto(Eval("id_gasto")) %>'
                            Font-Bold="True" />
                    </td>
                    <td>
                        <asp:Label ID="lblPropago" runat="server" Text='<%#programacion_pago(Eval("id_gasto")) %>'
                            Font-Bold="True" />
                    </td>
                    <td>
                        <asp:Label ID="lblPago" runat="server" Text='<%#pago(Eval("id_gasto")) %>' Font-Bold="True" />
                    </td>
                    <td>
                        <asp:Label ID="lblIdGasto" runat="server" Text='<%#Eval("id_gasto") %>' Font-Bold="True" />
                    </td>
                </tr>
            </AlternatingItemTemplate>
            <LayoutTemplate>
                <table border="1" cellspacing="0">
                    <tr>
                        <th>
                        </th>
                        <th>
                            
                        </th>
                        <th>
                            FACTURA
                        </th>
                        <th>
                            PROVEEDOR
                        </th>
                        <th>
                            DESCRIPCION
                        </th>
                        <th>
                            MODO DE PAGO
                        </th>
                        <th>
                            REFERENCIA DE PAGO
                        </th>
                        <th>
                            IMPORTE
                        </th>
                        <th>
                            IVA
                        </th>
                        <th>
                            NETO
                        </th>
                        <th>
                            PROGRAMACIÓN PAGO
                        </th>
                        <th>
                            PAGO
                        </th>
                        <th>
                        </th>
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                    </tr>
                </table>
            </LayoutTemplate>
        </asp:ListView>
    </p>
                       
    <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="Button1" PopupControlID="Panel1">
    </asp:ModalPopupExtender>
    <asp:Panel ID="Panel1" runat="server" BackColor="white">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table style="width: 100%">
                <tr>
                    <td style="width: 242px">
                        Proveedor:
                    </td>
                    <td>
                        <asp:Label ID="lblProveedor" runat="server"></asp:Label>
                        <asp:TextBox ID="txbIdGasto" runat="server" Visible="False"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 242px">
                        Factura:
                    </td>
                    <td>
                        <asp:TextBox ID="txbFolio" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 242px">
                        Fecha Programacion de pago:
                    </td>
                    <td>
                        <asp:TextBox ID="txbProPago" runat="server"></asp:TextBox>
                        <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txbProPago"
                            Format="dd/MM/yyyy">
                        </asp:CalendarExtender>
                    </td>
                </tr>
                <tr>
                    <td style="width: 242px">
                        Fecha de Pago:
                    </td>
                    <td>
                        <asp:TextBox ID="txbPago" runat="server" Width="170px"></asp:TextBox><asp:CalendarExtender
                            ID="CalendarExtender2" runat="server" TargetControlID="txbPago" Format="dd/MM/yyyy">
                        </asp:CalendarExtender>
                    </td>
                </tr>
                <tr>
                    <td style="width: 242px">
                        Medio de Pago:
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlMedio" runat="server" Width="150px" DataSourceID="SqlDataSource2"
                            DataTextField="forma_pago" DataValueField="id_forma_pago">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                            SelectCommand="SELECT [id_forma_pago], [forma_pago] FROM [formas_pago]"></asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td style="width: 242px">
                        Referencia:
                    </td>
                    <td>
                        <asp:TextBox ID="txbReferencia" runat="server">0</asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 242px">
                        Cuenta:
                    </td>
                    <td>
                        &nbsp;<asp:DropDownList ID="ddlCuenta" runat="server" DataSourceID="SqlDataSource1"
                            DataTextField="cuenta" DataValueField="id_cuenta" Height="16px" Width="159px">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                            SelectCommand="SELECT [cuenta], [id_cuenta] FROM [conta_cuentas] WHERE (([id_padre] = @id_padre) Or ([id_cuenta] = @id_cuenta))">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="27" Name="id_padre" Type="Int32" />
                                <asp:Parameter DefaultValue="34" Name="id_cuenta" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td style="width: 242px">
                        Importe:
                    </td>
                    <td>
                        <asp:TextBox ID="txbImporte" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 242px">
                        IVA:
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlIva" runat="server" AutoPostBack="True">
                            <asp:ListItem Value="0.00">Seleccionar...</asp:ListItem>
                            <asp:ListItem Value=".16">16%</asp:ListItem>
                            <asp:ListItem Value=".11">11%</asp:ListItem>
                            <asp:ListItem Value="0">0%</asp:ListItem>
                        </asp:DropDownList>
                        <asp:Label ID="lblIva" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 242px">
                        Total:
                    </td>
                    <td>
                        <asp:Label ID="lblTotal" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 242px">
                        <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
                    </td>
                    <td>
                        &nbsp;
                        <asp:Label ID="lblMensaje" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Button ID="btnCerrar" runat="server" Text="Cerrar" />
    </asp:Panel>
    <p>
    </p>
</asp:Content>
