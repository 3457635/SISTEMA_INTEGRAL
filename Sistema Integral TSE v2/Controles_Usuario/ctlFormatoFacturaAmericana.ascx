<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlFormatoFacturaAmericana.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlFormatoFacturaAmericana" %>
<style type="text/css">
    .style1
    {
        width: 100%;
    }
    .style2
    {
        font-family: Arial, Helvetica, sans-serif;
        text-align: center;
    }
    .style5
    {
        font-family: Arial, Helvetica, sans-serif;
        font-size: medium;
    }
    .style6
    {
        font-family: Arial, Helvetica, sans-serif;
        text-align: center;
        color: #FFFFFF;
    }
    .style7
    {
        font-family: Arial, Helvetica, sans-serif;
        font-size: small;
    }
    .style9
    {
        font-family: Arial, Helvetica, sans-serif;
        width: 67px;
    }
    .style14
    {
        width: 685px;
    }
    .style15
    {
        width: 600px;
    }
    .style17
    {
        width: 50px;
    }
    .style18
    {
        width: 621px;
    }
    .style19
    {
        width: 621px;
        font-family: Arial, Helvetica, sans-serif;
    }
    .style20
    {
        font-family: Arial, Helvetica, sans-serif;
    }
    .style21
    {
        font-family: Arial, Helvetica, sans-serif;
        width: 67px;
        font-size: medium;
    }
    .style23
    {
        font-family: Arial, Helvetica, sans-serif;
        text-align: center;
        font-size: medium;
    }
    .style24
    {
        font-family: Arial, Helvetica, sans-serif;
        font-size: medium;
        width: 90px;
    }
    .style26
    {
        font-family: Arial, Helvetica, sans-serif;
        font-size: small;
        width: 90px;
    }
    .style27
    {
        width: 90px;
    }
    .style28
    {
        width: 985px;
    }
</style>

<div style="position: absolute; top: 17px; left: 48px;">
    <asp:Image ID="Image1" runat="server" ImageUrl="~/imagenes/logo.jpg" />
</div>
<div style="position: absolute; top: 23px; left: 291px; width: 527px; height: 128px;">
    <table class="style1">
        <tr>
            <td class="style23">
                <strong>CARLOS CHAVEZ TRUCKING INC.</strong></td>
        </tr>
        <tr>
            <td class="style23">
                LUIS CARLOS CHAVEZ LOYA</td>
        </tr>
        <tr>
            <td class="style23">
                PHONE: (915) 859-35-002</td>
        </tr>
        <tr>
            <td class="style23">
                9742 NORTH LOOP</td>
        </tr>
        <tr>
            <td class="style23">
                EL PASO, Tx. 79927</td>
        </tr>
        </table>
</div>
<div style="position: absolute; top: 25px; left: 861px; width: 212px; height: 122px;">
    <table class="style1">
        <tr>
            <td class="style6" bgcolor="#d3d3d3">
                <strong>INVOICE</strong></td>
        </tr>
        <tr>
            <td class="style5">
                No.
                <asp:Label ID="lblFolio" runat="server" Font-Names="Arial"></asp:Label>
            </td>
        </tr>
    </table>
    <table class="style1">
        <tr>
            <td class="style2" bgcolor="#d3d3d3">
                &nbsp;</td>
            <td class="style6" bgcolor="#d3d3d3">
                <strong>DATE</strong></td>
            <td class="style2" bgcolor="#d3d3d3">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style7">
                MONTH</td>
            <td class="style7">
                DAY</td>
            <td class="style7">
                YEAR</td>
        </tr>
        <tr>
            <td class="style5">
                <asp:Label ID="lblMes" runat="server" Font-Names="Arial"></asp:Label>
            </td>
            <td class="style5">
                <asp:Label ID="lblDia" runat="server" Font-Names="Arial"></asp:Label>
            </td>
            <td class="style5">
                <asp:Label ID="lblAno" runat="server" Font-Names="Arial"></asp:Label>
            </td>
        </tr>
    </table>
</div>

<div style="position: absolute; top: 235px; left: 265px; width: 695px; height: 130px;">
    <table border="1" cellspacing="0" class="style14">
        <tr>
            <td class="style21">
                NAME</td>
            <td class="style15">
                <asp:TextBox ID="txbName" runat="server" BorderColor="White" 
                    BorderStyle="Solid" Font-Size="Large" style="font-size: medium" Width="600px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style21">
                ADDRESS</td>
            <td class="style15">
                <asp:TextBox ID="txbDireccion" runat="server" BorderStyle="None" 
                    Font-Size="Large" Width="600px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style9">
                CITY</td>
            <td class="style15">
                <asp:TextBox ID="txbCiudad" runat="server" BorderStyle="None" Font-Size="Large" 
                    style="font-size: medium" Width="600px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style9">
                PHONE</td>
            <td class="style15">
                <asp:TextBox ID="txbTelefono" runat="server" BorderStyle="None" 
                    Font-Size="Large" style="font-size: medium" Width="600px"></asp:TextBox>
            </td>
        </tr>
    </table>
</div>
<div style="position: absolute; top: 375px; left: 59px; width: 986px; height: 347px;">
    <table border="1" cellpadding="0" cellspacing="0" class="style28">
        <tr>
            <td bgcolor="#d3d3d3" class="style20">
                Number</td>
            <td bgcolor="#d3d3d3" class="style19">
                Description</td>
            <td bgcolor="#d3d3d3" class="style24">
                Unit price</td>
            <td bgcolor="#d3d3d3" class="style24">
                Amount</td>
        </tr>
        <tr>
            <td class="style17">
                <asp:TextBox ID="txbCantidad1" runat="server" BorderStyle="None" 
                    CssClass="style5" Font-Size="Small" Height="30px" Width="50px"></asp:TextBox>
            </td>
            <td class="style18">
                <asp:TextBox ID="txbDescripcion1" runat="server" BorderStyle="None" 
                    CssClass="style5" Font-Size="Small" Height="30px" Width="700px"></asp:TextBox>
            </td>
            <td class="style27">
                <asp:TextBox ID="txbValor1" runat="server" BorderStyle="None" CssClass="style5" 
                    Font-Size="Small" Height="30px" Width="90px"></asp:TextBox>
            </td>
            <td class="style27">
                <asp:TextBox ID="importe1" runat="server" BorderStyle="None" CssClass="style5" 
                    Font-Size="Small" Height="30px" Width="90px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style17">
                <asp:TextBox ID="txbCantidad2" runat="server" BorderStyle="None" 
                    CssClass="style5" Font-Size="Small" Height="30px" Width="50px"></asp:TextBox>
            </td>
            <td class="style18">
                <asp:TextBox ID="txbDescripcion2" runat="server" BorderStyle="None" 
                    CssClass="style5" Font-Size="Small" Height="30px" Width="700px"></asp:TextBox>
            </td>
            <td class="style27">
                <asp:TextBox ID="txbValor2" runat="server" BorderStyle="None" CssClass="style5" 
                    Font-Size="Small" Height="30px" Width="90px"></asp:TextBox>
            </td>
            <td class="style27">
                <asp:TextBox ID="importe2" runat="server" BorderStyle="None" CssClass="style5" 
                    Font-Size="Small" Height="30px" Width="90px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style17">
                <asp:TextBox ID="txbCantidad3" runat="server" BorderStyle="None" 
                    CssClass="style5" Font-Size="Small" Height="30px" Width="50px"></asp:TextBox>
            </td>
            <td class="style18">
                <asp:TextBox ID="txbDescripcion3" runat="server" BorderStyle="None" 
                    CssClass="style5" Font-Size="Small" Height="30px" Width="700px"></asp:TextBox>
            </td>
            <td class="style27">
                <asp:TextBox ID="txbValor3" runat="server" BorderStyle="None" CssClass="style5" 
                    Font-Size="Small" Height="30px" Width="90px"></asp:TextBox>
            </td>
            <td class="style27">
                <asp:TextBox ID="importe3" runat="server" BorderStyle="None" CssClass="style5" 
                    Font-Size="Small" Height="30px" Width="90px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style17">
                <asp:TextBox ID="txbCantidad4" runat="server" BorderStyle="None" 
                    CssClass="style5" Font-Size="Small" Height="30px" Width="50px"></asp:TextBox>
            </td>
            <td class="style18">
                <asp:TextBox ID="txbDescripcion4" runat="server" BorderStyle="None" 
                    CssClass="style5" Font-Size="Small" Height="30px" Width="700px"></asp:TextBox>
            </td>
            <td class="style27">
                <asp:TextBox ID="txbValor4" runat="server" BorderStyle="None" CssClass="style5" 
                    Font-Size="Small" Height="30px" Width="90px"></asp:TextBox>
            </td>
            <td class="style27">
                <asp:TextBox ID="importe4" runat="server" BorderStyle="None" CssClass="style5" 
                    Font-Size="Small" Height="30px" Width="90px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style17">
                <asp:TextBox ID="txbCantidad5" runat="server" BorderStyle="None" 
                    CssClass="style5" Font-Size="Small" Height="30px" Width="50px"></asp:TextBox>
            </td>
            <td class="style18">
                <asp:TextBox ID="txbDescripcion5" runat="server" BorderStyle="None" 
                    CssClass="style5" Font-Size="Small" Height="30px" Width="700px"></asp:TextBox>
            </td>
            <td class="style27">
                <asp:TextBox ID="txbValor5" runat="server" BorderStyle="None" CssClass="style5" 
                    Font-Size="Small" Height="30px" Width="90px"></asp:TextBox>
            </td>
            <td class="style27">
                <asp:TextBox ID="importe5" runat="server" BorderStyle="None" CssClass="style5" 
                    Font-Size="Small" Height="30px" Width="90px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style17">
                <asp:TextBox ID="txbCantidad6" runat="server" BorderStyle="None" 
                    CssClass="style5" Font-Size="Small" Height="30px" Width="50px"></asp:TextBox>
            </td>
            <td class="style18">
                <asp:TextBox ID="txbDescripcion6" runat="server" BorderStyle="None" 
                    CssClass="style5" Font-Size="Small" Height="30px" Width="700px"></asp:TextBox>
            </td>
            <td class="style27">
                <asp:TextBox ID="txbValor6" runat="server" BorderStyle="None" CssClass="style5" 
                    Font-Size="Small" Height="30px" Width="90px"></asp:TextBox>
            </td>
            <td class="style27">
                <asp:TextBox ID="importe6" runat="server" BorderStyle="None" CssClass="style5" 
                    Font-Size="Small" Height="30px" Width="90px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style17">
                <asp:TextBox ID="txbCantidad7" runat="server" BorderStyle="None" 
                    CssClass="style5" Font-Size="Small" Height="30px" Width="50px"></asp:TextBox>
            </td>
            <td class="style18">
                <asp:TextBox ID="txbDescripcion7" runat="server" BorderStyle="None" 
                    CssClass="style5" Font-Size="Small" Height="30px" Width="700px"></asp:TextBox>
            </td>
            <td class="style27">
                <asp:TextBox ID="txbValor7" runat="server" BorderStyle="None" CssClass="style5" 
                    Font-Size="Small" Height="30px" Width="90px"></asp:TextBox>
            </td>
            <td class="style27">
                <asp:TextBox ID="importe7" runat="server" BorderStyle="None" CssClass="style5" 
                    Font-Size="Small" Height="30px" Width="90px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style17">
                <asp:TextBox ID="txbCantidad8" runat="server" BorderStyle="None" 
                    CssClass="style5" Font-Size="Small" Height="30px" Width="50px"></asp:TextBox>
            </td>
            <td class="style18">
                <asp:TextBox ID="txbDescripcion8" runat="server" BorderStyle="None" 
                    CssClass="style5" Font-Size="Small" Height="30px" Width="700px"></asp:TextBox>
            </td>
            <td class="style27">
                <asp:TextBox ID="txbValor8" runat="server" BorderStyle="None" CssClass="style5" 
                    Font-Size="Small" Height="30px" Width="90px"></asp:TextBox>
            </td>
            <td class="style27">
                <asp:TextBox ID="importe8" runat="server" BorderStyle="None" CssClass="style5" 
                    Font-Size="Small" Height="30px" Width="90px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style20" colspan="2">
                <asp:TextBox ID="txbCantidadLetra" runat="server" BorderStyle="None" 
                    Font-Size="Small" Height="30px" Width="500px"></asp:TextBox>
            </td>
            <td class="style26">
                <strong style="text-align: center">TOTAL</strong></td>
            <td class="style27">
                <asp:TextBox ID="txbTotal" runat="server" BorderStyle="None" CssClass="style5" 
                    Font-Size="Small" Height="30px" Width="90px"></asp:TextBox>
            </td>
        </tr>
    </table>
</div>


