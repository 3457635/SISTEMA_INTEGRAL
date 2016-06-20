<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Nuevo_Rol.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Nuevo_Rol" 
    title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<b>Crear a Nuevo Rol:</b>
<asp:TextBox ID="RoleName" runat="server"></asp:TextBox>
<br />
<asp:Button ID="CreateRoleButton" runat="server" Text="Guardar" />
<asp:GridView ID="RoleList" runat="server" AutoGenerateColumns="False">
 <Columns>
 <asp:CommandField DeleteText="Eliminar" ShowDeleteButton="True" />
 <asp:TemplateField HeaderText="Rol">
 <ItemTemplate>
 <asp:Label runat="server" ID="RoleNameLabel" Text='<%# Container.DataItem %>' />
 </ItemTemplate>
 </asp:TemplateField>
 </Columns> 
</asp:GridView>




</asp:Content>
