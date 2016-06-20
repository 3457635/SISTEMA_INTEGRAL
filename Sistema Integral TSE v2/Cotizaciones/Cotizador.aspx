<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.master" CodeBehind="Cotizador.aspx.vb" Inherits="Sistema_Integral_TSE_v45.Cotizador" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register src="../Controles_Usuario/configurar_cotizador.ascx" tagname="configurar_cotizador" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Cotización de Servicio

   

    </h1>
    <table style="width: 220px">
        <tr>
            <td style="width: 69px">
                <asp:Button ID="btnRegresar" runat="server" CausesValidation="False" 
                    SkinID="btn" Text="Regresar" />
            </td>
            <td style="width: 68px">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" SkinID="btn" 
                    ValidationGroup="infoEmpresa" />
            </td>
            <td style="width: 69px">
                <asp:Button ID="btnVerCotizacion" runat="server" SkinID="btn" 
                    Text="Ver Cotización" CausesValidation="False" />
            </td>
            <td style="width: 69px">
                <asp:Button ID="btnConfigurar" runat="server" SkinID="btn" 
                    Text="Configurar Cotizador" CausesValidation="False" />
            </td>
        </tr>
    </table><br />

    <asp:TextBox ID="txbIdCotizacion" runat="server" Visible="False"></asp:TextBox>

    <br />
    Folio:
                ct-<asp:Label ID="lblAno" runat="server">x</asp:Label>
        -<asp:Label ID="lblConsecutivo" runat="server" Text="x"></asp:Label>
        &nbsp;
    <asp:LinkButton ID="lnkAgregarPrecio" runat="server" CausesValidation="False">+ Agregar Precio a Cotización</asp:LinkButton>
    <br />
    &nbsp;<asp:Label 
        ID="lblEtiqueta" runat="server" Text="Precio:"></asp:Label>
&nbsp;<asp:Label ID="lblLetra" runat="server" Text="x"></asp:Label>
            <br />
    <p>&nbsp;&nbsp;&nbsp; &nbsp;<asp:Label ID="lblMensaje" runat="server" SkinID="lblMensaje"></asp:Label>
    </p>
    <p>
        <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" PopupControlID="Panel1" TargetControlID="lblAno" BackgroundCssClass="ModalBackground">
        </asp:ModalPopupExtender>
    </p>
    <asp:Panel ID="Panel1" runat="server" BackColor="White">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <asp:PlaceHolder ID="PlaceHolder1" runat="server">   </asp:PlaceHolder>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Button ID="btnCerrar" runat="server" CausesValidation="False" SkinID="btn" 
            Text="Cerrar" />
    </asp:Panel>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="sdsPrecios" EnableModelValidation="True" SkinID="GridView1" 
            DataKeyNames="id_relacion">
            <Columns>
                <asp:CommandField SelectText="Eliminar" ShowSelectButton="True" />
                <asp:BoundField DataField="id_relacion" InsertVisible="False" ReadOnly="True" 
                    SortExpression="id_relacion">
                <ItemStyle Font-Size="0pt" Width="0px" />
                </asp:BoundField>
                <asp:BoundField DataField="folio" HeaderText="FOLIO" ReadOnly="True" 
                    SortExpression="folio" />
                <asp:BoundField DataField="ruta" HeaderText="RUTA" SortExpression="ruta" />
                <asp:BoundField DataField="equipo" HeaderText="EQUIPO" 
                    SortExpression="equipo" />
                <asp:BoundField DataField="precio" DataFormatString="{0:c}" HeaderText="PRECIO" 
                    SortExpression="precio" />
                <asp:BoundField DataField="vigencia" DataFormatString="{0:d}" 
                    HeaderText="VIGENCIA" SortExpression="vigencia" />
                <asp:BoundField DataField="kms" HeaderText="KMS" SortExpression="kms" />
                <asp:BoundField DataField="casetas" HeaderText="CASETAS" 
                    SortExpression="casetas" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsPrecios" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            
            
            
            
            SelectCommand="SELECT 'ct-' + CONVERT (nvarchar, cotizaciones.ano) + '-' + CONVERT (nvarchar, cotizaciones.consecutivo) + '-' + precios.letra AS folio, dbo.llave_rutas.ruta, tipo_equipos.equipo, precios.precio, cotizaciones.vigencia, precios.id_relacion, precios.kms, precios.casetas FROM cotizaciones INNER JOIN precios ON cotizaciones.id_cotizacion = precios.id_cotizacion INNER JOIN dbo.llave_rutas ON precios.id_ruta = dbo.llave_rutas.id_ruta INNER JOIN tipo_equipos ON precios.id_tipo_recurso = tipo_equipos.id_tipo_equipo WHERE (cotizaciones.id_cotizacion = @id_cotizacion) AND (precios.id_status = 5 OR precios.id_status = 9 OR precios.id_status = 10)">
            <SelectParameters>
                <asp:Parameter Name="id_cotizacion" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>Empresa:  <asp:DropDownList ID="ddlEmpresa" runat="server" DataSourceID="sdsEmpresas" 
                    DataTextField="nombre" DataValueField="id_empresa" AutoPostBack="True">
                </asp:DropDownList>
                <asp:LinkButton ID="lnkEmpresas" runat="server" 
            CausesValidation="False">Agregar Empresa</asp:LinkButton>
                <asp:SqlDataSource ID="sdsEmpresas" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    SelectCommand="SELECT [nombre], [id_empresa] FROM [empresas] WHERE (([id_status] = @id_status) OR ([id_status] = @id_status2)) and id_tipo_empresa=1 ORDER BY [nombre]">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="5" Name="id_status" Type="Int32" />
                        <asp:Parameter DefaultValue="7" Name="id_status2" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
    </p>
    <asp:Panel ID="pnlInfo" runat="server" Visible="False">
    <table style="width: 159px">
        <tr>
            <td style="width: 143px">
                &nbsp;</td>
            <td style="width: 6px">
                
            </td>
        </tr>
        </table>

   

    <asp:ModalPopupExtender ID="mdlConfiguracion" runat="server" 
        PopupControlID="Panel1" TargetControlID="lblAno" 
        BackgroundCssClass="modalBackground" Drag="True">
    </asp:ModalPopupExtender>
   
   
    <br />
    <br />
    <br />
    <table style="width: 280px">
        <tr>
            <td colspan="2" style="text-align: center; color: #33CC33;">
                Contacto</td>
        </tr>
        <tr>
            <td style="width: 142px">
                Nombre:</td>
            <td style="width: 128px">
                <asp:SqlDataSource ID="sdsContacto" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    
                    SelectCommand="SELECT personas.primer_nombre + ' ' + personas.apellido_paterno AS Expr1, contactos.id_contacto FROM contactos INNER JOIN personas ON contactos.id_persona = personas.id_persona WHERE (contactos.id_empresa = @id_empresa)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="ddlEmpresa" Name="id_empresa" 
                            PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:DropDownList ID="ddlContacto" runat="server" DataSourceID="sdsContacto" 
                            DataTextField="Expr1" DataValueField="id_contacto">
                        </asp:DropDownList>
                    </ContentTemplate>
                    <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlEmpresa" EventName="selectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False">Agregar Contacto</asp:LinkButton>
            </td>
        </tr>
        </table>
        <br />
        <table>
            <tr>
                <td style="width: 109px">
                    Tipo de Viaje:</td>
                <td style="width: 6px">
                    <asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True">
                        <asp:ListItem Selected="True" Value="0">Sencillo</asp:ListItem>
                        <asp:ListItem Value="1">Redondo</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
        </table>
        <hr />
        <h1>Registro de ruta</h1>
    
    <table style="width: 86px">
        <tr>
            <td colspan="6" style="text-align: left; color: #33CC33;">
                <span style="color: #000000"><strong><br /> 1.-</strong> Para 
                generar la ruta seleccione el origen y presion el botón &quot;+&quot; notará que la ruta 
                se va indicando en la parte de abajo.</span><br /> <span style="color: #000000">
                <strong>2.-</strong> Si el viaje incluye recolecciones puede realizar el mismo 
                procedimiento, para este caso puede agregar más de una recolección.<br />
                <strong>3.-</strong> Por último seleccione el destino y agréguelo,
                <span style="text-decoration: underline"><strong>el destino no puede ser el mismo que el origen</strong></span>, si el viaje es redondo y tendrá 
                recolecciones de regreso puede agregarlas en recolecciones de regreso. Si el 
                viaje es sencillo notará que esta opción no se habilita.
                <br />
                <strong>4.-</strong> Si llegará a equivocarse puede presionar el botón de 
                &quot;Borrar&quot; para deshacer el último punto.</span></td>
        </tr>
        <tr>
            <td style="width: 70px" bgcolor="#006600">
                &nbsp;</td>
            <td style="width: 6px" bgcolor="#006600">
                &nbsp;</td>
            <td style="width: 6px; color: #FFFFFF;" bgcolor="#006600">
                Recolecciones Ida</td>
            <td style="width: 6px" bgcolor="#006600">
                &nbsp;</td>
            <td style="width: 6px" bgcolor="#006600">
                &nbsp;</td>
            <td style="width: 6px; color: #FFFFFF;" bgcolor="#006600">
                Recolecciones Regreso</td>
        </tr>
        <tr>
            <td style="width: 70px">
                Origen:</td>
            <td style="width: 6px">
                <asp:DropDownList ID="ddlOrigen" runat="server" DataSourceID="sdsOrigen" 
                    DataTextField="ubicacion" DataValueField="id_principal">
                </asp:DropDownList>
                <asp:Button ID="btnOrigen" runat="server" CausesValidation="False" Text="+" />
                <asp:SqlDataSource ID="sdsOrigen" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    
                    SelectCommand="SELECT ubicacion, id_principal FROM ubicaciones WHERE ((id_tipo_ubicacion = 1) OR (id_tipo_ubicacion = 3))  and id_status=2 ORDER BY ubicacion">
                </asp:SqlDataSource>
            </td>
            <td style="width: 6px">
                <asp:DropDownList ID="ddlRecoleccionesIda" runat="server" 
                    DataSourceID="sdsOrigen" DataTextField="ubicacion" 
                    DataValueField="id_principal" Enabled="False">
                </asp:DropDownList>
                <asp:Button ID="btnRecoleccionIda" runat="server" CausesValidation="False" 
                    Enabled="False" Text="+" />
            </td>
            <td style="width: 6px">
                Destino:</td>
            <td style="width: 6px">
                <asp:DropDownList ID="ddlDestino" runat="server" DataSourceID="sdsOrigen" 
                    DataTextField="ubicacion" DataValueField="id_principal" Enabled="False">
                </asp:DropDownList>
                <asp:Button ID="btnDestino" runat="server" CausesValidation="False" 
                    Enabled="False" Text="+" />
            </td>
            <td style="width: 6px">
                <asp:DropDownList ID="ddlRecoleccionesRegreso" runat="server" 
                    DataSourceID="sdsOrigen" DataTextField="ubicacion" 
                    DataValueField="id_principal" Enabled="False">
                </asp:DropDownList>
                <asp:Button ID="btnRecolecccionesRegreso" runat="server" 
                    CausesValidation="False" Enabled="False" Text="+" />
            </td>
        </tr>
    </table>
        <br />
        Ruta:&nbsp;<asp:Label ID="lblRuta" runat="server"></asp:Label>
        <asp:Button ID="btnBorrar" runat="server" CausesValidation="False" 
            Text="&lt;- Borrar" BackColor="Red" BorderColor="Red" ForeColor="White" />
        <asp:TextBox ID="txbRuta" runat="server" Visible="False"></asp:TextBox>
        <br />
        <br />
        <table style="width: 287px">
            <tr>
                <td style="width: 149px">
                    Comentarios:</td>
                <td style="width: 128px">
                    <asp:TextBox ID="txbComentarios" runat="server" Height="113px" 
                        TextMode="MultiLine" Width="212px"></asp:TextBox>
                </td>
            </tr>
        </table>
        <hr />
        
        <h1>Costo Diesel</h1>
        &nbsp;<table style="width: 281px">
        
        <tr>
            <td style="width: 143px">
                Precio Diesel:</td>
            <td style="width: 128px">
                <asp:TextBox ID="txbPrecioDiesel" runat="server" Width="60px"></asp:TextBox>
            &nbsp;pesos</td>
        </tr>
        <tr>
            <td style="width: 143px">
                Tipo de Equipo:</td>
            <td style="width: 128px">
                <asp:DropDownList ID="ddlVehiculo" runat="server" AutoPostBack="True" 
                    DataSourceID="sdsTipoVehiculo" DataTextField="equipo" 
                    DataValueField="id_tipo_equipo">
                    <asp:ListItem Value="102">Tracto</asp:ListItem>
                    <asp:ListItem Value="103">Rabon</asp:ListItem>
                    <asp:ListItem Value="105">Pick Up</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="sdsTipoVehiculo" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                    SelectCommand="SELECT [equipo], [id_tipo_equipo] FROM [tipo_equipos]">
                </asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td style="width: 143px">
                Rendimiento  
                promedio del vehiculo:</td>
            <td style="width: 128px">
                <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:Label ID="lblRendimiento" runat="server"></asp:Label>kms/lt.
                  
                </ContentTemplate>
                <Triggers><asp:AsyncPostBackTrigger ControlID="ddlVehiculo" EventName="SelectedIndexChanged" /></Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <br />
        <hr />
        <h1>Costo chofer</h1>
    <table style="width: 313px">
        
        <tr>
            <td style="width: 169px">
                Costo por kilometro:</td>
            <td style="width: 128px">
                <asp:Label ID="lblCostoxKilometro" runat="server"></asp:Label>
            &nbsp;pesos</td>
        </tr>
        <tr>
            <td style="width: 169px">
                Tarifa
                <br />
                Chofer</td>
            <td style="width: 128px">
                <asp:Label ID="lblTarifaChofer" runat="server"></asp:Label>
                %</td>
        </tr>
    </table>
    <br />
        <hr />
    <table style="width: 238px">
        <tr>
            <td style="width: 66px">
                kilometros solo Ida:</td>
            <td style="width: 128px">
                <asp:TextBox ID="txbKms" runat="server">0</asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 66px">
                Casetas solo Ida:</td>
            <td style="width: 128px">
                <asp:TextBox ID="txbCasetas" runat="server">0</asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 66px">
                Descuento:</td>
            <td style="width: 128px">
                <asp:TextBox ID="txbDescuento" runat="server">0</asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 66px">
                Incremento:</td>
            <td style="width: 128px">
                <asp:TextBox ID="txbIncremento" runat="server">0</asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 66px">
                Tipo de Moneda:</td>
            <td style="width: 128px">
                <asp:DropDownList ID="ddlMoneda" runat="server">
                    <asp:ListItem Value="4">m.n.</asp:ListItem>
                    <asp:ListItem Value="5">dolares</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td style="width: 66px">
                Tipo de Cambio :</td>
            <td style="width: 128px">
                <asp:TextBox ID="txbTipoCambio" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 66px">
                Vigencia de cotización:</td>
            <td style="width: 128px">
                <asp:Label ID="lblVigencia" runat="server"></asp:Label>
                &nbsp;meses</td>
        </tr>
        <tr>
            <td style="width: 66px">Vigencia de Precio</td>
            <td style="width: 128px">
                <asp:TextBox ID="txbCaducidadPrecio" runat="server"></asp:TextBox>
                <asp:CalendarExtender ID="clrCaducidadPrecio" runat="server" Format="dd/MM/yyyy" Enabled="True" TargetControlID="txbCaducidadPrecio">
                </asp:CalendarExtender>
            </td>
        </tr>
    </table>
    <br />
        Se factura en dolares: 
    <asp:CheckBox ID="ckbFacturaDolares" runat="server" />
        <br />
        <br />
        <table class="style5">
            <tr>
                <td class="style6">
                    Otros Conceptos:</td>
                <td class="style7">
                    <asp:DropDownList ID="ddlConceptos" runat="server" DataSourceID="sdsConceptos" 
                        DataTextField="concepto" DataValueField="ConceptoId" Height="16px" 
                        Width="152px">
                    </asp:DropDownList>
                    <asp:SqlDataSource ID="sdsConceptos" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
                        SelectCommand="SELECT [concepto], [ConceptoId] FROM [Conceptos] WHERE ([EstatusId] = @EstatusId)">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="5" Name="EstatusId" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td class="style7">
                    <asp:LinkButton ID="lnkConceptos" runat="server">Modificar Conceptos</asp:LinkButton>
                </td>
                <td class="style7">
                    Monto:</td>
                <td class="style7">
                    <asp:TextBox ID="txbCantidad" runat="server"></asp:TextBox>
                </td>
                <td class="style7">
                    <asp:Button ID="btnAgregar" runat="server" SkinID="btn" Text="Agregar" />
                </td>
            </tr>
        </table>
        <br />
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False"  
            DataSourceID="sdsOtrosCargos" EnableModelValidation="True" 
            AutoGenerateDeleteButton="True" DataKeyNames="CargoId">
            <Columns>
                <asp:BoundField DataField="CargoId" InsertVisible="False" ReadOnly="True" 
                    SortExpression="CargoId" />
                <asp:BoundField DataField="concepto" HeaderText="CONCEPTO" 
                    SortExpression="concepto" />
                <asp:BoundField DataField="cargo" HeaderText="CARGO" SortExpression="cargo" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="sdsOtrosCargos" runat="server" 
            ConnectionString="<%$ ConnectionStrings:tse-erpConnectionString2 %>" 
            DeleteCommand="DELETE FROM [CargosAdicionales] WHERE [CargoId] = @CargoId" 
            InsertCommand="INSERT INTO [CargosAdicionales] ([ConceptoId], [RelacionId], [cargo]) VALUES (@ConceptoId, @RelacionId, @cargo)" 
            SelectCommand="SELECT CargosAdicionales.cargo, Conceptos.concepto, CargosAdicionales.CargoId FROM CargosAdicionales INNER JOIN Conceptos ON CargosAdicionales.ConceptoId = Conceptos.ConceptoId where relacionId is null" 
            
            UpdateCommand="UPDATE [CargosAdicionales] SET [ConceptoId] = @ConceptoId, [RelacionId] = @RelacionId, [cargo] = @cargo WHERE [CargoId] = @CargoId">
            <DeleteParameters>
                <asp:Parameter Name="CargoId" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ConceptoId" Type="Int32" />
                <asp:Parameter Name="RelacionId" Type="Int32" />
                <asp:Parameter Name="cargo" Type="Decimal" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="ConceptoId" Type="Int32" />
                <asp:Parameter Name="RelacionId" Type="Int32" />
                <asp:Parameter Name="cargo" Type="Decimal" />
                <asp:Parameter Name="CargoId" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        <hr />
    <h1>Costo de operación</h1>
    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <table style="width: 76px">
                <tr>
                    <td style="width: 60px">
                        Casetas:</td>
                    <td style="width: 6px">
                        <asp:Label ID="lblCasetas" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 60px">
                        Diesel:</td>
                    <td style="width: 6px">
                        <asp:Label ID="lblDiesel" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 60px">
                        Chofer:</td>
                    <td style="width: 6px">
                        <asp:Label ID="lblChofer" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 60px">
                        Costo de Operación Ida:</td>
                    <td style="width: 6px">
                        <asp:Label ID="lblCosto" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 60px">
                        Otros Conceptos:</td>
                    <td style="width: 6px">
                        <asp:Label ID="lblOtros" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 60px">
                        Precio:</td>
                    <td style="width: 6px">
                        <asp:Label ID="lblPrecio" runat="server"></asp:Label>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td style="width: 60px">
                        &nbsp;</td>
                    <td style="width: 6px">
                        <asp:Label ID="lblPrecioDlls" runat="server"></asp:Label>
                        <asp:Label ID="lblMoneda" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                </tr>
            </table>
            <hr />
        </ContentTemplate>
        <Triggers><asp:AsyncPostBackTrigger ControlID="ImageButton1" EventName="Click" /></Triggers>
    </asp:UpdatePanel>
    <br />
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" 
        AssociatedUpdatePanelID="UpdatePanel1">
        <ProgressTemplate>
            <asp:Image ID="Image1" runat="server" 
                ImageUrl="~/imagenes/updateProgress.gif" />
            Por favor espere...
        </ProgressTemplate>
    </asp:UpdateProgress>
    <br />
    <br />
    <asp:ImageButton ID="ImageButton1" runat="server" SkinID="ibtnActualizar" 
        style="height: 16px; width: 14px;" />
&nbsp;<span style="color: #0000FF">Generar Precio...</span><br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    </asp:Panel>
    

</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="Head">
    <style type="text/css">
        .style5
        {
            width: 309px;
        }
        .style6
        {
            width: 122px;
        }
        .style7
        {
            width: 177px;
        }
    </style>
</asp:Content>

