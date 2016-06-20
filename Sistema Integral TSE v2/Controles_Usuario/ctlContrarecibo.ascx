<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlContrarecibo.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlContrarecibo" %>

<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <table class="style6">
            <tr>
                <td class="style7">
                    <table class="style1">
                        <tr>
                            <td class="style8">
                                Dias Transcurridos</td>
                            <td class="style5">
                                No. de Facturas</td>
                        </tr>
                        <tr>
                            <td class="style8">
                                0-3</td>
                            <td class="style5">
                                <asp:LinkButton ID="lnkRango1" runat="server">0</asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td class="style8">
                                4-7</td>
                            <td class="style5">
                                <asp:LinkButton ID="lnkRango2" runat="server">0</asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td class="style8">
                                8-14</td>
                            <td class="style5">
                                <asp:LinkButton ID="lnkRango3" runat="server">0</asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td class="style8">
                                15-30</td>
                            <td class="style5">
                                <asp:LinkButton ID="lnkRango4" runat="server">0</asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td class="style8">
                                +30</td>
                            <td class="style5">
                                <asp:LinkButton ID="lnkRango5" runat="server">0</asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td class="style8">
                                Total</td>
                            <td class="style5">
                                <asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    &nbsp;</td>
                <td>
                    <asp:GridView ID="grdContrarecibo" runat="server" SkinID="GridView1">
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>



