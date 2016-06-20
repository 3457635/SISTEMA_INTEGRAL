Public Class registroFallas
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        Dim idEquipo = ddlUnidad.SelectedValue
        If idEquipo = 0 Then
            idEquipo = ddlCaja.SelectedValue
        End If

        Dim nuevoReporte As New reportes_falla With {
                                                        .falla = txbFalla.Text,
                                                        .idEquipo = idEquipo,
                                                        .fecha = Now().AddHours(-7)
                                                      }
        db.reportes_fallas.InsertOnSubmit(nuevoReporte)
        db.SubmitChanges()
        GridView1.DataBind()
        lblMensaje.Text = "Listo!"
    End Sub

    Protected Sub ddlUnidad_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlUnidad.DataBound
        ddlUnidad.Items.Add(Crear_item("Todos...", 0))

    End Sub

    Protected Sub ddlCaja_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlCaja.DataBound
        ddlCaja.Items.Add(Crear_item("Todos...", 0))
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim idReporte = e.Row.Cells(0).Text

            Dim buscarReporte = (From consulta In db.reportes_fallas
                                 Where consulta.ReporteId = idReporte
                                 Select consulta).FirstOrDefault()

            Dim lblOrden As Label = CType(e.Row.FindControl("lblOrden"), Label)
            Dim lblTipoEquipo As Label = CType(e.Row.FindControl("lblTipoEquipo"), Label)
            Dim lblEquipo As Label = CType(e.Row.FindControl("lblEquipo"), Label)
            Dim lblChofer As Label = CType(e.Row.FindControl("lblChofer"), Label)
            Dim lblReparacion As Label = CType(e.Row.FindControl("lblReparacion"), Label)

            If Not buscarReporte Is Nothing Then
                Dim idEquipo = buscarReporte.idEquipo
                Dim idOrden = buscarReporte.idOrden
                Dim idChofer = buscarReporte.idChofer


                Dim buscarEquipo = (From consulta In db.equipo_operacions
                                 Where consulta.id_equipo = idEquipo
                                 Select consulta).FirstOrDefault()

                If Not buscarEquipo Is Nothing Then
                    Dim tipoEquipo = buscarEquipo.tipo_equipo.equipo
                    Dim equipo = buscarEquipo.economico
                    lblTipoEquipo.Text = tipoEquipo
                    lblEquipo.Text = equipo
                End If

                Dim buscarOrden = (From consulta In db.Ordenes
                                Where consulta.id_orden = idOrden
                                Select consulta).FirstOrDefault()

                If Not buscarOrden Is Nothing Then
                    Dim orden = String.Format("{0}-{1}", buscarOrden.ano, buscarOrden.consecutivo)
                    lblOrden.Text = orden
                End If

                Dim buscarChofer = (From consulta In db.empleados
                                 Where consulta.id_empleado = idChofer
                                 Select consulta).FirstOrDefault()

                If Not buscarChofer Is Nothing Then
                    Dim chofer = buscarChofer.persona.primer_nombre + " " + buscarChofer.persona.apellido_paterno
                    lblChofer.Text = chofer
                End If


                Dim buscarReparacion = (From consulta In db.reparaciones
                                       Where consulta.idReporte = idReporte
                                       Select consulta).FirstOrDefault()

                If Not buscarReparacion Is Nothing Then
                    lblReparacion.Text = buscarReparacion.comentarios
                End If

            End If

        End If
    End Sub
End Class