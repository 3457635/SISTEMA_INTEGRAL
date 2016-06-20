<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="autorizar_gastos.aspx.vb" Inherits="Sistema_Integral_TSE_v45.autorizar_gastos" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%--<%@ Register assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>--%>
<%@ Register src="../Controles_Usuario/ctlGraficaEgresos.ascx" tagname="ctlGraficaEgresos" tagprefix="uc1" %>
<%@ Register src="../Controles_Usuario/ctlGraficaDistribucionEgresos.ascx" tagname="ctlGraficaDistribucionEgresos" tagprefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Egresos</h1>
 <asp:CollapsiblePanelExtender ID="CollapsiblePanelExtender3" runat="server"
      TargetControlID="pnlIndicadores"
    CollapsedSize="0"
    ExpandedSize="370"
    Collapsed="True"
    ExpandControlID="LinkButton3"
    CollapseControlID="LinkButton3"
    AutoCollapse="False"
    AutoExpand="False"
    ScrollContents="True"
    TextLabelID="Label3"
    CollapsedText="(Click para mostrar)"
    ExpandedText="(Click para ocultar)" 
    ImageControlID="Image2"
    ExpandedImage="~/imagenes/abajo.png"
    CollapsedImage="~/imagenes/adelante.png"
    ExpandDirection="Vertical">
    </asp:CollapsiblePanelExtender>
<div style="background-image: url('../imagenes/banner.jpg'); height:35px;width:600px; text-align: center;" >     
        <asp:Label ID="Label3" runat="server" Font-Size="Smaller"></asp:Label>
    &nbsp;
    <asp:LinkButton ID="LinkButton3" runat="server" Font-Size="Large" ForeColor="Black">Indicadores</asp:LinkButton> &nbsp; 
        <asp:Image
        ID="Image2" runat="server" Height="20px" Width="20px" />
    </div>

    <asp:Panel ID="pnlIndicadores" runat="server">
    <table style="width: 100%">
        <tr>
            <td>
                <uc2:ctlGraficaDistribucionEgresos ID="ctlGraficaDistribucionEgresos1" 
                    runat="server" />
                <uc1:ctlGraficaEgresos ID="ctlGraficaEgresos1" runat="server" />
            </td>
        </tr>
    </table>    
    </asp:Panel><br />
    <asp:CollapsiblePanelExtender ID="CollapsiblePanelExtender2" runat="server"
      TargetControlID="pnlResumen"
    CollapsedSize="0"
    ExpandedSize="300"
    Collapsed="True"
    ExpandControlID="LinkButton2"
    CollapseControlID="LinkButton2"
    AutoCollapse="False"
    AutoExpand="False"
    ScrollContents="True"
    TextLabelID="Label2"
    CollapsedText="(Click para mostrar)"
    ExpandedText="(Click para ocultar)" 
    ImageControlID="Image4"
    ExpandedImage="~/imagenes/abajo.png"
    CollapsedImage="~/imagenes/adelante.png"
    ExpandDirection="Vertical">
    </asp:CollapsiblePanelExtender>
    
    <div style="background-image: url('../imagenes/banner.jpg'); height:35px;width:600px; text-align: center;" >     
        <asp:Label ID="Label2" runat="server" Font-Size="Smaller"></asp:Label>
    &nbsp;
    <asp:LinkButton ID="LinkButton2" runat="server" Font-Size="Large" ForeColor="Black">Resumen</asp:LinkButton> &nbsp; 
        <asp:Image
        ID="Image4" runat="server" Height="20px" Width="20px" />
    </div>
    <asp:Panel ID="pnlResumen" runat="server" GroupingText="* Resumen de Egresos">
        <table>
            <tr>
                <td style="width: 57px">
                    <asp:ImageButton ID="ImageButton1" runat="server" 
                        ImageUrl="~/imagenes/help.png" SkinID="ibtnHelp" />
                </td>
                <td style="text-align: left">
                    <strong>Lote No.</strong>
                    <asp:Label ID="lblLote" runat="server" style="font-weight: 700"></asp:Label>
                </td>
            </tr>
        </table>
       <br />
        <table style="width: 509px">
            <tr>
                <td style="width: 287px" bgcolor="#CCFFCC">
                    Egreso Anterior:</td>
                <td style="width: 55px" bgcolor="#CCFFCC">
                    <asp:Label ID="lblEgresoAnterior" runat="server" Text="$ 0.00"></asp:Label>
                </td>
                <td style="width: 103px" bgcolor="#CCFFCC">
                    Egreso del Mes:</td>
                <td bgcolor="#CCFFCC" style="width: 46px">
                    <asp:Label ID="lblEgresoActual" runat="server" Text="$ 0.00"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width: 287px">
                    Lote Solicitado Anteriormente:</td>
                <td style="width: 55px">
                    <asp:Label ID="lblLoteAnterior" runat="server" Text="$ 0.00"></asp:Label>
                </td>
                <td style="width: 103px">
                    Egresos del Año:</td>
                <td style="width: 46px">
                    <asp:Label ID="lblInfo8" runat="server" Text="$ 0.00"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width: 287px" bgcolor="#CCFFCC">
                    Pagos del Lote Anterior:</td>
                <td style="width: 55px" bgcolor="#CCFFCC">
                    <asp:Label ID="lblEgresoEjecutado" runat="server" Text="$ 0.00"></asp:Label>
                </td>
                <td style="width: 103px" bgcolor="#CCFFCC">
                    Lote Actual:</td>
                <td bgcolor="#CCFFCC" style="width: 46px">
                    <asp:Label ID="lblInfo7" runat="server" Text="$ 0.00"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="width: 287px">
                    Pendientes de pago:</td>
                <td style="width: 55px">
                    <asp:Label ID="lblEgresoPendiente" runat="server" Text="$ 0.00"></asp:Label>
                </td>
                <td style="width: 103px">
                    &nbsp;</td>
                <td style="width: 46px">
                    &nbsp;</td>
            </tr>
            <tr>
                <td style="width: 287px" bgcolor="#CCFFCC">
                    Pagos Pendientes Acumulados:</td>
                <td style="width: 55px" bgcolor="#CCFFCC">
                    <asp:Label ID="lblEgresoAcumulado" runat="server" Text="$ 0.00"></asp:Label>
                </td>
                <td style="width: 103px" bgcolor="#CCFFCC">
                    &nbsp;</td>
                <td bgcolor="#CCFFCC" style="width: 46px">
                    &nbsp;</td>
            </tr>
        </table>
    </asp:Panel>
    <br />
    <asp:CollapsiblePanelExtender ID="CollapsiblePanelExtender4" runat="server"
      TargetControlID="pnlListado"
    CollapsedSize="0"
    ExpandedSize="700"
    Collapsed="True"
    ExpandControlID="LinkButton4"
    CollapseControlID="LinkButton4"
    AutoCollapse="False"
    AutoExpand="False"
    ScrollContents="True"
    TextLabelID="Label4"
    CollapsedText="(Click para mostrar)"
    ExpandedText="(Click para ocultar)" 
    ImageControlID="Image5"
    ExpandedImage="~/imagenes/abajo.png"
    CollapsedImage="~/imagenes/adelante.png"
    ExpandDirection="Vertical">
    </asp:CollapsiblePanelExtender>
    <div style="background-image: url('../imagenes/banner.jpg'); height:35px;width:600px; text-align: center;" >     
        <asp:Label ID="Label4" runat="server" Font-Size="Smaller"></asp:Label>
    &nbsp;
    <asp:LinkButton ID="LinkButton4" runat="server" Font-Size="Large" ForeColor="Black">Autorizar Egresos</asp:LinkButton> &nbsp; 
        <asp:Image
        ID="Image5" runat="server" Height="20px" Width="20px" />
    </div>


    <asp:Panel ID="pnlListado" runat="server" GroupingText="* Autorizar Egresos">
    <p>
        Total autorizado:<asp:Label ID="lblGastos" runat="server" Text="0"></asp:Label>
    </p>
    <p>
        <asp:Button ID="Button1" runat="server" Text="Guardar" />
    </p>
    <p>
        <asp:CheckBox ID="CheckBox2" runat="server" AutoPostBack="True" 
            Text="Selecionar todo" />
    </p>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        EnableModelValidation="True" SkinID="GridView1" 
        EmptyDataText="No hay más información.">
        <Columns>
            <asp:TemplateField HeaderText="AUTORIZAR">
                <ItemTemplate>                   
                    <asp:RadioButtonList ID="rbtnStatus" runat="server" Width="143px">
                        <asp:ListItem Value="5">Aceptar</asp:ListItem>
                        <asp:ListItem Value="6">Rechazar</asp:ListItem>
                        <asp:ListItem Selected="True" Value="0">Pendiente</asp:ListItem>
                    </asp:RadioButtonList>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="id_gasto" >
            <ItemStyle Font-Size="0pt" Width="0px" />
            </asp:BoundField>
            <asp:BoundField DataField="nombre" HeaderText="PROVEEDOR" />
            <asp:BoundField DataField="descripcion" HeaderText="DESCRIPCIÓN" />
            <asp:BoundField DataField="cantidad" DataFormatString="{0:c}" 
                HeaderText="IMPORTE" />
            <asp:BoundField DataField="fecha_programacion_pago" DataFormatString="{0:d}" 
                HeaderText="FECHA PAGO" />
        </Columns>
    </asp:GridView>
    <br />
        <asp:Button ID="Button2" runat="server" Text="Guardar" />
        </asp:Panel>
    <br />
    <asp:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server"
      TargetControlID="pnlHistorialEgresos"
    CollapsedSize="0"
    ExpandedSize="500"
    Collapsed="True"
    ExpandControlID="LinkButton1"
    CollapseControlID="LinkButton1"
    AutoCollapse="False"
    AutoExpand="False"
    ScrollContents="True"
    TextLabelID="Label1"
    CollapsedText="(Click para mostrar)"
    ExpandedText="(Click para ocultar)" 
    ImageControlID="Image3"
    ExpandedImage="~/imagenes/abajo.png"
    CollapsedImage="~/imagenes/adelante.png"
    ExpandDirection="Vertical"

    >
    </asp:CollapsiblePanelExtender>
    
    
    <div style="background-image: url('../imagenes/banner.jpg'); height:35px;width:600px; text-align: center;" >     
<asp:Label ID="Label1" runat="server" Font-Size="Smaller"></asp:Label>
    &nbsp;
    <asp:LinkButton ID="LinkButton1" runat="server" Font-Size="Large" ForeColor="Black">Historial</asp:LinkButton> &nbsp; 
        <asp:Image
        ID="Image3" runat="server" Height="20px" Width="20px" />
    </div>
    <asp:Panel ID="pnlHistorialEgresos" runat="server" GroupingText="*" 
        Width="597px">
        <asp:GridView ID="GridView2" runat="server" 
    AutoGenerateColumns="False" DataKeyNames="id_gasto" 
    DataSourceID="SqlDataSource1" EnableModelValidation="True" SkinID="GridView1" 
            AllowPaging="True">
            <Columns>
                <asp:CommandField ShowEditButton="True" />
                <asp:TemplateField SortExpression="aprovado">
                    <EditItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" 
                    Checked='<%# Bind("aprovado") %>' />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="nombre" HeaderText="PROVEEDOR" 
            SortExpression="nombre" />
                <asp:BoundField DataField="descripcion" 
            HeaderText="DESCRIPCIÓN" SortExpression="descripcion" />
                <asp:BoundField DataField="cantidad" 
            DataFormatString="{0:c}" HeaderText="IMPORTE" SortExpression="cantidad" />
                <asp:BoundField DataField="fecha_programacion_pago" 
            HeaderText="FECHA PAGO" SortExpression="fecha_pago" DataFormatString="{0:d}" />
                <asp:BoundField DataField="id_gasto" 
            HeaderText="id_gasto" InsertVisible="False" ReadOnly="True" 
            SortExpression="id_gasto" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>"             
            SelectCommand="SELECT gastos.id_status, dbo.empresas.nombre, gastos.descripcion, gastos.cantidad, gastos.id_gasto, proveedores_pago.fecha_programacion_pago FROM gastos INNER JOIN proveedores_pago ON gastos.id_gasto = proveedores_pago.id_gasto INNER JOIN dbo.empresas ON proveedores_pago.id_proveedor = dbo.empresas.id_empresa WHERE (gastos.id_status=5) order by proveedores_pago.fecha_programacion_pago desc" 
                                  >                           
        </asp:SqlDataSource>
    </asp:Panel>
    
    <br />
</asp:Content>
