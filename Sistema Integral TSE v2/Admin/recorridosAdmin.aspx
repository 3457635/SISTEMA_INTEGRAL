<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="recorridosAdmin.aspx.vb" Inherits="Sistema_Integral_TSE_v45.recorridosAdmin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <br />
        Grupo:<asp:TextBox ID="txbGrupo" runat="server"></asp:TextBox>
&nbsp;<asp:Button ID="btnGuardar" runat="server" Text="Buscar" />
    </p>
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="id" DataSourceID="sdsRecorrido" EnableModelValidation="True">
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" 
                ReadOnly="True" SortExpression="id" />
            <asp:TemplateField HeaderText="tipoTrayecto" SortExpression="tipoTrayecto">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sdsTrayectos" 
                        DataTextField="tipo_trayecto" DataValueField="id_tipo_trayecto" 
                        SelectedValue='<%# Bind("tipoTrayecto") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsTrayectos" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [tipo_trayecto], [id_tipo_trayecto] FROM [tipo_trayecto]">
                    </asp:SqlDataSource>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("tipoTrayecto") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="grupo" HeaderText="grupo" SortExpression="grupo" />
            <asp:BoundField DataField="idEquipoAsignado" HeaderText="idEquipoAsignado" 
                SortExpression="idEquipoAsignado" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsRecorrido" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        DeleteCommand="DELETE FROM [recorridoEquipo] WHERE [id] = @id" 
        InsertCommand="INSERT INTO [recorridoEquipo] ([tipoTrayecto], [grupo], [idEquipoAsignado]) VALUES (@tipoTrayecto, @grupo, @idEquipoAsignado)" 
        SelectCommand="SELECT * FROM [recorridoEquipo] WHERE ([grupo] = @grupo)" 
        UpdateCommand="UPDATE [recorridoEquipo] SET [tipoTrayecto] = @tipoTrayecto, [grupo] = @grupo, [idEquipoAsignado] = @idEquipoAsignado WHERE [id] = @id">
        <DeleteParameters>
            <asp:Parameter Name="id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="tipoTrayecto" Type="Int32" />
            <asp:Parameter Name="grupo" Type="Int32" />
            <asp:Parameter Name="idEquipoAsignado" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="txbGrupo" Name="grupo" PropertyName="Text" 
                Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="tipoTrayecto" Type="Int32" />
            <asp:Parameter Name="grupo" Type="Int32" />
            <asp:Parameter Name="idEquipoAsignado" Type="Int32" />
            <asp:Parameter Name="id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <p>
    </p>
</asp:Content>
