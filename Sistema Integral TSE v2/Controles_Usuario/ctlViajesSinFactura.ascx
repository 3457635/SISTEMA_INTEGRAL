<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlViajesSinFactura.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlViajesSinFactura" %>
<br />
<asp:DropDownList ID="ddlRango" runat="server" Height="20px" Width="204px">
    <asp:ListItem Value="Por salir">Viajes Por salir</asp:ListItem>
    <asp:ListItem Value="1 a 3">1 a 3 días</asp:ListItem>
    <asp:ListItem Value="4 a 7">4 a 7 días</asp:ListItem>
    <asp:ListItem Value="8 a 14">8 a 14 días</asp:ListItem>
    <asp:ListItem Value="14+">14+ días</asp:ListItem>
</asp:DropDownList>
&nbsp;&nbsp;
<asp:Button ID="btnConsultar" runat="server" Text="Consultar" />
&nbsp;<asp:Button ID="btnLimpiar" runat="server" Text="Limpiar" />
<br />
<p>
    <asp:GridView ID="grdDetalle" runat="server" AutoGenerateColumns="False" 
        DataSourceID="sdsViajes" EnableModelValidation="True" AllowPaging="True">
        <Columns>
            <asp:BoundField DataField="fecha_cierre" DataFormatString="{0:d}" 
                HeaderText="FECHA CIERRE" />
            <asp:TemplateField HeaderText="VERIFICADO">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("verificado") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" Checked="<%# Bind('Verificado') %>" 
                        Enabled="False" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="orden" HeaderText="ORDEN" />
            <asp:BoundField DataField="cliente" HeaderText="CLIENTE" />
            <asp:BoundField DataField="ruta" HeaderText="RUTA" />
            <asp:BoundField DataField="fecha_viaje" HeaderText="FECHA VIAJE" />
            <asp:BoundField DataField="Días" HeaderText="DIAS" />
            <asp:BoundField DataField="Precio" DataFormatString="{0:c0}" 
                HeaderText="PRECIO" />
        </Columns>
        <PagerSettings Position="Top" />
    </asp:GridView>
    <asp:SqlDataSource ID="sdsViajes" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        SelectCommand="ViajesSinFacturar" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="13" Name="nTipo_Cambio" Type="Int32" />
            <asp:Parameter DefaultValue="Viajes" Name="cCual" Type="String" />
            <asp:ControlParameter ControlID="ddlRango" DefaultValue="" Name="cTipo" 
                PropertyName="SelectedValue" Type="String" />
            <asp:Parameter DefaultValue="Sin_Facturar" Name="cEstado" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</p>

