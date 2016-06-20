<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ContrareciboGlobal.aspx.vb" Inherits="Sistema_Integral_TSE_v45.WebForm4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function hide() {
            document.poppedLayer = eval('document.getElementById("hide")');
            document.poppedLayer.style.visibility = "hidden";
            window.print();
        }
    </script>   
</head>

<body>
    <form id="form1" runat="server">
    <div id ="hide">
     <asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnImprimir"  
            onclientclick="hide();" style="width: 14px; height: 16px;" />
    
    
        <span class="style3">
        <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True">
            <asp:ListItem>Selecciona</asp:ListItem>
            <asp:ListItem>BATESVILLE MANUFACTURING INC</asp:ListItem>
        </asp:DropDownList>
        </span>
    </div>
    
     <table class="style2">
            <tr>
                <td>
                    <img alt="" class="style1" src="../imagenes/logo.jpg" /></td>
                <td class="style4">
                    <span class="style3"><strong>Transportes y Seguridad Empresarial</strong></span><br 
                        class="style3" />
                    <span class="style3">Octavio Paz No. 170, Complejo Industrial Chihuahua</span><br 
                        class="style3" />
                    <span class="style3">Tel.(614) 481-42-10&nbsp; </span>
                </td>
            </tr>
        </table>
        _____________________________________________________________________________________________________________<br class="style3" />
        <span class="style3">
        <asp:HyperLink ID="HyperLink1" runat="server">HyperLink</asp:HyperLink>
        </span>
        <br class="style3" />
        <span class="style3">
        <asp:HyperLink ID="HyperLink2" runat="server">HyperLink</asp:HyperLink>
        <br />
        <asp:HyperLink ID="HyperLink3" runat="server">HyperLink</asp:HyperLink>
        <br />
        Chihuahua, Chih. </span>
        <br class="style3" />
        <span class="style3">Departamento de Tráfico y Pagos</span></div>
    <p class="style3">
        Por medio de la presente, nos permitimos enviar relación de fletes.</p>
    <p class="style3">
        Se anexa documentación correspondiente;</p>
<table border="1" cellpadding="0" cellspacing="0" class="style12">
        <tr>
            <td class="style5">
                FACTURA</td>
            <td class="style17">
                IMPORTE</td>
            <td class="style16">
                RETENCIÓN</td>
            <td class="style15">
                IVA</td>
            <td class="style14">
                TOTAL</td>
            <td class="style14">
                MONEDA</td>
            <td class="style14">
                ORDEN/RUTA/VEHICULO/FECHA</td>
            
        </tr>
        <tr>
            <td class="style18" rowspan="6">
                <asp:TextBox ID="TextBox17" runat="server" Width="85px"></asp:TextBox>
            </td>
            <td class="style18" rowspan="6">
                <asp:TextBox ID="TextBox13" runat="server" Width="93px"></asp:TextBox>
            </td>
            <td class="style18" rowspan="6">
                <asp:TextBox ID="TextBox14" runat="server" Width="85px"></asp:TextBox>
            </td>
            <td class="style7" rowspan="6">
                <asp:TextBox ID="TextBox9" runat="server" Width="81px"></asp:TextBox>
            </td>
            <td class="style9" rowspan="6">
                <asp:TextBox ID="TextBox10" runat="server" Width="83px"></asp:TextBox>
            </td>
            <td class="style10" rowspan="6">
                <asp:TextBox ID="TextBox11" runat="server" Width="88px"></asp:TextBox>
            </td>
            <td class="style13" > 
                <asp:TextBox ID="TextBox12" runat="server" Width="295px" Height="41px" Rows="2" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
        <tr>
            
            <td class="style13">
                <asp:TextBox ID="TextBox28" runat="server" Width="295px" Height="41px" Rows="2" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
    <tr>
            
        <td class="style13">
                <asp:TextBox ID="TextBox29" runat="server" Width="295px" Height="41px" Rows="2" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
    <tr>
           
        <td class="style13">
                <asp:TextBox ID="TextBox30" runat="server" Width="295px" Height="41px" Rows="2" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
    <tr>
           
        <td class="style13">
                <asp:TextBox ID="TextBox31" runat="server" Width="295px" Height="41px" Rows="2" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
    <tr>
            
        <td class="style13">
                <asp:TextBox ID="TextBox32" runat="server" Width="295px" Height="41px" Rows="2" TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
    </table>
        <br />
<table border="1" cellpadding="0" cellspacing="0" class="style12">
        <tr>
            <td class="style5">
                &nbsp;</td>
            <td class="style17">
                IMPORTE</td>
            <td class="style16">
                RETENCIÓN</td>
            <td class="style15">
                IVA</td>
            <td class="style14">
                TOTAL</td>
        </tr>
        <tr>
            <td class="style18">
                M.N</td>
            <td class="style7">
                <asp:TextBox ID="TextBox1" runat="server" Width="107px"></asp:TextBox>
            </td>
            <td class="style9">
                <asp:TextBox ID="TextBox3" runat="server" Width="102px"></asp:TextBox>
            </td>
            <td class="style10">
                <asp:TextBox ID="TextBox5" runat="server" Width="101px"></asp:TextBox>
            </td>
            <td class="style13">
                <asp:TextBox ID="TextBox7" runat="server" Width="97px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style18">
                Dlls.</td>
            <td class="style7">
                <asp:TextBox ID="TextBox2" runat="server" Width="106px"></asp:TextBox>
            </td>
            <td class="style9">
                <asp:TextBox ID="TextBox4" runat="server" Width="102px"></asp:TextBox>
            </td>
            <td class="style10">
                <asp:TextBox ID="TextBox6" runat="server" Width="100px"></asp:TextBox>
            </td>
            <td class="style13">
                <asp:TextBox ID="TextBox8" runat="server" Width="95px"></asp:TextBox>
            </td>
        </tr>
    </table>
        <p>
        Recibo por parte de Transportes y Seguridad Empresarial<br />
        las facturas de los viajes listados en este documento,<br />
        asi como su respectivo soporte.<br></p>
    </form>
    <p>
        &nbsp;</p>
    <p>
        ___________________________________</p>
    <p>
        Firma del Cliente.</p>
    </div>
    </form>
</body>
</html>
