<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlCajas.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlCajas" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<p>
   
    Caja:
    <asp:DropDownList ID="ddlEquipo" runat="server" 
        DataSourceID="SqlDataSource1" DataTextField="economico" 
        DataValueField="id_equipo" Height="17px" Width="95px" AutoPostBack="True">
    </asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        
        
        SelectCommand="SELECT [id_equipo], [economico] FROM [equipo_operacion] WHERE (([id_tipo_equipo] = @id_tipo_equipo) AND ([id_status] = @id_status)) ORDER BY [economico]">
        <SelectParameters>
            <asp:Parameter DefaultValue="107" Name="id_tipo_equipo" Type="Int32" />
            <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</p>
<asp:Button ID="btnNuevo" runat="server" Text="Nuevo" />
&nbsp;
<asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
&nbsp;<asp:Button ID="btnEliminar" runat="server" Text="Eliminar" />
<asp:ConfirmButtonExtender
    ID="ConfirmButtonExtender1" runat="server" TargetControlID="btnEliminar" ConfirmText="Esta apunto de eliminar una caja.">
</asp:ConfirmButtonExtender>
&nbsp;<p>
    <asp:TextBox ID="txbIdEquipo" runat="server" Visible="False"></asp:TextBox>
    <asp:Label ID="lblMensaje" runat="server"></asp:Label>
</p>
<table class="style1">
    <tr>
        <td>
            Economico:</td>
        <td>
            <asp:TextBox ID="txbEconomico" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>
            Placa:</td>
        <td>
            <asp:TextBox ID="txbPlaca" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>
            Marca:</td>
        <td>
            <asp:DropDownList ID="ddlmarca" runat="server" DataSourceID="SqlDataSource2" 
                DataTextField="marca" DataValueField="id_marca">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                SelectCommand="SELECT [id_marca], [marca] FROM [marcas]">
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td>
            No. Serie</td>
        <td>
            <asp:TextBox ID="txbSerie" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>
            Año:</td>
        <td>
            <asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>
            Pies:</td>
        <td>
            <asp:TextBox ID="txbPies" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>
            Tipo de Uso:</td>
        <td>
            <asp:DropDownList ID="ddlUso" runat="server" Height="17px" Width="173px" 
                DataSourceID="SqlDataSource3" DataTextField="tipo_uso" 
                DataValueField="id_tipo_uso">
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                SelectCommand="SELECT [id_tipo_uso], [tipo_uso] FROM [tipo_uso]">
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td>
            Puede cruzar:</td>
        <td>
            <asp:CheckBox ID="CheckBox1" runat="server" />
        </td>
    </tr>
</table>

