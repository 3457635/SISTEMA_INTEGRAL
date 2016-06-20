<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="saldoClientes.aspx.vb" Inherits="Sistema_Integral_TSE_v45.saldoClientes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Saldos de clientes</h1>
    <asp:SqlDataSource ID="sdsSaldosClientes" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT Cliente, '$'+CAST(CONVERT(varchar,CAST( SUM(total) as money),1)as varchar) as Saldo  FROM
 dbo.facturas_clientes('mexicana', 'activas', 'pesos', 16,0,0,0, null , null) WHERE fecha_pago IS NULL GROUP BY cliente ORDER BY cliente"></asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="sdsSaldosClientes" SkinID="GridViewGreen">
        <Columns>
            <asp:BoundField DataField="Cliente" HeaderText="Cliente" SortExpression="Cliente" />
            <asp:BoundField DataField="Saldo" HeaderText="Saldo" SortExpression="Saldo" ReadOnly="True" />
        </Columns>
    </asp:GridView>
</asp:Content>
