<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Cajas.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Cajas" 
    title="Untitled Page" %>
<%@ Register src="../../Controles_Usuario/ctlCajas.ascx" tagname="ctlCajas" tagprefix="uc1" %>
<%@ Register src="../../Controles_Usuario/tramites_equipo.ascx" tagname="tramites_equipo" tagprefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        Catalogo de Cajas.</p>
    <p>
        &nbsp;</p>
    <uc1:ctlCajas ID="ctlCajas1" runat="server" />
    <p>
        &nbsp;</p>
<uc2:tramites_equipo ID="tramites_equipo1" runat="server" />
</asp:Content>
