<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ctlConceptosCotizacion.ascx.vb" Inherits="Sistema_Integral_TSE_v45.ctlConceptosCotizacion" %>
<p>
    Concepto:
    <asp:TextBox ID="txbConcepto" runat="server" Width="200px"></asp:TextBox>
&nbsp;<asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
&nbsp;<asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
</p>
<p>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="ConceptoId" DataSourceID="sdsConceptos" 
        EnableModelValidation="True">
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="ConceptoId" InsertVisible="False" ReadOnly="True" 
                SortExpression="ConceptoId" />
            <asp:BoundField DataField="concepto" HeaderText="CONCEPTO" 
                SortExpression="concepto" />
            <asp:TemplateField HeaderText="ESTATUS" SortExpression="EstatusId">
                <ItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sdsEstatus" 
                        DataTextField="estatus" DataValueField="id_status" Enabled="False" 
                        SelectedValue='<%# Bind("EstatusId") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsEstatus" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [estatus], [id_status] FROM [estado_activacion]">
                    </asp:SqlDataSource>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="sdsEstatus2" 
                        DataTextField="estatus" DataValueField="id_status" 
                        SelectedValue='<%# Bind("EstatusId") %>'>
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsEstatus2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [estatus], [id_status] FROM [estado_activacion]">
                    </asp:SqlDataSource>
                </EditItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsConceptos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
        DeleteCommand="DELETE FROM [Conceptos] WHERE [ConceptoId] = @ConceptoId" 
        InsertCommand="INSERT INTO [Conceptos] ([concepto], [EstatusId]) VALUES (@concepto, @EstatusId)" 
        SelectCommand="SELECT * FROM [Conceptos]" 
        UpdateCommand="UPDATE [Conceptos] SET [concepto] = @concepto, [EstatusId] = @EstatusId WHERE [ConceptoId] = @ConceptoId">
        <DeleteParameters>
            <asp:Parameter Name="ConceptoId" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="concepto" Type="String" />
            <asp:Parameter Name="EstatusId" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="concepto" Type="String" />
            <asp:Parameter Name="EstatusId" Type="Int32" />
            <asp:Parameter Name="ConceptoId" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</p>

