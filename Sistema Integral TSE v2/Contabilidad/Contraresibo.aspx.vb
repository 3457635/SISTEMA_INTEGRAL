Public Class Contraresibo
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Dim total_facturado As Decimal
    Dim iva_facturado As Decimal
    Dim retencion_facturado As Decimal
    Dim importe_facturado As Decimal

    Dim total_dolares As Decimal
    Dim iva_dolares As Decimal
    Dim retencion_dolares As Decimal
    Dim importe_dolares As Decimal

    Dim total_mn As Decimal
    Dim iva_mn As Decimal
    Dim retencion_mn As Decimal
    Dim importe_mn As Decimal


    Dim total_cajas As Decimal
    Dim t_moneda As String


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
         
            Dim cliente = Request.Params("cliente")




            lblFecha.Text = StrConv(Now.AddHours(-7).ToString("D"), VbStrConv.ProperCase)

            Dim cliente_nombre = (From consulta In db.datos_facturacions
                        Where consulta.id_empresa = cliente And
                        consulta.idEstatus = 5
                        Select consulta.razon_social).FirstOrDefault()

            lblCliente.Text = cliente_nombre

            Dim lote = ultimoLote()
            lblLote.Text = String.Format("Lote No. {0}", lote)


            actualizarTotales()

        End If
    End Sub

    Private Sub actualizarTotales()
        lblTotalMn.Text = String.Format("{0:c}", Me.total_mn)
        lblIva.Text = String.Format("{0:c}", Me.iva_mn)
        lblRentencion.Text = String.Format("{0:c}", Me.retencion_mn)
        lblImporte.Text = String.Format("{0:c}", Me.importe_mn)

        lblTotalDlls.Text = String.Format("{0:c}", Me.total_dolares)
        lblIvaDlls.Text = String.Format("{0:c}", Me.iva_dolares)
        lblRetencionDlls.Text = String.Format("{0:c}", Me.retencion_dolares)
        lblImporteDlls.Text = String.Format("{0:c}", Me.importe_dolares)
    End Sub

   

    Protected Sub grdMn_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdMn.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim s As SqlDataSource = CType(e.Row.FindControl("SqlDataSource1"), SqlDataSource)

            Dim moneda = e.Row.Cells(6).Text

            If moneda = "MN" Then
                    Me.total_mn += CDec(e.Row.Cells(5).Text)
                    Me.iva_mn += CDec(e.Row.Cells(4).Text)
                    Me.retencion_mn += CDec(e.Row.Cells(3).Text)
                    Me.importe_mn += CDec(e.Row.Cells(2).Text)
            Else
                    Me.total_dolares += CDec(e.Row.Cells(5).Text)
                    Me.iva_dolares += CDec(e.Row.Cells(4).Text)
                    Me.retencion_dolares += CDec(e.Row.Cells(3).Text)
                    Me.importe_dolares += CDec(e.Row.Cells(2).Text)
            End If

                s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
        End If


        actualizarTotales()

    End Sub


    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click

        Dim lote = nuevoLote()


        For Each row As GridViewRow In grdMn.Rows
            Dim id_factura = row.Cells(0).Text
            Dim folio = row.Cells(1).Text

            registrarFactura(id_factura, lote)
           
        Next

        For Each row As GridViewRow In grdLibres.Rows
            Dim id_factura = row.Cells(0).Text
            Dim folio = row.Cells(1).Text

            registrarFactura(id_factura, lote)
        Next

      
       
    End Sub

    Public Sub registrarFactura(ByVal id_factura As Integer, ByVal lote As Integer)

        Dim buscar_factura = (From consulta In db.facturas
                                          Where consulta.id_factura = id_factura
                                          Select consulta).FirstOrDefault()

        If Not buscar_factura Is Nothing Then
            buscar_factura.Contrarecibo = True

            Dim idDatoFacturacion = buscar_factura.id_dato_facturacion

            registrarFacturasEnLote(id_factura, lote)


            Dim fechaProgramacionCobro = Now.AddHours(-7).AddDays(obtenerDiasCredito(idDatoFacturacion))
            asignarProgramacionCobro(id_factura, fechaProgramacionCobro)

            Dim buscar_fecha_contra = (From consulta In db.fechas_facturacions
                                         Where consulta.id_factura = id_factura And
                                         consulta.fecha.tipo_fecha = 5
                                         Select consulta.fecha).FirstOrDefault()

            If buscar_fecha_contra Is Nothing Then
                Dim nueva_fecha_contrarecibo As New fecha With {.fecha = Now.AddHours(-7),
                                                                .tipo_fecha = 5}

                Dim fecha_factura As New fechas_facturacion With {.fecha = nueva_fecha_contrarecibo,
                                                                  .id_factura = id_factura}

                db.fechas_facturacions.InsertOnSubmit(fecha_factura)

            Else
                buscar_fecha_contra.fecha = Now.AddHours(-7)
            End If
            db.SubmitChanges()
        End If
    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles LinkButton1.Click
        Response.Redirect("ReporteFacturacion.aspx")
    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles DropDownList1.SelectedIndexChanged
        lblCliente.Text = DropDownList1.SelectedValue
    End Sub

    Protected Sub grdLibres_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles grdLibres.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim grid As GridView = CType(e.Row.FindControl("grdLibres"), GridView)
            Dim dolares = e.Row.Cells(6).Text

            If dolares = "Dolares" Then
                Me.total_dolares += CDec(e.Row.Cells(5).Text)
                Me.iva_dolares += CDec(e.Row.Cells(4).Text)
                Me.retencion_dolares += CDec(e.Row.Cells(3).Text)
                Me.importe_dolares += CDec(e.Row.Cells(2).Text)
            Else
                Me.total_mn += CDec(e.Row.Cells(5).Text)
                Me.iva_mn += CDec(e.Row.Cells(4).Text)
                Me.retencion_mn += CDec(e.Row.Cells(3).Text)
                Me.importe_mn += CDec(e.Row.Cells(2).Text)
            End If
        End If

        actualizarTotales()


    End Sub
End Class