Public Class autorizar_gastos
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim egresos = (From consulta In db.gastos, consulta2 In db.proveedores_pagos
                          Where consulta.id_status = 0 And
                          consulta.id_gasto = consulta2.id_gasto
                          Select consulta.cantidad,
                          consulta2.empresa.nombre,
                          consulta.descripcion,
                          consulta2.fecha_programacion_pago,
                          consulta.id_status,
                          consulta.id_gasto).OrderBy(Function(x) x.fecha_programacion_pago)

            
            GridView1.DataSource = egresos
            GridView1.DataBind()


            
            Dim id_lote_anterior = (From consulta In db.lote_aprobacions
                                       Where consulta.fecha.Value.Month = Now.AddHours(-7).Month() And
                                       consulta.fecha.Value.Year = Now.AddHours(-7).Year()
                                Select consulta.id_lote).ToList().LastOrDefault()

            Dim lote_anterior_pagado = (From consulta In db.proveedores_pagos
                              Where consulta.gasto.id_lote = id_lote_anterior And
            consulta.gasto.id_status = 5 And
            Not consulta.fecha_pago Is Nothing
                              Select consulta.gasto.cantidad).Sum()

            If lote_anterior_pagado <> 0 Then
                lblEgresoEjecutado.Text = String.Format("{0:c0}", lote_anterior_pagado)
            End If

            Dim lote_actual = (From consulta In db.proveedores_pagos
                             Where consulta.gasto.id_status = 0
                             Select consulta.gasto.cantidad).Sum()

            lblInfo7.Text = String.Format("{0:c0}", lote_actual)

            Dim egreso_actual = (From consulta In db.proveedores_pagos
                              Where consulta.fecha_pago.Value.Month = Now.AddHours(-7).Month And
            consulta.gasto.id_status = 5 And
            Not consulta.fecha_pago Is Nothing
                              Select consulta.gasto.cantidad).Sum()

            Dim pendiente_pago = (From consulta In db.proveedores_pagos
                              Where consulta.gasto.id_lote = id_lote_anterior And
            consulta.gasto.id_status = 5 And
            consulta.fecha_pago Is Nothing
                              Select consulta.gasto.cantidad).Sum()

            lblEgresoPendiente.Text = String.Format("{0:c0}", pendiente_pago)

            Dim egreso_actual_anual = (From consulta In db.proveedores_pagos
                             Where consulta.fecha_pago.Value.Year = Now().AddHours(-7).Year And
                            consulta.gasto.id_status = 5 And
                            Not consulta.fecha_pago Is Nothing
                             Select consulta.gasto.cantidad).Sum()
            lblInfo8.Text = String.Format("{0:c0}", egreso_actual_anual)

            If egreso_actual <> 0 Then
                lblEgresoActual.Text = String.Format("{0:c0}", egreso_actual)
            End If

            If id_lote_anterior <> 0 Then
                Dim lote_anterior = (From consulta In db.gastos
                                  Where consulta.id_lote = id_lote_anterior And consulta.id_status = 5
                                  Select consulta.cantidad).Sum()
                lblLoteAnterior.Text = String.Format("{0:c0}", lote_anterior)
            End If

            Dim egreso_total = (From consulta In db.proveedores_pagos
                                 Where consulta.fecha_pago.Value.Month = Now.AddHours(-7).Month And
                                 consulta.fecha_pago.Value.Year = Now.AddHours(-7).Year And
                                 consulta.gasto.id_status = 5
                                 Select consulta.gasto.cantidad).Sum()

            Dim ejecuciones_pendientes_acumuladas = (From consulta In db.proveedores_pagos
            Where (consulta.gasto.id_status = 5 And consulta.gasto.id_lote <> id_lote_anterior And
consulta.fecha_pago Is Nothing)
                              Select consulta.gasto.cantidad).Sum()

            lblEgresoAcumulado.Text = String.Format("{0:c0}", ejecuciones_pendientes_acumuladas)

            If IsNumeric(lblLoteAnterior.Text) Then
                Dim egreso_anterior = egreso_total - CDec(lblLoteAnterior.Text)

                End If


        End If




    End Sub

    Protected Sub RadioButtonList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
       

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button1.Click
        Guardar_egresos()

    End Sub
    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As EventArgs) Handles Button2.Click
        Guardar_egresos()
    End Sub
    Protected Sub Guardar_egresos()

        Dim ultimo_lote = (From consulta In db.lote_aprobacions
                           Where consulta.fecha.Value.Month = Now.AddHours(-7).Month
                          Select consulta.lote).Max()

        Dim siguiente_lote As Integer = 0

        If Not ultimo_lote Is Nothing Then
            siguiente_lote = ultimo_lote + 1
        Else
            siguiente_lote = 1
        End If

        Dim nuevo_lote As New lote_aprobacion With {.fecha = Now().AddHours(-7), .lote = siguiente_lote}

        For Each gvr As GridViewRow In GridView1.Rows

            Dim rbtnStatus As RadioButtonList = TryCast(gvr.FindControl("rbtnStatus"), RadioButtonList)


            Dim id_gasto = gvr.Cells(1).Text
            Dim id_status = rbtnStatus.SelectedValue

            Dim actualizar_gastos = (From consulta In db.gastos
                                  Where consulta.id_gasto = id_gasto
                                  Select consulta).FirstOrDefault()

            actualizar_gastos.id_status = id_status

            If id_status = 5 Then
                actualizar_gastos.lote_aprobacion = nuevo_lote
            End If

            db.SubmitChanges()

            If id_status = 5 Then
                lblGastos.Text = String.Format("{0:c}", CDec(lblGastos.Text) + actualizar_gastos.cantidad)
            End If

        Next
        GridView1.DataBind()
        GridView2.DataBind()
    End Sub

    Protected Sub GridView2_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView2.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim imagen As Image = CType(e.Row.FindControl("Image1"), Image)

            Dim aceptado = (From consulta In db.gastos
                         Where consulta.id_gasto = e.Row.Cells(6).Text
                         Select consulta.id_status).FirstOrDefault()

            Select Case aceptado
                Case 5
                    imagen.ImageUrl = "~/imagenes/ok.png"
                Case 6
                    imagen.ImageUrl = "~/imagenes/cancel.png"
                Case 0
                    imagen.ImageUrl = "~/imagenes/pendiente.png"
                Case Else
                    imagen.Visible = False
            End Select

        
        End If

    End Sub

    Protected Sub CheckBox2_CheckedChanged(ByVal sender As Object, ByVal e As EventArgs) Handles CheckBox2.CheckedChanged
        For Each check As GridViewRow In GridView1.Rows
            Dim rb As RadioButtonList = TryCast(check.FindControl("rbtnStatus"), RadioButtonList)
            rb.SelectedValue = 5

        Next
    End Sub

    Protected Sub CheckBox1_CheckedChanged(ByVal sender As Object, ByVal e As EventArgs)

    End Sub
End Class