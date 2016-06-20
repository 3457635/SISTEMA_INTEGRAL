<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Liquidacion.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Liquidacion" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style3
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: small;
        }
        .style5
        {
            font-family: Arial, Helvetica, sans-serif;
        }
        .style10
        {
            font-family: Arial, Helvetica, sans-serif;
            width: 101px;
            font-size: small;
        }
        .style11
        {
            width: 101px;
        }
        .style13
        {
            width: 45px;
            font-family: Arial, Helvetica, sans-serif;
            font-size: small;
        }
        .style16
        {
            font-size: x-small;
        }
        .style19
        {
            width: 38px;
        }
        .style20
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: x-small;
        }
        .style21
        {
            font-family: Arial, Helvetica, sans-serif;
            font-weight: bold;
            font-size: x-small;
        }
        .style22
        {
            width: 89px;
        }
        .style23
        {
            font-family: Arial, Helvetica, sans-serif;
            font-weight: bold;
            font-size: x-small;
            width: 89px;
        }
        .style29
        {
            width: 333px;
        }
        .style34
        {
            font-family: Arial, Helvetica, sans-serif;
            font-weight: bold;
            font-size: x-small;
            width: 98px;
        }
        .style35
        {
            width: 98px;
        }
        .style38
        {
            background-color: #FFFFFF;
        }
        .style39
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: small;
            background-color: #FFFFFF;
        }
        .style40
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: x-small;
            background-color: #FFFFFF;
        }
        .style41
        {
            width: 244px;
        }
        .style42
        {
            font-family: Arial, Helvetica, sans-serif;
            font-weight: bold;
            font-size: x-small;
            width: 101px;
        }
        .style43
        {
            width: 304px;
            font-weight: bold;
            text-align: left;
            font-family: Arial, Helvetica, sans-serif;
            font-size: small;
        }
        .style44
        {
            text-align: center;
            width: 185px;
        }
        .style45
        {
            font-family: Arial, Helvetica, sans-serif;
            font-weight: bold;
            font-size: small;
            width: 89px;
        }
        .style46
        {
            width: 98px;
            font-weight: bold;
        }
        .style47
        {
            width: 101px;
            font-weight: bold;
        }
        .style48
        {
            text-decoration: underline;
        }
        .style49
        {
            width: 185px;
        }
        .style50
        {
            width: 46px;
            height: 44px;
        }
        .style51
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: small;
            width: 73px;
        }
        .style52
        {
            width: 73px;
        }
        </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="formato" style="width: 100%; height: 100%">
    <div id="main">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    &nbsp;<img alt="" class="style50" src="../imagenes/logo2.jpg" /></td>
                <td>
                    <span class="style5"><strong>TRANSPORTES Y SEGURIDAD EMPRESARIAL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </strong></span><strong>
                        <br class="style5" />
                    </strong><span class="style5"><strong>LIQUIDACIÓN DE GASTOS DE VIAJE</strong></span>
                </td>
                <td>
                    <asp:Label ID="lblOrden" runat="server" Font-Bold="True" Font-Underline="True" Font-Names="Arial"></asp:Label>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
        </div>
    <table>
        <tr>
            <td>
                <strong><span class="style3">Fecha de Servicio:</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </strong>
            </td>
            <td>
                &nbsp;&nbsp;<asp:Label ID="lblFecha" runat="server" Font-Names="Arial" Font-Size="Small"></asp:Label>
            </td>
        </tr>
    </table>
    <table class="style1" border="0" cellpadding="0">
        <tr>
            <td class="style13">
                <strong>Cliente:</strong>
            </td>
            <td class="style41">
                <asp:Label ID="lblCliente" runat="server" Font-Names="Arial" Font-Size="Small"></asp:Label>
            </td>
            <td class="style19">
                <strong><span class="style3">Ruta</span>:</strong>
            </td>
            <td>
                <asp:Label ID="lblRuta" runat="server" Font-Names="Arial" Font-Size="Small"></asp:Label>
            </td>
        </tr>
    </table>
    <table class="style1" cellpadding="0" cellspacing="0">
        <tr>
            <td class="style10">
                <strong>Chofer(es)</strong>
            </td>
            <td class="style51">
                <strong>Equipo</strong>
            </td>
            <td class="style3">
                <strong>Caja</strong></td>
        </tr>
        <tr>
            <td class="style11">
                <asp:GridView ID="grdChofer" runat="server" ShowHeader="False" Font-Size="Small"
                    Font-Names="Arial">
                </asp:GridView>
            </td>
            <td class="style52">
                <asp:GridView ID="grdEquipo" runat="server" ShowHeader="False" Font-Size="Small"
                    Font-Names="Arial">
                </asp:GridView>
            </td>
            <td>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="sdsCaja" EnableModelValidation="True" ShowHeader="False">
                    <Columns>
                        <asp:BoundField DataField="economico" HeaderText="economico" 
                            SortExpression="economico" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsCaja" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT eo.economico FROM equipo_operacion eo INNER JOIN cajaAsignada ON eo.id_equipo = cajaAsignada.CajaId INNER JOIN equipo_asignado ON cajaAsignada.EquipoAsignadoId = equipo_asignado.id_equipo_asignado where viajeId=@id">
                    <SelectParameters>
                        <asp:Parameter Name="id" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    <div>
        <span class="style20"><strong>CASETAS</strong></span><br class="style5" />
        <span class="style20">Debe registrarse en el orden en que fueron utilizadas.</span>
        <table border="1" cellspacing="0" class="style1" cellpadding="0">
            <tr>
                <td class="style21">
                    Caseta Omitida
                </td>
                <td class="style21">
                    Caseta Cruzada
                </td>
                <td class="style21">
                    No.Comprobante
                </td>
                <td class="style21">
                    M.N. ($)
                </td>
                <td class="style21">
                    DLLS.
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style39">
                    <strong>Total</strong>
                </td>
                <td class="style38">
                    &nbsp;
                </td>
                <td class="style38">
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
    <span class="style20"><strong>COMBUSTIBLE</strong></span><br />
    <span class="style20">Solo se aceptan facturas o ticket con sello fiscal.</span>
    <br />
    <table class="style1" border="1" cellspacing="0" cellpadding="0">
        <tr>
            <td class="style21">
                LUGAR DE CARGA
            </td>
            <td class="style21">
                ODOMETRO
            </td>
            <td class="style21">
                LITROS
            </td>
            <td class="style21">
                CANTIDAD($)
            </td>
            <td class="style21">
                FECHA
            </td>
        </tr>
        <tr>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style40">
                <strong>TOTAL</strong>
            </td>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
        </tr>
    </table>
    <strong><span class="style16">OTROS </span></strong>
    <table border="1" cellspacing="0" class="style1" cellpadding="0">
        <tr>
            <td class="style21">
                CONCEPTO
            </td>
            <td class="style21">
                No. COMPROBANTE
            </td>
            <td class="style21">
                M.N. ($)
            </td>
            <td class="style21">
                DLLS.
            </td>
        </tr>
        <tr>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td class="style38">
                &nbsp;</td>
            <td class="style38">
                &nbsp;</td>
            <td class="style38">
                &nbsp;</td>
            <td class="style38">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style39">
                <strong>TOTAL</strong>
            </td>
            <td class="style38">
                &nbsp;
            </td>
            <td class="style38">
                &nbsp;
            </td>
        </tr>
    </table>
    <span class="style20"><strong>LIQUIDACIÓN</strong></span>
    </form>
    <div>
       
        <div style="text-align: right" />

        <div id="col1" style="float:left; text-align: left;"><table border="1" cellspacing="0" class="style29" cellpadding="0">
            <tr>
                <td class="style22">
                    &nbsp;
                </td>
                <td class="style42">
                    M.N. ($)
                </td>
                <td class="style34">
                    Dlls.
                </td>
            </tr>
            <tr>
                <td class="style23">
                    Importe de Recibo
                </td>
                <td class="style11">
                    &nbsp;
                </td>
                <td class="style35">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="style45">
                    Total de Gastos
                </td>
                <td class="style47">
                    &nbsp;
                </td>
                <td class="style46">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="style23">
                    Diferencia
                </td>
                <td class="style11">
                    &nbsp;
                </td>
                <td class="style35">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="style23">
                    Entrega
                </td>
                <td class="style11">
                    &nbsp;
                </td>
                <td class="style35">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="style23">
                    Debe
                </td>
                <td class="style11">
                    &nbsp;
                </td>
                <td class="style35">
                    &nbsp;
                </td>
            </tr>
        </table>
            </div>
<div id="col2" style="float: left">&nbsp;&nbsp;&nbsp; </div>
<div id="Div1" style="float: left; width: 251px;"> 
    <table border="1" cellpadding="0" cellspacing="0" class="style1">
        <tr>
            <td class="style43">
                Recargas Combustible <span class="style48">(No en efectivo</span>)</td>
            <td class="style44">
                <strong>Litros</strong></td>
        </tr>
        <tr>
            <td class="style43">
                X56</td>
            <td class="style49">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style43">
                Ultragas</td>
            <td class="style49">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style43">
                Cuatro Caminos</td>
            <td class="style49">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style43">
                Grupo Siga</td>
            <td class="style49">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style43">
                Total</td>
            <td class="style49">
                &nbsp;</td>
        </tr>
    </table>
            </div>
            </div>

         
                <br />
                <br />
        <br />
        <br />
             ________________________________<br />
        <span class="style3"><strong>Nombre y Firma Chofer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </strong></span>
           


       
    </div>
    <br />
    <table class="style1">
        <tr>
            <td>
                TSE-F-12</td>
            <td>
                REV. 01</td>
            <td>
                ABRIL-16</td>
        </tr>
    </table>
           
           </div>

       
    </body>
</html>
