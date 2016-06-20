<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="cltMovimientoCuenta.ascx.vb" Inherits="Sistema_Integral_TSE_v45.cltMovimientoCuenta" %>
<style type="text/css">
    .style1
    {
        width: 100%;
    }
    .style2
    {
        width: 134px;
    }
</style>

<p>
    &nbsp;</p>
<table class="style1">
    <tr>
        <td class="style2">
            <p>
                Monto:</p>
        </td>
        <td>
            <asp:TextBox ID="txbMonto" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="style2">
            IVA:</td>
        <td>
            <asp:DropDownList ID="DropDownList1" runat="server">
                <asp:ListItem Value="1">16 %</asp:ListItem>
                <asp:ListItem Value="2">11%</asp:ListItem>
                <asp:ListItem Value="3">0%</asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td class="style2">
            Neto:</td>
        <td>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="style2">
            Cuenta Contable:</td>
        <td>
            <asp:DropDownList ID="DropDownList2" runat="server">
            </asp:DropDownList>
            <asp:DropDownList ID="DropDownList3" runat="server">
            </asp:DropDownList>
            <asp:DropDownList ID="DropDownList4" runat="server">
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td class="style2">
            Tipo:
        </td>
        <td>
            <asp:DropDownList ID="DropDownList5" runat="server">
                <asp:ListItem Value="1">Ingreso</asp:ListItem>
                <asp:ListItem Value="2">Egreso</asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td class="style2">
            Programación de Pago o Cobro</td>
        <td>
            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="style2">
            Pago o cobro</td>
        <td>
            <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td class="style2">
            Cuenta Bancaria:</td>
        <td>
            <asp:DropDownList ID="DropDownList6" runat="server">
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td class="style2">
            Presentación de Pago:</td>
        <td>
            <asp:DropDownList ID="DropDownList7" runat="server">
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td class="style2">
            Factura:</td>
        <td>
            <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
        </td>
    </tr>
</table>

