<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="ayuda.aspx.vb" Inherits="Sistema_Integral_TSE_v45.ayuda" %>
<%@ Register src="../Controles_Usuario/ctlMapa.ascx" tagname="ctlMapa" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:ctlMapa ID="ctlMapa1" runat="server" />
</asp:Content>
