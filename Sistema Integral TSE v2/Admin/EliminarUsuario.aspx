<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="EliminarUsuario.aspx.vb" Inherits="Sistema_Integral_TSE_v45.EliminarUsuario" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <br />
        usuario:<asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:Button ID="Button1" runat="server" Text="Button" />
    </p>
    <p>
        &nbsp;&nbsp;<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="SqlDataSource1" EnableModelValidation="True">
            <Columns>
                <asp:BoundField DataField="UserName" HeaderText="UserName" 
                    SortExpression="UserName" />
                <asp:BoundField DataField="RoleName" HeaderText="RoleName" 
                    SortExpression="RoleName" />
                <asp:BoundField DataField="Password" HeaderText="Password" 
                    SortExpression="Password" />
                <asp:BoundField DataField="PasswordFormat" HeaderText="PasswordFormat" 
                    SortExpression="PasswordFormat" />
                <asp:BoundField DataField="PasswordSalt" HeaderText="PasswordSalt" 
                    SortExpression="PasswordSalt" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            SelectCommand="SELECT dbo.aspnet_Users.UserName, dbo.aspnet_Roles.RoleName, dbo.aspnet_Membership.Password, dbo.aspnet_Membership.PasswordFormat, dbo.aspnet_Membership.PasswordSalt FROM dbo.aspnet_Users INNER JOIN dbo.aspnet_UsersInRoles ON dbo.aspnet_Users.UserId = dbo.aspnet_UsersInRoles.UserId INNER JOIN dbo.aspnet_Roles ON dbo.aspnet_UsersInRoles.RoleId = dbo.aspnet_Roles.RoleId INNER JOIN dbo.aspnet_Membership ON dbo.aspnet_Users.UserId = dbo.aspnet_Membership.UserId">
        </asp:SqlDataSource>
    </p>
    <p>
    </p>
    <p>
    </p>
</asp:Content>
