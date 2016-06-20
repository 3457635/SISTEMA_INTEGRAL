<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlFormatoFactura.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlFormatoFactura" %>
   
       <br />
    <br />
    <br />
       <div id="Fecha" 
    
    
    
    
    style="position: absolute; top: 117px; left: 944px; width: 193px; height: 25px;">
               <asp:TextBox ID="txbDia" runat="server" Font-Bold="True" Font-Names="Arial" 
             Height="25px" Width="60px" BorderStyle="None"></asp:TextBox>
        <asp:TextBox ID="txbMes" runat="server" Height="25px" 
            Width="42px" BorderStyle="None" Font-Bold="True" Font-Names="Arial" 
                   ></asp:TextBox>
        &nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txbAno" runat="server" Height="25px" 
            Width="60px" BorderStyle="None" Font-Bold="True" Font-Names="Arial" 
                   ></asp:TextBox>
       </div>

        <div id="Encabezado" 
    style="position: absolute; top: 163px; width: 643px; left: 130px;">
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
    style="position: absolute; top: 296px; left: 30px; width: 1090px;">
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
    style="position: absolute; top: 542px; left: 131px; width: 814px;">                
                <asp:TextBox ID="txbCantidadLetra" runat="server" Width="650px" BorderStyle="None" 
                        Font-Bold="True" Font-Names="Arial" 
             Height="21px" ></asp:TextBox>
           
        <asp:TextBox ID="TextBox6" runat="server" Font-Bold="True" Height="21px" 
            Width="153px" BorderStyle="None"  Font-Names="Arial" 
            >TASA DEL 16% I.V.A.</asp:TextBox>
            </div>

<div id="Subtotal" style="position: absolute; top: 565px; left: 992px;">
              <asp:TextBox ID="txbSubtotal" runat="server" Height="30px" BorderStyle="None" 
                  Font-Bold="True" Font-Names="Arial" 
             
            Width="102px"></asp:TextBox>                
              <br />
        <asp:TextBox ID="txbIva" runat="server" Height="30px" BorderStyle="None" 
                  Font-Bold="True" Font-Names="Arial" 
            
            Width="101px"></asp:TextBox>                
              <br />
        <asp:TextBox ID="txbRetencion" runat="server" Height="30px" BorderStyle="None" 
                  Font-Bold="True" Font-Names="Arial" 
           
            Width="100px"></asp:TextBox>                
              <br />
        <asp:TextBox ID="txbTotal" runat="server" Height="30px" BorderStyle="None" 
                  Font-Bold="True" Font-Names="Arial" 
            
            Width="100px"></asp:TextBox>
            </div>
     
        
    
<div style="position: absolute; top: 184px; left: 798px; width: 130px;">
        <asp:TextBox ID="txbTelefono" runat="server" Height="30px" BorderStyle="None" 
            Font-Bold="True" Font-Names="Arial" 
           ></asp:TextBox>
        <asp:TextBox ID="txbRfc" runat="server" Height="30px" BorderStyle="None" 
            Font-Bold="True" Font-Names="Arial" 
            ></asp:TextBox>
                </div>

     
        
    
<div style="position: absolute; top: 500px; left: 132px; width: 703px;">
    <asp:TextBox ID="txbAnotaciones" runat="server" BorderStyle="None" 
        Font-Bold="True" Width="650px"></asp:TextBox>
</div>


     
        
    
