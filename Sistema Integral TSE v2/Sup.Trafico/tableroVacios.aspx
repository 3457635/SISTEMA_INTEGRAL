<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="tableroVacios.aspx.vb" Inherits="Sistema_Integral_TSE_v45.tableroVacios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .auto-style2 {
            width: 100%;
        }
    </style>
    <script src="../Scripts/jquery-1.9.1.js"></script>
    <script>
        $(document).ready(function () {
            $("#ano").load("../Sup.Trafico/Graficas/vaciosAlMes.aspx");            
            $("#ctl00_ContentPlaceHolder1_ImageButton1").click(function () {
                $("#ano").remove();
            });
        });
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    Año: <asp:textbox id="txbAno" runat="server"></asp:textbox> &nbsp;Mes: <asp:DropDownList ID="ddlMes"  runat="server" SkinID="ddlMes">
    </asp:DropDownList>
&nbsp;<asp:Button ID="btnConsultar" runat="server" Text="Consultar" />
        <asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnActualizar" />
    <br />
    <table class="auto-style2">
        <tr>
            <td>
                <div id="ano">
                </div>
            </td>
            <td>
                <div id="mes">
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="detalle">
                </div>
            </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
&nbsp;
</asp:Content>
