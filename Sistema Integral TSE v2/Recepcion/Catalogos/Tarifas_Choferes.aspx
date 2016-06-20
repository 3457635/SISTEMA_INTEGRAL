<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Tarifas_Choferes.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Tarifas_Choferes" 
    title="Untitled Page" %>
<%@ Register src="../../Controles_Usuario/ctlTarifas.ascx" tagname="ctlTarifas" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        Tarifas Choferes.</p>
    <table style="width: 100%">
        <tr>
            <td style="height: 30px; width: 88px">
                Cliente:</td>
            <td style="height: 30px; width: 30%">
                Ruta:</td>
            <td style="height: 30px; width: 21%">
                Vehículo:</td>
            <td style="height: 30px; width: 31%">
                &nbsp;</td>
            <td style="width: 9%; height: 30px">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="height: 30px; width: 88px">
                <asp:DropDownList ID="ddlCliente" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSource1" DataTextField="nombre" 
                    DataValueField="id_empresa">
                </asp:DropDownList>
            </td>
            <td style="height: 30px; width: 30%">
                <asp:DropDownList ID="ddlRuta" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSource2" DataTextField="ruta" DataValueField="id_ruta">
                </asp:DropDownList>
            </td>
            <td style="height: 30px; width: 21%">
&nbsp;<asp:DropDownList ID="ddlVehiculo" runat="server" AutoPostBack="True" 
                    DataSourceID="SqlDataSource3" DataTextField="equipo" 
                    DataValueField="id_tipo_equipo" AppendDataBoundItems="True">
                    <asp:ListItem Value="0">Seleccionar...</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td style="height: 30px; width: 31%">
                                        Tarifa Chofer:<asp:TextBox ID="txbTarifa" runat="server"></asp:TextBox>
            </td>
            <td style="width: 9%; height: 30px">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" SkinID="btnGuardar" />
                </td>
        </tr>
        <tr>
            <td colspan="5">
                <asp:Label ID="lblAnuncio" runat="server" SkinID="lblMensaje"></asp:Label>
                <br />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    EnableModelValidation="True" SkinID="GridView1">
                    <Columns>
                        <asp:BoundField DataField="id_relacion" />
                        <asp:BoundField DataField="ruta" HeaderText="RUTA" />
                        <asp:BoundField DataField="vehiculo" HeaderText="VEHICULO" />
                        <asp:TemplateField HeaderText="TARIFA">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("tarifa") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:GridView ID="GridView2" runat="server" DataSourceID="sdsTarifa" 
                                    EnableModelValidation="True" ShowHeader="False">
                                </asp:GridView>
                                <asp:SqlDataSource ID="sdsTarifa" runat="server"></asp:SqlDataSource>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>
                            <p>
                                &nbsp;<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                    SelectCommand="SELECT id_empresa, nombre FROM dbo.empresas where id_status=5 and id_tipo_empresa=1 order by nombre">
                                </asp:SqlDataSource>
&nbsp;<asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                    
                                    SelectCommand="SELECT DISTINCT dbo.llave_rutas.ruta, dbo.llave_rutas.id_ruta FROM dbo.llave_rutas INNER JOIN rutas_cliente ON dbo.llave_rutas.id_ruta = rutas_cliente.id_ruta WHERE (dbo.llave_rutas.id_status = 5) AND (rutas_cliente.id_empresa = @id_empresa) ORDER BY dbo.llave_rutas.ruta">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="ddlCliente" Name="id_empresa" 
                                            PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </p>
    <uc1:ctlTarifas ID="ctlTarifas1" runat="server" />
    <p>
&nbsp;<asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                                    
            SelectCommand="SELECT equipo, id_tipo_equipo FROM tipo_equipos WHERE (id_tipo_equipo &lt; 106)">
                                </asp:SqlDataSource>
                            </p>
</asp:Content>
