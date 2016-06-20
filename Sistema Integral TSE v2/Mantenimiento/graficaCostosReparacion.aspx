<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="graficaCostosReparacion.aspx.vb" Inherits="Sistema_Integral_TSE_v45.graficaCostosReparacion" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Indicadores de cantidad y costo de mantenimientos por unidad</h1>
    <table>
        <tr>
            <td >
                <asp:Label ID="Label1" runat="server" Text="Fecha inicio"></asp:Label>
                <asp:TextBox ID="TextBox1" runat="server" ToolTip="Seleccione la fecha inicial dando clic en el campo de texto"></asp:TextBox>
                <asp:CalendarExtender ID="CalendarExtender2"
        runat="server" TargetControlID="TextBox1" Format="yyyy/MM/dd">
    </asp:CalendarExtender>
                <asp:Label ID="Label3" runat="server" Text="Fecha fin"></asp:Label>
                <asp:TextBox ID="TextBox2" runat="server" ToolTip="Seleccione la fecha final dando clic en el campo de texto"></asp:TextBox>
                <asp:CalendarExtender ID="CalendarExtender1"
        runat="server" TargetControlID="TextBox2" Format="yyyy/MM/dd">
    </asp:CalendarExtender>
                <asp:Label ID="Label2" runat="server" Text="Unidad"></asp:Label>
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="sdsUnidad" DataTextField="equipo" DataValueField="equipo">
                </asp:DropDownList>
                <asp:Button ID="Button1" runat="server" PostBackUrl="~/Mantenimiento/graficaCostosReparacion.aspx" Text="Consultar" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Chart ID="Chart1" runat="server" BorderlineColor="Black" BorderlineWidth="0" DataSourceID="sdsCorrectivos" Palette="None" Width="1268px">
                    <Series>
                        <asp:Series Name="Costo en pesos" IsValueShownAsLabel="True" LabelFormat="{0:c0}" Legend="Legend1" MapAreaAttributes="#VAL{C2}" XValueMember="economico" YValueMembers="costo">
                        </asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1" BorderDashStyle="Solid" BorderWidth="0">
                            <AxisY LineWidth="0">
                                <MajorGrid Enabled="False" LineWidth="0" />
                            </AxisY>
                            <AxisX Interval="1">
                                <MajorGrid Enabled="False" LineWidth="0" />
                                <MinorGrid LineWidth="0" />
                            </AxisX>
                            <AxisX2>
                                <MajorGrid Enabled="False" />
                            </AxisX2>
                            <AxisY2>
                                <MajorGrid Enabled="False" />
                            </AxisY2>
                        </asp:ChartArea>
                    </ChartAreas>
                    <Legends>
                        <asp:Legend AutoFitMinFontSize="5" IsTextAutoFit="False" LegendStyle="Column" Name="Legend1">
                        </asp:Legend>
                    </Legends>
                    <Titles>
                        <asp:Title Font="Microsoft Sans Serif, 11pt" Name="Title1" Text="Costos de correctivos por unidad ">
                        </asp:Title>
                    </Titles>
                </asp:Chart>
            </td>
            
        </tr>
        <tr><td>
                <asp:Chart ID="Chart3" runat="server" BorderlineColor="Black" BorderlineWidth="0" DataSourceID="sdsCorrectivosPorUnidad" Palette="Chocolate" Width="1268px">
                    <Series>
                        <asp:Series Name="Cantidad de correctivos" IsValueShownAsLabel="True" LabelFormat="{0:n0}" Legend="Legend1" MapAreaAttributes="#VAL{C2}" XValueMember="economico" YValueMembers="total">
                        </asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1" BorderDashStyle="Solid" BorderWidth="0">
                            <AxisY LineWidth="0">
                                <MajorGrid Enabled="False" LineWidth="0" />
                            </AxisY>
                            <AxisX Interval="1">
                                <MajorGrid Enabled="False" LineWidth="0" />
                                <MinorGrid LineWidth="0" />
                            </AxisX>
                            <AxisX2>
                                <MajorGrid Enabled="False" />
                            </AxisX2>
                            <AxisY2>
                                <MajorGrid Enabled="False" />
                            </AxisY2>
                        </asp:ChartArea>
                    </ChartAreas>
                    <Legends>
                        <asp:Legend AutoFitMinFontSize="5" IsTextAutoFit="False" LegendStyle="Column" Name="Legend1">
                        </asp:Legend>
                    </Legends>
                    <Titles>
                        <asp:Title Font="Microsoft Sans Serif, 11pt" Name="Title1" Text="Cantidad de correctivos por unidad ">
                        </asp:Title>
                    </Titles>
                </asp:Chart>
            </td></tr>
        <tr><td>   
                &nbsp;<hr/></td></tr>
        <tr><td>   
                <asp:Chart ID="Chart2" runat="server" BorderlineColor="Black" BorderlineWidth="0" DataSourceID="sdsPreventivos" Palette="Pastel" Width="1272px">
                    <Series>
                        <asp:Series Name="Costo en pesos" IsValueShownAsLabel="True" LabelFormat="{0:c0}" Legend="Legend1" MapAreaAttributes="#VAL{C2}" XValueMember="economico" YValueMembers="costo">
                        </asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1" BorderDashStyle="Solid" BorderWidth="0">
                            <AxisY LineWidth="0">
                                <MajorGrid Enabled="False" LineWidth="0" />
                            </AxisY>
                            <AxisX Interval="1">
                                <MajorGrid Enabled="False" LineWidth="0" />
                                <MinorGrid LineWidth="0" />
                            </AxisX>
                            <AxisX2>
                                <MajorGrid Enabled="False" />
                            </AxisX2>
                            <AxisY2>
                                <MajorGrid Enabled="False" />
                            </AxisY2>
                        </asp:ChartArea>
                    </ChartAreas>
                    <Legends>
                        <asp:Legend AutoFitMinFontSize="5" IsTextAutoFit="False" LegendStyle="Column" Name="Legend1">
                        </asp:Legend>
                    </Legends>
                    <Titles>
                        <asp:Title Font="Microsoft Sans Serif, 11pt" Name="Title1" Text="Costos de preventivos por unidad">
                        </asp:Title>
                    </Titles>
                </asp:Chart>
            </td></tr>
        <tr><td>   
                <asp:Chart ID="Chart4" runat="server" BorderlineColor="Black" BorderlineWidth="0" DataSourceID="sdsPreventivosPorUnidad" Palette="SeaGreen" Width="1272px">
                    <Series>
                        <asp:Series Name="Cantidad de preventivos" IsValueShownAsLabel="True" LabelFormat="{0:n0}" Legend="Legend1" MapAreaAttributes="#VAL{C2}" XValueMember="economico" YValueMembers="total">
                        </asp:Series>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1" BorderDashStyle="Solid" BorderWidth="0">
                            <AxisY LineWidth="0">
                                <MajorGrid Enabled="False" LineWidth="0" />
                            </AxisY>
                            <AxisX Interval="1">
                                <MajorGrid Enabled="False" LineWidth="0" />
                                <MinorGrid LineWidth="0" />
                            </AxisX>
                            <AxisX2>
                                <MajorGrid Enabled="False" />
                            </AxisX2>
                            <AxisY2>
                                <MajorGrid Enabled="False" />
                            </AxisY2>
                        </asp:ChartArea>
                    </ChartAreas>
                    <Legends>
                        <asp:Legend AutoFitMinFontSize="5" IsTextAutoFit="False" LegendStyle="Column" Name="Legend1">
                        </asp:Legend>
                    </Legends>
                    <Titles>
                        <asp:Title Font="Microsoft Sans Serif, 11pt" Name="Title1" Text="Cantidad de preventivos por unidad ">
                        </asp:Title>
                    </Titles>
                </asp:Chart>
            </td></tr>
    </table>
    <asp:SqlDataSource ID="sdsCorrectivos" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="
Select   sum(r.costo) as costo,	eo.economico
	from	equipo_operacion	eo
		Join	tipo_equipos		te		On te.id_tipo_equipo = eo.id_tipo_equipo
		Join	estado_activacion	ea		On ea.id_status = eo.id_status
		Join	reparaciones		r		On eo.id_equipo = r.idequipo
		--join	reportes_fallas		rf		on rf.reporteid = r.idreporte
Where	eo.id_status = 5 and eo.id_equipo = r.idequipo 
		and		(@cunidad= 'Todos...' or te.equipo = @cunidad) And	r.fecha &gt;= @fechaini and r.fecha &lt;= @fechafin  group by eo.economico order by costo desc">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="cunidad" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="TextBox1" Name="nAño" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox1" Name="fechaini" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox2" Name="fechafin" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsPreventivos" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="Select   sum(r.costo) as costo,	eo.economico
	from		preventivos p
		Join	reparaciones r	on	r.idreparacion = p.id_reparacion
		
		
		 join equipo_operacion eo on eo.id_equipo = p.id_equipo 
		 Join	tipo_equipos		te		On te.id_tipo_equipo = eo.id_tipo_equipo
Where	eo.id_status = 5 --and eo.id_equipo = p.id_equipo 
		and		(@cunidad= 'Todos...' or te.equipo = @cunidad) And	r.fecha &gt;= @fechaini and r.fecha &lt;= @fechafin group by eo.economico order by costo desc">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="cunidad" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="TextBox1" Name="nAño" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox1" Name="fechaini" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox2" Name="fechafin" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsCorrectivosPorUnidad" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="Select   count(r.costo) as total,	eo.economico
	from	equipo_operacion	eo
		Join	tipo_equipos		te		On te.id_tipo_equipo = eo.id_tipo_equipo
		Join	estado_activacion	ea		On ea.id_status = eo.id_status
		Join	reparaciones		r		On eo.id_equipo = r.idequipo
		--join	reportes_fallas		rf		on rf.reporteid = r.idreporte
Where	eo.id_status = 5 and eo.id_equipo = r.idequipo 
	and		(@cunidad= 'Todos...' or te.equipo = @cunidad)	 And	r.fecha &gt;= @fechaini and r.fecha &lt;= @fechafin group by eo.economico order by total desc">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="cUnidad" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="TextBox1" Name="nAño" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox1" Name="fechaini" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox2" Name="fechafin" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsPreventivosPorUnidad" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="Select   count(r.costo) as total,	eo.economico
	from		preventivos p
		Join	reparaciones r	on	r.idreparacion = p.id_reparacion
		
		
		 join equipo_operacion eo on eo.id_equipo = p.id_equipo 
		 Join	tipo_equipos		te		On te.id_tipo_equipo = eo.id_tipo_equipo
Where	eo.id_status = 5 --and eo.id_equipo = p.id_equipo 
	and		(@cunidad= 'Todos...' or te.equipo = @cunidad)	 And	r.fecha &gt;= @fechaini and r.fecha &lt;= @fechafin  group by eo.economico order by total desc">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="cUnidad" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="TextBox1" Name="nAño" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox1" Name="fechaini" PropertyName="Text" />
            <asp:ControlParameter ControlID="TextBox2" Name="fechafin" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sdsUnidad" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="Select equipo from tipo_equipos"></asp:SqlDataSource>
</asp:Content>
