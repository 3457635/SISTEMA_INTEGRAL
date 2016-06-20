Public Class Contraresibo_trw
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Dim total_facturado As Decimal
    Dim iva_facturado As Decimal
    Dim retencion_facturado As Decimal
    Dim importe_facturado As Decimal

    Dim total_d As Decimal
    Dim iva_d As Decimal
    Dim retencion_d As Decimal
    Dim importe_d As Decimal
    'variable para guardar el folio de factura 15 06 2015
    Dim factura As Integer = 0



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            cargar_grid()
           
        End If
    End Sub

    Protected Sub grdMn_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdMn.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim lblUnidad As Label = CType(e.Row.FindControl("lblUnidad"), Label)

            Dim viaje = e.Row.Cells(2).Text

            Dim unidad = (From
                          consulta2 In db.equipo_asignados,
                          consulta3 In db.Ordenes,
                          consulta4 In db.viajes
                         Where consulta3.id_orden = consulta4.id_orden And
            consulta3.consecutivo = viaje And
            consulta2.equipo_operacion.id_tipo_equipo = 107 And
            consulta2.ViajeId = consulta4.id_viaje
                         Select consulta2.equipo_operacion.economico,
                         consulta2.equipo_operacion.tipo_equipo.equipo).FirstOrDefault()

            If Not unidad Is Nothing Then
                lblUnidad.Text = String.Format("TRAILER {0}" + unidad.economico)
            Else
                Dim equipo_asignado = (From
                          consulta2 In db.equipo_asignados,
                          consulta3 In db.Ordenes,
                          consulta4 In db.viajes
                         Where consulta3.id_orden = consulta4.id_orden And
                         consulta3.consecutivo = viaje And
                         consulta2.ViajeId = consulta4.id_viaje
                         Select consulta2.equipo_operacion.economico,
                         consulta2.equipo_operacion.tipo_equipo.equipo).FirstOrDefault()
                If Not equipo_asignado Is Nothing Then
                    lblUnidad.Text = equipo_asignado.equipo.ToString() + " " + equipo_asignado.economico.ToString()
                End If
            End If


            Dim grid As GridView = CType(e.Row.FindControl("Gridview1"), GridView)

            'quitar valores que se duplican 15/06/2015
            'se pregunta con IsNumeric para no tomar en cuenta las columnas de titulo
            If factura = 0 And IsNumeric(e.Row.Cells(1).Text) Then
                factura = e.Row.Cells(1).Text
            Else

                If IsNumeric(e.Row.Cells(1).Text) And e.Row.Cells(1).Text <> factura.ToString() Then
                    factura = e.Row.Cells(1).Text
                Else
                    If IsNumeric(e.Row.Cells(1).Text) Then
                        e.Row.Cells(4).Text = String.Format("{0:c}", 0) 'string.format("{0:c}") imprime en formato de moneda
                        e.Row.Cells(5).Text = String.Format("{0:c}", 0)
                        e.Row.Cells(6).Text = String.Format("{0:c}", 0)
                        e.Row.Cells(7).Text = String.Format("{0:c}", 0)
                    End If
                End If
            End If
            '----------------------------------------------------------------------------------------------------------------

            If IsNumeric(e.Row.Cells(6).Text) Then
                Me.total_facturado += CDec(e.Row.Cells(7).Text)
                Me.iva_facturado += CDec(e.Row.Cells(5).Text)
                Me.retencion_facturado += CDec(e.Row.Cells(6).Text)
            End If

            If IsNumeric(e.Row.Cells(4).Text) Then
                Me.importe_facturado += CDec(e.Row.Cells(4).Text)
            End If


        End If
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Dim inicio = Request.Params("inicio")
        Dim fin = Request.Params("fin")


        Dim lote = nuevoLote()

        For i As Integer = 0 To grdMn.Rows.Count - 1

            Dim id_factura = grdMn.Rows(i).Cells(0).Text
            registrarFacturasEnLote(id_factura, lote)

            Dim buscar_factura = (From consulta In db.facturas
                              Where consulta.id_factura = id_factura
                              Select consulta).FirstOrDefault()

            If Not buscar_factura Is Nothing Then
                buscar_factura.Contrarecibo = True

                asignarProgramacionCobro(id_factura, Now.AddHours(-7).AddDays(obtenerDiasCredito(buscar_factura.id_dato_facturacion)))
            End If

            Dim buscar_fecha_contra = (From consulta In db.fechas_facturacions
                                         Where consulta.id_factura = id_factura And
                                         consulta.fecha.tipo_fecha = 5
                                         Select consulta.fecha).FirstOrDefault()

            If buscar_fecha_contra Is Nothing Then
                Dim nueva_fecha_contrarecibo As New fecha With {.fecha = txbFecha.Text, .tipo_fecha = 5}

                Dim fecha_factura As New fechas_facturacion With {.fecha = nueva_fecha_contrarecibo, .id_factura = id_factura}

                db.fechas_facturacions.InsertOnSubmit(fecha_factura)
            Else
                buscar_fecha_contra.fecha = txbFecha.Text
            End If

            db.SubmitChanges()
        Next
        For i As Integer = 0 To grdMovimientos.Rows.Count - 1

            Dim id_factura = grdMovimientos.Rows(i).Cells(0).Text
            registrarFacturasEnLote(id_factura, lote)

            Dim buscar_factura = (From consulta In db.facturas
                               Where consulta.id_factura = id_factura
                               Select consulta).FirstOrDefault()

            If Not buscar_factura Is Nothing Then
                buscar_factura.Contrarecibo = True
            End If


            Dim buscar_fecha_contra = (From consulta In db.fechas_facturacions
                                         Where consulta.id_factura = id_factura And
                                         consulta.fecha.tipo_fecha = 5
                                         Select consulta.fecha).FirstOrDefault()

            If buscar_fecha_contra Is Nothing Then
                Dim nueva_fecha_contrarecibo As New fecha With {.fecha = txbFecha.Text, .tipo_fecha = 5}

                Dim fecha_factura As New fechas_facturacion With {.fecha = nueva_fecha_contrarecibo, .id_factura = id_factura}

                db.fechas_facturacions.InsertOnSubmit(fecha_factura)
            Else
                buscar_fecha_contra.fecha = txbFecha.Text
            End If


            Dim fecha_programacion_cobro = (From consulta In db.fechas_facturacions
                                         Where consulta.id_factura = id_factura And consulta.fecha.tipo_fecha = 6
                                         Select consulta.fecha).FirstOrDefault()
            Dim fecha_p_p As Date = txbFecha.Text

            If Not fecha_programacion_cobro Is Nothing Then
                fecha_programacion_cobro.fecha = fecha_p_p.AddDays(30)
            End If

            db.SubmitChanges()
        Next



    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles LinkButton1.Click
        Response.Redirect("ReporteFacturacion.aspx")
    End Sub


    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles DropDownList1.SelectedIndexChanged
        cargar_grid()
    End Sub
    Protected Sub cargar_grid()
        Dim inicio = Request.Params("inicio")
        Dim fin = Request.Params("fin")
        Dim cliente = Request.Params("cliente")

        txbInicio.Text = inicio
        txbFin.Text = fin
        txbCliente.Text = cliente


        Dim lote = ultimoLote()
        lblLote.Text = String.Format("Lote No. {0}", lote)

        lblFecha.Text = StrConv(Now.AddHours(-7).ToString("D"), VbStrConv.ProperCase)
        txbFecha.Text = Now.AddHours(-7).ToString("dd/MM/yyyy")

        Dim cliente_nombre = (From consulta In db.datos_facturacions
                    Where consulta.id_dato = DropDownList1.SelectedValue
                    Select consulta.razon_social).FirstOrDefault()

        lblCliente.Text = cliente_nombre

        'moneda nacional 
        Dim todas_mn = ((From consulta2 In db.facturacions,
                         consulta3 In db.fechas_viajes,
                         consulta6 In db.datos_facturacions
             Where
             consulta3.fecha.fecha.Value.Date >= inicio And
             consulta3.fecha.fecha.Value.Date <= fin And
            consulta3.fecha.tipo_fecha = 1 And
           consulta6.id_dato = DropDownList1.SelectedValue And
           consulta2.factura.id_dato_facturacion = consulta6.id_dato And
        consulta2.factura.Cancelada = False And
        consulta2.factura.facturada_dolares = False And
        consulta2.id_viaje = consulta3.id_viaje And
        Not (From consulta4 In db.fechas_facturacions
                       Where consulta4.factura.Contrarecibo = True
                       Select consulta4.id_factura).Contains(consulta2.id_factura)
             Select consulta2.factura.folio,
             consulta2.factura.importe,
             consulta2.factura.iva,
             consulta3.viaje.Ordene.consecutivo,
             consulta2.factura.retencion,
             consulta3.fecha.fecha,
             consulta2.factura.total,
             consulta2.factura.Cancelada,
             consulta2.id_factura).Distinct().OrderByDescending(Function(x) x.folio))
        grdMn.DataSource = todas_mn
        grdMn.DataBind()


        Dim movimientos = (From consulta In db.fechas_facturacions
                        Where consulta.fecha.fecha.Value.Date >= inicio And
                        consulta.fecha.fecha.Value.Date <= fin And
                        consulta.fecha.tipo_fecha = 4 And
                        consulta.factura.Cancelada = False And
                        consulta.factura.id_dato_facturacion = DropDownList1.SelectedValue And
                        Not (From consulta2 In db.facturacions
                                   Select consulta2.id_factura).Contains(consulta.id_factura) And
     Not (From consulta4 In db.fechas_facturacions
                    Where consulta4.factura.Contrarecibo = True
                    Select consulta4.id_factura).Contains(consulta.factura.id_factura)
                                 Select consulta.id_factura,
                                 consulta.factura.folio,
                                 consulta.factura.importe,
                                 consulta.factura.iva,
                                 consulta.factura.retencion,
                                 consulta.factura.total).Distinct()

        grdMovimientos.DataSource = movimientos
        grdMovimientos.DataBind()
    End Sub

    Protected Sub grdMovimientos_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdMovimientos.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            

                If IsNumeric(e.Row.Cells(6).Text) Then
                    Me.total_facturado += CDec(e.Row.Cells(6).Text)
                    Me.iva_facturado += CDec(e.Row.Cells(4).Text)
                    Me.retencion_facturado += CDec(e.Row.Cells(5).Text)
                End If

                If IsNumeric(e.Row.Cells(3).Text) Then
                    Me.importe_facturado += CDec(e.Row.Cells(3).Text)
                End If
        End If
        If e.Row.RowType = DataControlRowType.Footer Then
            If IsNumeric(Me.total_facturado) Then
                e.Row.Cells(6).Text = String.Format("{0:c}", Me.total_facturado)
                e.Row.Cells(4).Text = String.Format("{0:c}", Me.iva_facturado)
                e.Row.Cells(5).Text = String.Format("{0:c}", Me.retencion_facturado)
            End If
            If IsNumeric(Me.importe_facturado) Then
                e.Row.Cells(3).Text = String.Format("{0:c}", Me.importe_facturado)
            End If

            e.Row.Cells(2).Text = "TOTAL M.N."
        End If
    End Sub
End Class