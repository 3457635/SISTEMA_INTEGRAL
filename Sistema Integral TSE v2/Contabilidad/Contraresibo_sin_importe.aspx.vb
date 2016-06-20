Public Class Contraresibo_sin_importe
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



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim inicio = Request.Params("inicio")
            Dim fin = Request.Params("fin")
            Dim cliente = Request.Params("cliente")

            txbInicio.Text = inicio
            txbFin.Text = fin
            txbCliente.Text = cliente
            lblLote.Text = String.Format("Lote No.{0}", ultimoLote())
            lblFecha.Text = StrConv(Now.AddHours(-7).ToString("D"), VbStrConv.ProperCase)
            txbFecha.Text = Now.AddHours(-7).ToString("dd/MM/yyyy")

            Dim cliente_nombre = (From consulta In db.datos_facturacions
                        Where consulta.id_empresa = cliente
                        Select consulta.razon_social).FirstOrDefault()

            lblCliente.Text = cliente_nombre

            Dim todas_mn = ((From consulta In db.fechas_facturacions, consulta2 In db.facturacions, consulta3 In db.fechas_viajes
                 Where
                 consulta3.fecha.fecha.Value.Date >= inicio And
                 consulta3.fecha.fecha.Value.Date <= fin And
                 consulta3.viaje.verificado = True And
                consulta3.fecha.tipo_fecha = 1 And
               consulta2.viaje.precio.id_empresa = cliente And
               consulta.id_factura = consulta2.id_factura And
               consulta.factura.Cancelada = False And
               consulta2.factura.facturada_dolares = False And
               consulta2.id_viaje = consulta3.id_viaje And
                Not (From consulta4 In db.fechas_facturacions
                    Where consulta4.fecha.tipo_fecha = 5 And consulta4.fecha.fecha.Value.Date <= Now.Date.AddDays(-3).AddHours(-7)
                    Select consulta4.id_factura).Contains(consulta.id_factura)
                 Select consulta.factura.folio,
                 consulta.factura.Cancelada,
                 consulta.id_factura).Distinct().OrderByDescending(Function(x) x.folio))
            grdMn.DataSource = todas_mn
            grdMn.DataBind()

            Dim todas_dlls = ((From consulta In db.fechas_facturacions, consulta2 In db.facturacions, consulta3 In db.fechas_viajes
                 Where
                 consulta3.fecha.fecha.Value.Date >= inicio And
                 consulta3.fecha.fecha.Value.Date <= fin And
                consulta3.fecha.tipo_fecha = 1 And
                consulta.factura.Cancelada = False And
               consulta2.viaje.precio.id_empresa = cliente And
               consulta.id_factura = consulta2.id_factura And
               consulta2.factura.facturada_dolares = True And
               consulta2.id_viaje = consulta3.id_viaje And
               Not (From consulta4 In db.fechas_facturacions
                    Where consulta4.fecha.tipo_fecha = 5 And consulta4.fecha.fecha.Value.Date <= Now.Date.AddDays(-3).AddHours(-7)
                    Select consulta4.id_factura).Contains(consulta.id_factura)
                 Select consulta.factura.folio,
                 consulta.factura.Cancelada,
                 consulta.id_factura).Distinct().OrderByDescending(Function(x) x.folio))
            grdDlls.DataSource = todas_dlls
            grdDlls.DataBind()
        End If
    End Sub

    Protected Sub grdMn_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdMn.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim grid As GridView = CType(e.Row.FindControl("Gridview1"), GridView)
            Dim s As SqlDataSource = CType(e.Row.FindControl("SqlDataSource1"), SqlDataSource)


            s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text
        End If



       
    End Sub

    Protected Sub grdDlls_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdDlls.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim grid As GridView = CType(e.Row.FindControl("Gridview1"), GridView)
            Dim s As SqlDataSource = CType(e.Row.FindControl("SqlDataSource2"), SqlDataSource)
           

           

            s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text

        End If
       
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Dim facturas_contrarecibo = ((From consulta In db.fechas_facturacions, consulta2 In db.facturacions, consulta3 In db.fechas_viajes
                  Where
                  consulta3.fecha.fecha.Value.Date >= txbInicio.Text And
                  consulta3.fecha.fecha.Value.Date <= txbFin.Text And
                 consulta3.fecha.tipo_fecha = 1 And
                consulta2.viaje.precio.id_empresa = txbCliente.Text And
                consulta.id_factura = consulta2.id_factura And
                consulta.factura.Cancelada = False And
                consulta3.viaje.verificado = True And
         consulta2.id_viaje = consulta3.id_viaje And
         Not (From consulta4 In db.fechas_facturacions
              Where consulta4.fecha.tipo_fecha = 5 And consulta4.fecha.fecha.Value.Date <= Now.Date.AddDays(-3).AddHours(-7)
              Select consulta4.id_factura).Contains(consulta.id_factura)
                  Select
                  consulta.id_factura,
                  consulta.factura.id_dato_facturacion).Distinct())

        Dim lote = nuevoLote()

        For Each factura In facturas_contrarecibo

            Dim id_factura = factura.id_factura
            registrarFacturasEnLote(id_factura, lote)

            asignarProgramacionCobro(id_factura, Now.AddDays(obtenerDiasCredito(factura.id_dato_facturacion)).AddHours(-7))

            Dim buscar_factura = (From consulta In db.facturas
                               Where consulta.id_factura = id_factura
                               Select consulta).FirstOrDefault()
            If Not buscar_factura Is Nothing Then
                buscar_factura.Contrarecibo = True
            End If

            Dim buscar_fecha_contra = (From consulta In db.fechas_facturacions
                                         Where consulta.id_factura = id_factura And consulta.fecha.tipo_fecha = 5
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

    
End Class