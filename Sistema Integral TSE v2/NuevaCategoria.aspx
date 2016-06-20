<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="NuevaCategoria.aspx.vb" Inherits="Sistema_Integral_TSE_v45.InsertarCatalogoProveedores" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register src="~/Controles_Usuario/ctlCategoria_Proveedores.ascx" tagname="Nuevo_Catalogo" tagprefix="uc1" %>
<%@ Register src="~/Controles_Usuario/CtlSubcuentas.ascx" tagname="CtlSubcuentas" tagprefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc2:CtlSubcuentas ID="CtlSubcuentas1" runat="server" />
    
    </asp:Content>
