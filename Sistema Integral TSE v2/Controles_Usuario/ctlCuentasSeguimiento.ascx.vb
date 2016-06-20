Public Class ctlCuentasSeguimiento
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnAsignar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnAsignar.Click
        Dim idEmpresa = ddlCliente.SelectedValue
        Dim idRuta = ddlRuta.SelectedValue
        Dim idLista = ddlLista.SelectedValue
        lblMensaje.Text = String.Empty


        If idEmpresa <> 0 And idRuta <> 0 And idLista <> 0 Then
            Dim buscarServicios = From consulta In db.precios
                                          Where consulta.id_empresa = idEmpresa And
                                          consulta.id_ruta = idRuta And
                                          consulta.id_status = 5
                                          Select consulta

            For Each servicio In buscarServicios
                Dim idRelacion = servicio.id_relacion

                If IsNumeric(idRelacion) Then
                    Dim nuevoAsignacion As New contactosServicio With {.id_relacion = idRelacion, .idLista = idLista}
                    db.contactosServicios.InsertOnSubmit(nuevoAsignacion)
                    db.SubmitChanges()

                    lblMensaje.Text = "Listo!"
                End If
            Next

        Else
            lblMensaje.Text = "Ocurrió un problema con la información que proporcionó."
        End If



    End Sub

    Protected Sub ddlLista_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlLista.DataBound
        ddlLista.Items.Add(Crear_item("Seleccionar...", 0))

    End Sub

    Protected Sub ddlCliente_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlCliente.DataBound
        ddlCliente.Items.Add(Crear_item("Seleccionar...", 0))

    End Sub

    Protected Sub ddlRuta_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlRuta.DataBound
        ddlRuta.Items.Add(Crear_item("Seleccionar...", 0))
    End Sub
End Class