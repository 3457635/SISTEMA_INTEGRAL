<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Nomina.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Nomina" %>
<%@ Register src="../Controles_Usuario/ctlNomina.ascx" tagname="ctlNomina" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <br />
    </p>
    <uc1:ctlNomina ID="ctlNomina1" runat="server" />
    <p>
    </p>
</asp:Content>
