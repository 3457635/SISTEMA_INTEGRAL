<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="correcionFacturacion.aspx.vb" Inherits="Sistema_Integral_TSE_v45.correcionFacturacion" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <br />
        Folio:
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
&nbsp;<asp:Button ID="Button1" runat="server" Text="Actualizar" />
        <br />
    
    </div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="id_factura" DataSourceID="sdsFacturas" 
        EnableModelValidation="True">
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="id_factura" HeaderText="id_factura" 
                InsertVisible="False" ReadOnly="True" SortExpression="id_factura" />
            <asp:BoundField DataField="folio" HeaderText="folio" SortExpression="folio" />
            <asp:BoundField DataField="importe" HeaderText="importe" 
                SortExpression="importe" />
            <asp:BoundField DataField="iva" HeaderText="iva" SortExpression="iva" />
            <asp:BoundField DataField="retencion" HeaderText="retencion" 
                SortExpression="retencion" />
            <asp:BoundField DataField="total" HeaderText="total" SortExpression="total" />
            <asp:CheckBoxField DataField="Cancelada" HeaderText="Cancelada" 
                SortExpression="Cancelada" />
            <asp:BoundField DataField="id_dato_facturacion" 
                HeaderText="id_dato_facturacion" SortExpression="id_dato_facturacion" />
            <asp:CheckBoxField DataField="facturada_dolares" HeaderText="facturada_dolares" 
                SortExpression="facturada_dolares" />
            <asp:CheckBoxField DataField="Contrarecibo" HeaderText="Contrarecibo" 
                SortExpression="Contrarecibo" />
            <asp:CheckBoxField DataField="facturaAmericana" HeaderText="facturaAmericana" 
                SortExpression="facturaAmericana" />
            <asp:BoundField DataField="saldo" HeaderText="saldo" SortExpression="saldo" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsFacturas" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        DeleteCommand="DELETE FROM [facturas] WHERE [id_factura] = @id_factura" 
        InsertCommand="INSERT INTO [facturas] ([folio], [importe], [iva], [retencion], [total], [Cancelada], [id_dato_facturacion], [facturada_dolares], [Contrarecibo], [facturaAmericana], [saldo]) VALUES (@folio, @importe, @iva, @retencion, @total, @Cancelada, @id_dato_facturacion, @facturada_dolares, @Contrarecibo, @facturaAmericana, @saldo)" 
        SelectCommand="SELECT * FROM [facturas] WHERE ([folio] = @folio)" 
        UpdateCommand="UPDATE [facturas] SET [folio] = @folio, [importe] = @importe, [iva] = @iva, [retencion] = @retencion, [total] = @total, [Cancelada] = @Cancelada, [id_dato_facturacion] = @id_dato_facturacion, [facturada_dolares] = @facturada_dolares, [Contrarecibo] = @Contrarecibo, [facturaAmericana] = @facturaAmericana, [saldo] = @saldo WHERE [id_factura] = @id_factura">
        <DeleteParameters>
            <asp:Parameter Name="id_factura" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="folio" Type="Int32" />
            <asp:Parameter Name="importe" Type="Double" />
            <asp:Parameter Name="iva" Type="Double" />
            <asp:Parameter Name="retencion" Type="Double" />
            <asp:Parameter Name="total" Type="Double" />
            <asp:Parameter Name="Cancelada" Type="Boolean" />
            <asp:Parameter Name="id_dato_facturacion" Type="Int32" />
            <asp:Parameter Name="facturada_dolares" Type="Boolean" />
            <asp:Parameter Name="Contrarecibo" Type="Boolean" />
            <asp:Parameter Name="facturaAmericana" Type="Boolean" />
            <asp:Parameter Name="saldo" Type="Double" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="TextBox1" Name="folio" PropertyName="Text" 
                Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="folio" Type="Int32" />
            <asp:Parameter Name="importe" Type="Double" />
            <asp:Parameter Name="iva" Type="Double" />
            <asp:Parameter Name="retencion" Type="Double" />
            <asp:Parameter Name="total" Type="Double" />
            <asp:Parameter Name="Cancelada" Type="Boolean" />
            <asp:Parameter Name="id_dato_facturacion" Type="Int32" />
            <asp:Parameter Name="facturada_dolares" Type="Boolean" />
            <asp:Parameter Name="Contrarecibo" Type="Boolean" />
            <asp:Parameter Name="facturaAmericana" Type="Boolean" />
            <asp:Parameter Name="saldo" Type="Double" />
            <asp:Parameter Name="id_factura" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
