<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="tramites_equipo.ascx.vb" Inherits="Sistema_Integral_TSE_v45.tramites_equipo" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

    
<h1>
   
    </h1>
<h1>Tramites Equipos</h1>
<telerik:RadScheduler ID="RadScheduler1" runat="server" Culture="es-MX" 
    DataDescriptionField="anotaciones" DataEndField="fin" DataKeyField="id" 
    DataRecurrenceField="ReglasRecurrencia" 
    DataRecurrenceParentKeyField="RecurrenciaPadreID" DataReminderField="Reminder" 
    DataSourceID="sdsTramites" DataStartField="inicio" DataSubjectField="asunto" 
    EnableDescriptionField="True" Height="604px" SelectedView="MonthView">
    <ResourceTypes>
        <telerik:ResourceType DataSourceID="sdsEquipo" ForeignKeyField="id_equipo" 
            KeyField="id_equipo" Name="Equipo:" TextField="equipo" />
        <telerik:ResourceType DataSourceID="sdsTramite" ForeignKeyField="id_tramite" 
            KeyField="id" Name="Tramite:" TextField="tramite" />
    </ResourceTypes>
    <Reminders Enabled="True" />
</telerik:RadScheduler>
<asp:SqlDataSource ID="sdsTramite" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
    SelectCommand="SELECT [tramite], [id] FROM [tramites]"></asp:SqlDataSource>
<asp:SqlDataSource ID="sdsEquipo" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
    SelectCommand="SELECT equipo_operacion.id_equipo, equipo_operacion.economico + ' (' + tipo_equipos.equipo + ')' AS equipo FROM equipo_operacion INNER JOIN tipo_equipos ON equipo_operacion.id_tipo_equipo = tipo_equipos.id_tipo_equipo WHERE (equipo_operacion.id_status = 5)">
</asp:SqlDataSource>
<asp:SqlDataSource ID="sdsTramites" runat="server" 
    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
    DeleteCommand="DELETE FROM [fechas_tramites_equipos] WHERE [id] = @id" 
    InsertCommand="INSERT INTO [fechas_tramites_equipos] ([inicio], [id_equipo], [id_tramite], [fin], [ReglasRecurrencia], [RecurrenciaPadreID], [anotaciones], [Reminder], [asunto]) VALUES (@inicio, @id_equipo, @id_tramite, @fin, @ReglasRecurrencia, @RecurrenciaPadreID, @anotaciones, @Reminder, @asunto)" 
    SelectCommand="SELECT * FROM [fechas_tramites_equipos]" 
    UpdateCommand="UPDATE [fechas_tramites_equipos] SET [inicio] = @inicio, [id_equipo] = @id_equipo, [id_tramite] = @id_tramite, [fin] = @fin, [ReglasRecurrencia] = @ReglasRecurrencia, [RecurrenciaPadreID] = @RecurrenciaPadreID, [anotaciones] = @anotaciones, [Reminder] = @Reminder, [asunto] = @asunto WHERE [id] = @id">
    <DeleteParameters>
        <asp:Parameter Name="id" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="inicio" Type="DateTime" />
        <asp:Parameter Name="id_equipo" Type="Int32" />
        <asp:Parameter Name="id_tramite" Type="Int32" />
        <asp:Parameter Name="fin" Type="DateTime" />
        <asp:Parameter Name="ReglasRecurrencia" Type="String" />
        <asp:Parameter Name="RecurrenciaPadreID" Type="Int32" />
        <asp:Parameter Name="anotaciones" Type="String" />
        <asp:Parameter Name="Reminder" Type="String" />
        <asp:Parameter Name="asunto" Type="String" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="inicio" Type="DateTime" />
        <asp:Parameter Name="id_equipo" Type="Int32" />
        <asp:Parameter Name="id_tramite" Type="Int32" />
        <asp:Parameter Name="fin" Type="DateTime" />
        <asp:Parameter Name="ReglasRecurrencia" Type="String" />
        <asp:Parameter Name="RecurrenciaPadreID" Type="Int32" />
        <asp:Parameter Name="anotaciones" Type="String" />
        <asp:Parameter Name="Reminder" Type="String" />
        <asp:Parameter Name="asunto" Type="String" />
        <asp:Parameter Name="id" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>

</form>


