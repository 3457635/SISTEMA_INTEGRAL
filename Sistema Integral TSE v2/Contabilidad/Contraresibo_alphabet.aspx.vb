Public Class Contraresibo_alphabet
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    

    Dim total As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim inicio = Request.Params("inicio")
            Dim fin = Request.Params("fin")
            Dim cliente = Request.Params("cliente")

            txbInicio.Text = inicio
            txbFin.Text = fin
            txbCliente.Text = cliente

            lblFecha.Text = StrConv(Now.AddHours(-7).ToString("D"), VbStrConv.ProperCase)
            txbFecha.Text = Now.AddHours(-7).ToString("dd/MM/yyyy")

            Dim cliente_nombre = (From consulta In db.datos_facturacions
                        Where consulta.id_empresa = cliente
                        Select consulta.razon_social).FirstOrDefault()

            lblCliente.Text = cliente_nombre

            Dim todas_mn = (From consulta In db.fechas_facturacions, consulta2 In db.facturacions, consulta3 In db.fechas_viajes
                 Where
                 consulta3.fecha.fecha.Value.Date >= inicio And
                 consulta3.fecha.fecha.Value.Date <= fin And
                consulta3.fecha.tipo_fecha = 1 And
               consulta2.viaje.precio.id_empresa = cliente And
               consulta.id_factura = consulta2.id_factura And
               consulta.factura.Cancelada = False And
               consulta2.factura.facturada_dolares = False And
               consulta2.id_viaje = consulta3.id_viaje
                           Select consulta.id_factura, consulta2.factura.total).Distinct().FirstOrDefault()

            Dim total_facturado = From consulta In db.facturacions


            sdsOrdenes.SelectParameters(0).DefaultValue = todas_mn.id_factura

            grdMn.DataBind()
            lblTotal.Text = String.Format("{0:c}", todas_mn.total)


        End If
    End Sub

    Protected Sub grdMn_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdMn.RowDataBound
        
    End Sub

    

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Dim facturas_contrarecibo = (From consulta In db.fechas_facturacions, consulta2 In db.facturacions, consulta3 In db.fechas_viajes
                Where consulta3.fecha.fecha.Value.Date >= txbInicio.Text And
                consulta3.fecha.fecha.Value.Date <= txbFin.Text And
               consulta3.fecha.tipo_fecha = 1 And
              consulta2.viaje.precio.id_empresa = txbCliente.Text And
              consulta.id_factura = consulta2.id_factura And
              consulta2.factura.facturada_dolares = False And
              consulta2.id_viaje = consulta3.id_viaje
                Select consulta.id_factura).Distinct()
        For Each factura In facturas_contrarecibo

            Dim id_factura = factura

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
            fecha_programacion_cobro.fecha = fecha_p_p.AddDays(30)

            db.SubmitChanges()
        Next
    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles LinkButton1.Click
        Response.Redirect("ReporteFacturacion.aspx")
    End Sub


End Class