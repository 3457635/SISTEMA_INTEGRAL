<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlFormatoCFDI.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlFormatoCFDI" %>
   
       <style type="text/css">
           .style1
           {
               width: 100%;
               height: 93px;
           }
           .style2
           {
               font-family: Arial, Helvetica, sans-serif;
           }
           .style3
           {
               font-family: Arial, Helvetica, sans-serif;
               height: 20px;
               }
           .style4
           {
               height: 27px;
               width: 60px;
           }
           .style5
           {
               width: 184px;
               height: 53px;
           }
           .style6
           {
               font-family: Arial, Helvetica, sans-serif;
               height: 32px;
           }
           .style7
           {
               height: 32px;
           }
           .style10
           {
               width: 100%;
               height: 70px;
           }
           .style11
           {
               width: 100%;
           }
           .style13
           {
               width: 100px;
           }
           .style14
           {
               width: 758px;
           }
           .style15
           {
               width: 100px;
               font-family: Arial, Helvetica, sans-serif;
           }
           .style16
           {
               width: 758px;
               font-family: Arial, Helvetica, sans-serif;
           }
           .style20
           {
               width: 201px;
           }
           .style21
           {
               width: 102px;
           }
           .style22
           {
               width: 89px;
               font-family: Arial, Helvetica, sans-serif;
           }
           .style23
           {
               height: 27px;
               width: 60px;
               font-family: Arial, Helvetica, sans-serif;
           }
           .style24
           {
               height: 27px;
               width: 68px;
               font-family: Arial, Helvetica, sans-serif;
           }
           .style25
           {
               height: 27px;
               width: 42px;
               font-family: Arial, Helvetica, sans-serif;
           }
           .style26
           {
               height: 27px;
               width: 68px;
           }
           .style27
           {
               height: 27px;
               width: 42px;
           }
       </style>
   
       <div id="Fecha" 
    
    
    
    
    
    
    
    
    
    style="position: absolute; top: 22px; left: 1021px; width: 201px; height: 80px;">
               <table class="style5">
                   <tr>
                       <td class="style3" colspan="3">
                           FECHA</td>
                   </tr>
                   <tr>
                       <td class="style24">
                           DÍA</td>
                       <td class="style25">
                           MES</td>
                       <td class="style23">
                           AÑO</td>
                   </tr>
                   <tr>
                       <td class="style26">
               <asp:TextBox ID="txbDia" runat="server" Font-Bold="True" Font-Names="Arial" 
             Height="25px" Width="60px" BorderStyle="None"></asp:TextBox>
        &nbsp;&nbsp;</td>
                       <td class="style27">
                           <asp:TextBox ID="txbMes" runat="server" Height="25px" 
            Width="42px" BorderStyle="None" Font-Bold="True" Font-Names="Arial" 
                   ></asp:TextBox>
                       </td>
                       <td class="style4">
                           <asp:TextBox ID="txbAno" runat="server" Height="25px" 
            Width="60px" BorderStyle="None" Font-Bold="True" Font-Names="Arial" 
                   ></asp:TextBox>
                       </td>
                   </tr>
               </table>
       </div>

        <div id="Encabezado" 
    
    
    style="position: absolute; top: 24px; width: 643px; left: 64px; height: 119px;">
                
                    <table class="style1">
                        <tr>
                            <td class="style2">
                                EMPRESA</td>
                            <td>
                    <asp:TextBox ID="txbNombre" runat="server" Height="30px" 
            MaxLength="50" Width="550px" BorderStyle="Solid" Font-Bold="True" Font-Names="Arial" 
            ></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="style2">
                                DIRECCION</td>
                            <td>
            <asp:TextBox ID="txbDireccion" runat="server" 
            Height="30px" Width="550px" BorderStyle="Solid" Font-Bold="True" Font-Names="Arial" 
           ></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="style2">
                                CIUDAD</td>
                            <td>
                                <asp:TextBox ID="txbCiudad" runat="server" Height="30px" 
             Width="550px" BorderStyle="Solid" Font-Bold="True" Font-Names="Arial" 
            ></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
       

       <div id="Detalle" 
    
    
    style="position: absolute; top: 153px; left: 67px; width: 1090px; height: 262px;">
           <table class="style11">
               <tr>
                   <td class="style15">
                       CANTIDAD</td>
                   <td class="style16">
                       DESCRIPCIÓN</td>
                   <td class="style15">
                       VALOR UNITARIO</td>
                   <td class="style2">
                       IMPORTE</td>
               </tr>
               <tr>
                   <td class="style13">
       <asp:TextBox ID="txbCantidad" runat="server" Height="200px" 
           TextMode="MultiLine" Width="100px" BorderStyle="Solid" Font-Bold="True" Font-Names="Arial" 
            ></asp:TextBox>
                   </td>
                   <td class="style14">
       <asp:TextBox ID="txbDescripcion" runat="server" Height="200px" 
           TextMode="MultiLine" Width="758px" BorderStyle="Solid" Font-Bold="True" Font-Names="Arial" 
            ></asp:TextBox>
                   </td>
                   <td class="style13">
           <asp:TextBox ID="txbPrecioUnitario" runat="server" BorderStyle="Solid" 
               Font-Bold="True" Font-Names="Arial" Height="200px" TextMode="MultiLine" 
               Width="100px"></asp:TextBox>
                   </td>
                   <td>
       <asp:TextBox ID="txbImporte" runat="server" Height="200px" TextMode="MultiLine" 
           Width="100px" BorderStyle="Solid" Font-Bold="True" Font-Names="Arial" ReadOnly="True" 
            ></asp:TextBox>
                   </td>
               </tr>
           </table>
        </div>       
                
    <br />
                
                

<div id="Subtotal" 
    
    style="position: absolute; top: 424px; left: 935px; width: 226px; height: 147px;">
              <table class="style20">
                  <tr>
                      <td class="style22">
                          SUBTOTAL</td>
                      <td class="style21">
              <asp:TextBox ID="txbSubtotal" runat="server" Height="30px" BorderStyle="Solid" 
                  Font-Bold="True" Font-Names="Arial" 
             
            Width="102px" ReadOnly="True"></asp:TextBox>                
                      </td>
                  </tr>
                  <tr>
                      <td class="style22">
                          IVA</td>
                      <td class="style21">
        <asp:TextBox ID="txbIva" runat="server" Height="30px" BorderStyle="Solid" 
                  Font-Bold="True" Font-Names="Arial" 
            
            Width="101px" ReadOnly="True"></asp:TextBox>                
                      </td>
                  </tr>
                  <tr>
                      <td class="style22">
                          RETENCIÓN</td>
                      <td class="style21">
        <asp:TextBox ID="txbRetencion" runat="server" Height="30px" BorderStyle="Solid" 
                  Font-Bold="True" Font-Names="Arial" 
           
            Width="100px" ReadOnly="True"></asp:TextBox>                
                      </td>
                  </tr>
                  <tr>
                      <td class="style22">
                          TOTAL</td>
                      <td class="style21">
        <asp:TextBox ID="txbTotal" runat="server" Height="30px" BorderStyle="Solid" 
                  Font-Bold="True" Font-Names="Arial" 
            
            Width="100px" ReadOnly="True"></asp:TextBox>
                      </td>
                  </tr>
              </table>
            </div>
     
        
    
<div style="position: absolute; top: 25px; left: 754px; width: 246px; height: 80px;">
        <table class="style10">
            <tr>
                <td class="style6">
                    TELEFONO</td>
                <td class="style7">
        <asp:TextBox ID="txbTelefono" runat="server" Height="30px" BorderStyle="Solid" 
            Font-Bold="True" Font-Names="Arial" 
           ></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style6">
                    RFC</td>
                <td class="style7">
        <asp:TextBox ID="txbRfc" runat="server" Height="30px" BorderStyle="Solid" 
            Font-Bold="True" Font-Names="Arial" Width="128px" 
            ></asp:TextBox>
                </td>
            </tr>
        </table>
                </div>

     
        
    
<div style="position: absolute; top: 458px; left: 70px; width: 833px;">
    <span class="style2">ANOTACIONES&nbsp; </span>
    <asp:TextBox ID="txbAnotaciones" runat="server" BorderStyle="Solid" 
        Font-Bold="True" Width="689px" Height="70px" TextMode="MultiLine"></asp:TextBox>
</div>


     
        
    
<div style="position: absolute; top: 544px; left: 73px; width: 812px; height: 79px;">
    <asp:Label ID="lblMensajeCFDI" runat="server" SkinID="lblMensaje"></asp:Label>
    <br />
    <asp:Label ID="lblMensajeCBB" runat="server" SkinID="lblMensaje"></asp:Label>
    <br />
    <asp:Label ID="lblMensajePdf" runat="server" SkinID="lblMensaje"></asp:Label>
&nbsp;</div>
                <div style="position: absolute; top: 422px; left: 66px; height: 27px; width: 818px;">
                    <span class="style2">IMPORTE CON LETRA</span><asp:TextBox ID="txbCantidadLetra" runat="server" Width="650px" BorderStyle="Solid" 
                        Font-Bold="True" Font-Names="Arial" 
             Height="21px" ></asp:TextBox>
           
        


     
        
    
</div>

           
        


     
        
    
