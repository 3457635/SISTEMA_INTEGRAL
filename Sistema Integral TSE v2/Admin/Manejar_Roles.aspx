<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Manejar_Roles.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Manejar_Roles" 
    title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div>
    <p align="center"> 
     <asp:Label ID="ActionStatus" runat="server"> </asp:Label> 
</p> 
<h3>Manejar Roles del Usuario</h3> 
<p> 
     <b>Seleccionar Usuario:</b> 
     <asp:DropDownList ID="UserList" runat="server" AutoPostBack="True" 
          DataTextField="UserName" DataValueField="UserName"> 
     </asp:DropDownList> 
</p> 
<p> 
     <asp:Repeater ID="UsersRoleList" runat="server"> 
          <ItemTemplate> 
               <asp:CheckBox runat="server" ID="RoleCheckBox" 
     AutoPostBack="true" 
     Text='<%# Container.DataItem %>' 
     OnCheckedChanged="RoleCheckBox_CheckChanged" /> 

               <br /> 
          </ItemTemplate> 
     </asp:Repeater> 
</p> 
<h3>Manejar Usuarios del Rol</h3> 
<p> 
     <b>Seleccionar un Rol:</b> 
     <asp:DropDownList ID="RoleList" runat="server" AutoPostBack="true"></asp:DropDownList> 
</p> 
<p> 
     <asp:GridView ID="RolesUserList" runat="server" AutoGenerateColumns="False" 
          EmptyDataText="No users belong to this role."> 
          <Columns> 
               <asp:TemplateField HeaderText="Users"> 
                    <ItemTemplate> 
                         <asp:Label runat="server" id="UserNameLabel" 
                              Text='<%# Container.DataItem %>'></asp:Label> 
                    </ItemTemplate> 
               </asp:TemplateField> 
               <asp:CommandField DeleteText="Remove" ShowDeleteButton="True" />
          </Columns> 
     </asp:GridView> 
</p> 

<p> 
     <b>UserName:</b> 
     <asp:TextBox ID="UserNameToAddToRole" runat="server"></asp:TextBox> 
     <br /> 
     <asp:Button ID="AddUserToRoleButton" runat="server" Text="Add User to Role" /> 
</p> 

    </div>
   


</asp:Content>
