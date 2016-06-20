<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="IndicadorKm.aspx.vb" Inherits="Sistema_Integral_TSE_v45.IndicadorKm" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Indicadores de kms recorridos</h1>
    <table>
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" Text="Fecha inicio"></asp:Label>
                <asp:TextBox ID="txtFechaInicio" runat="server"></asp:TextBox>
                <asp:CalendarExtender ID="CalendarExtender1"
                    runat="server" TargetControlID="txtFechaInicio" Format="yyyy/MM/dd">
                </asp:CalendarExtender>
                <asp:CalendarExtender ID="CalendarExtender2"
                    runat="server" TargetControlID="txtFechafin" Format="yyyy/MM/dd">
                </asp:CalendarExtender>
                <asp:Label ID="Label2" runat="server" Text="Fecha fin"></asp:Label>
                <asp:TextBox ID="txtFechafin" runat="server"></asp:TextBox>
                <asp:Button ID="btnConsultar" runat="server" PostBackUrl="~/Auditor/IndicadorKm.aspx" Text="Consultar" />
                <asp:Label ID="Label3" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>

                <asp:Chart ID="Chart1" runat="server" BorderlineColor="Black" BorderlineWidth="0" DataSourceID="sdsKmTotales" Palette="None" Width="1146px">
                    <Series>
                        <asp:Series Name="Kms" IsValueShownAsLabel="True" LabelFormat="{0:n0}" Legend="Legend1" MapAreaAttributes="#VAL{C2}" XValueMember="Unidad" YValueMembers="Kms_Unidad">
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
                        <asp:Title Font="Microsoft Sans Serif, 11pt" Name="Title1" Text="Km recorridos por unidad">
                        </asp:Title>
                    </Titles>
                </asp:Chart>

            </td>

        </tr>
        <tr><td>

                <asp:Chart ID="Chart3" runat="server" BorderlineColor="Black" BorderlineWidth="0" DataSourceID="sdsKmChoferInd" Palette="Bright" Width="1146px">
                    <Series>
                        <asp:Series Name="Kms" IsValueShownAsLabel="True" LabelFormat="{0:n0}" Legend="Legend1" MapAreaAttributes="#VAL{C2}" XValueMember="nombre" YValueMembers="kms" LabelAngle="45">
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
                        <asp:Title Font="Microsoft Sans Serif, 11pt" Name="Title1" Text="Km recorridos por chofer">
                        </asp:Title>
                    </Titles>
                </asp:Chart>

            </td></tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="sdsKmTotales" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT  Economico as Unidad,  (max(odometro * case when economico in ('21') then 1.609 else 1 end) - min(odometro * case when economico in ('21') then 1.609 else 1 end)) as Kms_Unidad
FROM vista_KmsUnidad
WHERE (fecha &gt;= @dFechaInicio)  AND (fecha&lt; DATEADD(Day, 1, @fecha2))  AND id_status &lt;&gt; 5 and id_status &lt;&gt; 3 and tipo_fecha = 2
group by  economico
ORDER by  kms_unidad Desc">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtFechaInicio" Name="dFechainicio" PropertyName="Text" Type="DateTime" />
                        <asp:ControlParameter ControlID="txtFechafin" Name="fecha2" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsKmChofer" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT   (max(odometro * case when economico in ('21') then 1.609 else 1 end) - min(odometro * case when economico in ('21') then 1.609 else 1 end)) as kms

,   (primer_nombre +' '+ apellido_paterno + ' ' +economico ) as nombre
FROM vista_KmsUnidad
WHERE fecha &gt;= @dFechaInicio AND fecha&lt; DATEADD(Day, 1,@fecha2 ) AND id_status &lt;&gt; 5 and id_status &lt;&gt; 3 and tipo_fecha=2
group by  economico ,   primer_nombre, apellido_paterno
order by nombre">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtFechaInicio" Name="dFechaInicio" PropertyName="Text" />
                        <asp:ControlParameter ControlID="txtFechafin" Name="fecha2" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="sdsKmChoferInd" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT SUM(kms) AS kms, nombre AS nombre
FROM (
    SELECT   (MAX(odometro * CASE WHEN economico in ('21') THEN 1.609 ELSE 1 END) - MIN(odometro * CASE WHEN economico in ('21') THEN 1.609 ELSE 1 END)) AS kms
    ,   (primer_nombre +' '+ apellido_paterno  ) AS nombre
    FROM vista_KmsUnidad
    WHERE fecha &gt;=@dFechaInicio AND fecha&lt; DATEADD(Day, 1,@fecha2 ) AND id_status &lt;&gt; 5 and id_status &lt;&gt; 3 and tipo_fecha=2
    GROUP BY  economico ,   primer_nombre, apellido_paterno
    ) AS tabla GROUP BY nombre ORDER BY KMS DESC">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtFechaInicio" Name="dFechaInicio" PropertyName="Text" />
                        <asp:ControlParameter ControlID="txtFechafin" Name="fecha2" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>

        </tr>
        <tr>
            <td>

                <asp:Chart ID="Chart2" runat="server" BorderlineColor="Black" BorderlineWidth="0" DataSourceID="sdsKmChofer" Palette="Pastel" Width="701px" Height="784px">
                    <Series>
                        <asp:Series Name="Kms" IsValueShownAsLabel="True" LabelFormat="{0:n0}" Legend="Legend1" MapAreaAttributes="#VAL{C2}" XValueMember="nombre" YValueMembers="kms" ChartType="Bar">
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
                        <asp:Title Font="Microsoft Sans Serif, 11pt" Name="Title1" Text="Km recorridos por Chofer/Unidad">
                        </asp:Title>
                    </Titles>
                </asp:Chart>
                </td>
            
                <tr>

                    <td>
                        <table>
                            <tr>
                                <td>Tracto</td>
                                <td>Pick Up</td>
                                <td>Rabón</td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="sdsTracto" SkinID="gridviewgreen">
                                        <Columns>
                                            <asp:BoundField DataField="Economico" HeaderText="Economico" SortExpression="Economico" />
                                            <asp:BoundField DataField="Kms" HeaderText="Kms" ReadOnly="True" SortExpression="Kms" />
                                        </Columns>
                                    </asp:GridView>

                                    <asp:SqlDataSource ID="sdsTracto" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT  Economico,  (max(odometro * case when economico in ('21') then 1.609 else 1 end) - min(odometro * case when economico in ('21') then 1.609 else 1 end)) as Kms

FROM vista_KmsUnidad
WHERE fecha &gt;= @fecha1 AND fecha&lt; DATEADD(Day, 1,@fecha2 ) AND id_status &lt;&gt; 5 and id_status &lt;&gt; 3 AND equipo = 'Tracto' AND tipo_fecha = 2
group by  economico">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="txtFechaInicio" Name="fecha1" PropertyName="Text" />
                                            <asp:ControlParameter ControlID="txtFechafin" Name="fecha2" PropertyName="Text" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>

                                </td>
                                <td>
                                    <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="sdsPickUp" SkinID="gridviewgreen">
                                        <Columns>
                                            <asp:BoundField DataField="Economico" HeaderText="Economico" SortExpression="Economico" />
                                            <asp:BoundField DataField="Kms" HeaderText="Kms" ReadOnly="True" SortExpression="Kms" />
                                        </Columns>
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="sdsPickUp" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT  Economico,  (max(odometro * case when economico in ('21') then 1.609 else 1 end) - min(odometro * case when economico in ('21') then 1.609 else 1 end)) as Kms

FROM vista_KmsUnidad
WHERE fecha &gt;= @fecha1 AND fecha&lt; DATEADD(Day, 1,@fecha2 ) AND id_status &lt;&gt; 5 and id_status &lt;&gt; 3 AND equipo = 'Pick Up' AND tipo_fecha = 2
group by  economico">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="txtFechaInicio" Name="fecha1" PropertyName="Text" />
                                            <asp:ControlParameter ControlID="txtFechafin" Name="fecha2" PropertyName="Text" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>

                                </td>
                                <td>


                                    <asp:GridView ID="GridView3" runat="server" Width="240px" AutoGenerateColumns="False" DataSourceID="sdsRabon" SkinID="gridviewgreen">
                                        <Columns>
                                            <asp:BoundField DataField="Economico" HeaderText="Economico" SortExpression="Economico" />
                                            <asp:BoundField DataField="Kms" HeaderText="Kms" ReadOnly="True" SortExpression="Kms" />
                                        </Columns>
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="sdsRabon" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT  Economico,  (max(odometro * case when economico in ('21') then 1.609 else 1 end) - min(odometro * case when economico in ('21') then 1.609 else 1 end)) as Kms

FROM vista_KmsUnidad
WHERE fecha &gt;= @fecha1 AND fecha&lt; DATEADD(Day, 1,@fecha2 ) AND id_status &lt;&gt; 5 and id_status &lt;&gt; 3 AND equipo = 'Rabon' AND tipo_fecha = 2
group by  economico">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="txtFechaInicio" Name="fecha1" PropertyName="Text" />
                                            <asp:ControlParameter ControlID="txtFechafin" Name="fecha2" PropertyName="Text" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>


                                </td>
                            </tr>
                        </table>
                    </td>




                </tr>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="sdsDetalle" SkinID="gridviewgreen" AllowSorting="True">
                    <Columns>
                        <asp:TemplateField HeaderText="No.">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                        <asp:BoundField DataField="ruta" HeaderText="ruta" SortExpression="ruta" />
                        <asp:BoundField DataField="Consecutivo" HeaderText="Consecutivo" SortExpression="Consecutivo" />
                        <asp:BoundField DataField="Cliente" HeaderText="Cliente" SortExpression="Cliente" />
                        <asp:BoundField DataField="Fecha inicio" HeaderText="Fecha inicio" SortExpression="Fecha inicio" />
                        <asp:BoundField DataField="Fecha cierre" HeaderText="Fecha cierre" SortExpression="Fecha cierre" />
                        <asp:BoundField DataField="Economico" HeaderText="Economico" SortExpression="Economico" />
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre" />
                        <asp:BoundField DataField="Apellido" HeaderText="Apellido" SortExpression="Apellido" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsDetalle" runat="server" ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" SelectCommand="SELECT DISTINCT [ruta]
, [Consecutivo]
, [nombre] as Cliente
--, (select distinct [fecha] from vista_kmsunidad vkms where vkms.id_viaje = vkm.id_viaje and tipo_fecha=1) as 'Fecha inicio'
, inicioreal as 'Fecha inicio'
,  fecha as 'Fecha cierre'
, [Economico]
, [primer_nombre] as Nombre
, [apellido_paterno] as Apellido 
FROM [vista_KmsUnidad] vkm
WHERE ([fecha] &gt;= @fecha1) AND ([fecha] &lt; DATEADD(Day, 1,@fecha2 ))  AND ([tipo_fecha] = @tipo_fecha)
">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtFechaInicio" Name="fecha1" PropertyName="Text" Type="DateTime" />
                        <asp:ControlParameter ControlID="txtFechafin" Name="fecha2" PropertyName="Text" />
                        <asp:Parameter DefaultValue="2" Name="tipo_fecha" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>

            

        </tr>
    </table>
</asp:Content>
