<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="parametros.aspx.vb" Inherits="Sistema_Integral_TSE_v45.parametros" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <br />
    </p>
    <p>
        Parametro:
        <asp:TextBox ID="txbParametro" runat="server"></asp:TextBox>
&nbsp; Valor:
        <asp:TextBox ID="txbValor" runat="server"></asp:TextBox>
&nbsp;<asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
    </p>
    <p>
        <asp:GridView ID="grdParametros" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="id" DataSourceID="sdsParametros" EnableModelValidation="True">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="id" HeaderText="id" InsertVisible="False" 
                    ReadOnly="True" SortExpression="id" />
                <asp:BoundField DataField="variable" HeaderText="PARAMETRO" 
                    SortExpression="variable" />
                <asp:BoundField DataField="valor" HeaderText="VALOR" SortExpression="valor" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsParametros" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            DeleteCommand="DELETE FROM [parametros] WHERE [id] = @id" 
            InsertCommand="INSERT INTO [parametros] ([variable], [valor]) VALUES (@variable, @valor)" 
            SelectCommand="SELECT * FROM [parametros]" 
            UpdateCommand="UPDATE [parametros] SET [variable] = @variable, [valor] = @valor WHERE [id] = @id">
            <DeleteParameters>
                <asp:Parameter Name="id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="variable" Type="String" />
                <asp:Parameter Name="valor" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="variable" Type="String" />
                <asp:Parameter Name="valor" Type="String" />
                <asp:Parameter Name="id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>
