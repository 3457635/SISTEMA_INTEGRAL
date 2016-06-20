<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Tarifas.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Tarifas" %>
<%@ Register src="../Controles_Usuario/ctlTarifaChofer.ascx" tagname="ctlTarifaChofer" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        Existen 2 tipos de tarifas, Tarifa Unichofer que es cuando la ruta la realiza un 
        solo chofer o por Trayecto que es cuando el viaje se realiza en modo Multichofer 
        y cada uno realiza un trayecto en especifico. Por favor seleccione cual de los 2 
        tipos de tarifa descea registrar;</p>
    <p>
        <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True">
            <asp:ListItem Value="0">Tarifa Unichofer</asp:ListItem>
            <asp:ListItem Value="1">Tarifa Multichofer</asp:ListItem>
        </asp:RadioButtonList>
    </p>
    <p>
        <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
    </p>
    <p>
        <asp:PlaceHolder ID="PlaceHolder2" runat="server"></asp:PlaceHolder>
    </p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
</asp:Content>
