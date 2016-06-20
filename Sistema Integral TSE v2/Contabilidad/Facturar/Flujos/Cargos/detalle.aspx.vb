Public Class detalle
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim tipo_query = Request("tipo_query")
        Dim fecha_inicio = Request("fecha_inicio")
        Dim fecha_fin = Request("fecha_fin")
        Dim db As New DataClasses1DataContext()

        lblFechaInicio.Text = fecha_inicio
        lblFechaFin.Text = fecha_fin


        If tipo_query = 1 Then
            Dim resultado = From consulta In db.aplicacion_movimientos
                                                Where consulta.id_tipo_movimiento = 1 And
                                                consulta.fecha_ejecucion Is Nothing And
                                                consulta.fecha_programacion >= fecha_inicio And
                                                consulta.fecha_programacion <= fecha_fin
                                                Select importe = consulta.conta_Movimiento.cantidad,
                                                consulta.conta_Movimiento.iva,
                                                consulta.conta_Movimiento.neto,
                                                consulta.conta_cuenta.cuenta,
                                                consulta.descripcion,
                                                consulta.formas_pago.forma_pago,
                                                consulta.conta_Movimiento.referencia

            GridView1.DataSource = resultado
            GridView1.DataBind()
            lblTitulo.Text = "Cargos"
        End If
        If tipo_query = 2 Then
            Dim resultado = From consulta In db.aplicacion_movimientos
                                            Where consulta.id_tipo_movimiento = 1 And
                                            consulta.fecha_ejecucion >= fecha_inicio And
                                            consulta.fecha_ejecucion <= fecha_fin
                                            Select importe = consulta.conta_Movimiento.cantidad,
                                                consulta.conta_Movimiento.iva,
                                                consulta.conta_Movimiento.neto,
                                                consulta.conta_cuenta.cuenta,
                                                consulta.descripcion,
                                                consulta.formas_pago.forma_pago,
                                                consulta.conta_Movimiento.referencia

            GridView1.DataSource = resultado
            GridView1.DataBind()
            lblTitulo.Text = "Cargos"
        End If
        If tipo_query = 3 Then
            Dim resultado = From consulta In db.aplicacion_movimientos
                                            Where consulta.id_tipo_movimiento = 2 And
                                            consulta.fecha_ejecucion Is Nothing And
                                            consulta.fecha_programacion >= fecha_inicio And
                                            consulta.fecha_programacion <= fecha_fin
                                            Select importe = consulta.conta_Movimiento.cantidad,
                                                consulta.conta_Movimiento.iva,
                                                consulta.conta_Movimiento.neto,
                                                consulta.conta_cuenta.cuenta,
                                                consulta.descripcion,
                                                consulta.formas_pago.forma_pago,
                                                consulta.conta_Movimiento.referencia

            GridView1.DataSource = resultado
            GridView1.DataBind()
            lblTitulo.Text = "Abonos"
        End If
        If tipo_query = 4 Then
            Dim resultado = From consulta In db.aplicacion_movimientos
                                            Where consulta.id_tipo_movimiento = 2 And
                                            consulta.fecha_ejecucion >= fecha_inicio And
                                            consulta.fecha_ejecucion <= fecha_fin
                                            Select importe = consulta.conta_Movimiento.cantidad,
                                                consulta.conta_Movimiento.iva,
                                                consulta.conta_Movimiento.neto,
                                                consulta.conta_cuenta.cuenta,
                                                consulta.descripcion,
                                                consulta.formas_pago.forma_pago,
                                                consulta.conta_Movimiento.referencia

            GridView1.DataSource = resultado
            GridView1.DataBind()
            lblTitulo.Text = "Abonos"
        End If



    End Sub

End Class