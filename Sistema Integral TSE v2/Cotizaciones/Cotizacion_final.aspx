<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Cotizacion_final.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Cotizacion_final" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            width: 70px;
        }
        .style3
        {
            font-size: large;
        }
        .style4
        {
            font-family: Arial, Helvetica, sans-serif;
        }
        </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Button ID="Button1" runat="server" SkinID="btn" Text="Enviar Cotización" ValidationGroup="correo" />
&nbsp;&nbsp;
        <asp:TextBox ID="txbIdCotizacion" runat="server" Visible="False"></asp:TextBox>
        <asp:Button ID="btnRegresar" runat="server" SkinID="btn" Text="Regresar" />
        <br />
        Para:
        <asp:TextBox ID="txbCorreo" runat="server" Height="66px" TextMode="MultiLine" Width="326px"></asp:TextBox>
    
        <asp:RequiredFieldValidator ID="rfvCorreo" runat="server" ControlToValidate="txbCorreo" ErrorMessage="Campo Obligatorio" ValidationGroup="correo"></asp:RequiredFieldValidator>
    
        <br />
        <asp:Label ID="lblMensaje" runat="server"></asp:Label>
        <br />
&nbsp;</div>
    <table class="style1">
        <tr>
            <td class="style2">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/imagenes/logo2.jpg" />
            </td>
            <td style="text-align: left; font-family: Arial, Helvetica, sans-serif">
                <strong><span class="style3">TRANSPORTES Y SEGURIDAD EMPRESARIAL</span></strong><br />
                AUTOTRANSPORTE ESPECIALIZADO DENTRO Y FUERA DEL PAÍS</td>
        </tr>
    </table>
    <p>
&nbsp;<span class="style4">Chihuahua, Chih. A</span>
        <asp:Label ID="lblFecha" runat="server" 
            style="font-family: Arial, Helvetica, sans-serif"></asp:Label>
    </p>
    <table class="style1">
        <tr>
            <td>
                <asp:Label ID="lblEmpresa" runat="server" 
                    style="font-family: Arial, Helvetica, sans-serif; font-weight: 700;"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Atención a
                <asp:Label ID="lblContacto" runat="server" 
                    style="font-family: Arial, Helvetica, sans-serif"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style4">
                En referencia a su amable solicitud me permito enviarle el precio solicitado, hemos considerado la información recibida para el servicio especifico que necesita, pero le  agradeceremos revisar los datos para asegurarnos  haber  enviado el valor correcto.</td>
        </tr>
    </table>
    <p>
        No.
        <asp:Label ID="lblFolio" runat="server"></asp:Label>
    </p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="sdsPrecios" EnableModelValidation="True">
            <Columns>
                <asp:BoundField DataField="FOLIO" HeaderText="FOLIO" ReadOnly="True" 
                    SortExpression="FOLIO" />
                <asp:BoundField DataField="ruta" HeaderText="RUTA" SortExpression="ruta" />
                <asp:BoundField DataField="equipo" HeaderText="VEHICULO" 
                    SortExpression="equipo" />
                <asp:BoundField DataField="precio" DataFormatString="{0:c}" HeaderText="PRECIO" 
                    SortExpression="precio" />
                <asp:BoundField DataField="especificacion" HeaderText="COMENTARIOS" 
                    SortExpression="especificacion" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsPrecios" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            
            
            SelectCommand="SELECT CONVERT (nvarchar, cotizaciones.ano) + '-' + CONVERT (nvarchar, cotizaciones.consecutivo) + '-' + precios.letra AS FOLIO, dbo.llave_rutas.ruta, tipo_equipos.equipo, precios.precio, precios.especificacion FROM cotizaciones INNER JOIN precios ON cotizaciones.id_cotizacion = precios.id_cotizacion INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN tipo_equipos ON precios.id_tipo_recurso = tipo_equipos.id_tipo_equipo WHERE (cotizaciones.id_cotizacion = @id_cotizacion) AND (precios.id_status &lt;&gt; 6)">
            <SelectParameters>
                <asp:QueryStringParameter Name="id_cotizacion" 
                    QueryStringField="id_cotizacion" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <span class="style4">* Este precio incluye la totalidad de conceptos como chofer, combustible.<br />
        * El precio no incluye IVA la cual será la tasa vigente.<br />
        * El precio tendrá una vigencia hasta el&nbsp;
        </span>
        <asp:Label ID="lblVigencia" runat="server" CssClass="style4"></asp:Label><br /><br />
        Cualquier duda o comentario puede dirigirse al departamento de cotizaciones.<br />
        Correo: contacto@tse.com.mx<br />
        Télefono:(614-481-42-10) Ext.109<br />        
    </p>
    <p class="style4" 
        style="mso-fareast-font-family: &quot;Times New Roman&quot;; mso-fareast-language: ES-MX">
        Agradeceremos sus comentarios a la presente.<o:p></o:p></p>
    <p class="style4">
        Atentamente.</p>
    <p class="style4">
        Atención a Cliente.</p>
    <p>
        <span class="style4" 
            style="font-size: 12.0pt; mso-fareast-font-family: &quot;Times New Roman&quot;; mso-fareast-language: ES-MX">
        Departamento de Cotizaciones</span><span style="font-size:12.0pt;font-family:&quot;Times New Roman&quot;,&quot;serif&quot;;
mso-fareast-font-family:&quot;Times New Roman&quot;;mso-fareast-language:ES-MX"><o:p>.</o:p></span></p>
    <p style="text-align: center">
        Ave. Octavio Paz No. 170 Complejo Industrial Chihuahua C.P. 31109</p>
    <p style="text-align: center">
        Tel. 614-481-42-10&nbsp; Lada Mex.01.800.467.21.98 Toll Free From USA 
        1.800.297.5730</p>
    <p style="text-align: center">
        tse.com.mx</p>
    </form>
    </body>
</html>
