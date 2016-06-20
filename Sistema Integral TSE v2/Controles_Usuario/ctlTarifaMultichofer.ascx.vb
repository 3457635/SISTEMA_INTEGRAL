Public Class ctlTarifaMultichofer
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack Then
            If Session("popup") = 1 Then
                Dim id_ruta = Session("id_ruta")

                Dim id_tipo_vehiculo = Session("id_tipo_vehiculo")

                If Not String.IsNullOrEmpty(id_ruta) Then
                    ddlRuta.SelectedValue = id_ruta
                End If

                If Not String.IsNullOrEmpty("id_tipo_vehiculo") Then
                    ddlTipoVehiculo.SelectedValue = id_tipo_vehiculo
                End If

            End If
        End If
    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Dim _tarifa = txbTarifa.Text
        If IsNumeric(_tarifa) Then
            Dim buscar_tarifa = (From consulta In db.tarifas_trayectos
                                      Where consulta.id_tipo_vehiculo = ddlTipoVehiculo.SelectedValue And
                                      consulta.id_trayecto = ddlTrayecto.SelectedValue
                                      Select consulta).FirstOrDefault()

            If buscar_tarifa Is Nothing Then
                Dim nueva_tarifa As New tarifas_trayecto With {.id_trayecto = ddlTrayecto.SelectedValue,
                                                               .id_tipo_vehiculo = ddlTipoVehiculo.SelectedValue,
                                                               .tarifa = _tarifa}
                db.tarifas_trayectos.InsertOnSubmit(nueva_tarifa)
            Else
                buscar_tarifa.tarifa = _tarifa
            End If
            db.SubmitChanges()
            lblMensaje.Text = "Se guardó la información exitosamente."
        Else
            lblMensaje.Text = "Ingrese la tarifa."
        End If


    End Sub

    Protected Sub ddlRuta_DataBound(sender As Object, e As EventArgs) Handles ddlRuta.DataBound
        If Session("popup") <> 1 Then
            ddlRuta.Items.Add(Crear_item("Seleccionar...", 0))

        End If

    End Sub

    Protected Sub ddlTipoVehiculo_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlTipoVehiculo.SelectedIndexChanged
        Dim buscar_tarifa = (From consulta In db.tarifas_trayectos
                          Where
                          consulta.id_trayecto = ddlTrayecto.SelectedValue And
                          consulta.id_tipo_vehiculo = ddlTipoVehiculo.SelectedValue
                          Select consulta.tarifa).FirstOrDefault()

        If Not buscar_tarifa Is Nothing Then
            txbTarifa.Text = buscar_tarifa
        Else
            txbTarifa.Text = String.Empty
        End If
    End Sub

    Protected Sub ddlTrayecto_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlTrayecto.DataBound
        If Session("popup") <> 1 Then
            ddlTrayecto.Items.Add(Crear_item("seleccionar...", 0))
        End If



    End Sub

    Protected Sub ddlTipoVehiculo_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlTipoVehiculo.DataBound
        If Session("popup") <> 1 Then
            ddlTipoVehiculo.Items.Add(Crear_item("seleccionar...", 0))
        End If


    End Sub
End Class