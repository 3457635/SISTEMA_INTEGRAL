﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="tramitesEquipos.aspx.vb" Inherits="Sistema_Integral_TSE_v45.tramitesEquipos" %>
<%@ Register src="../Controles_Usuario/tramites_equipo.ascx" tagname="tramites_equipo" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc1:tramites_equipo ID="tramites_equipo1" runat="server" />
</asp:Content>
