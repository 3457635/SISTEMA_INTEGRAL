<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="NuevoProveedor.aspx.vb" Inherits="Sistema_Integral_TSE_v45.NuevoProveedor" %>

<%@ Register src="../../../../Controles_Usuario/CtlNuevaEmpresa.ascx" tagname="CtlNuevaEmpresa" tagprefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Proveedor</h1>
    <p>
        &nbsp;</p>
    <uc2:CtlNuevaEmpresa ID="CtlNuevaEmpresa1" runat="server" />
    <hr />
</asp:Content>
