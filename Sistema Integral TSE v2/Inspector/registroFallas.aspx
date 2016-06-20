<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="registroFallas.aspx.vb" Inherits="Sistema_Integral_TSE_v45.registroFallas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .style5
        {
            width: 100%;
        }
        .style6
        {
            height: 56px;
        }
        .style7
        {
            height: 56px;
            width: 90px;
        }
        .style8
        {
            width: 90px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Registro de fallas sin orden</h1>
    <hr />
    <table class="style5">
        <tr>
            <td class="style7">
                Unidad</td>
            <td class="style6">
                <asp:DropDownList ID="ddlUnidad" runat="server" DataSourceID="sdsUnida" 
                    DataTextField="economico" DataValueField="id_equipo" Height="16px" 
                    Width="201px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsUnida" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT [economico], [id_equipo] FROM [equipo_operacion] WHERE (([id_status] = @id_status) AND ([id_tipo_equipo] &lt;= @id_tipo_equipo)) ORDER BY [economico]">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                        <asp:Parameter DefaultValue="106" Name="id_tipo_equipo" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style7">
                Caja</td>
            <td class="style6">
                <asp:DropDownList ID="ddlCaja" runat="server" DataSourceID="sdsCaja" 
                    DataTextField="economico" DataValueField="id_equipo" Height="16px" 
                    Width="198px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsCaja" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT [economico], [id_equipo] FROM [equipo_operacion] WHERE (([id_status] = @id_status) AND ([id_tipo_equipo] &gt; @id_tipo_equipo))">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                        <asp:Parameter DefaultValue="106" Name="id_tipo_equipo" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td class="style8">
                Falla</td>
            <td>
                <asp:TextBox ID="txbFalla" runat="server" Height="175px" TextMode="MultiLine" 
                    Width="576px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style8">
                &nbsp;</td>
            <td>
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
            &nbsp;<asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
            </td>
        </tr>
    </table>
    <hr />
    <h1>Fallas registradas</h1>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        AutoGenerateColumns="False" DataKeyNames="ReporteId" DataSourceID="sdsFallas" 
        EnableModelValidation="True" SkinID="GridViewGreen">
        <Columns>
            <asp:BoundField DataField="ReporteId" InsertVisible="False" ReadOnly="True" 
                SortExpression="ReporteId" />
            <asp:BoundField DataField="falla" HeaderText="FALLA" SortExpression="falla" />
            <asp:CheckBoxField DataField="salida" HeaderText="Reportado al salir vehiculo?" 
                SortExpression="salida" />
            <asp:TemplateField HeaderText="TIPO DE EQUIPO">
                <ItemTemplate>
                    <asp:Label ID="lblTipoEquipo" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="EQUIPO" SortExpression="idEquipo">
                <ItemTemplate>
                    <asp:Label ID="lblEquipo" runat="server"></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("idEquipo") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ORDEN" SortExpression="idOrden">
                <ItemTemplate>
                    <asp:Label ID="lblOrden" runat="server"></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("idOrden") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="CHOFER" SortExpression="idChofer">
                <ItemTemplate>
                    <asp:Label ID="lblChofer" runat="server"></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("idChofer") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="idEstatus" HeaderText="ESTATUS" 
                SortExpression="idEstatus" />
            <asp:BoundField DataField="fecha" DataFormatString="{0:d}" 
                HeaderText="FECHA DE REPORTE" SortExpression="fecha" />
            <asp:TemplateField HeaderText="REPARACION">
                <ItemTemplate>
                    <asp:Label ID="lblReparacion" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsFallas" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        SelectCommand="SELECT * FROM [reportes_fallas] ORDER BY [ReporteId] DESC">
    </asp:SqlDataSource>
</asp:Content>
