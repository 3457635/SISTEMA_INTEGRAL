<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Nuevo_Precio.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Precios" 
    title="Untitled Page" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        Nuevo Servicio.</p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDservicioscliente" CellPadding="4" ForeColor="#333333" 
            GridLines="None">
            <RowStyle BackColor="#E3EAEB" />
            <Columns>
                <asp:BoundField DataField="RUTA" HeaderText="RUTA" SortExpression="RUTA" />
                <asp:BoundField DataField="VEHICULO" HeaderText="VEHICULO" 
                    SortExpression="VEHICULO" />
                <asp:BoundField DataField="ESPECIFICACION" HeaderText="ESPECIFICACION" 
                    SortExpression="ESPECIFICACION" />
                <asp:BoundField DataField="PRECIO" HeaderText="PRECIO" ReadOnly="True" 
                    SortExpression="PRECIO" />
                <asp:BoundField DataField="MONEDA" HeaderText="MONEDA" 
                    SortExpression="MONEDA" />
            </Columns>
            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#7C6F57" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDservicioscliente" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            
            SelectCommand="SELECT dbo.llave_rutas.ruta AS RUTA, dbo.tipo_vehiculo.descripcion AS VEHICULO, precios.especificacion AS ESPECIFICACION, '$' + CONVERT (nvarchar, CONVERT (money, precios.precio), 1) AS PRECIO, Moneda.moneda AS MONEDA FROM precios INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN dbo.tipo_vehiculo ON precios.id_tipo_recurso = dbo.tipo_vehiculo.id_tipo_recurso INNER JOIN Moneda ON precios.id_moneda = Moneda.id_moneda WHERE (precios.id_empresa = @id_empresa) ORDER BY vehiculo, RUTA">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlEmpresa" Name="id_empresa" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        &nbsp;<table style="width: 325px">
            <tr>
                <td style="width: 121px">
                    Empresa:</td>
                <td style="width: 194px">
                    <asp:DropDownList ID="ddlEmpresa" runat="server" DataSourceID="SqlDEmpresa" 
                        DataTextField="nombre" DataValueField="id_empresa" AutoPostBack="True">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDEmpresa" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [id_empresa], [nombre] FROM [empresas] ORDER BY [nombre]">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="width: 121px">
                    Especificación:</td>
                                        <td style="width: 194px">
                                            <asp:TextBox ID="txbEspecificacion" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 121px">
                                            Ruta:</td>
                                        <td style="width: 194px">
                                            <asp:DropDownList ID="ddlRuta" runat="server" DataSourceID="SqlDataSource1" 
                                                DataTextField="ruta" DataValueField="id_ruta">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                                SelectCommand="SELECT [id_ruta], [ruta] FROM [llave_rutas] ORDER BY [ruta]">
                                            </asp:SqlDataSource>
                                            <asp:Button ID="btnNuevo" runat="server" Text="Nueva..." />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 1px; width: 121px">
                                            Vehículo:</td>
                <td style="height: 1px; width: 194px;">
                    <asp:DropDownList ID="ddlVehiculo" runat="server" 
                        DataSourceID="SqlDataVehiculos" DataTextField="descripcion" 
                        DataValueField="id_tipo_recurso">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataVehiculos" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [id_tipo_recurso], [descripcion] FROM [tipo_vehiculo]">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="height: 1px; width: 121px">
                    Moneda:</td>
                <td style="height: 1px; width: 194px;">
                    <asp:DropDownList ID="ddlMoneda" runat="server" DataSourceID="SqlDMoneda" 
                        DataTextField="moneda" DataValueField="id_moneda">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDMoneda" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [moneda], [id_moneda] FROM [Moneda]">
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="height: 1px; width: 121px">
                    Precio:</td>
                <td style="height: 1px; width: 194px;">
                    <asp:TextBox ID="txbPrecio" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="height: 1px; width: 121px">
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
                </td>
                <td style="height: 1px; width: 194px;">
                    <asp:Label ID="lblAnuncio" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
        <br />
       
        <asp:ModalPopupExtender ID="mdlTrayecto" runat="server" TargetControlID="lblAnuncio"
                    PopupControlID="pnlChild"  
            BackgroundCssClass="modalBackground">
                </asp:ModalPopupExtender>
                
        
    <asp:Panel ID="pnlChild" runat="server" Style="display: none; position: absolute; width: 500px;
        border: solid 1px black; height: 400px; background-color: White; margin-left: 50px">
       
    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
    <ContentTemplate>   
        
        <table style="width: 100%"  bgcolor="White">
            <tr>
                <td colspan="3">
                    Nueva Ruta</td>
            </tr>
            <tr>
                <td>
                    Origen:
                    <asp:DropDownList ID="ddlOrigen" runat="server" 
                        DataSourceID="SqlDataOrigenes" DataTextField="ubicacion" 
                        DataValueField="id_ubicacion">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataOrigenes" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        
                        SelectCommand="SELECT [ubicacion], [id_ubicacion] FROM [ubicaciones] WHERE (([id_tipo_ubicacion] = @id_tipo_ubicacion) OR ([id_tipo_ubicacion] = @id_tipo_ubicacion2)) ORDER BY ubicacion">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="id_tipo_ubicacion" Type="Int32" />
                            <asp:Parameter DefaultValue="3" Name="id_tipo_ubicacion2" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td>
                    Intermedio:<asp:DropDownList ID="ddlIntermedio" runat="server" 
                        DataSourceID="SqlDataOrigenes" DataTextField="ubicacion" 
                        DataValueField="id_ubicacion">
                    </asp:DropDownList>
                </td>
                <td>
                    Destino:<asp:DropDownList ID="ddlDestino" runat="server" 
                        DataSourceID="SqlDataOrigenes" DataTextField="ubicacion" 
                        DataValueField="id_ubicacion">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnGuardarOrigen" runat="server" Text="Guardar"/>
                    &nbsp;</td>
                <td>
                    <asp:Button ID="btnGuardarIntermedio" runat="server" Text="Guardar"  />
                    &nbsp;</td>
                <td>
                    <asp:Button ID="btnGuardarDestino" runat="server" Text="Guardar"  />
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:Label ID="lblRuta" runat="server"></asp:Label>
                    <asp:Label ID="lblIdRuta" runat="server" Visible="False"></asp:Label>
                </td>
            </tr>
        </table>
    
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:Button ID="btnCloseChild" runat="server" Text="Cerrar" />
       

    </asp:Panel>
    </p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
</asp:Content>
