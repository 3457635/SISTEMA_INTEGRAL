<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CtlSubcuentas.ascx.vb" Inherits="Sistema_Integral_TSE_v45.CtlSubcuentas" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
No.Cuenta<br />
<asp:TextBox ID="txbCuentaPadre" runat="server" MaxLength="3" Width="58px" 
    AutoPostBack="True" Height="20px"></asp:TextBox>
&nbsp;-
<asp:TextBox ID="txbCuentaIntermedia" runat="server" Height="20px" Width="58px"></asp:TextBox>
&nbsp;-
<asp:TextBox ID="txbCuentaHija" runat="server" Height="20px" Width="58px"></asp:TextBox>
<div><asp:Label ID="lblCuenta" runat="server"></asp:Label>
<asp:Label ID="lblNombreCuenta" runat="server"></asp:Label>
</div>


