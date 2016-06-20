<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="recargasInternas.aspx.vb" Inherits="Sistema_Integral_TSE_v45.recargasInternas" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Reporte de Recargas Internas</h1>
    <p>
        <br />
        Desde<asp:TextBox ID="txbInicio" runat="server"></asp:TextBox>
        <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="yyyy/MM/dd" 
            TargetControlID="txbInicio">
        </asp:CalendarExtender>
&nbsp;Hora
        <asp:TextBox ID="txbHoraInicio" runat="server"></asp:TextBox>
        <asp:MaskedEditExtender ID="mskHoraInicio" Mask="99:99" MaskType="Time" runat="server" TargetControlID="txbHoraInicio">
        </asp:MaskedEditExtender>
    </p>
    <p>
        Hasta<asp:TextBox ID="txbFin" runat="server"></asp:TextBox>
        <asp:CalendarExtender ID="CalendarExtender2" runat="server" Format="yyyy/MM/dd" 
            TargetControlID="txbFin">
        </asp:CalendarExtender>
&nbsp;Hora
        <asp:TextBox ID="txbHoraFin" runat="server"></asp:TextBox>
        <asp:MaskedEditExtender ID="mskHoraFin" MaskType="Time" Mask="99:99" runat="server" TargetControlID="txbHoraFin">
        </asp:MaskedEditExtender>
    </p>
    <p>
        Unidad
        <asp:DropDownList ID="ddlUnidad" runat="server" DataSourceID="sdsUnidades" DataTextField="economico" DataValueField="id_equipo" Height="21px" Width="142px">
        </asp:DropDownList>
        <asp:SqlDataSource ID="sdsUnidades" runat="server" ConnectionString="<%$ ConnectionStrings:tse_erpConnectionString2 %>" SelectCommand="SELECT [economico], [id_equipo] FROM [equipo_operacion] WHERE (([id_status] = @id_status) AND ([id_tipo_equipo] &lt; @id_tipo_equipo)) ORDER BY [economico]">
            <SelectParameters>
                <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                <asp:Parameter DefaultValue="106" Name="id_tipo_equipo" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:ImageButton ID="ibtnActualizar" runat="server" SkinID="ibtnActualizar" />
    </p>
    <p>
        &nbsp;</p>
    <p>
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
            DataSourceID="sdsRecargas" EnableModelValidation="True" ShowFooter="True">
            <Columns>
                <asp:BoundField DataField="lts" HeaderText="LITROS" SortExpression="lts" />
                <asp:BoundField DataField="economico" HeaderText="EQUIPO" 
                    SortExpression="economico" />
                <asp:BoundField DataField="Column1" HeaderText="CHOFER" SortExpression="Column1" />
                <asp:CheckBoxField DataField="recargaSinOrden" HeaderText="SIN ORDEN" SortExpression="recargaSinOrden" />
                <asp:BoundField DataField="odometro" HeaderText="ODOMETRO" 
                    SortExpression="odometro" />
                <asp:BoundField DataField="responsable" HeaderText="INSPECTOR" SortExpression="responsable" />
                <asp:BoundField DataField="fechaRecarga" HeaderText="FECHA RECARGA" 
                    SortExpression="fechaRecarga" />
                <asp:BoundField DataField="consecutivo" HeaderText="ORDEN" SortExpression="consecutivo" />
                <asp:BoundField DataField="estatus" HeaderText="ESTADO" SortExpression="estatus" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsRecargas" runat="server" 
            CancelSelectOnNullParameter="False" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT rc.lts 
,eo.economico
,p.primer_nombre+' '+p.apellido_paterno
,recargaSinOrden
,odometro
,fechaRecarga
,responsable
,o.consecutivo
,CASE WHEN v.id_status IS NULL 
  THEN 'Sin Estatus'
  ELSE ev.estatus_viaje
END as estatus
FROM recargas_combustible rc
JOIN equipo_operacion eo	ON eo.id_equipo=rc.id_equipo
JOIN empleados e		ON e.id_empleado=rc.id_chofer
JOIN personas p		ON p.id_persona=e.id_persona
left 
JOIN equipo_asignado ea	ON ea.id_equipo_asignado=rc.idEquipoAsignado
left 
JOIN viajes v		ON v.id_viaje=ea.viajeId
LEFT
JOIN ordenes o		ON o.id_orden=v.id_orden
LEFT
JOIN estatus_viajes ev	ON ev.id_status = v. id_status
WHERE rc.id_lugar = 2
AND rc.fechaRecarga BETWEEN @inicio AND @fin
AND rc.id_equipo = isnull( @idEquipo,rc.id_equipo)
AND ( v.id_status IN ( 2, 4) or v.id_status IS NULL)
ORDER BY rc.fechaRecarga DESC">
            <SelectParameters>
                <asp:Parameter Name="inicio" />
                <asp:Parameter Name="fin" />
                <asp:Parameter Name="idEquipo" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>
