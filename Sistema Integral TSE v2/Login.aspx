<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Login.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Login" 
    title="TSE SI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">




    <table class="auto-style4">
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td class="auto-style6" style="font-weight: 700; text-align: center">



<asp:LoginView ID="LoginView1" runat="server">
    <LoggedInTemplate>
        BIENVENIDO.


    </LoggedInTemplate>
    <AnonymousTemplate>
        Registrese nuevamente<br />
        
        <asp:Login ID="Login1" runat="server" LoginButtonText="Iniciar Sesión" PasswordLabelText="Contraseña:" RememberMeText="Recordarme" TitleText="Inicio de sesión" UserNameLabelText="Usuario:" Width="299px">
        </asp:Login>
    </AnonymousTemplate>
</asp:LoginView>
    

            </td>
            <td>&nbsp;</td>
        </tr>
    </table>

    <br />
    <br />
    <br />
    <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="Head">
    <style type="text/css">
        .auto-style4 {
            width: 100%;
        }
        .auto-style5 {
            width: 555px;
        }
        .auto-style6 {
            width: 347px;
        }
    </style>
</asp:Content>

