<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlPrecios.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlPrecios" %>


<table>
    <tr>
        <td>
            Cliente:</td>
        <td>
            <asp:DropDownList ID="ddlCliente" runat="server" 
                DataSourceID="SqlDataSource1" DataTextField="nombre" 
                DataValueField="id_empresa" BackColor="#FFFF99" Width="195px">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                
                SelectCommand="SELECT [id_empresa], [nombre] FROM [empresas] WHERE ([id_status] = @id_status) and id_tipo_empresa=1 ORDER BY [nombre]">
                <SelectParameters>
                    <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
    </tr>
</table>
<p>
    <asp:RadioButtonList ID="RadioButtonList1" runat="server">
        <asp:ListItem Value="5">Activos</asp:ListItem>
        <asp:ListItem Value="6">Eliminado</asp:ListItem>
        <asp:ListItem Value="9">Pendiente</asp:ListItem>
        <asp:ListItem Value="10">Rechazado</asp:ListItem>
    </asp:RadioButtonList>
</p>
<p style="text-align: center">
    <asp:Button ID="btnBuscar" runat="server" SkinID="btn" Text="Buscar" />
</p>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
    DataKeyNames="id_relacion" CellPadding="4" ForeColor="#333333" 
    GridLines="None" Visible="False">
    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    <Columns>
        <asp:CommandField ShowEditButton="True" />
        <asp:BoundField DataField="id_relacion" 
            InsertVisible="False" ReadOnly="True" SortExpression="id_relacion" >
        <ItemStyle Font-Size="0pt" />
        </asp:BoundField>
        <asp:BoundField DataField="ruta" HeaderText="Ruta" SortExpression="ruta" 
            ReadOnly="True" />
        <asp:BoundField DataField="equipo" HeaderText="Equipo" 
            SortExpression="equipo" ReadOnly="True" />
        <asp:BoundField DataField="precio" HeaderText="Precio" 
            SortExpression="precio" DataFormatString="{0:c}" />
        <asp:TemplateField HeaderText="Moneda" SortExpression="id_moneda">
            <EditItemTemplate>
                <asp:DropDownList ID="DropDownList2" runat="server" 
                    SelectedValue='<%# Bind("id_moneda") %>'>
                    <asp:ListItem Value="4">M.N.</asp:ListItem>
                    <asp:ListItem Value="5">Dlls.</asp:ListItem>
                </asp:DropDownList>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:DropDownList ID="DropDownList4" runat="server" Enabled="False" 
                    SelectedValue='<%# Bind("id_moneda") %>'>
                    <asp:ListItem Value="4">M.N.</asp:ListItem>
                    <asp:ListItem Value="5">Dlls.</asp:ListItem>
                </asp:DropDownList>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Estatus" SortExpression="id_status">
            <EditItemTemplate>
                <asp:DropDownList ID="DropDownList1" runat="server" 
                    SelectedValue='<%# Bind("id_status") %>'>
                    <asp:ListItem Value="5">Activo</asp:ListItem>
                    <asp:ListItem Value="6">Baja</asp:ListItem>
                    <asp:ListItem Value="9">En Espera</asp:ListItem>
                    <asp:ListItem Value="10">Rechazada</asp:ListItem>
                </asp:DropDownList>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:DropDownList ID="DropDownList3" runat="server" Enabled="False" 
                    SelectedValue='<%# Bind("id_status") %>'>
                    <asp:ListItem Value="5">Activo</asp:ListItem>
                    <asp:ListItem Value="6">Baja</asp:ListItem>
                    <asp:ListItem Value="9">En espera</asp:ListItem>
                    <asp:ListItem Value="10">Rechazado</asp:ListItem>
                </asp:DropDownList>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:CheckBoxField DataField="factura_dolares" HeaderText="Facturada en dolares" 
            SortExpression="factura_dolares" />
        <asp:BoundField DataField="especificacion" HeaderText="Especificación" SortExpression="especificacion" />
        <asp:TemplateField HeaderText="Cotización/Caducidad">
            <ItemTemplate>
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="sdsCotizacion" ShowHeader="False" 
                    SkinID="GridViewGreen" DataKeyNames="id_cotizacion" OnRowCommand="GridView2_RowCommand">
                    <Columns>
                        
                        <asp:BoundField DataField="Expr1" HeaderText="Expr1" ReadOnly="True" 
                            SortExpression="Expr1">
                        </asp:BoundField>
                        <asp:BoundField DataField="id_cotizacion" 
                            HeaderText="id_cotizacion" SortExpression="id_cotizacion" InsertVisible="False" ReadOnly="True" />
                        <asp:BoundField DataField="fechacaducidadprecio" HeaderText="fechacaducidadprecio" SortExpression="fechacaducidadprecio" />
                        <asp:TemplateField HeaderText="Modificar caducidad">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkModificar" runat="server" CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>" CommandName="modificarCaducidad">Modificar caducidad</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsCotizacion" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT CONVERT (nvarchar, cotizaciones.ano) + '-' + CONVERT (nvarchar, cotizaciones.consecutivo) + '-' + precios.letra AS Expr1,cotizaciones.id_cotizacion, cotizaciones.fechacaducidadprecio FROM cotizaciones INNER JOIN precios ON cotizaciones.id_cotizacion = precios.id_cotizacion WHERE (precios.id_relacion = @id_relacion)">
                    <SelectParameters>
                        <asp:Parameter Name="id_relacion" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
    <EditRowStyle BackColor="#999999" />
    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
</asp:GridView>
<asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
    DataKeyNames="id_relacion" DataSourceID="SqlDataSource2" CellPadding="4" ForeColor="#333333" 
    GridLines="None">
    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    <Columns>
        <asp:CommandField ShowEditButton="True" />
        <asp:BoundField DataField="id_relacion" 
            InsertVisible="False" ReadOnly="True" SortExpression="id_relacion" >
        <ItemStyle Font-Size="0pt" />
        </asp:BoundField>
        <asp:BoundField DataField="id_cotizacion" HeaderText="Cotizacion " />
        <asp:BoundField DataField="ano" HeaderText="Año" />
        <asp:TemplateField HeaderText="Modificar Caducidad">
            <ItemTemplate>
                <asp:LinkButton ID="lnkModificar" runat="server" CommandArgument="<%# CType(Container,GridViewRow).RowIndex %>" CommandName="modificar">Modificar caducidad</asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="fechaCaducidadPrecio" HeaderText="Caducidad" />
        <asp:BoundField DataField="ruta" HeaderText="Ruta" SortExpression="ruta" 
            ReadOnly="True" />
        <asp:BoundField DataField="equipo" HeaderText="Equipo" 
            SortExpression="equipo" ReadOnly="True" />
        <asp:BoundField DataField="precio" HeaderText="Precio" 
            SortExpression="precio" DataFormatString="{0:c}" />
        <asp:TemplateField HeaderText="Moneda" SortExpression="id_moneda">
            <EditItemTemplate>
                <asp:DropDownList ID="DropDownList5" runat="server" 
                    SelectedValue='<%# Bind("id_moneda") %>'>
                    <asp:ListItem Value="4">M.N.</asp:ListItem>
                    <asp:ListItem Value="5">Dlls.</asp:ListItem>
                </asp:DropDownList>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:DropDownList ID="DropDownList6" runat="server" Enabled="False" 
                    SelectedValue='<%# Bind("id_moneda") %>'>
                    <asp:ListItem Value="4">M.N.</asp:ListItem>
                    <asp:ListItem Value="5">Dlls.</asp:ListItem>
                </asp:DropDownList>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Estatus" SortExpression="id_status">
            <EditItemTemplate>
                <asp:DropDownList ID="DropDownList7" runat="server" 
                    SelectedValue='<%# Bind("id_status") %>'>
                    <asp:ListItem Value="5">Activo</asp:ListItem>
                    <asp:ListItem Value="6">Baja</asp:ListItem>
                    <asp:ListItem Value="9">En Espera</asp:ListItem>
                    <asp:ListItem Value="10">Rechazada</asp:ListItem>
                </asp:DropDownList>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:DropDownList ID="DropDownList8" runat="server" Enabled="False" 
                    SelectedValue='<%# Bind("id_status") %>'>
                    <asp:ListItem Value="5">Activo</asp:ListItem>
                    <asp:ListItem Value="6">Baja</asp:ListItem>
                    <asp:ListItem Value="9">En espera</asp:ListItem>
                    <asp:ListItem Value="10">Rechazado</asp:ListItem>
                </asp:DropDownList>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:CheckBoxField DataField="factura_dolares" HeaderText="Facturada en dolares" 
            SortExpression="factura_dolares" />
        <asp:BoundField DataField="especificacion" HeaderText="Especificación" SortExpression="especificacion" />
    </Columns>
    <EditRowStyle BackColor="#999999" />
    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
</asp:GridView>
<asp:SqlDataSource ID="SqlDataSource2" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
    DeleteCommand="UPDATE [precios] SET [id_status] = 6 WHERE [id_relacion] = @id_relacion"
    InsertCommand="INSERT INTO [precios] ([id_ruta], [id_tipo_recurso], [id_empresa], [id_moneda], [especificacion], [tarifa], [precio], [id_fecha]) VALUES (@id_ruta, @id_tipo_recurso, @id_empresa, @id_moneda, @especificacion, @tarifa, @precio, @id_fecha)" 
    SelectCommand="SELECT precios.id_relacion, dbo.llave_rutas.ruta, tipo_equipos.equipo, precios.precio, precios.id_status, precios.factura_dolares, 
precios.id_moneda, precios.id_cotizacion, c.fechacaducidadprecio, c.ano,
precios.especificacion FROM precios INNER JOIN 
dbo.llave_rutas 
ON precios.id_ruta = dbo.llave_rutas.id_ruta 
INNER JOIN 
tipo_equipos 
ON precios.id_tipo_recurso = tipo_equipos.id_tipo_equipo left join cotizaciones c on c.id_cotizacion = precios.id_cotizacion 
WHERE 
(precios.id_empresa =@id_empresa)
AND (precios.id_status = @id_status) 
ORDER BY dbo.llave_rutas.ruta, tipo_equipos.equipo" 
          
    
    UpdateCommand="UPDATE [precios] SET [precio] = @precio,[factura_dolares]=@factura_dolares, id_status=@id_status, id_moneda=@id_moneda, especificacion=@especificacion WHERE [id_relacion] = @id_relacion">
    <DeleteParameters>
        <asp:Parameter Name="id_relacion" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="id_ruta" Type="Int32" />
        <asp:Parameter Name="id_tipo_recurso" Type="Int32" />
        <asp:Parameter Name="id_empresa" Type="Int32" />
        <asp:Parameter Name="id_moneda" Type="Int32" />
        <asp:Parameter Name="especificacion" Type="String" />
        <asp:Parameter Name="tarifa" Type="Double" />
        <asp:Parameter Name="precio" Type="Double" />
        <asp:Parameter Name="id_fecha" Type="Int32" />
    </InsertParameters>
    <SelectParameters>
         <asp:Parameter Name="id_empresa" Type="Int32" />
        <asp:Parameter Name="id_status" />
    </SelectParameters>
    <UpdateParameters>
        <asp:Parameter Name="precio" Type="Double" />        
    <asp:Parameter Name="factura_dolares" Type="boolean" />    
     <asp:Parameter Name="id_status" Type="Int32" />         
    <asp:Parameter Name="id_moneda" Type="Int32" />   
    <asp:Parameter Name="id_relacion" Type="Int32" />  
    
        <asp:Parameter Name="especificacion" />
    
    </UpdateParameters>
</asp:SqlDataSource>

