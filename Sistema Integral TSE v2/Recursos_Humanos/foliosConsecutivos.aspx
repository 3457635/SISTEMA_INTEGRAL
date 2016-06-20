<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="foliosConsecutivos.aspx.vb" Inherits="Sistema_Integral_TSE_v45.foliosConsecutivos" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Revisión de Folios</h1>
    <table>
        <tr>
            <td >
                <asp:Label ID="Label1" runat="server" Text="Fecha inicio"></asp:Label>
                <asp:TextBox ID="txbFechaInicio" runat="server"></asp:TextBox>
                <asp:CalendarExtender ID="ceInicio" runat="server" Enabled="True" Format="yyyy/MM/dd" TargetControlID="txbFechaInicio">
                </asp:CalendarExtender>
                <asp:Label ID="lblFIn" runat="server" Text="Fecha fin"></asp:Label>
                <asp:TextBox ID="txbFechaFin" runat="server"></asp:TextBox>
                <asp:CalendarExtender ID="ceFin" runat="server" Enabled="True" Format="yyyy/MM/dd" TargetControlID="txbFechaFin">
</asp:CalendarExtender>
                <asp:Button ID="Button1" runat="server" PostBackUrl="~/Recursos_Humanos/foliosConsecutivos.aspx" Text="Consultar" />
                <asp:Button ID="Button2" runat="server" Text="Descargar" />
            </td>
        </tr>
        <tr>
            <td>
               <asp:GridView ID="GridView2" runat="server" DataSourceID="sdsVerFolios" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="Fecha" HeaderText="Fecha" SortExpression="Fecha" />
                        <asp:BoundField DataField="Folio" HeaderText="Folio" SortExpression="Folio" />
                        <asp:BoundField DataField="Importe" HeaderText="Importe" SortExpression="Importe" />
                        <asp:BoundField DataField="IVA" HeaderText="IVA" SortExpression="IVA" />
                        <asp:BoundField DataField="Retencion" HeaderText="Retencion" SortExpression="Retencion" />
                        <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total" />
                        <asp:BoundField DataField="Saldo" HeaderText="Saldo" SortExpression="Saldo" />
                        <asp:CheckBoxField DataField="Cancelada" HeaderText="Cancelada" SortExpression="Cancelada" />
                        <asp:CheckBoxField DataField="Dolares" HeaderText="Dolares" SortExpression="Dolares" />
                        <asp:BoundField DataField="Cliente" HeaderText="Cliente" SortExpression="Cliente" />
                    </Columns>
    </asp:GridView>
            </td>
            
        </tr>
        
    </table>
    
    <asp:SqlDataSource ID="sdsVerFolios" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="mostrarConsecutivoFoliosFacturacion" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="txbFechaInicio" Name="inicio" PropertyName="Text" Type="DateTime" />
            <asp:ControlParameter ControlID="txbFechaFin" Name="fin" PropertyName="Text" Type="DateTime" />
            <asp:Parameter Name="tipoFecha" Type="Int32" DefaultValue="4" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
    
