Public Class ctlNomina
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()
    Dim aTotal As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        If Not String.IsNullOrEmpty(txbFecha1.Text) And Not String.IsNullOrEmpty(txbFecha2.Text) Then
            Dim nomina = From consulta In db.viajes, consulta2 In db.fechas_viajes, consulta3 In db.margens
                         Where consulta.id_viaje = consulta3.idViaje And
                         consulta2.fecha.fecha.Value.Date >= txbFecha1.Text And
                         consulta2.fecha.fecha.Value.Date <= txbFecha2.Text And
                         consulta.id_viaje = consulta2.id_viaje
                         Select orden = consulta.Ordene.ano.ToString() + "-" + consulta.Ordene.consecutivo.ToString() + "-" + consulta.num_viaje.ToString(),
                         consulta.precio.empresa.nombre,
                         consulta3.margen,
                         consulta.precio.llave_ruta.ruta,
                         consulta.id_viaje

            GridView1.DataSource = nomina
            GridView1.DataBind()

        End If
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim id_viaje = e.Row.Cells(0).Text

            Dim sdsChofer As SqlDataSource = CType(e.Row.FindControl("sdsChofer"), SqlDataSource)
            sdsChofer.SelectParameters(0).DefaultValue = id_viaje

            Dim sdsVehiculo As SqlDataSource = CType(e.Row.FindControl("sdsVehiculo"), SqlDataSource)
            sdsVehiculo.SelectParameters(0).DefaultValue = id_viaje

            Dim grdTarifa As GridView = CType(e.Row.FindControl("grdTarifa"), GridView)

            Dim multichofer = (From consulta In db.trayectos_asignados
            Where (consulta.equipo_asignado.ViajeId = id_viaje)
            Select consulta.id_trayecto).FirstOrDefault()

            If Not multichofer Is Nothing Then

                Dim tarifa_multichofer = From consulta In db.trayectos_asignados,
                                         consulta2 In db.tarifas_trayectos
                                       Where consulta.equipo_asignado.ViajeId = id_viaje And
                                       consulta.id_trayecto = consulta2.id_trayecto
                                       Select consulta2.tarifa

                grdTarifa.DataSource = tarifa_multichofer
                grdTarifa.DataBind()
            Else
                Dim existe_tarifa = (From consulta In db.viajes
                                     Where consulta.id_viaje = id_viaje
                                     Select consulta.precio.tarifa).FirstOrDefault()
                If Not existe_tarifa Is Nothing Then
                    Me.aTotal += existe_tarifa
                    Dim tarifa_unichofer = From consulta In db.viajes
                                         Where consulta.id_viaje = id_viaje
                                         Select consulta.precio.tarifa,
                                         consulta.Ordene.consecutivo


                    grdTarifa.DataSource = tarifa_unichofer

                    grdTarifa.DataBind()
                End If


            End If
        End If
        If e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(6).Text = String.Format("{0:c0}", Me.aTotal)
        End If

    End Sub
End Class