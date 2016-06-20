<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="cotizaciones.aspx.vb" Inherits="Sistema_Integral_TSE_v45.cotizaciones" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Cotizaciones</h1>
    <asp:Button ID="btnNuevo" runat="server" SkinID="btn"
        Text="Nueva Cotización..." />

    <br />
    <br />

    Año:<asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
    - Consecutivo:<asp:TextBox ID="txbConsecutivo" runat="server"></asp:TextBox>
    &nbsp;<asp:Button ID="btnBuscar" runat="server" SkinID="btn" Text="Buscar" />
    &nbsp;<br />
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
        DataKeyNames="id_cotizacion" DataSourceID="sdsCotizaciones" AllowPaging="True" PageSize="50"
        EmptyDataText="No hay datos" AllowSorting="True">
        <Columns>
            <asp:BoundField DataField="id_cotizacion" InsertVisible="False" ReadOnly="True"
                SortExpression="id_cotizacion">
                <ItemStyle Font-Size="0pt" Width="0px" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="ESTATUS">
                <ItemTemplate>
                    <asp:Image ID="imgEstatus" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="lnkAceptar" runat="server" CommandName="aceptar" CommandArgument="<%# CType(Container,GridViewRow).RowIndex  %>">Aceptada</asp:LinkButton>
                    <br />
                    <br />
                    <asp:LinkButton ID="lnkRechazada" runat="server" CommandName="rechazar" CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>">Rechazada</asp:LinkButton>
                    <br />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="lnkModificar" runat="server" CommandName="modificar"
                        CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>">Modificar</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton ID="lnkCancelar" runat="server" CommandName="cancelar" CommandArgument="<%# CType(Container,GridViewRow).RowIndex  %>">Cancelar</asp:LinkButton>
                    <asp:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" TargetControlID="lnkCancelar" ConfirmText="Al cancelar perdera la información de esta cotización, Continuar?">
                    </asp:ConfirmButtonExtender>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="folio" HeaderText="FOLIO" ReadOnly="True"
                SortExpression="folio" />
            <asp:TemplateField HeaderText="EMPRESA">
                <ItemTemplate>
                    <asp:Label ID="lblEmpresa" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="PRECIO">
                <ItemTemplate>
                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False"
                        DataSourceID="sdsPrecios" EnableModelValidation="True" SkinID="grdAnidado">
                        <AlternatingRowStyle BackColor="#FFFF99" />
                        <Columns>
                            <asp:BoundField DataField="letra" HeaderText="letra" SortExpression="letra" />
                            <asp:BoundField DataField="ruta" HeaderText="ruta" SortExpression="ruta" />
                            <asp:BoundField DataField="equipo" HeaderText="equipo"
                                SortExpression="equipo" />
                            <asp:BoundField DataField="precio" DataFormatString="{0:c}" HeaderText="precio"
                                SortExpression="precio">
                                <ItemStyle Font-Bold="True" />
                            </asp:BoundField>
                            <asp:BoundField DataField="moneda" HeaderText="moneda"
                                SortExpression="moneda" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsPrecios" runat="server"
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
                        SelectCommand="SELECT dbo.llave_rutas.ruta, tipo_equipos.equipo, precios.precio, tipos_monedas.moneda, precios.letra FROM precios INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN tipo_equipos ON precios.id_tipo_recurso = tipo_equipos.id_tipo_equipo INNER JOIN tipos_monedas ON precios.id_moneda = tipos_monedas.id_moneda WHERE (precios.id_cotizacion = @id_cotizacion) and precios.id_status&lt;&gt;6">
                        <SelectParameters>
                            <asp:Parameter Name="id_cotizacion" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="enviadoA" HeaderText="ENVIADO A" SortExpression="enviadoA" />
            <asp:TemplateField HeaderText="F. SOLICITUD">
                <ItemTemplate>
                    <asp:Label ID="lblSolicitud" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="F. RESPUESTA">
                <ItemTemplate>
                    <asp:Label ID="lblRespuesta" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="F. Vigencia">
                <ItemTemplate>
                    <asp:Label ID="lblFechaVigencia" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsCotizaciones" runat="server"
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"
        SelectCommand="listarCotizaciones" CancelSelectOnNullParameter="False"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="consecutivo" Type="Int32" />
            <asp:Parameter DefaultValue="2013" Name="ano" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />


</asp:Content>
