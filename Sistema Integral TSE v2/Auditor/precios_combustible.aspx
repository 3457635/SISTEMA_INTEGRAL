<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="precios_combustible.aspx.vb" Inherits="Sistema_Integral_TSE_v45.precios_combustible" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Precios de Combustible</h1>
    <table >
        <tr>
            <td>
                Combustible</td>
            <td>
                Precio</td>
            <td>
                Fecha</td>
        </tr>
        <tr>
            <td>
                <asp:DropDownList ID="ddlCombustible" runat="server" 
                    DataSourceID="sdsCombustible" DataTextField="combustible" 
                    DataValueField="id" AutoPostBack="True">
                </asp:DropDownList>
                <asp:LinkButton ID="lnkAgregar" runat="server">+ Agregar</asp:LinkButton>
                <asp:SqlDataSource ID="sdsCombustible" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT [id], [combustible] FROM [tipos_combustible]">
                </asp:SqlDataSource>
                
            </td>
            <td>
                <asp:TextBox ID="txbPrecio" runat="server"></asp:TextBox>
            </td>
            <td>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txbPrecio" Display="Dynamic" ErrorMessage="*">Campo Obligatorio</asp:RequiredFieldValidator>
                <asp:TextBox ID="txbFecha" runat="server"></asp:TextBox><asp:CalendarExtender ID="CalendarExtender1"
                    runat="server" TargetControlID="txbFecha" Format="dd/MM/yyyy">
                </asp:CalendarExtender>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="txbFecha" ErrorMessage="*">Campo Obligatorio</asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
    <asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
    <br />
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="id" DataSourceID="sdsPrecios" EnableModelValidation="True">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" />
            <asp:BoundField DataField="id" InsertVisible="False" ReadOnly="True" 
                SortExpression="id">
            <ItemStyle Font-Size="0pt" Width="0px" />
            </asp:BoundField>
            <asp:BoundField DataField="combustible" HeaderText="COMBUSTIBLE" 
                SortExpression="combustible" />
            <asp:BoundField DataField="precio" DataFormatString="{0:c2}" HeaderText="PRECIO" 
                SortExpression="precio" />
            <asp:BoundField DataField="fecha" HeaderText="FECHA" SortExpression="fecha" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsPrecios" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        DeleteCommand="DELETE FROM [costo_combustible] WHERE [id] = @id" 
        InsertCommand="INSERT INTO [costo_combustible] ([tipo_combustible], [fecha], [precio]) VALUES (@tipo_combustible, @fecha, @precio)" 
        SelectCommand="SELECT costo_combustible.id, costo_combustible.fecha, costo_combustible.precio, tipos_combustible.combustible FROM costo_combustible INNER JOIN tipos_combustible ON costo_combustible.tipo_combustible = tipos_combustible.id WHERE (costo_combustible.tipo_combustible = @tipo_combustible) ORDER BY costo_combustible.fecha DESC" 
        
        UpdateCommand="UPDATE [costo_combustible] SET [tipo_combustible] = @tipo_combustible, [fecha] = @fecha, [precio] = @precio WHERE [id] = @id">
        <DeleteParameters>
            <asp:Parameter Name="id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="tipo_combustible" Type="Int32" />
            <asp:Parameter Name="fecha" Type="DateTime" />
            <asp:Parameter Name="precio" Type="Decimal" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlCombustible" Name="tipo_combustible" 
                PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="tipo_combustible" Type="Int32" />
            <asp:Parameter Name="fecha" Type="DateTime" />
            <asp:Parameter Name="precio" Type="Decimal" />
            <asp:Parameter Name="id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
