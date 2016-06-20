Public Partial Class Autorizaciones
    Inherits System.Web.UI.Page
    Dim id_viaje As String
    Dim db As New DataClasses1DataContext()
    Dim proxy As New wcfRef1.Service1Client()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles GridView1.SelectedIndexChanged
        Dim row As GridViewRow = GridView1.SelectedRow
        lblIdViaje.Text = row.Cells(1).Text

        mdlHolder.Show()

    End Sub

    Protected Sub lnkAceptar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkAceptar.Click
        id_viaje = lblIdViaje.Text
        If id_viaje <> "" Then

            Session("id_viaje") = id_viaje
            Dim actualizar_viaje = (From consulta In db.viajes
                                 Where consulta.id_viaje = id_viaje
                                 Select consulta).FirstOrDefault()

            If Not actualizar_viaje Is Nothing Then
                actualizar_viaje.id_status = 2

                actualizar_viaje.facturado = False
            End If

            Try
                db.SubmitChanges()
            Catch ex As Exception
                Dim errorAlActualizar = ex.Message
            End Try
        End If


        Response.Redirect("~/Sup.Trafico/invisibles/Asignar_Recursos.aspx?id_viaje=" + id_viaje)

    End Sub

    Protected Sub lnkRechazar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkRechazar.Click
        id_viaje = lblIdViaje.Text
        If id_viaje <> "" Then
            Dim Query As String = "UPDATE viajes SET id_status=3 WHERE id_viaje=" + id_viaje
            InsertarActualizarRegistro(Query)

            Query = "SELECT id_orden as info from viajes WHERE id_viaje=" + id_viaje
            Dim id_orden As String = SeleccionarRegistro(Query)

            Query = "UPDATE ordenes SET id_status=3 WHERE id_orden=" + id_orden
            InsertarActualizarRegistro(Query)
            Response.Redirect("~/Sup.Trafico/Autorizaciones.aspx")
        End If
    End Sub

    Protected Sub btnCancelar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCancelar.Click
        mdlHolder.Hide()

    End Sub
End Class