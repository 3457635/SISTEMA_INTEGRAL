<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Contraresibo_trw.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Contraresibo_trw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">   
    <script type="text/javascript">
        function hide() {
            document.poppedLayer = eval('document.getElementById("hide")');
            document.poppedLayer.style.visibility = "hidden";
            window.print();
        }
    </script>   
    <style type="text/css">
        .style1
        {
            width: 34px;
            height: 45px;
            font-family: Arial, Helvetica, sans-serif;
        }
        .style2
        {
            width: 100%;
        }
        .style3
        {
            font-family: Arial, Helvetica, sans-serif;
        }
    .DataGridFixedHeader
	{
	position: relative;
	top: expression(this.offsetParent.scrollTop); /*this works fine with IE only, but FireFox seems to be ignoring this*/
	}
	
	
        .style4
        {
            text-align: left;
        }
	
	
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="hide">
    
        <asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnImprimir"  
            onclientclick="hide();" style="width: 14px" />
    
    &nbsp;<asp:LinkButton ID="LinkButton1" runat="server">Regresar</asp:LinkButton>
    
    &nbsp;<asp:TextBox ID="txbInicio" runat="server" Visible="False"></asp:TextBox>
&nbsp;<asp:TextBox ID="txbFin" runat="server" Visible="False"></asp:TextBox>
&nbsp;<asp:TextBox ID="txbCliente" runat="server" Visible="False"></asp:TextBox>
    
&nbsp;&nbsp;<asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True">
            <asp:ListItem Value="2">TRW SWS</asp:ListItem>
            <asp:ListItem Value="3">TRW OR</asp:ListItem>
        </asp:DropDownList>
&nbsp;</div>
    <div>
    
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
        <asp:Label ID="lblLote" runat="server" 
            style="font-family: Arial, Helvetica, sans-serif"></asp:Label>
        <br class="style3" />
        <span class="style3">
        <asp:Label ID="lblCliente" runat="server" CssClass="style3" Font-Bold="True"></asp:Label>
        <br />
        <asp:Label ID="lblFecha" runat="server" CssClass="style3"></asp:Label>
        &nbsp;<asp:TextBox ID="txbFecha" runat="server" Visible="False"></asp:TextBox>
        <br />
        Chihuahua, Chih. </span>
        <br class="style3" />
        <span class="style3">Departamento de Tráfico y Pagos</span></div>
    <p class="style3">
        Por medio de la presente, nos permitimos enviar relación de fletes.</p>
    <p class="style3">
        Se anexa documentación correspondiente;</p>
    <asp:GridView 
        ID="grdMn" runat="server" CssClass="Grid"
        RowStyle-VerticalAlign="Bottom" EnableModelValidation="True" AutoGenerateColumns="False" 
        Width="900px" Font-Names="Arial">
        

        <Columns>
            <asp:BoundField DataField="id_factura" ShowHeader="False">
            
            <ItemStyle Font-Size="0pt" Width="2px" />
            </asp:BoundField>
            <asp:BoundField DataField="folio" HeaderText="FACTURA" >
            
            <ItemStyle VerticalAlign="Middle" Font-Bold="True" />
            
            </asp:BoundField>
            <asp:BoundField DataField="consecutivo" HeaderText="No.VIAJE" />
            <asp:BoundField DataField="fecha" DataFormatString="{0:d}" 
                HeaderText="FECHA VIAJE" />
            <asp:BoundField DataField="importe" HeaderText="IMPORTE" 
                DataFormatString="{0:c}" >
            
            <ItemStyle VerticalAlign="Middle" Width="150px" />
            
            </asp:BoundField>
            <asp:BoundField DataField="iva" DataFormatString="{0:c}" HeaderText="IVA">
            <ItemStyle VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="retencion" DataFormatString="{0:c}" 
                HeaderText="RETENCION">
            <ItemStyle VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="total" DataFormatString="{0:c}" HeaderText="TOTAL">
            <ItemStyle VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="DESTINO-FLETE">
                <ItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Height="27px" Width="524px" 
                        style="text-align: center" Font-Size="Smaller"></asp:TextBox>
                </ItemTemplate>
                
                <ItemStyle Width="150px" />
                
            </asp:TemplateField>
            <asp:TemplateField HeaderText="No.CAJA">
                <ItemTemplate>
                    <asp:Label ID="lblUnidad" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <HeaderStyle 
            CssClass="DataGridFixedHeader" />
        <RowStyle />
    </asp:GridView>
    <br />
    <asp:GridView ID="grdMovimientos" runat="server" AutoGenerateColumns="False" 
        EnableModelValidation="True" ShowHeader="False" Font-Names="Arial" 
        Font-Size="Medium" style="font-family: Arial, Helvetica, sans-serif" 
        ShowFooter="True">
        <Columns>
            <asp:BoundField DataField="id_factura" HeaderText="id_factura" >
            <ItemStyle Font-Size="0pt" Width="5px" />
            </asp:BoundField>
            <asp:BoundField DataField="folio" HeaderText="FACTURA" >
            <ItemStyle Width="77px" Font-Names="Arial" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="No.VIAJE">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" 
                        style="font-size: x-small; font-weight: 700;" Width="200px" 
                        Font-Size="Smaller"></asp:TextBox>
                </ItemTemplate>
                <ItemStyle Width="155px" />
            </asp:TemplateField>
            <asp:BoundField DataField="importe" HeaderText="IMPORTE" 
                DataFormatString="{0:c}" >
            <ItemStyle Font-Names="Arial" />
            </asp:BoundField>
            <asp:BoundField DataField="iva" HeaderText="IVA" DataFormatString="{0:c}" >
            <ItemStyle Width="72px" />
            </asp:BoundField>
            <asp:BoundField DataField="retencion" HeaderText="RETENCION" 
                DataFormatString="{0:c}" >
            <ItemStyle Width="92px" />
            </asp:BoundField>
            <asp:BoundField DataField="total" HeaderText="TOTAL" DataFormatString="{0:c}" >
            <ItemStyle Width="82px" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="DESTINO-FLETE">
                <ItemTemplate>
                    Movimientos Locales
                </ItemTemplate>
                <ItemStyle Width="314px" />
            </asp:TemplateField>
            <asp:BoundField HeaderText="No. Caja" >
            <ItemStyle Width="67px" />
            </asp:BoundField>
        </Columns>
        <FooterStyle BackColor="#003399" Font-Bold="True" Font-Overline="True" 
            ForeColor="White" />
    </asp:GridView>
    <br />
    <br />


    <p>
        Recibo por parte de Transportes y Seguridad Empresarial 
        las facturas de los viajes listados en este documento,como su respectivo soporte.<br></p>
    </form>
    <p>
        &nbsp;</p>
    <p>
        ___________________________________</p>
    <p>
        Firma del Cliente.</p>
</body>
</html>
