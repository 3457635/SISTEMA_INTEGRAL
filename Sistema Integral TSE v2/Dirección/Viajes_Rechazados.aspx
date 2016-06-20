<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Viajes_Rechazados.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Viajes_Rechazados" 
    title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <p>
        <br />
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
            AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="ORDEN" HeaderText="ORDEN" ReadOnly="True" 
                    SortExpression="ORDEN" />
                <asp:BoundField DataField="CLIENTE" HeaderText="CLIENTE" 
                    SortExpression="CLIENTE" />
                <asp:BoundField DataField="CATEGORIA" HeaderText="CATEGORIA" 
                    SortExpression="CATEGORIA" />
                <asp:BoundField DataField="COMENTARIOS" HeaderText="COMENTARIOS" 
                    SortExpression="COMENTARIOS" />
                <asp:BoundField DataField="FECHA" HeaderText="FECHA" SortExpression="FECHA" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            
            SelectCommand="SELECT CONVERT (nvarchar, Ordenes.ano) + '-' + CONVERT (nvarchar, Ordenes.consecutivo) + '-' + CONVERT (nvarchar, viajes.num_viaje) AS ORDEN, dbo.empresas.nombre AS CLIENTE, tipos_rechazo.rechazo AS CATEGORIA, Rechazos.descripcion AS COMENTARIOS, viajes.fecha_apertura AS FECHA FROM viajes INNER JOIN Rechazos ON viajes.id_viaje = Rechazos.id_viaje INNER JOIN precios ON viajes.id_relacion = precios.id_relacion INNER JOIN Ordenes ON viajes.id_orden = Ordenes.id_orden AND viajes.id_orden = Ordenes.id_orden AND viajes.id_orden = Ordenes.id_orden INNER JOIN dbo.empresas ON precios.id_empresa = dbo.empresas.id_empresa AND precios.id_empresa = dbo.empresas.id_empresa INNER JOIN tipos_rechazo ON Rechazos.id_tipo_rechazo = tipos_rechazo.id_tipo_rechazo AND Rechazos.id_tipo_rechazo = tipos_rechazo.id_tipo_rechazo AND Rechazos.id_tipo_rechazo = tipos_rechazo.id_tipo_rechazo ORDER BY FECHA DESC">
        </asp:SqlDataSource>
    </p>
    <p>
    </p>
</asp:Content>
