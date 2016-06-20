<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="tableroTrafico.aspx.vb" Inherits="Sistema_Integral_TSE_v45.tableroTrafico" %>
<%@ Register src="../Controles_Usuario/ctlLlegadasTiempo.ascx" tagname="ctlLlegadasTiempo" tagprefix="uc1" %>
<%@ Register src="../Controles_Usuario/ctlEvaluacionesPendientes.ascx" tagname="ctlEvaluacionesPendientes" tagprefix="uc2" %>
<%@ Register src="../Controles_Usuario/ctlLlegadasListado.ascx" tagname="ctlLlegadasListado" tagprefix="uc3" %>
<%@ Register src="../Controles_Usuario/ctlViajesHechos.ascx" tagname="ctlViajesHechos" tagprefix="uc4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        &nbsp;</p>
    <asp:WebPartManager ID="WebPartManager1" runat="server">
    </asp:WebPartManager>
    <p>
        <asp:WebPartZone ID="WebPartZone1" runat="server" SkinID="wprtProfesional" >
        </asp:WebPartZone>
</p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        <asp:WebPartZone ID="WebPartZone2" runat="server" SkinID="wprtProfesional">
            <ZoneTemplate>
                <uc1:ctlLlegadasTiempo ID="ctlLlegadasTiempo1" runat="server" title="Llegadas a Tiempo" />
            </ZoneTemplate>
        </asp:WebPartZone>
</p>
    <p>
        &nbsp;</p>
    <asp:WebPartZone ID="WebPartZone3" runat="server" SkinID="wprtProfesional">
        <ZoneTemplate>
            <uc4:ctlViajesHechos ID="ctlViajesHechos1" runat="server" />
        </ZoneTemplate>
    </asp:WebPartZone>
    <p>
    <br />
</p>
</asp:Content>
