Public Class ctlPreventivos
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Tipo_Servicio") = 1
    End Sub

    Protected Sub btnGuardar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGuardar.Click
        If Not String.IsNullOrEmpty(txbServicio.Text) Then
            Dim es_correctivo = Session("correctivo")

            Dim nuevo_servicio As New Tipo_reparacion With {.reparacion = txbServicio.Text, .correctivo = es_correctivo}
            db.Tipo_reparacions.InsertOnSubmit(nuevo_servicio)
            db.SubmitChanges()
            lblMensaje.Text = "La información se guardó exitosamente."
        Else
            lblMensaje.Text = "Proporcione el tipo de servicio preventivo."
        End If
        GridView1.DataBind()
    End Sub

    Protected Sub btnNuevo_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnNuevo.Click
        txbServicio.Text = String.Empty

    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles GridView1.SelectedIndexChanged
        Dim idReparacion = GridView1.SelectedDataKey(0).ToString

        Dim buscarReparacion = (From consulta In db.Tipo_reparacions
                             Where consulta.id = idReparacion
                             Select consulta).FirstOrDefault()
        If Not buscarReparacion Is Nothing Then
            buscarReparacion.idEstatus = 6
            db.SubmitChanges()
            GridView1.DataBind()
        Else
            lblMensaje.Text = "Hay un problema para eliminar ese registro."
        End If
    End Sub
End Class