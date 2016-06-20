<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlFormatoFacturaAmerica.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlFormatoFacturaAmerica" %>
   
       
    <br />
       <div id="Fecha" 
    
    
    
    
    style="position: absolute; top: 176px; left: 911px; width: 243px; height: 25px;">
               <asp:TextBox ID="txbDia" runat="server" Font-Bold="True" Font-Names="Arial" 
             Height="25px" Width="60px" BorderStyle="None"></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txbMes" runat="server" Height="25px" 
            Width="42px" BorderStyle="None" Font-Bold="True" Font-Names="Arial" 
                   ></asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txbAno" runat="server" Height="25px" 
            Width="60px" BorderStyle="None" Font-Bold="True" Font-Names="Arial" 
                   ></asp:TextBox>
       </div>

        <div id="Encabezado" 
    style="position: absolute; top: 237px; width: 643px; left: 105px;">
                    <asp:TextBox ID="txbNombre" runat="server" Height="30px" 
            MaxLength="50" Width="550px" BorderStyle="None" Font-Bold="True" Font-Names="Arial" 
            ></asp:TextBox></br>
            <asp:TextBox ID="txbDireccion" runat="server" 
            Height="30px" Width="550px" BorderStyle="None" Font-Bold="True" Font-Names="Arial" 
           ></asp:TextBox>
                <asp:TextBox ID="txbCiudad" runat="server" Height="30px" 
             Width="550px" BorderStyle="None" Font-Bold="True" Font-Names="Arial" 
            ></asp:TextBox>
                </div>
       

       <div id="Detalle" 
    style="position: absolute; top: 411px; left: 56px; width: 1090px;">
       <asp:TextBox ID="txbCantidad" runat="server" Height="200px" 
           TextMode="MultiLine" Width="100px" BorderStyle="None" Font-Bold="True" Font-Names="Arial" 
            ></asp:TextBox>
       <asp:TextBox ID="txbDescripcion" runat="server" Height="200px" 
           TextMode="MultiLine" Width="758px" BorderStyle="None" Font-Bold="True" Font-Names="Arial" 
            ></asp:TextBox>
           <asp:TextBox ID="txbPrecioUnitario" runat="server" BorderStyle="None" 
               Font-Bold="True" Font-Names="Arial" Height="200px" TextMode="MultiLine" 
               Width="100px"></asp:TextBox>
       <asp:TextBox ID="txbImporte" runat="server" Height="200px" TextMode="MultiLine" 
           Width="100px" BorderStyle="None" Font-Bold="True" Font-Names="Arial" 
            ></asp:TextBox>
        </div>       
                
    <br />
                
                <div id="CantidadLetra" 
    style="position: absolute; top: 874px; left: 34px; width: 814px;">                
                <asp:TextBox ID="txbCantidadLetra" runat="server" Width="797px" BorderStyle="None" 
                        Font-Bold="True" Font-Names="Arial" 
             Height="20px" ></asp:TextBox>
           
            </div>

<div id="Subtotal" style="position: absolute; top: 868px; left: 1035px;">
        <asp:TextBox ID="txbTotal" runat="server" Height="30px" BorderStyle="None" 
                  Font-Bold="True" Font-Names="Arial" 
            
            Width="100px"></asp:TextBox>
            </div>
     
        
    
<div style="position: absolute; top: 242px; left: 769px; width: 130px;">
        <asp:TextBox ID="txbTelefono" runat="server" Height="30px" BorderStyle="None" 
            Font-Bold="True" Font-Names="Arial" 
           ></asp:TextBox>
        <asp:TextBox ID="txbRfc" runat="server" Height="30px" BorderStyle="None" 
            Font-Bold="True" Font-Names="Arial" 
            ></asp:TextBox>
                </div>

     
        
    



     
        
    
