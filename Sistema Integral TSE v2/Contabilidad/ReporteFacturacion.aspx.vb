Public Class ReporteFacturacion
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Dim total_facturado As Decimal
    Dim iva_facturado As Decimal
    Dim retencion_facturado As Decimal
    Dim importe_facturado As Decimal
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim viajes_sin_factura = obtenerViajesSinFactura()


        lnkSinFactura.Text = viajes_sin_factura
        If Not IsPostBack Then
            Me.total_facturado = 0
            txbSerie.Text = Now.AddHours(-7).Year()
        End If
    End Sub

    

    Protected Sub grd_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grd.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("SqlDataSource1"), SqlDataSource)
            Dim sdsCajas As SqlDataSource = CType(e.Row.FindControl("sdsCajas"), SqlDataSource)
            Dim sdsFacturaOtros As SqlDataSource = CType(e.Row.FindControl("sdsOtros"), SqlDataSource)


            Dim idFactura = e.Row.Cells(0).Text

            If Not String.IsNullOrEmpty(idFactura) Then
               

                Me.total_facturado += CDec(e.Row.Cells(8).Text)
                Me.iva_facturado += CDec(e.Row.Cells(7).Text)
                'Me.retencion_facturado += CDec(e.Row.Cells(4).Text)
                Me.importe_facturado += CDec(e.Row.Cells(6).Text)

                s.SelectParameters(0).DefaultValue = idFactura
                sdsCajas.SelectParameters(0).DefaultValue = idFactura
                sdsFacturaOtros.SelectParameters(0).DefaultValue = idFactura

            End If

            If e.Row.RowType = DataControlRowType.Footer Then
                If IsNumeric(Me.total_facturado) Then
                    e.Row.Cells(7).Text = String.Format("{0:c}", Me.total_facturado)
                    e.Row.Cells(6).Text = String.Format("{0:c}", Me.iva_facturado)
                    e.Row.Cells(5).Text = String.Format("{0:c}", Me.retencion_facturado)
                    e.Row.Cells(4).Text = String.Format("{0:c}", Me.importe_facturado)
                    e.Row.Cells(6).Text = "TOTAL M.N."
                End If
            End If
        End If

    End Sub

    

    Protected Sub lnkSinFactura_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkSinFactura.Click
        Response.Redirect("~/Contabilidad/SinFactura_detalle.aspx")

    End Sub

    Protected Sub ibtnActualizar0_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ibtnActualizar0.Click
        SqlDataSource3.SelectParameters(0).DefaultValue = Nothing
        SqlDataSource3.SelectParameters(1).DefaultValue = Nothing
        SqlDataSource3.SelectParameters(2).DefaultValue = Nothing
        SqlDataSource3.SelectParameters(3).DefaultValue = Nothing
        SqlDataSource3.SelectParameters(4).DefaultValue = Nothing
        SqlDataSource3.SelectParameters(5).DefaultValue = 4
        SqlDataSource3.SelectParameters(6).DefaultValue = 3

        If Not String.IsNullOrEmpty(txbFechaInicio.Text) And Not String.IsNullOrEmpty(txbFechaFin.Text) Then
            SqlDataSource3.SelectParameters(2).DefaultValue = String.Format("{0} 00:00", txbFechaInicio.Text)
            SqlDataSource3.SelectParameters(3).DefaultValue = String.Format("{0} 23:59", txbFechaFin.Text)
            If ddlCliente.SelectedValue <> 0 Then
                SqlDataSource3.SelectParameters(0).DefaultValue = ddlCliente.SelectedValue
            End If
        End If

    End Sub
    Private Sub cargarGrid2()

        SqlDataSource3.SelectParameters(0).DefaultValue = Nothing
        SqlDataSource3.SelectParameters(1).DefaultValue = Nothing
        SqlDataSource3.SelectParameters(2).DefaultValue = Nothing
        SqlDataSource3.SelectParameters(3).DefaultValue = Nothing
        SqlDataSource3.SelectParameters(4).DefaultValue = Nothing


        If Not String.IsNullOrEmpty(txbBuscarFactura.Text) Then
            SqlDataSource3.SelectParameters(1).DefaultValue = txbBuscarFactura.Text
            txbBuscarFactura.Text = String.Empty
        Else
            If Not String.IsNullOrEmpty(txbFechaInicio.Text) And Not String.IsNullOrEmpty(txbFechaFin.Text) Then
                SqlDataSource3.SelectParameters(2).DefaultValue = txbFechaInicio.Text
                SqlDataSource3.SelectParameters(3).DefaultValue = txbFechaFin.Text
                If ddlCliente.SelectedValue = 0 Then
                    SqlDataSource3.SelectParameters(0).DefaultValue = ddlCliente.SelectedValue
                End If
            End If
        End If
    End Sub
    
    Protected Sub ibtnActualizar1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ibtnActualizar1.Click
        lblMensaje.Text = ""
        'idEmpresa
        SqlDataSource3.SelectParameters(0).DefaultValue = Nothing
        'inicio
        SqlDataSource3.SelectParameters(2).DefaultValue = Nothing
        'fin
        SqlDataSource3.SelectParameters(3).DefaultValue = Nothing
        'tipo fecha
        SqlDataSource3.SelectParameters(5).DefaultValue = 4

        If Not String.IsNullOrEmpty(txbSerie.Text) Then
            ''folio
            SqlDataSource3.SelectParameters(1).DefaultValue = txbBuscarFactura.Text
            SqlDataSource3.SelectParameters(4).DefaultValue = txbSerie.Text
            'tipo consulta'
            SqlDataSource3.SelectParameters(6).DefaultValue = 2
        Else
            ''folio
            SqlDataSource3.SelectParameters(1).DefaultValue = txbBuscarFactura.Text
            'tipo consulta'
            SqlDataSource3.SelectParameters(6).DefaultValue = 1
        End If

        Dim buscarFactura = (From facturas In db.facturas
                               Join cfdis In db.cfdis On facturas.id_factura Equals cfdis.idFactura
                               Where cfdis.serie = txbSerie.Text And facturas.folio = Convert.ToInt32(txbBuscarFactura.Text.ToString())
                               Select facturas.id_factura).FirstOrDefault()

        Dim buscarFechaPago = (From consulta In db.fechas_facturacions
                                    Where consulta.id_factura = Convert.ToInt32(buscarFactura.ToString()) And
                                    consulta.fecha.tipo_fecha = 7
                                    Select consulta).FirstOrDefault()

        If Not buscarFechaPago Is Nothing Then
            ctlCancelarCFDI1.habilitaBoton(False)
        Else
            ctlCancelarCFDI1.habilitaBoton(True)
        End If
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ibtnPrint.Click
        If RadioButtonList1.SelectedValue = 0 Then
            Response.Redirect(String.Format("Contraresibo.aspx?inicio={0:MM/dd/yyyy} 00:00&fin={1:MM/dd/yyyy} 23:59&cliente={2}&tipoConsulta={3}", txbFechaInicio.Text, txbFechaFin.Text, ddlCliente.SelectedValue, 3))
        ElseIf RadioButtonList1.SelectedValue = 1 Then
            Response.Redirect("Contraresibo_sin_importe.aspx?inicio=" + txbFechaInicio.Text + "&fin=" + txbFechaFin.Text + "&cliente=" + ddlCliente.SelectedValue)

        ElseIf RadioButtonList1.SelectedValue = 2 Then
            Response.Redirect("Contraresibo_TRW.aspx?inicio=" + txbFechaInicio.Text + " 00:00&fin=" + txbFechaFin.Text + " 23:59&cliente=" + ddlCliente.SelectedValue)

        ElseIf RadioButtonList1.SelectedValue = 3 Then
            Response.Redirect("ContraresiboCaja.aspx?inicio=" + txbFechaInicio.Text + " 00:00&fin=" + txbFechaFin.Text + " 23:59&cliente=" + ddlCliente.SelectedValue)
        ElseIf RadioButtonList1.SelectedValue = 4 Then
            Response.Redirect(String.Format("ContrareciboGlobal.aspx?inicio={0:MM/dd/yyyy} 00:00&fin={1:MM/dd/yyyy} 23:59&cliente={2}&tipoConsulta={3}", txbFechaInicio.Text, txbFechaFin.Text, ddlCliente.SelectedValue, 3))

        End If

        ''Response.Write("<script type='text/javascript'>window.open('Contraresibo.aspx?inicio=" + txbFechaInicio.Text + "&fin=" + txbFechaFin.Text + "&cliente=" + DropDownList1.SelectedValue + "');</script>")
    End Sub




    Protected Sub DropDownList1_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlCliente.DataBound
        ddlCliente.Items.Add(Crear_item("Todos...", 0))
    End Sub

    Protected Sub ckbContrarecibo_CheckedChanged(ByVal sender As Object, ByVal e As EventArgs)
        Dim ckbContrarecibo As CheckBox = CType(sender, CheckBox)
        Dim gvrFilaActual As GridViewRow = DirectCast(DirectCast(ckbContrarecibo.Parent, DataControlFieldCell).Parent, GridViewRow)

        Dim idFactura = gvrFilaActual.Cells(0).Text

        If Not String.IsNullOrEmpty(idFactura) Then
            Dim buscar_cotrarecibo = (From consulta In db.facturas
                                           Where consulta.id_factura = idFactura
                                           Select consulta).FirstOrDefault()

            If Not buscar_cotrarecibo Is Nothing Then
                Dim ya_tiene_contrarecibo = buscar_cotrarecibo.Contrarecibo

                If ya_tiene_contrarecibo = True Then
                    buscar_cotrarecibo.Contrarecibo = False
                Else
                    buscar_cotrarecibo.Contrarecibo = True
                End If
                db.SubmitChanges()
            End If
        End If

       

    End Sub

   
   
    Protected Sub grd_RowCommand1(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles grd.RowCommand
        If (e.CommandName = "descargarXml") Then
            ' Retrieve the row index stored in the CommandArgument property.
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)

            Dim row As GridViewRow = grd.Rows(index)
            Dim folio = row.Cells(6).Text
            Dim serie = row.Cells(4).Text

            Dim archivo = String.Format("{0}-{1}.xml", serie, folio)

            Dim ruta = String.Format(Server.MapPath(String.Format("~/Contabilidad/Facturar/xmls/{0}", archivo)))
            Response.Clear()
            Response.ContentType = "application/octet-stream"
            Response.AppendHeader("Content-Disposition", "attachment; filename=" & archivo)
            Response.TransmitFile(ruta)
            Response.End()
        ElseIf (e.CommandName = "descargarPdf") Then
            ' Retrieve the row index stored in the CommandArgument property.
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)

            Dim row As GridViewRow = grd.Rows(index)
            Dim folio = row.Cells(6).Text
            Dim serie = row.Cells(4).Text

            Dim archivo = String.Format("{0}-{1}.pdf", serie, folio)

            Dim ruta = String.Format(Server.MapPath(String.Format("~/Contabilidad/Facturar/pdfs/{0}", archivo)))
            Response.Clear()
            Response.ContentType = "application/octet-stream"
            Response.AppendHeader("Content-Disposition", "attachment; filename=" & archivo)
            Response.TransmitFile(ruta)
            Response.End()
        ElseIf (e.CommandName = "enviarMail") Then
            ' Retrieve the row index stored in the CommandArgument property.
            Dim index As Integer = Convert.ToInt32(e.CommandArgument)
            ModalPopupExtender1.Show()
            Dim row As GridViewRow = grd.Rows(index)
            Dim folio = row.Cells(6).Text
            Dim serie = row.Cells(4).Text
            Dim idFactura = row.Cells(0).Text
            Dim folioFiscal = row.Cells(3).Text

            ctlMail1.limpiarFormulario()

            ctlMail1.llenarFormato(String.Format("Envio de factura {0}.", folio),
                                   String.Format("Envio de factura {0}.", folio),
                                   String.Empty,
                                   String.Format("{0}-{1}.xml", serie, folio),
                                   String.Format("{0}-{1}.pdf", serie, folio),
                                   folioFiscal)

            Dim idDato = (From consutla In db.facturas
                       Where consutla.id_factura = idFactura
                       Select consutla).FirstOrDefault()

            If Not idDato Is Nothing Then
                Dim contactos() As String = obtenerContactosFacturacion(idDato.id_dato_facturacion)

                ctlMail1.ingresarCorreos(contactos)
            End If
        End If
    End Sub

    Protected Sub btnCerrar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCerrar.Click
        ModalPopupExtender1.Hide()
    End Sub

    
    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim folio As String = txtFolioFactAmericana.Text
        Dim facturaAmericana = (From consulta In db.facturas
                                      Where consulta.facturaAmericana = True And
                                      consulta.folio = folio
                                      Select consulta).FirstOrDefault()
        If facturaAmericana Is Nothing Then
            lblMensajeFactAmericana.Text = "Folio incorrecto verifiquelo"
        Else
            facturaAmericana.Cancelada = True
            Try
                db.SubmitChanges()
                lblMensajeFactAmericana.Text = "Factura americana " + folio + " cancelada"
            Catch ex As Exception
                lblMensajeFactAmericana.Text = ex.ToString()
            End Try
        End If


    End Sub
End Class