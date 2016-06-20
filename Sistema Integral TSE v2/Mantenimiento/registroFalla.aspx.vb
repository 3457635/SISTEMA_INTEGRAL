Public Class registroFalla
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        Dim idEquipo = ddlCaja.SelectedValue

        If idEquipo = 0 Then
            idEquipo = ddlVehiculo.SelectedValue
            If idEquipo <> 0 Then
                Dim nuevaReparacion As New reparacione With {.comentarios = txbComentarios.Text,
                                                                    .costo = txbCosto.Text,
                                                                    .fecha = txbFecha.Text,
                                                                    .lugar = ddlLugar.Text,
                                                                    .odometro = txbOdometro.Text,
                                                                    .tipo_reparacion = ddlReparacion.SelectedValue}
            End If
        End If

        GridView1.DataBind()
        lblMensaje.Text = "Listo!"
    End Sub

    Protected Sub ddlVehiculo_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlVehiculo.DataBound
        ddlVehiculo.Items.Add(Crear_item("Seleccionar...", 0))

    End Sub

    Protected Sub ddlCaja_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlCaja.DataBound
        ddlCaja.Items.Add(Crear_item("Seleccionar...", 0))
    End Sub
End Class