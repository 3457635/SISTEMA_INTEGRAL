<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Evaluacion_Unidad.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Evaluacion_Unidad" %>

<%@ Register src="../Controles_Usuario/ctlRendimientoUnidad.ascx" tagname="ctlRendimientoUnidad" tagprefix="uc1" %>

<%@ Register src="../Controles_Usuario/ctlGraficaRendimientoPorCliente.ascx" tagname="ctlGraficaRendimientoPorCliente" tagprefix="uc2" %>

<asp:Content ID="Content2" ContentPlaceHolderID="Head" runat="server">
    <script type="text/javascript">
    $(document).ready(function () {
        $("#text1").focus(function () {
            $(this).css("background-color", "#cccccc");
        });
        $("#text1").blur(function () {
            $(this).css("background-color", "#ffffff");
        });
    });
</script>
    <style type="text/css">
        .auto-style4 {
            width: 100%;
        }
        .auto-style5 {
            width: 417px;
        }
        .auto-style6 {
            width: 387px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Evaluación por Unidad</h1><table style="width: 202px">
    <tr>
        <td style="width: 64px">
            Unidad:</td>
        <td style="width: 128px">
            <asp:DropDownList ID="ddlUnidad" runat="server" DataSourceID="sdsUnidad" 
                DataTextField="economico" DataValueField="id_equipo">
            </asp:DropDownList>
            <asp:SqlDataSource ID="sdsUnidad" runat="server" 
                ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                SelectCommand="SELECT economico, id_equipo FROM equipo_operacion where id_status&lt;&gt;6 and id_tipo_equipo&lt;&gt;107 order by economico">
            </asp:SqlDataSource>
        </td>
    </tr>
    <tr>
        <td style="width: 64px">
            Mes:</td>
        <td style="width: 128px">
            <asp:DropDownList ID="ddlMes" runat="server">
                <asp:ListItem Value="1">Enero</asp:ListItem>
                <asp:ListItem Value="2">Febrero</asp:ListItem>
                <asp:ListItem Value="3">Marzo</asp:ListItem>
                <asp:ListItem Value="4">Abril</asp:ListItem>
                <asp:ListItem Value="5">Mayo</asp:ListItem>
                <asp:ListItem Value="6">Junio</asp:ListItem>
                <asp:ListItem Value="7">Julio</asp:ListItem>
                <asp:ListItem Value="8">Agosto</asp:ListItem>
                <asp:ListItem Value="9">Septiembre</asp:ListItem>
                <asp:ListItem Value="10">Octubre</asp:ListItem>
                <asp:ListItem Value="11">Noviembre</asp:ListItem>
                <asp:ListItem Value="12">Diciembre</asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td style="width: 64px">
            Año:
        </td>
        <td style="width: 128px">
            <asp:TextBox ID="txbAno" runat="server"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td style="width: 64px">
            &nbsp;</td>
        <td style="width: 128px">
            <asp:Button ID="txbBuscar" runat="server" SkinID="btn" Text="Buscar" 
                Height="26px" />
            </td>
    </tr>
    </table>
    <table class="auto-style4">
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td>
                <asp:GridView ID="GridView6" runat="server" DataSourceID="SqlDataSource1">
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td class="auto-style5">&nbsp;</td>
            <td>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
            </td>
        </tr>
    </table>

    <hr />
    <asp:WebPartManager ID="WebPartManager1" runat="server">
    </asp:WebPartManager>
    <br />
    <asp:WebPartZone ID="WebPartZone1" runat="server" SkinID="wprtProfesional">
        <ZoneTemplate>
            <uc2:ctlGraficaRendimientoPorCliente ID="ctlGraficaRendimientoPorCliente1" title="Rendimiento Por Cliente"
                runat="server" />
            
        </ZoneTemplate>
    </asp:WebPartZone>
    <br />
    <asp:WebPartZone ID="WebPartZone2" runat="server" SkinID="wprtProfesional">
                <ZoneTemplate>
                    <uc1:ctlRendimientoUnidad ID="ctlRendimientoUnidad1" title="Rendimiento Por Unidad" runat="server" />
                </ZoneTemplate>
            </asp:WebPartZone>
    <hr />
    <h1>Resultados de busqueda</h1>
    <asp:Label ID="lblUnidad" runat="server"></asp:Label>
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="sdsEvaluaciones" EnableModelValidation="True" SkinID="GridView1">
        <Columns>
            <asp:BoundField DataField="id_equipo_asignado" InsertVisible="False" 
                SortExpression="id_equipo_asignado" >
            <ItemStyle Font-Size="0pt" Width="0px" />
            </asp:BoundField>
            <asp:BoundField DataField="recorrido" HeaderText="RECORRIDO" 
                SortExpression="recorrido" />
            <asp:BoundField DataField="grupo" HeaderText="GRUPO" SortExpression="grupo" />
            <asp:BoundField DataField="orden" HeaderText="ORDEN" SortExpression="orden" />
            <asp:BoundField DataField="fecha" DataFormatString="{0:d}" HeaderText="FECHA " 
                SortExpression="fecha" />
            <asp:BoundField DataField="nombre" HeaderText="EMPRESA" 
                SortExpression="nombre" />
            <asp:BoundField DataField="ruta" HeaderText="RUTA" SortExpression="ruta" />
            <asp:TemplateField HeaderText="TRAYECTOS">
                <ItemTemplate>
                    <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" 
                        DataSourceID="sdsTrayectos" EnableModelValidation="True" SkinID="grdAnidado">
                        <Columns>
                            <asp:BoundField DataField="trayecto" HeaderText="trayecto" 
                                SortExpression="trayecto" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsTrayectos" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        
                        SelectCommand="SELECT llave_trayectos.trayecto FROM trayectos_asignados INNER JOIN llave_trayectos ON trayectos_asignados.id_trayecto = llave_trayectos.id_trayecto WHERE (trayectos_asignados.EquipoAsignadoId = @EquipoAsignadoId)">
                        <SelectParameters>
                            <asp:Parameter Name="EquipoAsignadoId" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="primer_nombre" HeaderText="CHOFER" 
                SortExpression="primer_nombre" />
            <asp:BoundField DataField="apellido_paterno" 
                SortExpression="apellido_paterno" />
            <asp:BoundField DataField="odometroInicio" HeaderText="ODOMETRO INICIO" 
                SortExpression="odometroInicio" />
            <asp:BoundField DataField="odometroFin" HeaderText="ODOMETRO FIN" 
                SortExpression="odometroFin" />
            <asp:BoundField DataField="kms" HeaderText="KILOMETROS" SortExpression="kms" DataFormatString="{0:n2}" />
            <asp:TemplateField HeaderText="RECARGAS INTERNAS (lts.)">
                <ItemTemplate>
                    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
                        DataSourceID="sdsRecargasInternas" EnableModelValidation="True" 
                        SkinID="grdAnidado">
                        <Columns>
                            <asp:BoundField DataField="lts" HeaderText="lts" SortExpression="lts" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsRecargasInternas" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        
                        
                        
                        
                        SelectCommand="SELECT 
r.lts 
FROM 
recargas_combustible r
WHERE  (r.idEquipoAsignado = @idEquipoAsignado)
and r.id_lugar=2">
                        <SelectParameters>
                            <asp:Parameter Name="idEquipoAsignado" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="RECARGAS EXTERNAS (lts.)">
                <ItemTemplate>
                    <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" 
                        DataSourceID="sdsRecargasExternas" EnableModelValidation="True">
                        <Columns>
                            <asp:BoundField DataField="lugar" HeaderText="lugar" SortExpression="lugar" />
                            <asp:BoundField DataField="lts" HeaderText="lts" SortExpression="lts" />
                            <asp:BoundField DataField="monto" DataFormatString="{0:c}" 
                                HeaderText="cantidad" SortExpression="cantidad" />
                            <asp:BoundField DataField="ticket" HeaderText="ticket" SortExpression="folio" />
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsRecargasExternas" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        
                        
                        
                        
                        
                        SelectCommand="SELECT 
l.lugar, 
r.lts, 
r.ticket, 
r.monto 
FROM 
recargas_combustible r
INNER JOIN 
lugares_recarga l
ON r.id_lugar = l.id_lugar 
WHERE (r.idEquipoAsignado= @idEquipoAsignado)
and r.id_lugar<>2">
                        <SelectParameters>
                            <asp:Parameter Name="idEquipoAsignado" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="lts" HeaderText="LTS" DataFormatString="{0:n2}" />
            <asp:BoundField DataField="rendimiento" DataFormatString="{0:n2}" HeaderText="RENDIMIENTO" />
            <asp:TemplateField HeaderText="PARCIAL">
                <ItemTemplate>
                    <asp:CheckBox ID="chkParcial" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="INSITE">
            </asp:TemplateField>
        </Columns>
            </asp:GridView>


    <asp:SqlDataSource ID="sdsEvaluaciones" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        
        
        
        
        
        
        
        
        SelectCommand="recargasPorUnidad" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlMes" Name="mes" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="txbAno" Name="ano" PropertyName="Text" />
            <asp:ControlParameter ControlID="ddlUnidad" Name="idEquipo" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>


    <br />
    <br />
    
</asp:Content>
