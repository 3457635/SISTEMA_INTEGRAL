<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="RecargasElPaso.aspx.vb" Inherits="Sistema_Integral_TSE_v45.RecargasElPaso" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 33px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Recargas El Paso</h1>
    <table>
        <tr>
            <td class="auto-style1">
                <asp:Label ID="Label1" runat="server" Text="Fecha inicio"></asp:Label>
                <asp:TextBox ID="txtFechaInicio" runat="server"></asp:TextBox>
                <asp:CalendarExtender ID="clrFechaCarga" format="yyyy/MM/dd" runat="server" TargetControlID="txtFechaInicio">
                                    </asp:CalendarExtender>
                <asp:Label ID="Label2" runat="server" Text="Fecha fin"></asp:Label>
                <asp:TextBox ID="txtFechaFin" runat="server"></asp:TextBox>
                <asp:CalendarExtender ID="CalendarExtender1" format="yyyy/MM/dd" runat="server" TargetControlID="txtFechaFin">
                                    </asp:CalendarExtender>
                <asp:Button ID="Button1" runat="server" Text="Consultar" PostBackUrl="~/Auditor/RecargasElPaso.aspx" />
            </td>
            </tr>
        <tr><asp:GridView ID="GridView2" runat="server" DataSourceID="sdsRecargasElPaso" AllowSorting="True" SkinID="GridViewGreen" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="Consecutivo" HeaderText="Consecutivo" SortExpression="Consecutivo" />
                <asp:BoundField DataField="Ruta" HeaderText="Ruta" SortExpression="Ruta" />
                <asp:BoundField DataField="Economico" HeaderText="Economico" SortExpression="Economico" />
                <asp:BoundField DataField="Chofer" HeaderText="Chofer" ReadOnly="True" SortExpression="Chofer" />
                <asp:BoundField DataField="Litros" HeaderText="Litros" SortExpression="Litros" />
                <asp:BoundField DataField="Galones" HeaderText="Galones" ReadOnly="True" SortExpression="Galones" />
                <asp:BoundField DataField="Dlls" HeaderText="Dlls" ReadOnly="True" SortExpression="Dlls" />
                <asp:BoundField DataField="Precio por galon" HeaderText="Precio por galon" ReadOnly="True" SortExpression="Precio por galon" />
                <asp:BoundField DataField="Odometro" HeaderText="Odometro" SortExpression="Odometro" />
                <asp:BoundField DataField="Fecha" HeaderText="Fecha" SortExpression="Fecha" />
                <asp:BoundField DataField="Responsable" HeaderText="Responsable" SortExpression="Responsable" />
            </Columns>
    </asp:GridView>
            
            
        </tr>
    </table>
    
    <asp:SqlDataSource ID="sdsRecargasElPaso" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT DISTINCT Consecutivo,Ruta,Economico,(primer_nombre + ' '+ apellido_paterno) AS Chofer,lts AS Litros, (lts/3.785) AS Galones,('$'+ CAST(CONVERT(varchar,CAST( monto as money),1)as varchar)) AS Dlls,CAST(CONVERT(varchar,CAST( (monto/(lts/3.785)) as dec(10,4)),1)as varchar) AS 'Precio por galon',  Odo_recarga AS Odometro, fecharecarga AS Fecha, Responsable 
FROM vista_kmsunidad WHERE en_galones = 1 and fechaRecarga &gt;= @fechainicio and fechaRecarga &lt;= @fechafin">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtFechaInicio" Name="fechainicio" PropertyName="Text" />
            <asp:ControlParameter ControlID="txtFechaFin" Name="fechafin" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
