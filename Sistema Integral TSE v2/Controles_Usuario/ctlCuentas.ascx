<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlCuentas.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlCuentas" %>




<br />
Cuentas:<br />
<table>
    <tr>
        <td>
            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
                DataSourceID="SqlDataSource1" DataTextField="Expr1" 
                DataValueField="id_cuenta" AppendDataBoundItems="True">
                <asp:ListItem Selected="True" Value="0">Seleccionar...</asp:ListItem>
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                
                SelectCommand="SELECT CONVERT (nvarchar, clave) + '-' + cuenta AS Expr1, id_cuenta FROM conta_cuentas WHERE (id_padre IS NULL) order by id_cuenta desc">
            </asp:SqlDataSource>
        </td>
        <td>
            -</td>
        <td >
            <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" 
                DataSourceID="SqlDataSource2" DataTextField="cuenta" 
                DataValueField="id_cuenta">
                
            </asp:DropDownList>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                
                
                SelectCommand="SELECT CONVERT (nvarchar, clave) + '-' + cuenta AS cuenta, id_cuenta FROM conta_cuentas WHERE (id_padre = @id_padre) order by id_cuenta desc">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="id_padre" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </td>
        <td>
            -</td>
        <td>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                
                SelectCommand="SELECT CONVERT (nvarchar, clave) + '-' + cuenta AS Expr1, id_cuenta FROM conta_cuentas WHERE (id_padre = @id_padre) order by id_cuenta desc">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList2" Name="id_padre" 
                        PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:ListBox ID="ListBox1" runat="server" DataSourceID="SqlDataSource3" 
                DataTextField="Expr1" DataValueField="Expr1" Enabled="False">
            </asp:ListBox>
        </td>
    </tr>
</table>
<p>
    <asp:TextBox ID="txbRango1" runat="server" MaxLength="4" Width="30px"></asp:TextBox>
    -<asp:TextBox ID="txbRango2" runat="server" MaxLength="4" Width="30px" 
        Enabled="False"></asp:TextBox>
    -<asp:TextBox ID="txbRango3" runat="server" MaxLength="3" Width="50px" 
        Enabled="False"></asp:TextBox>
</p>
<p>
    <asp:Label ID="lblRango1" runat="server" ForeColor="#CC0000"></asp:Label>
    <asp:Label ID="lblRango2" runat="server" ForeColor="Red"></asp:Label>
    <asp:Label ID="lblRango3" runat="server" ForeColor="Red"></asp:Label>
</p>
<p>
    <asp:TextBox ID="txbCuenta1" runat="server" Height="21px" Width="93px" 
        Visible="False"></asp:TextBox>
&nbsp;
    <asp:TextBox ID="txbRango" runat="server" Visible="False"></asp:TextBox>
</p>
Nombre: 
<asp:TextBox ID="txbNombre" runat="server" Height="24px" Width="312px"></asp:TextBox>
<p>
    Saldo Inicial: 
    <asp:TextBox ID="txbSaldoInicial" runat="server"></asp:TextBox>
</p>
<p>
    &nbsp;</p>
<asp:Button ID="btnGuadar" runat="server" Text="Guardar" />

