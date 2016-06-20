<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="RentaCajas.aspx.vb" Inherits="Sistema_Integral_TSE_v45.RentaCajas" %>
<%@ Register src="../Controles_Usuario/ctlRenta_Cajas.ascx" tagname="ctlRenta_Cajas" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <br />
        <uc1:ctlRenta_Cajas ID="ctlRenta_Cajas1" runat="server" />
    </p>
</asp:Content>
