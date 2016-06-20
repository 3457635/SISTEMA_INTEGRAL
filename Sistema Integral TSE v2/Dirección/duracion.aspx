<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="duracion.aspx.vb" Inherits="Sistema_Integral_TSE_v45.duracion" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<%@ Register src="../Controles_Usuario/ctlViajesHechos.ascx" tagname="ctlViajesHechos" tagprefix="uc1" %>
<%@ Register src="../Controles_Usuario/CtlNuevoContacto.ascx" tagname="CtlNuevoContacto" tagprefix="uc2" %>
<%@ Register src="../Controles_Usuario/ctlSaldosClientes.ascx" tagname="ctlSaldosClientes" tagprefix="uc3" %>
<%@ Register src="../Controles_Usuario/ctlIngresosPorCliente.ascx" tagname="ctlIngresosPorCliente" tagprefix="uc4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        Días promedio del proceso.<br />
    </p>
    <p>
        <asp:WebPartManager ID="WebPartManager1" runat="server">
        </asp:WebPartManager>
        <asp:WebPartZone ID="WebPartZone2" runat="server" SkinID="wprtProfesional">
            <ZoneTemplate>
                <uc1:ctlViajesHechos ID="ctlViajesHechos1" Title="Viajes Realizados" runat="server" />
            </ZoneTemplate>
            <CloseVerb Enabled="False" Visible="False" />
        </asp:WebPartZone>
        <asp:WebPartZone ID="WebPartZone4" runat="server" SkinID="wprtProfesional">
            <ZoneTemplate>
                <uc4:ctlIngresosPorCliente ID="ctlIngresosPorCliente1" Title="Ingresos  Por Cliente" runat="server" />
            </ZoneTemplate>
            <CloseVerb Enabled="False" Visible="False" />
        </asp:WebPartZone>
        <asp:WebPartZone ID="WebPartZone3" runat="server" SkinID="wprtProfesional">
            <ZoneTemplate>
                <uc3:ctlSaldosClientes ID="ctlSaldosClientes1" Title="Saldo Clientes" runat="server" />
            </ZoneTemplate>
            <CloseVerb Enabled="False" Visible="False" />
            <MinimizeVerb ImageUrl="~/imagenes/minimizar.png" />
            <RestoreVerb ImageUrl="~/imagenes/maximizar.png" />
        </asp:WebPartZone>
    </p>
    <table style="width: 100%">
        <tr>
            <td>
            Año:
            <asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
&nbsp;Mes:<asp:DropDownList ID="ddlMes" runat="server">
                <asp:ListItem Value="1">Enero</asp:ListItem>
                <asp:ListItem Value="2">Febrero</asp:ListItem>
                <asp:ListItem Value="3">Marzo</asp:ListItem>
                <asp:ListItem Value="4">Abril</asp:ListItem>
                <asp:ListItem Value="5">Mayo</asp:ListItem>
                <asp:ListItem Value="6">Junio</asp:ListItem>
                <asp:ListItem Value="7">Julio</asp:ListItem>
                <asp:ListItem Value="8">Agosto</asp:ListItem>
                <asp:ListItem Value="9">Septiembre</asp:ListItem>
                <asp:ListItem Value="10">Octubre</asp:ListItem>
                <asp:ListItem Value="11">Noviembre</asp:ListItem>
                <asp:ListItem Value="12">Diciembre</asp:ListItem>
            </asp:DropDownList>
&nbsp;
            <asp:ImageButton ID="ibtnActualizar" runat="server" 
                ImageUrl="~/imagenes/refresh.png" style="height: 24px" />
                <br />
    <table style="width: 213px">
        <tr>
            <td style="width: 118px">
                Días Promedio</td>
            <td style="width: 85px">
                No. Viajes</td>
        </tr>
        <tr>
            <td style="width: 118px">
                0-15 días</td>
            <td style="width: 85px" >
                <asp:LinkButton ID="lnkRango1" runat="server">0</asp:LinkButton>
            &nbsp;</td>
        </tr>
        <tr>
            <td style="width: 118px">
                15-30 días</td>
            <td style="width: 85px">
                <asp:LinkButton ID="lnkRango2" runat="server">0</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td style="width: 118px">
                31-40 días</td>
            <td style="width: 85px">
                <asp:LinkButton ID="lnkRango3" runat="server">0</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td style="width: 118px">
                41-50 días</td>
            <td style="width: 85px">
                <asp:LinkButton ID="lnkRango4" runat="server">0</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td style="width: 118px">
                +50 días</td>
            <td style="width: 85px">
                <asp:LinkButton ID="lnkRango5" runat="server">0</asp:LinkButton>
            </td>
        </tr>
        <tr>
            <td style="width: 118px">
                Total</td>
            <td style="width: 85px">
                <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label>
            </td>
        </tr>
    </table>
            </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
    <p>
            &nbsp;</p>
    </asp:Content>
