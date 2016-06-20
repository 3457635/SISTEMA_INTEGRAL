Public Class ctlTablaCxC
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            actualizar_tabla()
        End If
    End Sub
    Protected Sub actualizar_tabla()
        Try
            grdDetalle.DataSource = Nothing
            grdDetalle.DataBind()


            ImageButton1.Visible = False
            Dim inicio = 0
            Dim fin = 0
            Dim total = 0

            For i = 0 To 5 Step 1
                Select Case i
                    Case 0
                        inicio = -1000
                        fin = 0
                    Case 1
                        inicio = 1
                        fin = 3
                    Case 2
                        inicio = 4
                        fin = 7
                    Case 3
                        inicio = 8
                        fin = 14
                    Case 4
                        inicio = 15
                        fin = 1000
                End Select
                Dim cantidad = 0
                If rbtnSinFactura.SelectedValue = 0 Then


                    'Se omiten los remisionados ---------------------------------06 07 2015
                    Dim Todas = (From consulta In db.fechas_viajes
                                Where (consulta.fecha.tipo_fecha = 1 And
                                consulta.viaje.id_status <> 5 And
                                consulta.viaje.id_status <> 3 And
                                consulta.viaje.remision = 0 And
                                (Now.AddHours(-7).Date - consulta.fecha.fecha.Value.Date).TotalDays >= inicio And
                                (Now.AddHours(-7).Date - consulta.fecha.fecha.Value.Date).TotalDays <= fin And
                                Not (
                                    From consulta2 In db.facturacions
                                    Select consulta2.id_viaje()
                                    ).Contains(consulta.id_viaje))
                                 Select consulta.id_viaje).Count()
                    cantidad = Todas

                Else
                    Dim SinSoportes = (From consulta In db.fechas_viajes
                                                 Where (consulta.fecha.tipo_fecha = 1 And
                                                        consulta.viaje.verificado = False And
                                                        consulta.viaje.id_status <> 3 And
                                                 consulta.viaje.id_status <> 5 And
                                                 consulta.viaje.remision = 0 And
                                                 (Now.AddHours(-7).Date - consulta.fecha.fecha.Value.Date).TotalDays >= inicio And
                                                (Now.AddHours(-7).Date - consulta.fecha.fecha.Value.Date).TotalDays <= fin And
                                                 Not (
                                                     From consulta2 In db.facturacions
                                                     Select consulta2.id_viaje
                                                     ).Contains(consulta.id_viaje))
                                                 Select consulta.id_viaje).Count()
                    cantidad = SinSoportes
                End If

                Select Case i
                    Case 0
                        lnkRango5.Text = cantidad
                        total += cantidad
                    Case 1
                        lnkRango1.Text = cantidad
                        total += cantidad
                    Case 2
                        lnkRango2.Text = cantidad
                        total += cantidad
                    Case 3
                        lnkRango3.Text = cantidad
                        total += cantidad
                    Case 4
                        lnkRango4.Text = cantidad
                        total += cantidad
                End Select
            Next
            lblTotal.Text = total

        Catch ex As Exception
            lblTotal.Text = ex.Message
        End Try

    End Sub
    Protected Sub lnkRango5_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkRango5.Click
        cargarGrid(5)
    End Sub
    Protected Sub cargarGrid(ByVal i As Integer)
        Try
            Dim inicio As Integer
            Dim fin As Integer
            ImageButton1.Visible = True

            Select Case i
                Case 5
                    inicio = -1000
                    fin = 0
                Case 1
                    inicio = 1
                    fin = 3
                Case 2
                    inicio = 4
                    fin = 7
                Case 3
                    inicio = 8
                    fin = 14
                Case 4
                    inicio = 15
                    fin = 1000
            End Select
            'Se omiten los remisionados ---------------------------------06 07 2015 jose pallares
            If rbtnSinFactura.SelectedValue = 0 Then
                Dim todos = From consulta In db.fechas_viajes
                                         Where (consulta.fecha.tipo_fecha = 1 And
                                         consulta.viaje.id_status <> 5 And
                                         consulta.viaje.id_status <> 3 And
                                         consulta.viaje.remision = 0 And
                                         (Now.AddHours(-7).Date - consulta.fecha.fecha.Value.Date).TotalDays >= inicio And
                     (Now.AddHours(-7).Date - consulta.fecha.fecha.Value.Date).TotalDays <= fin And
                                         Not (
                                             From consulta2 In db.facturacions
                                             Select consulta2.id_viaje
                                             ).Contains(consulta.id_viaje))
                                         Select orden = consulta.viaje.Ordene.ano.ToString() + "-" + consulta.viaje.Ordene.consecutivo.ToString() + "-" + consulta.viaje.num_viaje.ToString(),
                                         consulta.viaje.precio.empresa.nombre,
                                         consulta.viaje.precio.llave_ruta.ruta,
                                         consulta.viaje.id_orden,
                                         consulta.viaje.verificado,
                                         consulta.fecha.fecha,
                                         diferencia = (Now.AddHours(-7) - consulta.fecha.fecha).Value.Days

                grdDetalle.DataSource = todos

            Else
                Dim sinFactura = From consulta In db.fechas_viajes
                                         Where (consulta.fecha.tipo_fecha = 1 And
                                                consulta.viaje.verificado = False And
                                         consulta.viaje.id_status <> 5 And
                                         consulta.viaje.id_status <> 3 And
                                         consulta.viaje.remision = 0 And
                                         (Now.AddHours(-7).Date - consulta.fecha.fecha.Value.Date).TotalDays >= inicio And
                     (Now.AddHours(-7).Date - consulta.fecha.fecha.Value.Date).TotalDays <= fin And
                                         Not (
                                             From consulta2 In db.facturacions
                                             Select consulta2.id_viaje
                                             ).Contains(consulta.id_viaje))
                                         Select orden = consulta.viaje.Ordene.ano.ToString() + "-" + consulta.viaje.Ordene.consecutivo.ToString() + "-" + consulta.viaje.num_viaje.ToString(),
                                         consulta.viaje.precio.empresa.nombre,
                                         consulta.viaje.precio.llave_ruta.ruta,
                                         consulta.viaje.id_orden,
                                         consulta.viaje.verificado,
                                         consulta.fecha.fecha,
                                         diferencia = (Now.AddHours(-7).Date - consulta.fecha.fecha).Value.Days

                grdDetalle.DataSource = sinFactura
            End If
            grdDetalle.DataBind()
        Catch ex As Exception
            lblTotal.Text = ex.Message
        End Try

    End Sub



    Protected Sub lnkRango2_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkRango2.Click
        cargarGrid(2)
    End Sub

    Protected Sub lnkRango3_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkRango3.Click
        cargarGrid(3)
    End Sub

    Protected Sub lnkRango4_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkRango4.Click
        cargarGrid(4)
    End Sub

    Protected Sub lnkRango1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkRango1.Click
        cargarGrid(1)
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        grdDetalle.DataSource = Nothing
        grdDetalle.DataBind()
        ImageButton1.Visible = False
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdDetalle.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lblFechaCierre As Label = CType(e.Row.FindControl("lblCierre"), Label)

            Dim id_orden = e.Row.Cells(0).Text

            Dim buscar_fecha_cierre = (From consulta In db.fechas_ordenes
                                    Where consulta.id_orden = id_orden And
                                    consulta.fecha.tipo_fecha = 2
                                    Select consulta).FirstOrDefault()

            If Not buscar_fecha_cierre Is Nothing Then
                lblFechaCierre.Text = buscar_fecha_cierre.fecha.fecha.Value.Date
            End If

        End If
    End Sub

    Protected Sub ImageButton2_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton2.Click
        actualizar_tabla()
    End Sub
End Class