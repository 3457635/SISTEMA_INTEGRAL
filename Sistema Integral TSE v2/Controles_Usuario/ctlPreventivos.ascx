<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlPreventivos.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlPreventivos" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<style type="text/css">
    .style1
    {
        width: 260px;
        border-style: solid;
        border-width: 1px;
    }
    .style3
    {
        width: 51px;
    }
    .style5
    {
        width: 200px;
    }
</style>
<H1>Clasificación de Reparaciones</H1>
<p>
    <br />
    <asp:Button ID="btnNuevo" runat="server" Text="Nuevo" />
&nbsp;<asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
    <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
</p>
<table cellpadding="0" cellspacing="0" class="style1">
    <tr>
        <td class="style3">
            Reparacion:</td>
        <td class="style5">
            <asp:TextBox ID="txbServicio" runat="server" Width="200px"></asp:TextBox>
        </td>
    </tr>
</table>
<p>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="id" DataSourceID="sdsReparaciones" EnableModelValidation="True" 
        SkinID="GridView1">
        <Columns>
            <asp:CommandField EditText="Modificar" SelectText="Eliminar" 
                ShowEditButton="True" ShowSelectButton="True" />
            <asp:BoundField DataField="id" InsertVisible="False" ReadOnly="True" 
                SortExpression="id" />
            <asp:CheckBoxField DataField="correctivo" HeaderText="¿Es correctivo?" 
                SortExpression="correctivo" />
            <asp:BoundField DataField="reparacion" HeaderText="REPARACIÓN" 
                SortExpression="reparacion" />
        </Columns>
    </asp:GridView>
    
    <asp:SqlDataSource ID="sdsReparaciones" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        DeleteCommand="DELETE FROM [Tipo_reparacion] WHERE [id] = @id" 
        InsertCommand="INSERT INTO [Tipo_reparacion] ([correctivo], [reparacion]) VALUES (@correctivo, @reparacion)" 
        SelectCommand="SELECT * FROM [Tipo_reparacion] WHERE idEstatus=5" 
        UpdateCommand="UPDATE [Tipo_reparacion] SET [correctivo] = @correctivo, [reparacion] = @reparacion WHERE [id] = @id">
        <DeleteParameters>
            <asp:Parameter Name="id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="correctivo" Type="Boolean" />
            <asp:Parameter Name="reparacion" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="correctivo" Type="Boolean" />
            <asp:Parameter Name="reparacion" Type="String" />
            <asp:Parameter Name="id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</p>

