<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Default.aspx.vb" Inherits="Sistema_Integral_TSE_v45._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TSE SI</title>
    <script src="Script/jquery-1.8.3.js" type="text/javascript"></script>
    <script type="text/javascript" >
        $(document).ready(function () {
            $("#Image1").animate({ left: '500px', opacity: '0.1' }, "slow");
            $("#Image1").animate({ left: '200px', opacity: '1' }, "slow");
            $("#encabezado").animate({  opacity: '0.1' }, "slow");
            $("#encabezado").animate({  opacity: '1' }, "slow");
            
        });


    </script>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 271px;
        }
        .style3
        {
            width: 70px;
            height: 94px;
        }
        .style4
        {
            font-family: Arial, Helvetica, sans-serif;
            color: #003300;
        }
        .style5
        {
            font-family: Arial, Helvetica, sans-serif;
        }
        .style6
        {
            font-family: Arial, Helvetica, sans-serif;
            color: #006600;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

 <div id="encabezado">
                <img alt="" class="style3" src="imagenes/logo2.jpg" /><span class="style4"><strong>Transportes 
                y Seguridad Empresarial</strong></span></div>
    <table class="style1" bgcolor="#359766" border="0" cellpadding="0" 
        cellspacing="0">
        <tr>
            <td colspan="2" bgcolor="White">
           </td>
        </tr>
        <tr>
            <td class="style2">
                <asp:Login ID="Login1" runat="server" DestinationPageUrl="~/Login.aspx" 
                    BackColor="#359766" Font-Names="Arial" ForeColor="White" 
                    LoginButtonText="Iniciar Sesión" PasswordLabelText="Contraseña:" 
                    RememberMeText="Recordarme la próxima vez." TitleText="Inicio de Sesión" 
                    UserNameLabelText="Usuario:">
                </asp:Login>
            </td>
            <td>
                <asp:Image ID="Image1" runat="server" ImageUrl="~/imagenes/presen6.png" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                &nbsp;</td>
        </tr>
    </table>
    <div id="pie" style="text-align: center">
    
        <span class="style4"><strong>Sistema Integral</strong></span><br 
            class="style5" />
        <br class="style5" />
        <br class="style5" />
        <span class="style6">Transportes y Seguridad Empresarial</span><br 
            class="style6" />
        <span class="style6">Av. Octavio Paz No. 170</span><br class="style6" />
        <span class="style6">Complejo Industrial Chihuahua</span><br class="style6" />
        <span class="style6">Chihuahua, Chih. México C.P. 31109</span><br 
            class="style6" />
        <span class="style6">Tel.-(614) 481-42-10</span></div>
    
    
    
    </form>
</body>
</html>
