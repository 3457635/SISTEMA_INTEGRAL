<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="OrdenMail.aspx.vb" Inherits="Sistema_Integral_TSE_v45.OrdenMail" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
   
    <link href="../Styles.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style1
        {
            width: 616px;
        }
        .style3
        {
            width: 160px;
        }
        .style4
        {
            width: 82px;
            height: 84px;
        }
        .style5
        {
            width: 125px;
        }
        .style6
        {
            width: 131px;
        }
        .style7
        {
            width: 137px;
        }
        .style8
        {
            width: 369px;
        }
        .style9
        {
            width: 100%;
        }
        .style10
        {
            width: 856px;
        }
        .style11
        {
            width: 217px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="main">
    
        <table class="style1">
            <tr>
                <td class="style3">
                    <img alt="" class="style4" src="../imagenes/logo2.jpg" /></td>
                <td class="style8">
                    <span class="style4"><strong>TRANSPORTES Y SEGURIDAD EMPRESARIAL</strong></span><br 
                        class="style4" />
                    <span class="style4"><strong>ORDEN DE SERVICIO PARA FLETES Y CONTROL DE GASTOS</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></td>
                <td>
                    <asp:Label ID="lblOrden" runat="server" Font-Bold="True" Font-Size="Medium" 
                        Font-Underline="True"></asp:Label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
                <td>
                    <strong style="font-family: Arial, Helvetica, sans-serif; font-size: small">
                    &nbsp;Rev. 8<br />
                    26/03/2012</strong>&nbsp;</td>
            </tr>
        </table>       
        ________________________________________________________________________________________
    
       <br /><br /> <strong>Fecha de Servicio: </strong><asp:Label ID="lblFechaServicio" runat="server"></asp:Label>
&nbsp;<strong>Día</strong>:
    <asp:Label ID="lblDia" runat="server"></asp:Label>
&nbsp;<strong>Hora</strong>:
    <asp:Label ID="lblHora" runat="server"></asp:Label>
&nbsp;hrs.<asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ToolkitScriptManager>
        
&nbsp;<asp:Label ID="lblGuia" runat="server" style="font-weight: 700" 
            ForeColor="#003300"></asp:Label>
        <table class="style1">
        <tr>
            <td>
                <strong>Cliente:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </strong></td>
            <td>
                <strong>Contacto:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </strong></td>
            <td>
                <strong>Comunicación:</strong></td>
            <td>
                <strong>Destinos:</strong></td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblCliente" runat="server"></asp:Label>
            </td>
            <td>
                &nbsp;&nbsp;&nbsp;
                <asp:Label ID="lblContacto" runat="server"></asp:Label>
            </td>
            <td>
                <asp:GridView ID="grdComunicacion" runat="server">
                </asp:GridView>
            </td>
            <td>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="sdsDestinos" EnableModelValidation="True" Font-Size="Small" 
                    ShowHeader="False" SkinID="grdAnidado">
                    <Columns>
                        <asp:BoundField DataField="nombre" HeaderText="nombre" 
                            SortExpression="nombre" />
                        <asp:BoundField DataField="fecha" HeaderText="fecha" SortExpression="fecha" 
                            DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsDestinos" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT detalle_arrivos.nombre, llegadaDestinos.fecha FROM llegadaDestinos INNER JOIN detalle_arrivos ON llegadaDestinos.idArrivo = detalle_arrivos.id_detalle WHERE (llegadaDestinos.idViaje = @idViaje)">
                    <SelectParameters>
                        <asp:Parameter Name="idViaje" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    <table class="style1">
        <tr>
            <td>
                <strong>Ruta:</strong></td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblRuta" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <table class="style1">
        <tr>
            <td class="style5">
                <strong>CHOFER(ES)</strong></td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style5">
                <asp:GridView ID="grdChoferes" runat="server" EnableModelValidation="True" 
                    ShowHeader="False">
                </asp:GridView>
            </td>
            <td>
                <asp:GridView ID="grdTrayectos" runat="server" ShowHeader="False">
                </asp:GridView>
            </td>
        </tr>
    </table>
    <p>
        <strong>EQUIPO ASIGNADO</strong></p>
    <p>
        <table class="style9">
            <tr>
                <td class="style11">
        <asp:GridView ID="grdEquipo" runat="server">
        </asp:GridView>
                </td>
                <td>
                    <asp:GridView ID="grdCaja" runat="server" AutoGenerateColumns="False" 
                        DataSourceID="sdsCajas" EnableModelValidation="True">
                        <Columns>
                            <asp:BoundField DataField="economico" HeaderText="CAJA" 
                                SortExpression="economico" />
                            <asp:BoundField DataField="placa" HeaderText="PLACA" SortExpression="placa" />
                            <asp:BoundField DataField="marca" HeaderText="MARCA" SortExpression="marca" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsCajas" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT equipo_operacion.economico, equipo_operacion.placa, marcas.marca FROM cajaAsignada INNER JOIN equipo_operacion ON cajaAsignada.CajaId = equipo_operacion.id_equipo INNER JOIN equipo_asignado ON cajaAsignada.EquipoAsignadoId = equipo_asignado.id_equipo_asignado INNER JOIN marcas ON equipo_operacion.id_marca = marcas.id_marca
where equipo_asignado.ViajeId=@viajeId">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="viajeId" QueryStringField="id_viaje" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
&nbsp;</p>
    <table class="style1">
        <tr>
            <td class="style6">
                <strong>Gastos:</strong>
            </td>
            <td class="style7">
&nbsp;M.N.<strong> $</strong><asp:TextBox ID="txbGastoMn" runat="server" Font-Bold="True"></asp:TextBox>
            </td>
            <td>
                &nbsp;Dlls.
                <asp:TextBox ID="txbDlls" runat="server" Font-Bold="True"></asp:TextBox>
            </td>
        </tr>
    </table>
    <table class="style1">
        <tr>
            <td class="style9">
                Hora en que debe presentarse el chofer :
            </td>
            <td>
                Día:
                <asp:DropDownList ID="DropDownList1" runat="server" Height="16px" Width="122px" 
                    Font-Bold="True" AutoPostBack="True">
                    <asp:ListItem></asp:ListItem>
                    <asp:ListItem>Lunes</asp:ListItem>
                    <asp:ListItem>Martes</asp:ListItem>
                    <asp:ListItem>Miércoles</asp:ListItem>
                    <asp:ListItem>Jueves</asp:ListItem>
                    <asp:ListItem>Viernes</asp:ListItem>
                    <asp:ListItem>Sabado</asp:ListItem>
                    <asp:ListItem>Domingo</asp:ListItem>
                </asp:DropDownList>
&nbsp;Hora:
                <asp:TextBox ID="txbHora" runat="server" Font-Bold="True"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style9">
                Hora en que se presentó el chofer :</td>
            <td>
                __________________________</td>
        </tr>
        <tr>
            <td class="style9">
                Resibe Aviso :</td>
            <td>
                __________________________</td>
        </tr>
        <tr>
            <td class="style9">
                Avisa :</td>
            <td>
                __________________________</td>
        </tr>
        <tr>
            <td class="style9">
                Recibe $:</td>
            <td>
                M.N.
                ____________&nbsp;Dlls.
                ______________</td>
        </tr>
    </table>
    <br/>
    <br />
    <table class="style1">
        <tr>
            <td class="style10">
                Firma del Chofer:</td>
            <td class="style11">
                _____________________</td>
            <td class="style14">
&nbsp;&nbsp;&nbsp; Firma del Inspector:</td>
            <td>
                _______________________</td>
        </tr>
        <tr>
            <td class="style10">
                &nbsp;</td>
            <td class="style11">
                &nbsp;</td>
            <td class="style14">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
    <p>
        <strong>Observaciones:</strong></p>
    <p>
        <asp:TextBox ID="TextBox10" runat="server" Height="101px" TextMode="MultiLine" 
            Width="655px" Font-Underline="True" Font-Bold="True"></asp:TextBox>
    </p>
    <div />
       
         <asp:MaskedEditExtender
                    ID="MaskedEditExtender1" runat="server" Mask="9,999,999.99"
    MessageValidatorTip="true" 
    OnFocusCssClass="MaskedEditFocus" 
    OnInvalidCssClass="MaskedEditError"
    MaskType="Number" 
    InputDirection="RightToLeft" 
    AcceptNegative="Left"
    ErrorTooltipEnabled="True" TargetControlID="txbGastoMn"></asp:MaskedEditExtender>
        <asp:MaskedEditExtender
                    ID="MaskedEditExtender2" runat="server" Mask="9,999,999.99"
    MessageValidatorTip="true" 
    OnFocusCssClass="MaskedEditFocus" 
    OnInvalidCssClass="MaskedEditError"
    MaskType="Number" 
    InputDirection="RightToLeft" 
    AcceptNegative="Left"
    ErrorTooltipEnabled="True" TargetControlID="txbDlls"></asp:MaskedEditExtender>
    <asp:MaskedEditExtender
                    ID="MaskedEditExtender3" runat="server" Mask="99:99"
    MessageValidatorTip="true" 
    OnFocusCssClass="MaskedEditFocus" 
    OnInvalidCssClass="MaskedEditError"
    MaskType="Time" 
    InputDirection="RightToLeft" 
    AcceptNegative="Left"
    ErrorTooltipEnabled="True" TargetControlID="txbHora"></asp:MaskedEditExtender>
    </form>
</body>
</html>
