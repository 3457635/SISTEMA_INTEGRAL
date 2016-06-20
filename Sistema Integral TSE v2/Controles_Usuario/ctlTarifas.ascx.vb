Public Class ctlTarifas
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        lblMensaje.Text = ""
        Dim buscar_tarifa = (From consulta In db.tarifas_trayectos
                          Where consulta.id_trayecto = ddlTrayecto.SelectedValue And consulta.id_tipo_vehiculo = ddlVehiculo.SelectedValue
                          Select consulta).FirstOrDefault()

        If buscar_tarifa Is Nothing Then

            Dim nueva_tarifa As New tarifas_trayecto With {.id_trayecto = ddlTrayecto.SelectedValue,
                                                           .id_tipo_vehiculo = ddlVehiculo.SelectedValue,
                                                           .tarifa = txbTarifa.Text}
            db.tarifas_trayectos.InsertOnSubmit(nueva_tarifa)
            db.SubmitChanges()
        Else
            lblMensaje.Text = "Tarifa Repetida."
        End If

    End Sub
End Class