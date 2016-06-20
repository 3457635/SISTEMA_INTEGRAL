<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Unidades.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Unidades" %>
<%@ Register src="~/Controles_Usuario/ctlUnidad.ascx" tagname="ctlUnidad" tagprefix="uc1" %>
<%@ Register src="../../Controles_Usuario/tramites_equipo.ascx" tagname="tramites_equipo" tagprefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">  
    <div>
        <uc1:ctlUnidad ID="ctlUnidad1" runat="server" />
        <br />
        <di align="center">
        </div>
        <table class="style8">
            <tr>
                <td class="style9">
                    Tipo de Equipo:</td>
                <td class="style10">
                    Marca:</td>
                <td class="style10">
                    Estado:</td>
                <td class="style10">
                    No. Economico:</td>
                <td class="style10">
                    Año:</td>
                <td class="style10">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style9">
                    <asp:DropDownList ID="ddlTipoEquipo" runat="server" 
                        DataSourceID="sdsTipoEquipo" DataTextField="equipo" 
                        DataValueField="id_tipo_equipo" Width="150px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsTipoEquipo" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [id_tipo_equipo], [equipo] FROM [tipo_equipos]">
                    </asp:SqlDataSource>
                </td>
                <td class="style10">
                    <asp:DropDownList ID="ddlMarca" runat="server" DataSourceID="sdsMarca" 
                        DataTextField="marca" DataValueField="id_marca" Width="150px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsMarca" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [marca], [id_marca] FROM [marcas]">
                    </asp:SqlDataSource>
                </td>
                <td class="style10">
                    <asp:DropDownList ID="ddlEstatus" runat="server" Width="150px">
                        <asp:ListItem Value="5">Activos</asp:ListItem>
                        <asp:ListItem Value="6">Baja</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="style10">
                    <asp:TextBox ID="txbEconomico" runat="server" Width="150px"></asp:TextBox>
                </td>
                <td class="style10">
                    <asp:TextBox ID="txbAno" runat="server" Width="150px"></asp:TextBox>
                </td>
                <td class="style10">
                    <asp:Button ID="btnBuscar" runat="server" SkinID="btn" Text="Buscar" />
                </td>
            </tr>
    </table>
    <br />
        <br />
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="id_equipo" DataSourceID="sdsUnidadesModificar" 
            EnableModelValidation="True" SkinID="GridViewGreen">
            <Columns>
                <asp:CommandField ShowEditButton="True" />
                <asp:BoundField DataField="id_equipo" InsertVisible="False" ReadOnly="True" 
                    SortExpression="id_equipo">
                <ItemStyle Font-Size="0pt" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="TIPO EQUIPO" SortExpression="id_tipo_equipo">
                    <ItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" 
                            DataSourceID="sdsTipoEquipo" DataTextField="equipo" 
                            DataValueField="id_tipo_equipo" Enabled="False" 
                            SelectedValue='<%# Bind("id_tipo_equipo") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsTipoEquipo" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                            SelectCommand="SELECT [equipo], [id_tipo_equipo] FROM [tipo_equipos]">
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList4" runat="server" 
                            DataSourceID="sdsTipoEquipo" DataTextField="equipo" 
                            DataValueField="id_tipo_equipo" SelectedValue='<%# Bind("id_tipo_equipo") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsTipoEquipo" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                            SelectCommand="SELECT [equipo], [id_tipo_equipo] FROM [tipo_equipos]">
                        </asp:SqlDataSource>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="economico" HeaderText="ECONOMICO" 
                    SortExpression="economico" />
                <asp:BoundField DataField="placa" HeaderText="PLACA" SortExpression="placa" />
                <asp:TemplateField HeaderText="MARCA" SortExpression="id_marca">
                    <ItemTemplate>
                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="sdsMarca" 
                            DataTextField="marca" DataValueField="id_marca" Enabled="False" 
                            SelectedValue='<%# Bind("id_marca") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsMarca" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                            SelectCommand="SELECT [marca], [id_marca] FROM [marcas]">
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="sdsMarca" 
                            DataTextField="marca" DataValueField="id_marca" 
                            SelectedValue='<%# Bind("id_marca") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsMarca" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                            SelectCommand="SELECT [marca], [id_marca] FROM [marcas]">
                        </asp:SqlDataSource>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="serie" HeaderText="SERIE" SortExpression="serie" />
                <asp:TemplateField HeaderText="ESTATUS" SortExpression="id_status">
                    <ItemTemplate>
                        <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="sdsEstatus" 
                            DataTextField="estatus" DataValueField="id_status" Enabled="False" 
                            SelectedValue='<%# Bind("id_status") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsEstatus" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                            SelectCommand="SELECT [estatus], [id_status] FROM [estado_activacion]">
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList6" runat="server" DataSourceID="sdsEstatus" 
                            DataTextField="estatus" DataValueField="id_status" 
                            SelectedValue='<%# Bind("id_status") %>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsEstatus" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                            SelectCommand="SELECT [estatus], [id_status] FROM [estado_activacion]">
                        </asp:SqlDataSource>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ano" HeaderText="AÑO" SortExpression="ano" />
                <asp:TemplateField HeaderText="TIPO USO" SortExpression="idUso">
                    <EditItemTemplate>
                        <%--<asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("idUso") %>'></asp:TextBox>--%>
                        <asp:DropDownList ID="DropDownTipoUsoE" runat="server" DataSourceID="sdsTipoUsoUnidad" 
                            DataTextField="uso" DataValueField="id" Enabled="True" 
                            SelectedValue='<%# Bind("idUso")%>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsTipoUsoUnidad" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                            SelectCommand="SELECT [uso], [id] FROM [TipoUsoUnidad]">
                        </asp:SqlDataSource>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="DropDownTipoUsoI" runat="server" DataSourceID="sdsTipoUsoUnidad" 
                            DataTextField="uso" DataValueField="id" Enabled="False" 
                            SelectedValue='<%# Bind("idUso")%>'>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="sdsTipoUsoUnidad" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                            SelectCommand="SELECT [uso], [id] FROM [TipoUsoUnidad]">
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsUnidadesModificar" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            DeleteCommand="DELETE FROM [equipo_operacion] WHERE [id_equipo] = @id_equipo" 
            InsertCommand="INSERT INTO [equipo_operacion] ([economico], [placa], [id_marca], [serie], [id_tipo_equipo], [id_status], [ano], [idBase], [enBase]) VALUES (@economico, @placa, @id_marca, @serie, @id_tipo_equipo, @id_status, @ano, @idBase, @enBase)" 
            SelectCommand="SELECT *
FROM 
equipo_operacion
 WHERE 
(id_status IS NOT NULL) 
AND (id_status = ISNULL(@id_status, id_status)) 
AND (id_tipo_equipo = ISNULL(@id_tipo_equipo, id_tipo_equipo)) 
AND (ano = ISNULL(@ano, ano)) 
AND (id_marca = ISNULL(@id_marca, id_marca)) 
AND (economico = ISNULL(@economico, economico)) 
ORDER BY id_tipo_equipo, economico" 
            
        UpdateCommand="UPDATE [equipo_operacion] SET [localero]=@localero, [economico] = @economico, [placa] = @placa, [id_marca] = @id_marca, [serie] = @serie, [id_tipo_equipo] = @id_tipo_equipo, [id_status] = @id_status, [ano] = @ano, [idUso] = @idUso WHERE [id_equipo] = @id_equipo" 
        CancelSelectOnNullParameter="False">
            <DeleteParameters>
                <asp:Parameter Name="id_equipo" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="economico" Type="String" />
                <asp:Parameter Name="placa" Type="String" />
                <asp:Parameter Name="id_marca" Type="Int32" />
                <asp:Parameter Name="serie" Type="String" />
                <asp:Parameter Name="id_tipo_equipo" Type="Int32" />
                <asp:Parameter Name="id_status" Type="Int32" />
                <asp:Parameter Name="ano" Type="String" />
                <asp:Parameter Name="idUso" Type="Int32" />
                <asp:Parameter Name="idBase" Type="Int32" />
                <asp:Parameter Name="enBase" Type="Boolean" />
            </InsertParameters>
            <SelectParameters>
                <asp:Parameter Name="id_status" />
                <asp:Parameter Name="id_tipo_equipo" />
                <asp:Parameter Name="ano" />
                <asp:Parameter Name="id_marca" />
                <asp:Parameter Name="economico" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="localero" Type="Boolean" />
                <asp:Parameter Name="economico" Type="String" />
                <asp:Parameter Name="placa" Type="String" />
                <asp:Parameter Name="id_marca" Type="Int32" />
                <asp:Parameter Name="serie" Type="String" />
                <asp:Parameter Name="id_tipo_equipo" Type="Int32" />
                <asp:Parameter Name="id_status" Type="Int32" />
                <asp:Parameter Name="ano" Type="String" />
                <asp:Parameter Name="id_equipo" Type="Int32" />
                <asp:Parameter Name="idUso" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
    </div>
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="Head">
    <style type="text/css">
        .style8
        {
            width: 772px;
        }
        .style9
        {
            width: 77px;
        }
        .style10
        {
            width: 150px;
        }
    </style>
</asp:Content>

