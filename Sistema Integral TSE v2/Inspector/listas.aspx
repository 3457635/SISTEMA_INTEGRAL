<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="listas.aspx.vb" Inherits="Sistema_Integral_TSE_v45.listas" %>
<%@ Register src="../Controles_Usuario/ctlListasDistribucion.ascx" tagname="ctlListasDistribucion" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <br />
    </p>
    <uc1:ctlListasDistribucion ID="ctlListasDistribucion1" runat="server" />
    <p>
    </p>
</asp:Content>
