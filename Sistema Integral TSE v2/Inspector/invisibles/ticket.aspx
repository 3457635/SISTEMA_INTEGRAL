<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ticket.aspx.vb" Inherits="Sistema_Integral_TSE_v45.ticket" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        Rendimiento:
        <asp:Label ID="lblRendimiento" runat="server" Text="0"></asp:Label>
&nbsp;Kms/lt<br />
        Liquidación: $
        <asp:Label ID="lblLiquidación" runat="server" Text="0"></asp:Label>
        <br />
        Gastos otorgados: $
        <asp:Label ID="lblGastos" runat="server" Text="0"></asp:Label>
        <br />
    
    </div>
    </form>
</body>
</html>
